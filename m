From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 30 Jan 2019 15:25:38 +0100
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix potential RX buffer
 starvation for AF_XDP
In-Reply-To: <CAJ+HfNg=vUqUszLX+C6LvYRq8J_X_UiU4x63FCaXWqdRjV5DGA@mail.gmail.com>
References: <1548770630-16189-1-git-send-email-magnus.karlsson@intel.com>
 <20190129111411.3a4c3599@cakuba.hsd1.ca.comcast.net>
 <CAJ8uoz1GJBmC0GFbURvEzY4kDZZ6C7O9+1F+gV0y=GOMGLobUQ@mail.gmail.com>
 <CAJ+HfNg=vUqUszLX+C6LvYRq8J_X_UiU4x63FCaXWqdRjV5DGA@mail.gmail.com>
Message-ID: <CAJ8uoz3c0tD9dAAch6sr2y5z9=nZzT4SXsX5Ubu00y1kr0SZhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 30, 2019 at 3:16 PM Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>
> Den ons 30 jan. 2019 kl 10:35 skrev Magnus Karlsson <magnus.karlsson@gmail.com>:
> >
> > On Tue, Jan 29, 2019 at 8:15 PM Jakub Kicinski
> > <jakub.kicinski@netronome.com> wrote:
> [...]
> > >
> > > I may not understand the problem fully, but isn't it kind of normal
> > > that if you create a ring empty you'll never receive packets?  And it
> > > should be reasonably easy to catch while writing an app from scratch
> > > (i.e. it behaves deterministically).
> >
> > Agree that this should be the normal behavior for a NIC. The question
> > is how to get out of this situation.There are two options: punt this
> > to the application writer or fix this in the driver. I chose to fix
> > the driver since this removes complexity in the application.
> >
>
> Magnus' fix addresses a race/timing issue. At zero-copy initialization
> point, if the fill ring was empty, the driver (both i40e and ixgbe)
> would stop retrying to "allocate" zero-copy frames from the fill
> ring. So, frames would never be received, even if the fill ring was
> filled at a later point.
>
> If the driver runs-dry in terms of Rx buffer if one or more frames has
> been received, the driver will retry polling the fill-ring. However at
> initialization point, if the fill-ring was empty, the driver would
> just give up and never retry.
>
> As Magnus stated, there is no "notify the kernel that the items has
> appeared in the fill ring" (other than a HW mechanism where the tail
> pointer is a door bell) on the Rx side, so for the Intel drivers it's
> up to the driver to solve this.
>
> > > Plus user space can already do the kick manually: create the ring empty,
> > > attach prog, put packets on the ring, and kick xmit - that would work,
> > > no?
> >
> > Unfortunately there is no way such a kick could be guaranteed to work
> > since it only guarantees to wake up Tx. If the Rx is in another NAPI
> > context, then this will not work. On i40e and ixgbe, the Rx and Tx
> > processing is in the same NAPI so this would indeed work. But can I
> > guarantee that this is true for all current and future NICs?
> > Personally I would like to have Tx in a separate NAPI as I could get
> > better performance that way, at least in the i40e driver. You also do
> > not need to have any Tx at all in your socket, as it could be Rx only.
> > These arguments are why I went with the approach to fix this in the
> > driver, instead of a hard-to-explain extra step in the application
> > that might or might not work depending on your driver.
> >
> > I believe the crux of the problem is that we need to tell the driver
> > to take buffers from the fill ring then put references to them in the
> > HW Rx ring so that packets can be received from the wire. In this
> > patch I went for installing an XDP program and calling bind() as "the"
> > two places. But there could be a scenario where I do bind then install
> > the XDP program and after that populate my fill queue and not call any
> > other syscall ever! This would not be covered by this patch :-(.
> >
> > So you might be correct that the only way to fix this is from the
> > application. But how to do it in a simple and elegant way? I do not
> > think sendto() is the right answer, but what about poll()? Can we wire
> > that up to kick Rx through the busy poll mechanism? I would like the
> > solution to be simple and not complicate things for the user, if
> > possible. Another idea would be to use a timer in the driver to
> > periodically check the fill queue in the case it is empty. This would
> > be easy for application writers but add complexity for people
> > implementing AF_XDP ZC support in their drivers. Any ideas? What do
> > you prefer?
> >
>
> Hmm, actually your patch *does* cover the starve Rx scenarios. One
> downside, which is related to the fact that the AF_XDP ZC ndo doens't
> state if there actually is a socket that needs Rx (we'll just enable
> Rx zero unconditionally), is that the driver will try to allocate
> buffers from the fill ring even if the are no sockets with Rx
> queues. In this case, the fill ring probably never be filled from
> userland. :-) But fixing that would go in to another patch IMO!
>
> I think we can leave the NAPI discussion a side for now. Currently,
> the SPSC queue setup require a single NAPI context. Let's relax that
> later (if ever). (Or did I misunderstand your points?)

OK, good. Thanks. And yes, the NAPI discussion was only for a possible
future state, if ever.

/Magnus

> Cheers,
> Bj?rn
>
>
> > Thanks: Magnus
> >
> > > Putting the kick in ixgbe_xdp_setup() seems a tiny bit random to me,
> > > but perhaps I'm not seeing the rationale clearly.
> > _______________________________________________
> > Intel-wired-lan mailing list
> > Intel-wired-lan at osuosl.org
> > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
