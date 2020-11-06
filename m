From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Fri, 6 Nov 2020 20:09:42 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next 1/6] i40e: introduce lazy Tx
 completions for AF_XDP zero-copy
In-Reply-To: <20201105074511.6935e8b7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-2-git-send-email-magnus.karlsson@gmail.com>
 <20201104153320.66cecba8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJ8uoz3-tjXekU=kR+HfMhGBcHtAFnKGq1ZvpFq99T_S-mknPg@mail.gmail.com>
 <20201105074511.6935e8b7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAJ8uoz1nyv-_X5+z-nwyDOc628uYwmUVJCLkXJpsHgFK_QV+wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 5, 2020 at 4:45 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 5 Nov 2020 15:17:50 +0100 Magnus Karlsson wrote:
> > > I feel like this needs a big fat warning somewhere.
> > >
> > > It's perfectly fine to never complete TCP packets, but AF_XDP could be
> > > used to implement protocols in user space. What if someone wants to
> > > implement something like TSQ?
> >
> > I might misunderstand you, but with TSQ here (for something that
> > bypasses qdisk and any buffering and just goes straight to the driver)
> > you mean the ability to have just a few buffers outstanding and
> > continuously reuse these? If so, that is likely best achieved by
> > setting a low Tx queue size on the NIC. Note that even without this
> > patch, completions could be delayed. Though this patch makes that the
> > normal case. In any way, I think this calls for some improved
> > documentation.
>
> TSQ tries to limit the amount of data the TCP stack queues into TC/sched
> and drivers. Say 1MB ~ 16 GSO frames. It will not queue more data until
> some of the transfer is reported as completed.

Thanks. Got it. There is one more use case I can think of for quick
completions of Tx buffers and that is if you have metadata associated
with the completion, for example a Tx time stamp. Not that this
capability exists today, but hopefully it will get added at some
point.

Anyway after some more thinking, I would like to remove this patch
from the patch set and put it on the shelf for a while. The reason
behind this is that if we can get a good busy poll solution for AF_XDP
sockets, then we do not need this patch. With busy-poll the choice of
when to complete Tx buffers would be left to the application in a nice
way. If the application would like to quickly get buffers completed
(at the cost of some performance) it would call sendto() (or friends)
soon after it put the packet on the Tx ring. If max throughput is
desired with no regard to when a buffer is returned, then sendto()
would be called only after a large batch of packets have been put on
the Tx ring. No need for any threshold or new knob, in other words,
much nicer. So let us wait for Bj?rn's busy poll patches and see where
it leads. Please protest if you do not agree. Otherwise I will submit
a v2 without this patch and with Maciej's proposed simplification.

> IIUC you're allowing up to 64 descriptors to linger without reporting
> back that the transfer is done. That means that user space implementing
> a scheme similar to TSQ may see its transfers stalled.
