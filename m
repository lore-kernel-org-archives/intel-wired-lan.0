From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 19 May 2017 06:40:16 -0700
Subject: [Intel-wired-lan] [PATCH v5 2/2] i40e: add support for XDP_TX
	action
In-Reply-To: <20170519070856.13900-3-bjorn.topel@gmail.com>
References: <20170519070856.13900-1-bjorn.topel@gmail.com>
 <20170519070856.13900-3-bjorn.topel@gmail.com>
Message-ID: <CAKgT0Uc1QG9wH1LDwbHxhvEC9t81ROY=805jy=AqyVpQ3brRnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, May 19, 2017 at 12:08 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
>
> This patch adds proper XDP_TX action support. For each Tx ring, an
> additional XDP Tx ring is allocated and setup. This version does the
> DMA mapping in the fast-path, which will penalize performance for
> IOMMU enabled systems. Further, debugfs support is not wired up for
> the XDP Tx rings.
>
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

So I think we still have some extra complexity here we can remove. I
called it out down below.

Basic idea is I would like to see us lay out queues Tx, XDP, Rx
instead of Tx, Rx, XDP as it makes it easier for us to just overflow
out of the allocated Tx rings and to process XDP rings.

> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |  57 +++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    | 195 +++++++++++++++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 119 ++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  11 ++
>  5 files changed, 350 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index d3195b29d53c..4250ab55a9f1 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -629,6 +629,7 @@ struct i40e_vsi {
>         /* These are containers of ring pointers, allocated at run-time */
>         struct i40e_ring **rx_rings;
>         struct i40e_ring **tx_rings;
> +       struct i40e_ring **xdp_rings; /* XDP Tx rings */
>
>         u32  active_filters;
>         u32  promisc_threshold;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 3d58762efbc0..518788e42887 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -1302,7 +1302,7 @@ static void i40e_get_ringparam(struct net_device *netdev,
>  static int i40e_set_ringparam(struct net_device *netdev,
>                               struct ethtool_ringparam *ring)
>  {
> -       struct i40e_ring *tx_rings = NULL, *rx_rings = NULL;
> +       struct i40e_ring *tx_rings = NULL, *rx_rings = NULL, *xdp_rings = NULL;
>         struct i40e_netdev_priv *np = netdev_priv(netdev);
>         struct i40e_hw *hw = &np->vsi->back->hw;
>         struct i40e_vsi *vsi = np->vsi;
> @@ -1310,6 +1310,7 @@ static int i40e_set_ringparam(struct net_device *netdev,
>         u32 new_rx_count, new_tx_count;
>         int timeout = 50;
>         int i, err = 0;
> +       bool xdp = i40e_enabled_xdp_vsi(vsi);

So this should be moved up to match up with the reverse Christmas tree
layout that I called out in the previous patch.

>
>         if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>                 return -EINVAL;
> @@ -1345,6 +1346,8 @@ static int i40e_set_ringparam(struct net_device *netdev,
>                 for (i = 0; i < vsi->num_queue_pairs; i++) {
>                         vsi->tx_rings[i]->count = new_tx_count;
>                         vsi->rx_rings[i]->count = new_rx_count;
> +                       if (xdp)
> +                               vsi->xdp_rings[i]->count = new_tx_count;

I would say you can drop the "if (xdp)" line here. If the counts
aren't active updating it should have no impact, but not updating them
can cause issues since the XDP rings can fall out of sync with the Tx
rings.

>                 }
>                 goto done;
>         }
> @@ -1440,6 +1443,41 @@ static int i40e_set_ringparam(struct net_device *netdev,
>                 }
>         }
>
> +       /* alloc updated XDP Tx resources */
> +       if (xdp && new_tx_count != vsi->xdp_rings[0]->count) {
> +               netdev_info(netdev,
> +                           "Changing XDP Tx descriptor count from %d to %d.\n",
> +                           vsi->xdp_rings[0]->count, new_tx_count);
> +               xdp_rings = kcalloc(vsi->alloc_queue_pairs,
> +                                   sizeof(struct i40e_ring), GFP_KERNEL);
> +               if (!xdp_rings) {
> +                       err = -ENOMEM;
> +                       goto free_rx;
> +               }
> +
> +               for (i = 0; i < vsi->num_queue_pairs; i++) {
> +                       /* clone ring and setup updated count */
> +                       xdp_rings[i] = *vsi->xdp_rings[i];
> +                       xdp_rings[i].count = new_tx_count;
> +                       /* the desc and bi pointers will be reallocated in the
> +                        * setup call
> +                        */
> +                       xdp_rings[i].desc = NULL;
> +                       xdp_rings[i].rx_bi = NULL;
> +                       err = i40e_setup_tx_descriptors(&xdp_rings[i]);
> +                       if (err) {
> +                               while (i) {
> +                                       i--;
> +                                       i40e_free_tx_resources(&xdp_rings[i]);
> +                               }
> +                               kfree(xdp_rings);
> +                               xdp_rings = NULL;
> +
> +                               goto free_rx;
> +                       }
> +               }
> +       }
> +

Instead of adding this as a new block it might make sense to make this
a subsection of the Tx ring setup. You could then add a label to jump
to setup Rx if XDP is not supported and could avoid having to perform
the test more than once.

>         /* Bring interface down, copy in the new ring info,
>          * then restore the interface
>          */
> @@ -1474,8 +1512,25 @@ static int i40e_set_ringparam(struct net_device *netdev,
>                 rx_rings = NULL;
>         }
>
> +       if (xdp_rings) {
> +               for (i = 0; i < vsi->num_queue_pairs; i++) {
> +                       i40e_free_tx_resources(vsi->xdp_rings[i]);
> +                       *vsi->xdp_rings[i] = xdp_rings[i];
> +               }
> +               kfree(xdp_rings);
> +               xdp_rings = NULL;
> +       }
> +

I would prefer to see us move this up and handle it between Tx and Rx
instead of after Rx.

>         i40e_up(vsi);
>
> +free_rx:
> +       /* error cleanup if the XDP Tx allocations failed after getting Rx */
> +       if (rx_rings) {
> +               for (i = 0; i < vsi->num_queue_pairs; i++)
> +                       i40e_free_rx_resources(&rx_rings[i]);
> +               kfree(rx_rings);
> +               rx_rings = NULL;
> +       }

With the suggestion I made above I would rather see us freeing XDP
rings if the Rx failed rather than freeing Rx if XDP failed.

>  free_tx:
>         /* error cleanup if the Rx allocations failed after getting Tx */
>         if (tx_rings) {
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 27a29904611a..f1dbcead79ba 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -408,6 +408,27 @@ struct rtnl_link_stats64 *i40e_get_vsi_stats_struct(struct i40e_vsi *vsi)
>  }
>
>  /**
> + * i40e_get_netdev_stats_struct_tx - populate stats from a Tx ring
> + * @ring: Tx ring to get statistics from
> + * @stats: statistics entry to be updated
> + **/
> +static void i40e_get_netdev_stats_struct_tx(struct i40e_ring *ring,
> +                                           struct rtnl_link_stats64 *stats)
> +{
> +       u64 bytes, packets;
> +       unsigned int start;
> +
> +       do {
> +               start = u64_stats_fetch_begin_irq(&ring->syncp);
> +               packets = ring->stats.packets;
> +               bytes   = ring->stats.bytes;
> +       } while (u64_stats_fetch_retry_irq(&ring->syncp, start));
> +
> +       stats->tx_packets += packets;
> +       stats->tx_bytes   += bytes;
> +}
> +
> +/**
>   * i40e_get_netdev_stats_struct - Get statistics for netdev interface
>   * @netdev: network interface device structure
>   *
> @@ -437,15 +458,8 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
>                 tx_ring = ACCESS_ONCE(vsi->tx_rings[i]);
>                 if (!tx_ring)
>                         continue;
> +               i40e_get_netdev_stats_struct_tx(tx_ring, stats);
>
> -               do {
> -                       start = u64_stats_fetch_begin_irq(&tx_ring->syncp);
> -                       packets = tx_ring->stats.packets;
> -                       bytes   = tx_ring->stats.bytes;
> -               } while (u64_stats_fetch_retry_irq(&tx_ring->syncp, start));
> -
> -               stats->tx_packets += packets;
> -               stats->tx_bytes   += bytes;
>                 rx_ring = &tx_ring[1];
>
>                 do {
> @@ -456,6 +470,9 @@ static void i40e_get_netdev_stats_struct(struct net_device *netdev,
>
>                 stats->rx_packets += packets;
>                 stats->rx_bytes   += bytes;
> +
> +               if (i40e_enabled_xdp_vsi(vsi))
> +                       i40e_get_netdev_stats_struct_tx(&rx_ring[1], stats);
>         }
>         rcu_read_unlock();
>
> @@ -2802,6 +2819,12 @@ static int i40e_vsi_setup_tx_resources(struct i40e_vsi *vsi)
>         for (i = 0; i < vsi->num_queue_pairs && !err; i++)
>                 err = i40e_setup_tx_descriptors(vsi->tx_rings[i]);
>
> +       if (!i40e_enabled_xdp_vsi(vsi))
> +               return err;
> +
> +       for (i = 0; i < vsi->num_queue_pairs && !err; i++)
> +               err = i40e_setup_tx_descriptors(vsi->xdp_rings[i]);
> +
>         return err;
>  }
>
> @@ -2815,12 +2838,17 @@ static void i40e_vsi_free_tx_resources(struct i40e_vsi *vsi)
>  {
>         int i;
>
> -       if (!vsi->tx_rings)
> -               return;
> +       if (vsi->tx_rings) {
> +               for (i = 0; i < vsi->num_queue_pairs; i++)
> +                       if (vsi->tx_rings[i] && vsi->tx_rings[i]->desc)
> +                               i40e_free_tx_resources(vsi->tx_rings[i]);
> +       }
>
> -       for (i = 0; i < vsi->num_queue_pairs; i++)
> -               if (vsi->tx_rings[i] && vsi->tx_rings[i]->desc)
> -                       i40e_free_tx_resources(vsi->tx_rings[i]);
> +       if (vsi->xdp_rings) {
> +               for (i = 0; i < vsi->num_queue_pairs; i++)
> +                       if (vsi->xdp_rings[i] && vsi->xdp_rings[i]->desc)
> +                               i40e_free_tx_resources(vsi->xdp_rings[i]);
> +       }
>  }
>
>  /**
> @@ -3081,6 +3109,12 @@ static int i40e_vsi_configure_tx(struct i40e_vsi *vsi)
>         for (i = 0; (i < vsi->num_queue_pairs) && !err; i++)
>                 err = i40e_configure_tx_ring(vsi->tx_rings[i]);
>
> +       if (!i40e_enabled_xdp_vsi(vsi))
> +               return err;
> +
> +       for (i = 0; (i < vsi->num_queue_pairs) && !err; i++)
> +               err = i40e_configure_tx_ring(vsi->xdp_rings[i]);
> +
>         return err;
>  }
>
> @@ -3230,6 +3264,7 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
>         u16 vector;
>         int i, q;
>         u32 qp;
> +       bool has_xdp = i40e_enabled_xdp_vsi(vsi);

This line should be moved up for the reverse Xmas tree layout.

>
>         /* The interrupt indexing is offset by 1 in the PFINT_ITRn
>          * and PFINT_LNKLSTn registers, e.g.:
> @@ -3256,16 +3291,28 @@ static void i40e_vsi_configure_msix(struct i40e_vsi *vsi)
>                 wr32(hw, I40E_PFINT_LNKLSTN(vector - 1), qp);
>                 for (q = 0; q < q_vector->num_ringpairs; q++) {
>                         u32 val;
> +                       u32 nextqp = has_xdp ? qp + vsi->alloc_queue_pairs : qp;

Same here. This line should come before "u32 val;" not after.

>
>                         val = I40E_QINT_RQCTL_CAUSE_ENA_MASK |
>                               (I40E_RX_ITR << I40E_QINT_RQCTL_ITR_INDX_SHIFT)  |
>                               (vector      << I40E_QINT_RQCTL_MSIX_INDX_SHIFT) |
> -                             (qp          << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT)|
> +                             (nextqp      << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT)|
>                               (I40E_QUEUE_TYPE_TX
>                                       << I40E_QINT_RQCTL_NEXTQ_TYPE_SHIFT);
>
>                         wr32(hw, I40E_QINT_RQCTL(qp), val);
>
> +                       if (has_xdp) {
> +                               val = I40E_QINT_TQCTL_CAUSE_ENA_MASK |
> +                                     (I40E_TX_ITR << I40E_QINT_TQCTL_ITR_INDX_SHIFT)  |
> +                                     (vector      << I40E_QINT_TQCTL_MSIX_INDX_SHIFT) |
> +                                     (qp          << I40E_QINT_TQCTL_NEXTQ_INDX_SHIFT)|
> +                                     (I40E_QUEUE_TYPE_TX
> +                                      << I40E_QINT_TQCTL_NEXTQ_TYPE_SHIFT);
> +
> +                               wr32(hw, I40E_QINT_TQCTL(nextqp), val);
> +                       }
> +
>                         val = I40E_QINT_TQCTL_CAUSE_ENA_MASK |
>                               (I40E_TX_ITR << I40E_QINT_TQCTL_ITR_INDX_SHIFT)  |
>                               (vector      << I40E_QINT_TQCTL_MSIX_INDX_SHIFT) |
> @@ -3334,6 +3381,7 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
>         struct i40e_pf *pf = vsi->back;
>         struct i40e_hw *hw = &pf->hw;
>         u32 val;
> +       u32 nextqp = i40e_enabled_xdp_vsi(vsi) ? vsi->alloc_queue_pairs : 0;

Same here. The line should be moved up to the point that it has a
longer variable declaration in front of it. If there are no longer
variable declarations it should be the top.

>         /* set the ITR configuration */
>         q_vector->itr_countdown = ITR_COUNTDOWN_START;
> @@ -3350,12 +3398,22 @@ static void i40e_configure_msi_and_legacy(struct i40e_vsi *vsi)
>         wr32(hw, I40E_PFINT_LNKLST0, 0);
>
>         /* Associate the queue pair to the vector and enable the queue int */
> -       val = I40E_QINT_RQCTL_CAUSE_ENA_MASK                  |
> -             (I40E_RX_ITR << I40E_QINT_RQCTL_ITR_INDX_SHIFT) |
> +       val = I40E_QINT_RQCTL_CAUSE_ENA_MASK                   |
> +             (I40E_RX_ITR << I40E_QINT_RQCTL_ITR_INDX_SHIFT)  |
> +             (nextqp      << I40E_QINT_RQCTL_NEXTQ_INDX_SHIFT)|
>               (I40E_QUEUE_TYPE_TX << I40E_QINT_TQCTL_NEXTQ_TYPE_SHIFT);
>
>         wr32(hw, I40E_QINT_RQCTL(0), val);
>
> +       if (i40e_enabled_xdp_vsi(vsi)) {
> +               val = I40E_QINT_TQCTL_CAUSE_ENA_MASK                 |
> +                     (I40E_TX_ITR << I40E_QINT_TQCTL_ITR_INDX_SHIFT)|
> +                     (I40E_QUEUE_TYPE_TX
> +                      << I40E_QINT_TQCTL_NEXTQ_TYPE_SHIFT);
> +
> +              wr32(hw, I40E_QINT_TQCTL(nextqp), val);
> +       }
> +
>         val = I40E_QINT_TQCTL_CAUSE_ENA_MASK                  |
>               (I40E_TX_ITR << I40E_QINT_TQCTL_ITR_INDX_SHIFT) |
>               (I40E_QUEUE_END_OF_LIST << I40E_QINT_TQCTL_NEXTQ_INDX_SHIFT);
> @@ -3522,6 +3580,9 @@ static void i40e_vsi_disable_irq(struct i40e_vsi *vsi)
>         for (i = 0; i < vsi->num_queue_pairs; i++) {
>                 wr32(hw, I40E_QINT_TQCTL(vsi->tx_rings[i]->reg_idx), 0);
>                 wr32(hw, I40E_QINT_RQCTL(vsi->rx_rings[i]->reg_idx), 0);
> +               if (!i40e_enabled_xdp_vsi(vsi))
> +                       continue;
> +               wr32(hw, I40E_QINT_TQCTL(vsi->xdp_rings[i]->reg_idx), 0);
>         }
>
>         if (pf->flags & I40E_FLAG_MSIX_ENABLED) {
> @@ -3818,12 +3879,22 @@ static void i40e_map_vector_to_qp(struct i40e_vsi *vsi, int v_idx, int qp_idx)
>         struct i40e_q_vector *q_vector = vsi->q_vectors[v_idx];
>         struct i40e_ring *tx_ring = vsi->tx_rings[qp_idx];
>         struct i40e_ring *rx_ring = vsi->rx_rings[qp_idx];
> +       struct i40e_ring *xdp_ring = i40e_enabled_xdp_vsi(vsi) ?
> +                                    vsi->xdp_rings[qp_idx] : NULL;

What you might try doing is pulling this line out and actually drop it
into the if statement below. You could replace the xdp_ring check with
the i40e_enabled_xdp_vsi(vsi) check. Then it makes this a bit more
readable as the XDP setup below becomes a mini version of the
i40e_map_vector_to_qp function. Also it avoids the reverse xmas tree
issues as you could initialize the xdp_ring pointer inside of the if
statement.

>
>         tx_ring->q_vector = q_vector;
>         tx_ring->next = q_vector->tx.ring;
>         q_vector->tx.ring = tx_ring;
>         q_vector->tx.count++;
>
> +       /* Place XDP Tx ring in the same q_vector ring list as regular Tx */
> +       if (xdp_ring) {
> +               xdp_ring->q_vector = q_vector;
> +               xdp_ring->next = q_vector->tx.ring;
> +               q_vector->tx.ring = xdp_ring;
> +               q_vector->tx.count++;
> +       }
> +
>         rx_ring->q_vector = q_vector;
>         rx_ring->next = q_vector->rx.ring;
>         q_vector->rx.ring = rx_ring;
> @@ -4026,6 +4097,23 @@ static int i40e_vsi_control_tx(struct i40e_vsi *vsi, bool enable)
>                 }
>         }
>
> +       if (ret || !i40e_enabled_xdp_vsi(vsi))
> +               return ret;
> +
> +       pf_q = vsi->base_queue + vsi->alloc_queue_pairs;
> +       for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
> +               i40e_control_tx_q(pf, pf_q, enable);
> +
> +               /* wait for the change to finish */
> +               ret = i40e_pf_txq_wait(pf, pf_q, enable);
> +               if (ret) {
> +                       dev_info(&pf->pdev->dev,
> +                                "VSI seid %d XDP Tx ring %d %sable timeout\n",
> +                                vsi->seid, pf_q, (enable ? "en" : "dis"));
> +                       break;
> +               }
> +       }
> +

It might work better to place this inside the original loop in this
function. What you could do is just add another variable inside the
original loop in this function that could be pf_q +
vsi->alloc_queue_pairs.

>         return ret;
>  }
>
> @@ -4535,7 +4623,7 @@ int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
>                                  vsi->seid, pf_q);
>                         return ret;
>                 }
> -               /* Check and wait for the Tx queue */
> +               /* Check and wait for the Rx queue */
>                 ret = i40e_pf_rxq_wait(pf, pf_q, false);
>                 if (ret) {
>                         dev_info(&pf->pdev->dev,
> @@ -4545,6 +4633,21 @@ int i40e_vsi_wait_queues_disabled(struct i40e_vsi *vsi)
>                 }
>         }
>
> +       if (!i40e_enabled_xdp_vsi(vsi))
> +               return 0;
> +
> +       pf_q = vsi->base_queue + vsi->alloc_queue_pairs;
> +       for (i = 0; i < vsi->num_queue_pairs; i++, pf_q++) {
> +               /* Check and wait for the XDP Tx queue */
> +               ret = i40e_pf_txq_wait(pf, pf_q, false);
> +               if (ret) {
> +                       dev_info(&pf->pdev->dev,
> +                                "VSI seid %d XDP Tx ring %d disable timeout\n",
> +                                vsi->seid, pf_q);
> +                       return ret;
> +               }
> +       }
> +

