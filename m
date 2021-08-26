From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 26 Aug 2021 23:43:52 +0800
Subject: [Intel-wired-lan] [PATCH v4] ixgbe: let the xdpdrv work with
 more than 64 cpus
In-Reply-To: <d15a1f43-3fea-b798-7848-61faf3ca1e8c@intel.com>
References: <20210826141623.8151-1-kerneljasonxing@gmail.com>
 <d15a1f43-3fea-b798-7848-61faf3ca1e8c@intel.com>
Message-ID: <CAL+tcoDfz3un9fvQ7c-TF=eEiFrEXQBEWV9TvgcjbyNVopMJvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 26, 2021 at 11:23 PM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> On 8/26/2021 7:16 AM, kerneljasonxing at gmail.com wrote:
> > From: Jason Xing <xingwanli@kuaishou.com>
> >
> > Originally, ixgbe driver doesn't allow the mounting of xdpdrv if the
> > server is equipped with more than 64 cpus online. So it turns out that
> > the loading of xdpdrv causes the "NOMEM" failure.
> >
> > Actually, we can adjust the algorithm and then make it work through
> > mapping the current cpu to some xdp ring with the protect of @tx_lock.
>
> Thank you very much for working on this!
>
> you should put your sign off block here, and then end with a triple-dash
> "---"
>
> then have your vN: updates below that, so they will be dropped from
> final git apply. It's ok to have more than one triple-dash.
>

Thanks. Now I know much more about the submission.

> >
> > v4:
> > - Update the wrong commit messages. (Jason)
> >
> > v3:
> > - Change nr_cpu_ids to num_online_cpus() (Maciej)
> > - Rename MAX_XDP_QUEUES to IXGBE_MAX_XDP_QS (Maciej)
> > - Rename ixgbe_determine_xdp_cpu() to ixgbe_determine_xdp_q_idx() (Maciej)
> > - Wrap ixgbe_xdp_ring_update_tail() with lock into one function (Maciej)
> >
> > v2:
> > - Adjust cpu id in ixgbe_xdp_xmit(). (Jesper)
> > - Add a fallback path. (Maciej)
> > - Adjust other parts related to xdp ring.
> >
> > Fixes: 33fdc82f08 ("ixgbe: add support for XDP_TX action")
> > Co-developed-by: Shujin Li <lishujin@kuaishou.com>
> > Signed-off-by: Shujin Li <lishujin@kuaishou.com>
> > Signed-off-by: Jason Xing <xingwanli@kuaishou.com>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe.h           | 15 ++++-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c       |  9 ++-
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 64 ++++++++++++++++------
> >  .../net/ethernet/intel/ixgbe/ixgbe_txrx_common.h   |  1 +
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c       |  9 +--
> >  5 files changed, 73 insertions(+), 25 deletions(-)
>
> ...
>
> > @@ -8539,21 +8539,32 @@ static u16 ixgbe_select_queue(struct net_device *dev, struct sk_buff *skb,
> >  int ixgbe_xmit_xdp_ring(struct ixgbe_adapter *adapter,
> >                       struct xdp_frame *xdpf)
> >  {
> > -     struct ixgbe_ring *ring = adapter->xdp_ring[smp_processor_id()];
> >       struct ixgbe_tx_buffer *tx_buffer;
> >       union ixgbe_adv_tx_desc *tx_desc;
> > +     struct ixgbe_ring *ring;
> >       u32 len, cmd_type;
> >       dma_addr_t dma;
> > +     int index, ret;
> >       u16 i;
> >
> >       len = xdpf->len;
> >
> > -     if (unlikely(!ixgbe_desc_unused(ring)))
> > -             return IXGBE_XDP_CONSUMED;
> > +     index = ixgbe_determine_xdp_q_idx(smp_processor_id());
> > +     ring = adapter->xdp_ring[index];
> > +
> > +     if (static_branch_unlikely(&ixgbe_xdp_locking_key))
> > +             spin_lock(&ring->tx_lock);
> > +
> > +     if (unlikely(!ixgbe_desc_unused(ring))) {
> > +             ret = IXGBE_XDP_CONSUMED;
> > +             goto out;
> > +     }
>
> This static key stuff is tricky code, but I guess if it works, then it's
> better than nothing.
>
> As Maciej also commented, I'd like to see some before/after numbers for
> some of the xdp sample programs to make sure this doesn't cause a huge
> regression on the xdp transmit path. A small regression would be ok,
> since this *is* adding overhead.
>

Fine. It will take me some time. BTW, I'm wondering that, after I'm
done with the analysis, should I just reply to this email directly or
send the v5 patch including those numbers?

Thanks,
Jason

> Jesse
>
