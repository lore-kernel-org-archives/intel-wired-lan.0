From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Wed, 30 Jan 2019 10:35:19 +0100
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix potential RX buffer
 starvation for AF_XDP
In-Reply-To: <20190129111411.3a4c3599@cakuba.hsd1.ca.comcast.net>
References: <1548770630-16189-1-git-send-email-magnus.karlsson@intel.com>
 <20190129111411.3a4c3599@cakuba.hsd1.ca.comcast.net>
Message-ID: <CAJ8uoz1GJBmC0GFbURvEzY4kDZZ6C7O9+1F+gV0y=GOMGLobUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jan 29, 2019 at 8:15 PM Jakub Kicinski
<jakub.kicinski@netronome.com> wrote:
>
> On Tue, 29 Jan 2019 15:03:50 +0100, Magnus Karlsson wrote:
> > When the RX rings are created they are also populated with buffers so
> > that packets can be received. Usually these are kernel buffers, but
> > for AF_XDP in zero-copy mode, these are user-space buffers and in this
> > case the application might not have sent down any buffers to the
> > driver at this point. And if no buffers are allocated at ring creation
> > time, no packets can be received and no interupts will be generated so
> > the napi poll function that allocates buffers to the rings will never
> > get executed.
> >
> > To recitfy this, we kick the NAPI context of any queue with an
> > attached AF_XDP zero-copy socket in two places in the code. Once after
> > an XDP program has loaded and once after the umem is registered.  This
> > take care of both cases: XDP program gets loaded first then AF_XDP
> > socket is created, and the reverse, AF_XDP socket is created first,
> > then XDP program is loaded.
> >
> > Fixes: d0bcacd0a130 ("ixgbe: add AF_XDP zero-copy Rx support")
> > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
>
> I may not understand the problem fully, but isn't it kind of normal
> that if you create a ring empty you'll never receive packets?  And it
> should be reasonably easy to catch while writing an app from scratch
> (i.e. it behaves deterministically).

Agree that this should be the normal behavior for a NIC. The question
is how to get out of this situation.There are two options: punt this
to the application writer or fix this in the driver. I chose to fix
the driver since this removes complexity in the application.

> Plus user space can already do the kick manually: create the ring empty,
> attach prog, put packets on the ring, and kick xmit - that would work,
> no?

Unfortunately there is no way such a kick could be guaranteed to work
since it only guarantees to wake up Tx. If the Rx is in another NAPI
context, then this will not work. On i40e and ixgbe, the Rx and Tx
processing is in the same NAPI so this would indeed work. But can I
guarantee that this is true for all current and future NICs?
Personally I would like to have Tx in a separate NAPI as I could get
better performance that way, at least in the i40e driver. You also do
not need to have any Tx at all in your socket, as it could be Rx only.
These arguments are why I went with the approach to fix this in the
driver, instead of a hard-to-explain extra step in the application
that might or might not work depending on your driver.

I believe the crux of the problem is that we need to tell the driver
to take buffers from the fill ring then put references to them in the
HW Rx ring so that packets can be received from the wire. In this
patch I went for installing an XDP program and calling bind() as "the"
two places. But there could be a scenario where I do bind then install
the XDP program and after that populate my fill queue and not call any
other syscall ever! This would not be covered by this patch :-(.

So you might be correct that the only way to fix this is from the
application. But how to do it in a simple and elegant way? I do not
think sendto() is the right answer, but what about poll()? Can we wire
that up to kick Rx through the busy poll mechanism? I would like the
solution to be simple and not complicate things for the user, if
possible. Another idea would be to use a timer in the driver to
periodically check the fill queue in the case it is empty. This would
be easy for application writers but add complexity for people
implementing AF_XDP ZC support in their drivers. Any ideas? What do
you prefer?

Thanks: Magnus

> Putting the kick in ixgbe_xdp_setup() seems a tiny bit random to me,
> but perhaps I'm not seeing the rationale clearly.