This would make more sense inside of the original loop instead of
being added as an extra bit.

>         return 0;
>  }
>
> @@ -5454,6 +5557,8 @@ void i40e_down(struct i40e_vsi *vsi)
>
>         for (i = 0; i < vsi->num_queue_pairs; i++) {
>                 i40e_clean_tx_ring(vsi->tx_rings[i]);
> +               if (i40e_enabled_xdp_vsi(vsi))
> +                       i40e_clean_tx_ring(vsi->xdp_rings[i]);
>                 i40e_clean_rx_ring(vsi->rx_rings[i]);
>         }
>
> @@ -7475,6 +7580,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
>         switch (vsi->type) {
>         case I40E_VSI_MAIN:
>                 vsi->alloc_queue_pairs = pf->num_lan_qps;
> +

Looks like you somehow added a extra empty line here. This can be dropped.

>                 vsi->num_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
>                                       I40E_REQ_DESCRIPTOR_MULTIPLE);
>                 if (pf->flags & I40E_FLAG_MSIX_ENABLED)
> @@ -7524,13 +7630,17 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
>  {
>         int size;
>         int ret = 0;
> +       int nrings;
>
> -       /* allocate memory for both Tx and Rx ring pointers */
> -       size = sizeof(struct i40e_ring *) * vsi->alloc_queue_pairs * 2;
> +       /* allocate memory for both Tx, Rx and XDP Tx ring pointers */
> +       nrings = i40e_enabled_xdp_vsi(vsi) ? 3 : 2;
> +       size = sizeof(struct i40e_ring *) * vsi->alloc_queue_pairs * nrings;
>         vsi->tx_rings = kzalloc(size, GFP_KERNEL);
>         if (!vsi->tx_rings)
>                 return -ENOMEM;
>         vsi->rx_rings = &vsi->tx_rings[vsi->alloc_queue_pairs];
> +       if (i40e_enabled_xdp_vsi(vsi))
> +               vsi->xdp_rings = &vsi->rx_rings[vsi->alloc_queue_pairs];

I have a general thought here. Why not look at placing the xdp_rings
in the slot immediately after the Tx rings and before the Rx rings?
Doing that may help to simplify some of the code as you could then
just loop through alloc_queue_pairs * 2 in order to handle all of the
XDP rings from the Tx ring array pointer.

>         if (alloc_qvectors) {
>                 /* allocate memory for q_vector pointers */
> @@ -7650,6 +7760,7 @@ static void i40e_vsi_free_arrays(struct i40e_vsi *vsi, bool free_qvectors)
>         kfree(vsi->tx_rings);
>         vsi->tx_rings = NULL;
>         vsi->rx_rings = NULL;
> +       vsi->xdp_rings = NULL;
>  }
>
>  /**
> @@ -7733,6 +7844,8 @@ static void i40e_vsi_clear_rings(struct i40e_vsi *vsi)
>                         kfree_rcu(vsi->tx_rings[i], rcu);
>                         vsi->tx_rings[i] = NULL;
>                         vsi->rx_rings[i] = NULL;
> +                       if (vsi->xdp_rings)
> +                               vsi->xdp_rings[i] = NULL;
>                 }
>         }
>  }
> @@ -7743,14 +7856,15 @@ static void i40e_vsi_clear_rings(struct i40e_vsi *vsi)
>   **/
>  static int i40e_alloc_rings(struct i40e_vsi *vsi)
>  {
> -       struct i40e_ring *tx_ring, *rx_ring;
> +       struct i40e_ring *tx_ring, *rx_ring, *xdp_ring;

Instead of having multiple ring pointers we could probably simplify
this by just using one generic ring pointer since it doesn't matter if
it is really a Tx, Rx, or XDP ring. It simplifies the code below a
bit.

>         struct i40e_pf *pf = vsi->back;
> -       int i;
> +       int i, nr;
>
> +       nr = i40e_enabled_xdp_vsi(vsi) ? 3 : 2;
>         /* Set basic values in the rings to be used later during open() */
>         for (i = 0; i < vsi->alloc_queue_pairs; i++) {
>                 /* allocate space for both Tx and Rx in one shot */
> -               tx_ring = kzalloc(sizeof(struct i40e_ring) * 2, GFP_KERNEL);
> +               tx_ring = kcalloc(nr, sizeof(*tx_ring), GFP_KERNEL);

I would prefer it if we stayed with "sizeof(struct i40e_ring)" instead
of using "sizeof(*tx_ring)". I think it is more readable that way.

Also instead of using nr it might be more readable to use something
like "q_per_vector" or qpv just so it is clear that we are allocating
either 2 or 3 queues per vector.

>                 if (!tx_ring)
>                         goto err_out;
>
> @@ -7780,6 +7894,26 @@ static int i40e_alloc_rings(struct i40e_vsi *vsi)
>                 rx_ring->dcb_tc = 0;
>                 rx_ring->rx_itr_setting = pf->rx_itr_default;
>                 vsi->rx_rings[i] = rx_ring;
> +
> +               if (!i40e_enabled_xdp_vsi(vsi))
> +                       continue;
> +
> +               xdp_ring = &rx_ring[1];

So for example instead of doing this you could just call ring++ and
update the the correct pointer. It also makes it easier to move this
up to be processed before the Rx ring.

> +               xdp_ring->queue_index = vsi->alloc_queue_pairs + i;
> +               xdp_ring->reg_idx = vsi->base_queue +
> +                                   vsi->alloc_queue_pairs + i;

This could be redefined as "xdp_ring->reg_idx = vsi->alloc_queue_pairs
+ xpd_ring->queue_index".

> +               xdp_ring->ring_active = false;
> +               xdp_ring->vsi = vsi;
> +               xdp_ring->netdev = NULL;
> +               xdp_ring->dev = &pf->pdev->dev;
> +               xdp_ring->count = vsi->num_desc;
> +               xdp_ring->size = 0;
> +               xdp_ring->dcb_tc = 0;
> +               if (vsi->back->flags & I40E_FLAG_WB_ON_ITR_CAPABLE)
> +                       xdp_ring->flags = I40E_TXR_FLAGS_WB_ON_ITR;
> +               set_ring_xdp(xdp_ring);
> +               xdp_ring->tx_itr_setting = pf->tx_itr_default;
> +               vsi->xdp_rings[i] = xdp_ring;

So I would really like to see this whole block moved up to before the
Rx configuration. That way we have all the Tx configured before we get
to the Rx.

>         }
>
>         return 0;
> @@ -9988,6 +10122,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>         struct i40e_pf *pf;
>         u8 enabled_tc;
>         int ret;
> +       u16 alloc_queue_pairs;

Needs to be moved up for reverse Christmas tree layout.

>
>         if (!vsi)
>                 return NULL;
> @@ -10003,11 +10138,14 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
>         if (ret)
>                 goto err_vsi;
>
> -       ret = i40e_get_lump(pf, pf->qp_pile, vsi->alloc_queue_pairs, vsi->idx);
> +       alloc_queue_pairs = vsi->alloc_queue_pairs *
> +                           (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
> +
> +       ret = i40e_get_lump(pf, pf->qp_pile, alloc_queue_pairs, vsi->idx);
>         if (ret < 0) {
>                 dev_info(&pf->pdev->dev,
>                          "failed to get tracking for %d queues for VSI %d err %d\n",
> -                        vsi->alloc_queue_pairs, vsi->seid, ret);
> +                        alloc_queue_pairs, vsi->seid, ret);
>                 goto err_vsi;
>         }
>         vsi->base_queue = ret;
> @@ -10065,6 +10203,7 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>         struct i40e_veb *veb = NULL;
>         int ret, i;
>         int v_idx;
> +       u16 alloc_queue_pairs;
>
>         /* The requested uplink_seid must be either
>          *     - the PF's port seid
> @@ -10150,12 +10289,14 @@ struct i40e_vsi *i40e_vsi_setup(struct i40e_pf *pf, u8 type,
>         else if (type == I40E_VSI_SRIOV)
>                 vsi->vf_id = param1;
>         /* assign it some queues */
> -       ret = i40e_get_lump(pf, pf->qp_pile, vsi->alloc_queue_pairs,
> -                               vsi->idx);
> +       alloc_queue_pairs = vsi->alloc_queue_pairs *
> +                           (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
> +
> +       ret = i40e_get_lump(pf, pf->qp_pile, alloc_queue_pairs, vsi->idx);
>         if (ret < 0) {
>                 dev_info(&pf->pdev->dev,
>                          "failed to get tracking for %d queues for VSI %d err=%d\n",
> -                        vsi->alloc_queue_pairs, vsi->seid, ret);
> +                        alloc_queue_pairs, vsi->seid, ret);
>                 goto err_vsi;
>         }
>         vsi->base_queue = ret;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 0c2f0230faf4..c025e517f7e5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -630,6 +630,8 @@ static void i40e_unmap_and_free_tx_resource(struct i40e_ring *ring,
>         if (tx_buffer->skb) {
>                 if (tx_buffer->tx_flags & I40E_TX_FLAGS_FD_SB)
>                         kfree(tx_buffer->raw_buf);
> +               else if (ring_is_xdp(ring))
> +                       page_frag_free(tx_buffer->raw_buf);
>                 else
>                         dev_kfree_skb_any(tx_buffer->skb);
>                 if (dma_unmap_len(tx_buffer, len))
> @@ -771,8 +773,11 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
>                 total_bytes += tx_buf->bytecount;
>                 total_packets += tx_buf->gso_segs;
>
> -               /* free the skb */
> -               napi_consume_skb(tx_buf->skb, napi_budget);
> +               /* free the skb/XDP data */
> +               if (ring_is_xdp(tx_ring))
> +                       page_frag_free(tx_buf->raw_buf);
> +               else
> +                       napi_consume_skb(tx_buf->skb, napi_budget);
>
>                 /* unmap skb header data */
>                 dma_unmap_single(tx_ring->dev,
> @@ -848,6 +853,9 @@ static bool i40e_clean_tx_irq(struct i40e_vsi *vsi,
>                         tx_ring->arm_wb = true;
>         }
>
> +       if (ring_is_xdp(tx_ring))
> +               return !!budget;
> +
>         /* notify netdev of completed buffers */
>         netdev_tx_completed_queue(txring_txq(tx_ring),
>                                   total_packets, total_bytes);
> @@ -1969,6 +1977,10 @@ static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
>
>  #define I40E_XDP_PASS 0
>  #define I40E_XDP_CONSUMED 1
> +#define I40E_XDP_TX 2
> +
> +static int i40e_xmit_xdp_ring(struct xdp_buff *xdp,
> +                             struct i40e_ring *xdp_ring);
>
>  /**
>   * i40e_run_xdp - run an XDP program
> @@ -1981,6 +1993,7 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
>         int result = I40E_XDP_PASS;
>         struct bpf_prog *xdp_prog;
>         u32 act;
> +       struct i40e_ring *xdp_ring;

This should be moved up for reverse christmas tree.

>
>         rcu_read_lock();
>         xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> @@ -1989,12 +2002,16 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
>                 goto xdp_out;
>
>         act = bpf_prog_run_xdp(xdp_prog, xdp);
> +

This white space should either have been added in patch 1 or can be
dropped here.

>         switch (act) {
>         case XDP_PASS:
>                 break;
> +       case XDP_TX:
> +               xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
> +               result = i40e_xmit_xdp_ring(xdp, xdp_ring);
> +               break;
>         default:
>                 bpf_warn_invalid_xdp_action(act);
> -       case XDP_TX:
>         case XDP_ABORTED:
>                 trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
>                 /* fallthrough -- handle aborts by dropping packet */
> @@ -2008,6 +2025,27 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
>  }
>
>  /**
> + * i40e_rx_buffer_flip - adjusted rx_buffer to point to an unused region
> + * @rx_ring: Rx ring
> + * @rx_buffer: Rx buffer to adjust
> + * @size: Size of adjustment
> + **/
> +static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
> +                               struct i40e_rx_buffer *rx_buffer,
> +                               unsigned int size)
> +{
> +#if (PAGE_SIZE < 8192)
> +       unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
> +
> +       rx_buffer->page_offset ^= truesize;
> +#else
> +       unsigned int truesize = SKB_DATA_ALIGN(i40e_rx_offset(rx_ring) + size);
> +
> +       rx_buffer->page_offset += truesize;
> +#endif
> +}
> +
> +/**
>   * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>   * @rx_ring: rx descriptor ring to transact packets on
>   * @budget: Total limit on number of packets to process
> @@ -2024,7 +2062,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>         unsigned int total_rx_bytes = 0, total_rx_packets = 0;
>         struct sk_buff *skb = rx_ring->skb;
>         u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
> -       bool failure = false;
> +       bool failure = false, xdp_xmit = false;
>
>         while (likely(total_rx_packets < budget)) {
>                 struct i40e_rx_buffer *rx_buffer;
> @@ -2081,9 +2119,14 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                 }
>
>                 if (IS_ERR(skb)) {
> +                       if (PTR_ERR(skb) == -I40E_XDP_TX) {
> +                               xdp_xmit = true;
> +                               i40e_rx_buffer_flip(rx_ring, rx_buffer, size);
> +                       } else {
> +                               rx_buffer->pagecnt_bias++;
> +                       }
>                         total_rx_bytes += size;
>                         total_rx_packets++;
> -                       rx_buffer->pagecnt_bias++;
>                 } else if (skb) {
>                         i40e_add_rx_frag(rx_ring, rx_buffer, skb, size);
>                 } else if (ring_uses_build_skb(rx_ring)) {
> @@ -2131,6 +2174,19 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>                 total_rx_packets++;
>         }
>
> +       if (xdp_xmit) {
> +               struct i40e_ring *xdp_ring;
> +
> +               xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
> +
> +               /* Force memory writes to complete before letting h/w
> +                * know there are new descriptors to fetch.
> +                */
> +               wmb();
> +
> +               writel(xdp_ring->next_to_use, xdp_ring->tail);
> +       }
> +
>         rx_ring->skb = skb;
>
>         u64_stats_update_begin(&rx_ring->syncp);
> @@ -3188,6 +3244,59 @@ static inline int i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
>  }
>
>  /**
> + * i40e_xmit_xdp_ring - transmits an XDP buffer to an XDP Tx ring
> + * @xdp: data to transmit
> + * @xdp_ring: XDP Tx ring
> + **/
> +static int i40e_xmit_xdp_ring(struct xdp_buff *xdp,
> +                             struct i40e_ring *xdp_ring)
> +{
> +       struct i40e_tx_buffer *tx_bi;
> +       struct i40e_tx_desc *tx_desc;
> +       u16 i = xdp_ring->next_to_use;
> +       dma_addr_t dma;
> +       u32 size = xdp->data_end - xdp->data;
> +
> +       if (!unlikely(I40E_DESC_UNUSED(xdp_ring))) {
> +               xdp_ring->tx_stats.tx_busy++;
> +               return I40E_XDP_CONSUMED;
> +       }
> +
> +       dma = dma_map_single(xdp_ring->dev, xdp->data, size, DMA_TO_DEVICE);
> +       if (dma_mapping_error(xdp_ring->dev, dma))
> +               return I40E_XDP_CONSUMED;
> +
> +       tx_bi = &xdp_ring->tx_bi[i];
> +       tx_bi->bytecount = size;
> +       tx_bi->gso_segs = 1;
> +       tx_bi->raw_buf = xdp->data;
> +
> +       /* record length, and DMA address */
> +       dma_unmap_len_set(tx_bi, len, size);
> +       dma_unmap_addr_set(tx_bi, dma, dma);
> +
> +       tx_desc = I40E_TX_DESC(xdp_ring, i);
> +       tx_desc->buffer_addr = cpu_to_le64(dma);
> +       tx_desc->cmd_type_offset_bsz = build_ctob(I40E_TX_DESC_CMD_ICRC
> +                                                 | I40E_TXD_CMD,
> +                                                 0, size, 0);
> +
> +       /* Make certain all of the status bits have been updated
> +        * before next_to_watch is written.
> +        */
> +       smp_wmb();
> +
> +       i++;
> +       if (i == xdp_ring->count)
> +               i = 0;
> +
> +       tx_bi->next_to_watch = tx_desc;
> +       xdp_ring->next_to_use = i;
> +
> +       return I40E_XDP_TX;
> +}
> +
> +/**
>   * i40e_xmit_frame_ring - Sends buffer on Tx ring
>   * @skb:     send buffer
>   * @tx_ring: ring to send buffer on
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index 31f0b162996f..b288d58313a6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -396,6 +396,7 @@ struct i40e_ring {
>         u16 flags;
>  #define I40E_TXR_FLAGS_WB_ON_ITR               BIT(0)
>  #define I40E_RXR_FLAGS_BUILD_SKB_ENABLED       BIT(1)
> +#define I40E_TXR_FLAGS_XDP                     BIT(2)
>
>         /* stats structs */
>         struct i40e_queue_stats stats;
> @@ -438,6 +439,16 @@ static inline void clear_ring_build_skb_enabled(struct i40e_ring *ring)
>         ring->flags &= ~I40E_RXR_FLAGS_BUILD_SKB_ENABLED;
>  }
>
> +static inline bool ring_is_xdp(struct i40e_ring *ring)
> +{
> +       return !!(ring->flags & I40E_TXR_FLAGS_XDP);
> +}
> +
> +static inline void set_ring_xdp(struct i40e_ring *ring)
> +{
> +       ring->flags |= I40E_TXR_FLAGS_XDP;
> +}
> +
>  enum i40e_latency_range {
>         I40E_LOWEST_LATENCY = 0,
>         I40E_LOW_LATENCY = 1,
> --
> 2.11.0
>
