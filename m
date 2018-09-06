From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Sep 2018 22:55:56 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/4] i40e AF_XDP zero-copy
 buffer leak fixes
In-Reply-To: <CAJ+HfNjQCP7c7gCVJi=LRxK2LvQrNvn6cPfRACW6TPzM8339SA@mail.gmail.com>
References: <20180904181105.10983-1-bjorn.topel@gmail.com>
 <20180905191437.35f7d049@cakuba>
 <CAJ+HfNjQCP7c7gCVJi=LRxK2LvQrNvn6cPfRACW6TPzM8339SA@mail.gmail.com>
Message-ID: <20180906055555.rfknzs7anhjxdhlt@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 05, 2018 at 09:15:14PM +0200, Bj?rn T?pel wrote:
> Den ons 5 sep. 2018 kl 19:14 skrev Jakub Kicinski
> <jakub.kicinski@netronome.com>:
> >
> > On Tue,  4 Sep 2018 20:11:01 +0200, Bj?rn T?pel wrote:
> > > From: Bj?rn T?pel <bjorn.topel@intel.com>
> > >
> > > This series addresses an AF_XDP zero-copy issue that buffers passed
> > > from userspace to the kernel was leaked when the hardware descriptor
> > > ring was torn down.
> > >
> > > The patches fixes the i40e AF_XDP zero-copy implementation.
> > >
> > > Thanks to Jakub Kicinski for pointing this out!
> > >
> > > Some background for folks that don't know the details: A zero-copy
> > > capable driver picks buffers off the fill ring and places them on the
> > > hardware Rx ring to be completed at a later point when DMA is
> > > complete. Similar on the Tx side; The driver picks buffers off the Tx
> > > ring and places them on the Tx hardware ring.
> > >
> > > In the typical flow, the Rx buffer will be placed onto an Rx ring
> > > (completed to the user), and the Tx buffer will be placed on the
> > > completion ring to notify the user that the transfer is done.
> > >
> > > However, if the driver needs to tear down the hardware rings for some
> > > reason (interface goes down, reconfiguration and such), the userspace
> > > buffers cannot be leaked. They have to be reused or completed back to
> > > userspace.
> > >
> > > The implementation does the following:
> > >
> > > * Outstanding Tx descriptors will be passed to the completion
> > >   ring. The Tx code has back-pressure mechanism in place, so that
> > >   enough empty space in the completion ring is guaranteed.
> > >
> > > * Outstanding Rx descriptors are temporarily stored on a stash/reuse
> > >   queue. The reuse queue is based on Jakub's RFC. When/if the HW rings
> > >   comes up again, entries from the stash are used to re-populate the
> > >   ring.
> > >
> > > * When AF_XDP ZC is enabled, disallow changing the number of hardware
> > >   descriptors via ethtool. Otherwise, the size of the stash/reuse
> > >   queue can grow unbounded.
> > >
> > > Going forward, introducing a "zero-copy allocator" analogous to Jesper
> > > Brouer's page pool would be a more robust and reuseable solution.
> > >
> > > Jakub: I've made a minor checkpatch-fix to your RFC, prior adding it
> > > into this series.
> >
> > Thanks for the fix! :)
> >
> > Out of curiosity, did checking the reuse queue have a noticeable impact
> > in your test (i.e. always using the _rq() helpers)?  You seem to be
> > adding an indirect call, would that not be way worse on a retpoline
> > kernel?
> 
> Do you mean the indirection in __i40e_alloc_rx_buffers_zc (patch #3)?
> The indirect call is elided by the __always_inline -- without that
> retpoline took 2.5Mpps worth of Rx. :-(
> 
> I'm only using the _rq helpers in the configuration/slow path, so the
> fast-path is unchanged.

Applied to bpf-next. Thanks.

