From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 15 Apr 2016 10:25:37 -0700
Subject: [Intel-wired-lan] [next PATCH S35 11/14] i40e/i40evf: Refactor
 receive routine
In-Reply-To: <1460639974-2556-12-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460639974-2556-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460639974-2556-12-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <CAKgT0UfHqgZ=874HiTR6osxFO=y24Z6=a1Q-0E8ab+s9DFsOCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Apr 14, 2016 at 6:19 AM, Harshitha Ramamurthy
<harshitha.ramamurthy@intel.com> wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
>
> This refactor aligns the receive routine with the one in
> ixgbe which was highly optimized.  This reduces the code
> we have to maintain and allows for (hopefully) more readable
> and maintainable RX hot path.
>
> In order to do this:
> - consolidate the receive path into a single function that doesn't
>   use packet split but *does* use pages for rx buffers.
> - remove the old _1buf and _ps routines
> - consolidate several routines into helper functions
> - remove ethtool control over packet split
> - remove VF ethtool control over packet split
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I5ca100721de65992aa0114f8b4bac844b84758e0
> ---
> Testing Hints : lots of receive traffic, make
> sure it's all working, PF and VF. Please test on a machine with 8kB
> or larger pages, and check for memory leaks.
>
>  drivers/net/ethernet/intel/i40e/i40e.h             |   4 -
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  12 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |  20 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  57 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 951 ++++++++++-----------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  45 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 911 ++++++++++----------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  45 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   7 -
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  52 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  31 +-
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   4 -
>  12 files changed, 977 insertions(+), 1162 deletions(-)

If due to only the size I really think this should probably be split
into two patches.  One for the VF and one for the PF.  That way we
should only be looking at about 1000 lines of change per patch instead
of 2000 which becomes a bit unwieldy.  If nothing else it makes the
reviews easier to read as we don't end up with a novel with review
comments scattered throughout.

> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
> index b5fcd9c..5e23cc9 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
> @@ -101,7 +101,6 @@
>  #define I40E_PRIV_FLAGS_LINKPOLL_FLAG  BIT(1)
>  #define I40E_PRIV_FLAGS_FD_ATR         BIT(2)
>  #define I40E_PRIV_FLAGS_VEB_STATS      BIT(3)
> -#define I40E_PRIV_FLAGS_PS             BIT(4)
>  #define I40E_PRIV_FLAGS_HW_ATR_EVICT   BIT(5)
>
>  #define I40E_NVM_VERSION_LO_SHIFT  0
> @@ -335,8 +334,6 @@ struct i40e_pf {
>  #define I40E_FLAG_RX_CSUM_ENABLED              BIT_ULL(1)
>  #define I40E_FLAG_MSI_ENABLED                  BIT_ULL(2)
>  #define I40E_FLAG_MSIX_ENABLED                 BIT_ULL(3)
> -#define I40E_FLAG_RX_1BUF_ENABLED              BIT_ULL(4)
> -#define I40E_FLAG_RX_PS_ENABLED                        BIT_ULL(5)
>  #define I40E_FLAG_RSS_ENABLED                  BIT_ULL(6)
>  #define I40E_FLAG_VMDQ_ENABLED                 BIT_ULL(7)
>  #define I40E_FLAG_FDIR_REQUIRES_REINIT         BIT_ULL(8)
> @@ -549,7 +546,6 @@ struct i40e_vsi {
>         u8  *rss_lut_user;  /* User configured lookup table entries */
>
>         u16 max_frame;
> -       u16 rx_hdr_len;
>         u16 rx_buf_len;
>         u8  dtype;
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> index 83dccf1..519cfc8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
> @@ -268,13 +268,13 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
>                          rx_ring->queue_index,
>                          rx_ring->reg_idx);
>                 dev_info(&pf->pdev->dev,
> -                        "    rx_rings[%i]: rx_hdr_len = %d, rx_buf_len = %d, dtype = %d\n",
> -                        i, rx_ring->rx_hdr_len,
> +                        "    rx_rings[%i]: rx_buf_len = %d, dtype = %d\n",
> +                        i,
>                          rx_ring->rx_buf_len,
>                          rx_ring->dtype);
>                 dev_info(&pf->pdev->dev,
> -                        "    rx_rings[%i]: hsplit = %d, next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
> -                        i, ring_is_ps_enabled(rx_ring),
> +                        "    rx_rings[%i]: next_to_use = %d, next_to_clean = %d, ring_active = %i\n",
> +                        i,
>                          rx_ring->next_to_use,
>                          rx_ring->next_to_clean,
>                          rx_ring->ring_active);
> @@ -365,8 +365,8 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
>                  "    work_limit = %d\n",
>                  vsi->work_limit);
>         dev_info(&pf->pdev->dev,
> -                "    max_frame = %d, rx_hdr_len = %d, rx_buf_len = %d dtype = %d\n",
> -                vsi->max_frame, vsi->rx_hdr_len, vsi->rx_buf_len, vsi->dtype);
> +                "    max_frame = %d, rx_buf_len = %d dtype = %d\n",
> +                vsi->max_frame, vsi->rx_buf_len, vsi->dtype);
>         dev_info(&pf->pdev->dev,
>                  "    num_q_vectors = %i, base_vector = %i\n",
>                  vsi->num_q_vectors, vsi->base_vector);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index 35c211f..feb370b 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -235,7 +235,6 @@ static const char i40e_priv_flags_strings[][ETH_GSTRING_LEN] = {
>         "LinkPolling",
>         "flow-director-atr",
>         "veb-stats",
> -       "packet-split",
>         "hw-atr-eviction",
>  };
>
> @@ -2997,8 +2996,6 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
>                 I40E_PRIV_FLAGS_FD_ATR : 0;
>         ret_flags |= pf->flags & I40E_FLAG_VEB_STATS_ENABLED ?
>                 I40E_PRIV_FLAGS_VEB_STATS : 0;
> -       ret_flags |= pf->flags & I40E_FLAG_RX_PS_ENABLED ?
> -               I40E_PRIV_FLAGS_PS : 0;
>         ret_flags |= pf->auto_disable_flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE ?
>                 0 : I40E_PRIV_FLAGS_HW_ATR_EVICT;
>

One thing you might want to consider would be to pull the PS_ENABLED
option removal off into a separate patch.  If I recall I did something
similar when I was making these changes for igb and ixgbe.  Then at
least you will be looking at fewer files that have to change in the
next one.  In addition you can somewhat automate the process that way
as it would just be all cases where the flag is false become the
default.

> @@ -3019,23 +3016,6 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
>
>         /* NOTE: MFP is not settable */
>
> -       /* allow the user to control the method of receive
> -        * buffer DMA, whether the packet is split at header
> -        * boundaries into two separate buffers.  In some cases
> -        * one routine or the other will perform better.
> -        */
> -       if ((flags & I40E_PRIV_FLAGS_PS) &&
> -           !(pf->flags & I40E_FLAG_RX_PS_ENABLED)) {
> -               pf->flags |= I40E_FLAG_RX_PS_ENABLED;
> -               pf->flags &= ~I40E_FLAG_RX_1BUF_ENABLED;
> -               reset_required = true;
> -       } else if (!(flags & I40E_PRIV_FLAGS_PS) &&
> -                  (pf->flags & I40E_FLAG_RX_PS_ENABLED)) {
> -               pf->flags &= ~I40E_FLAG_RX_PS_ENABLED;
> -               pf->flags |= I40E_FLAG_RX_1BUF_ENABLED;
> -               reset_required = true;
> -       }
> -
>         if (flags & I40E_PRIV_FLAGS_LINKPOLL_FLAG)
>                 pf->flags |= I40E_FLAG_LINK_POLLING_ENABLED;
>         else
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 6308218..b5713ae 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -2856,10 +2856,8 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>         memset(&rx_ctx, 0, sizeof(rx_ctx));
>
>         ring->rx_buf_len = vsi->rx_buf_len;
> -       ring->rx_hdr_len = vsi->rx_hdr_len;
>
>         rx_ctx.dbuff = ring->rx_buf_len >> I40E_RXQ_CTX_DBUFF_SHIFT;
> -       rx_ctx.hbuff = ring->rx_hdr_len >> I40E_RXQ_CTX_HBUFF_SHIFT;
>
>         rx_ctx.base = (ring->dma / 128);
>         rx_ctx.qlen = ring->count;

So one concern I would have here would be to verify there isn't
anything that depends on the header length being defined for parsing.
I ask because I recall the 82599 had a dependency for the header
buffer length to be set for RSC to work correctly.  You might want to
make sure that setting this to 0 is correct.

> @@ -2872,18 +2870,9 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>         }
>
>         rx_ctx.dtype = vsi->dtype;
> -       if (vsi->dtype) {
> -               set_ring_ps_enabled(ring);
> -               rx_ctx.hsplit_0 = I40E_RX_SPLIT_L2      |
> -                                 I40E_RX_SPLIT_IP      |
> -                                 I40E_RX_SPLIT_TCP_UDP |
> -                                 I40E_RX_SPLIT_SCTP;
> -       } else {
> -               rx_ctx.hsplit_0 = 0;
> -       }
> +       rx_ctx.hsplit_0 = 0;
>
> -       rx_ctx.rxmax = min_t(u16, vsi->max_frame,
> -                                 (chain_len * ring->rx_buf_len));
> +       rx_ctx.rxmax = min_t(u16, vsi->max_frame, chain_len * ring->rx_buf_len);
>         if (hw->revision_id == 0)
>                 rx_ctx.lrxqthresh = 0;
>         else

You might want to look at updating this rxmax value to something that
supports whatever your maximum jumbo frame size is.  There shouldn't
be any need to block any frame here because your maximum supported
frame size should be something like 32K with descriptor chaining.

> @@ -2920,12 +2909,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>         ring->tail = hw->hw_addr + I40E_QRX_TAIL(pf_q);
>         writel(0, ring->tail);
>
> -       if (ring_is_ps_enabled(ring)) {
> -               i40e_alloc_rx_headers(ring);
> -               i40e_alloc_rx_buffers_ps(ring, I40E_DESC_UNUSED(ring));
> -       } else {
> -               i40e_alloc_rx_buffers_1buf(ring, I40E_DESC_UNUSED(ring));
> -       }
> +       i40e_alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
>
>         return 0;
>  }
> @@ -2964,31 +2948,13 @@ static int i40e_vsi_configure_rx(struct i40e_vsi *vsi)
>         else
>                 vsi->max_frame = I40E_RXBUFFER_2048;
>
> -       /* figure out correct receive buffer length */
> -       switch (vsi->back->flags & (I40E_FLAG_RX_1BUF_ENABLED |
> -                                   I40E_FLAG_RX_PS_ENABLED)) {
> -       case I40E_FLAG_RX_1BUF_ENABLED:
> -               vsi->rx_hdr_len = 0;
> -               vsi->rx_buf_len = vsi->max_frame;
> -               vsi->dtype = I40E_RX_DTYPE_NO_SPLIT;
> -               break;
> -       case I40E_FLAG_RX_PS_ENABLED:
> -               vsi->rx_hdr_len = I40E_RX_HDR_SIZE;
> -               vsi->rx_buf_len = I40E_RXBUFFER_2048;
> -               vsi->dtype = I40E_RX_DTYPE_HEADER_SPLIT;
> -               break;
> -       default:
> -               vsi->rx_hdr_len = I40E_RX_HDR_SIZE;
> -               vsi->rx_buf_len = I40E_RXBUFFER_2048;
> -               vsi->dtype = I40E_RX_DTYPE_SPLIT_ALWAYS;
> -               break;
> -       }
> +       vsi->rx_buf_len = I40E_RXBUFFER_2048;
> +       vsi->dtype = I40E_RX_DTYPE_NO_SPLIT;
>
>  #ifdef I40E_FCOE
>         /* setup rx buffer for FCoE */
>         if ((vsi->type == I40E_VSI_FCOE) &&
>             (vsi->back->flags & I40E_FLAG_FCOE_ENABLED)) {
> -               vsi->rx_hdr_len = 0;
>                 vsi->rx_buf_len = I40E_RXBUFFER_3072;
>                 vsi->max_frame = I40E_RXBUFFER_3072;
>                 vsi->dtype = I40E_RX_DTYPE_NO_SPLIT;
> @@ -2996,8 +2962,6 @@ static int i40e_vsi_configure_rx(struct i40e_vsi *vsi)
>
>  #endif /* I40E_FCOE */
>         /* round up for the chip's needs */
> -       vsi->rx_hdr_len = ALIGN(vsi->rx_hdr_len,
> -                               BIT_ULL(I40E_RXQ_CTX_HBUFF_SHIFT));
>         vsi->rx_buf_len = ALIGN(vsi->rx_buf_len,
>                                 BIT_ULL(I40E_RXQ_CTX_DBUFF_SHIFT));
>
> @@ -8461,11 +8425,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>                     I40E_FLAG_MSI_ENABLED     |
>                     I40E_FLAG_MSIX_ENABLED;
>
> -       if (iommu_present(&pci_bus_type))
> -               pf->flags |= I40E_FLAG_RX_PS_ENABLED;
> -       else
> -               pf->flags |= I40E_FLAG_RX_1BUF_ENABLED;
> -
>         /* Set default ITR */
>         pf->rx_itr_default = I40E_ITR_DYNAMIC | I40E_ITR_RX_DEF;
>         pf->tx_itr_default = I40E_ITR_DYNAMIC | I40E_ITR_TX_DEF;
> @@ -10691,11 +10650,9 @@ static void i40e_print_features(struct i40e_pf *pf)
>  #ifdef CONFIG_PCI_IOV
>         i += snprintf(&buf[i], REMAIN(i), " VFs: %d", pf->num_req_vfs);
>  #endif
> -       i += snprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d RX: %s",
> +       i += snprintf(&buf[i], REMAIN(i), " VSIs: %d QP: %d",
>                       pf->hw.func_caps.num_vsis,
> -                     pf->vsi[pf->lan_vsi]->num_queue_pairs,
> -                     pf->flags & I40E_FLAG_RX_PS_ENABLED ? "PS" : "1BUF");
> -
> +                     pf->vsi[pf->lan_vsi]->num_queue_pairs);
>         if (pf->flags & I40E_FLAG_RSS_ENABLED)
>                 i += snprintf(&buf[i], REMAIN(i), " RSS");
>         if (pf->flags & I40E_FLAG_FD_ATR_ENABLED)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ce4d94b..2f50ab8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -1042,7 +1042,6 @@ err:
>  void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>  {
>         struct device *dev = rx_ring->dev;
> -       struct i40e_rx_buffer *rx_bi;
>         unsigned long bi_size;
>         u16 i;
>
> @@ -1050,48 +1049,22 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>         if (!rx_ring->rx_bi)
>                 return;
>
> -       if (ring_is_ps_enabled(rx_ring)) {
> -               int bufsz = ALIGN(rx_ring->rx_hdr_len, 256) * rx_ring->count;
> -
> -               rx_bi = &rx_ring->rx_bi[0];
> -               if (rx_bi->hdr_buf) {
> -                       dma_free_coherent(dev,
> -                                         bufsz,
> -                                         rx_bi->hdr_buf,
> -                                         rx_bi->dma);
> -                       for (i = 0; i < rx_ring->count; i++) {
> -                               rx_bi = &rx_ring->rx_bi[i];
> -                               rx_bi->dma = 0;
> -                               rx_bi->hdr_buf = NULL;
> -                       }
> -               }
> -       }
>         /* Free all the Rx ring sk_buffs */
>         for (i = 0; i < rx_ring->count; i++) {
> -               rx_bi = &rx_ring->rx_bi[i];
> -               if (rx_bi->dma) {
> -                       dma_unmap_single(dev,
> -                                        rx_bi->dma,
> -                                        rx_ring->rx_buf_len,
> -                                        DMA_FROM_DEVICE);
> -                       rx_bi->dma = 0;
> -               }
> +               struct i40e_rx_buffer *rx_bi = &rx_ring->rx_bi[i];
> +
>                 if (rx_bi->skb) {
>                         dev_kfree_skb(rx_bi->skb);
>                         rx_bi->skb = NULL;
>                 }
> -               if (rx_bi->page) {
> -                       if (rx_bi->page_dma) {
> -                               dma_unmap_page(dev,
> -                                              rx_bi->page_dma,
> -                                              PAGE_SIZE,
> -                                              DMA_FROM_DEVICE);
> -                               rx_bi->page_dma = 0;
> -                       }
> -                       __free_page(rx_bi->page);
> -                       rx_bi->page = NULL;
> -                       rx_bi->page_offset = 0;
> -               }
> +               if (!rx_bi->page)
> +                       continue;
> +
> +               dma_unmap_page(dev, rx_bi->dma, PAGE_SIZE, DMA_FROM_DEVICE);
> +               __free_pages(rx_bi->page, 0);

If the order is going to be 0 you can just use __free_page instead of
__free_pages.

> +
> +               rx_bi->page = NULL;
> +               rx_bi->page_offset = 0;
>         }
>
>         bi_size = sizeof(struct i40e_rx_buffer) * rx_ring->count;
> @@ -1100,6 +1073,7 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>         /* Zero out the descriptor ring */
>         memset(rx_ring->desc, 0, rx_ring->size);
>
> +       rx_ring->next_to_alloc = 0;
>         rx_ring->next_to_clean = 0;
>         rx_ring->next_to_use = 0;
>  }
> @@ -1124,37 +1098,6 @@ void i40e_free_rx_resources(struct i40e_ring *rx_ring)
>  }
>
>  /**
> - * i40e_alloc_rx_headers - allocate rx header buffers
> - * @rx_ring: ring to alloc buffers
> - *
> - * Allocate rx header buffers for the entire ring. As these are static,
> - * this is only called when setting up a new ring.
> - **/
> -void i40e_alloc_rx_headers(struct i40e_ring *rx_ring)
> -{
> -       struct device *dev = rx_ring->dev;
> -       struct i40e_rx_buffer *rx_bi;
> -       dma_addr_t dma;
> -       void *buffer;
> -       int buf_size;
> -       int i;
> -
> -       if (rx_ring->rx_bi[0].hdr_buf)
> -               return;
> -       /* Make sure the buffers don't cross cache line boundaries. */
> -       buf_size = ALIGN(rx_ring->rx_hdr_len, 256);
> -       buffer = dma_alloc_coherent(dev, buf_size * rx_ring->count,
> -                                   &dma, GFP_KERNEL);
> -       if (!buffer)
> -               return;
> -       for (i = 0; i < rx_ring->count; i++) {
> -               rx_bi = &rx_ring->rx_bi[i];
> -               rx_bi->dma = dma + (i * buf_size);
> -               rx_bi->hdr_buf = buffer + (i * buf_size);
> -       }
> -}
> -
> -/**
>   * i40e_setup_rx_descriptors - Allocate Rx descriptors
>   * @rx_ring: Rx descriptor ring (for a specific queue) to setup
>   *
> @@ -1175,9 +1118,7 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
>         u64_stats_init(&rx_ring->syncp);
>
>         /* Round up to nearest 4K */
> -       rx_ring->size = ring_is_16byte_desc_enabled(rx_ring)
> -               ? rx_ring->count * sizeof(union i40e_16byte_rx_desc)
> -               : rx_ring->count * sizeof(union i40e_32byte_rx_desc);
> +       rx_ring->size = rx_ring->count * sizeof(union i40e_32byte_rx_desc);
>         rx_ring->size = ALIGN(rx_ring->size, 4096);
>         rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
>                                            &rx_ring->dma, GFP_KERNEL);
> @@ -1188,6 +1129,7 @@ int i40e_setup_rx_descriptors(struct i40e_ring *rx_ring)
>                 goto err;
>         }
>
> +       rx_ring->next_to_alloc = 0;
>         rx_ring->next_to_clean = 0;
>         rx_ring->next_to_use = 0;
>
> @@ -1206,6 +1148,10 @@ err:
>  static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>  {
>         rx_ring->next_to_use = val;
> +
> +       /* update next to alloc since we have filled the ring */
> +       rx_ring->next_to_alloc = val;
> +
>         /* Force memory writes to complete before letting h/w
>          * know there are new descriptors to fetch.  (Only
>          * applicable for weak-ordered memory model archs,
> @@ -1216,160 +1162,122 @@ static inline void i40e_release_rx_desc(struct i40e_ring *rx_ring, u32 val)
>  }
>
>  /**
> - * i40e_alloc_rx_buffers_ps - Replace used receive buffers; packet split
> - * @rx_ring: ring to place buffers on
> - * @cleaned_count: number of buffers to replace
> + * i40e_alloc_mapped_page - recycle or make a new page
> + * @rx_ring: ring to use
> + * @bi: rx_buffer struct to modify
>   *
> - * Returns true if any errors on allocation
> + * Returns true if the page was successfully allocated or
> + * reused.
>   **/
> -bool i40e_alloc_rx_buffers_ps(struct i40e_ring *rx_ring, u16 cleaned_count)
> +static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
> +                                  struct i40e_rx_buffer *bi)
>  {
> -       u16 i = rx_ring->next_to_use;
> -       union i40e_rx_desc *rx_desc;
> -       struct i40e_rx_buffer *bi;
> -       const int current_node = numa_node_id();
> +       struct page *page = bi->page;
> +       dma_addr_t dma;
>
> -       /* do nothing if no valid netdev defined */
> -       if (!rx_ring->netdev || !cleaned_count)
> -               return false;
> +       /* since we are recycling buffers we should seldom need to alloc */
> +       if (likely(page)) {
> +               rx_ring->rx_stats.page_reuse_count++;
> +               return true;
> +       }

I'd say you can probably get rid of the reuse_count stat.  Instead I
would track the number of pages allocated if you need a statistic.
That way the fast path can remain fast while the slow path should only
take a minor hit.

>
> -       while (cleaned_count--) {
> -               rx_desc = I40E_RX_DESC(rx_ring, i);
> -               bi = &rx_ring->rx_bi[i];
> +       /* alloc new page for storage */
> +       page = dev_alloc_page();
> +       if (unlikely(!page)) {
> +               rx_ring->rx_stats.alloc_page_failed++;
> +               return false;
> +       }
>
> -               if (bi->skb) /* desc is in use */
> -                       goto no_buffers;
> +       /* map page for use */
> +       dma = dma_map_page(rx_ring->dev, page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
>
> -       /* If we've been moved to a different NUMA node, release the
> -        * page so we can get a new one on the current node.
> +       /* if mapping failed free memory back to system since
> +        * there isn't much point in holding memory we can't use
>          */
> -               if (bi->page &&  page_to_nid(bi->page) != current_node) {
> -                       dma_unmap_page(rx_ring->dev,
> -                                      bi->page_dma,
> -                                      PAGE_SIZE,
> -                                      DMA_FROM_DEVICE);
> -                       __free_page(bi->page);
> -                       bi->page = NULL;
> -                       bi->page_dma = 0;
> -                       rx_ring->rx_stats.realloc_count++;
> -               } else if (bi->page) {
> -                       rx_ring->rx_stats.page_reuse_count++;
> -               }
> -
> -               if (!bi->page) {
> -                       bi->page = alloc_page(GFP_ATOMIC);
> -                       if (!bi->page) {
> -                               rx_ring->rx_stats.alloc_page_failed++;
> -                               goto no_buffers;
> -                       }
> -                       bi->page_dma = dma_map_page(rx_ring->dev,
> -                                                   bi->page,
> -                                                   0,
> -                                                   PAGE_SIZE,
> -                                                   DMA_FROM_DEVICE);
> -                       if (dma_mapping_error(rx_ring->dev, bi->page_dma)) {
> -                               rx_ring->rx_stats.alloc_page_failed++;
> -                               __free_page(bi->page);
> -                               bi->page = NULL;
> -                               bi->page_dma = 0;
> -                               bi->page_offset = 0;
> -                               goto no_buffers;
> -                       }
> -                       bi->page_offset = 0;
> -               }
> -
> -               /* Refresh the desc even if buffer_addrs didn't change
> -                * because each write-back erases this info.
> -                */
> -               rx_desc->read.pkt_addr =
> -                               cpu_to_le64(bi->page_dma + bi->page_offset);
> -               rx_desc->read.hdr_addr = cpu_to_le64(bi->dma);
> -               i++;
> -               if (i == rx_ring->count)
> -                       i = 0;
> +       if (dma_mapping_error(rx_ring->dev, dma)) {
> +               __free_pages(page, 0);

Order 0 page can just use __free_page.

> +               rx_ring->rx_stats.alloc_page_failed++;
> +               return false;
>         }
>
> -       if (rx_ring->next_to_use != i)
> -               i40e_release_rx_desc(rx_ring, i);
> +       bi->dma = dma;
> +       bi->page = page;
> +       bi->page_offset = 0;
>
> -       return false;
> +       return true;
> +}
>
> -no_buffers:
> -       if (rx_ring->next_to_use != i)
> -               i40e_release_rx_desc(rx_ring, i);
> +/**
> + * i40e_receive_skb - Send a completed packet up the stack
> + * @rx_ring:  rx ring in play
> + * @skb: packet to send up
> + * @vlan_tag: vlan tag for packet
> + **/
> +static void i40e_receive_skb(struct i40e_ring *rx_ring,
> +                            struct sk_buff *skb, u16 vlan_tag)
> +{
> +       struct i40e_q_vector *q_vector = rx_ring->q_vector;
>
> -       /* make sure to come back via polling to try again after
> -        * allocation failure
> -        */
> -       return true;
> +       if ((rx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
> +           (vlan_tag & VLAN_VID_MASK))
> +               __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> +

Really this piece does not fit in here.  You would be better off
keeping it with the rest of the Rx descriptor processing since that is
where the VLAN tag originated from.

> +       napi_gro_receive(&q_vector->napi, skb);
>  }
>
>  /**
> - * i40e_alloc_rx_buffers_1buf - Replace used receive buffers; single buffer
> + * i40e_alloc_rx_buffers - Replace used receive buffers
>   * @rx_ring: ring to place buffers on
>   * @cleaned_count: number of buffers to replace
>   *
> - * Returns true if any errors on allocation
> + * Returns false if all allocations were successful, true if any fail
>   **/
> -bool i40e_alloc_rx_buffers_1buf(struct i40e_ring *rx_ring, u16 cleaned_count)
> +bool i40e_alloc_rx_buffers(struct i40e_ring *rx_ring, u16 cleaned_count)
>  {
> -       u16 i = rx_ring->next_to_use;
> +       u16 ntu = rx_ring->next_to_use;
>         union i40e_rx_desc *rx_desc;
>         struct i40e_rx_buffer *bi;
> -       struct sk_buff *skb;
>
>         /* do nothing if no valid netdev defined */
>         if (!rx_ring->netdev || !cleaned_count)
>                 return false;
>
> -       while (cleaned_count--) {
> -               rx_desc = I40E_RX_DESC(rx_ring, i);
> -               bi = &rx_ring->rx_bi[i];
> -               skb = bi->skb;
> -
> -               if (!skb) {
> -                       skb = __netdev_alloc_skb_ip_align(rx_ring->netdev,
> -                                                         rx_ring->rx_buf_len,
> -                                                         GFP_ATOMIC |
> -                                                         __GFP_NOWARN);
> -                       if (!skb) {
> -                               rx_ring->rx_stats.alloc_buff_failed++;
> -                               goto no_buffers;
> -                       }
> -                       /* initialize queue mapping */
> -                       skb_record_rx_queue(skb, rx_ring->queue_index);
> -                       bi->skb = skb;
> -               }
> +       rx_desc = I40E_RX_DESC(rx_ring, ntu);
> +       bi = &rx_ring->rx_bi[ntu];
>
> -               if (!bi->dma) {
> -                       bi->dma = dma_map_single(rx_ring->dev,
> -                                                skb->data,
> -                                                rx_ring->rx_buf_len,
> -                                                DMA_FROM_DEVICE);
> -                       if (dma_mapping_error(rx_ring->dev, bi->dma)) {
> -                               rx_ring->rx_stats.alloc_buff_failed++;
> -                               bi->dma = 0;
> -                               dev_kfree_skb(bi->skb);
> -                               bi->skb = NULL;
> -                               goto no_buffers;
> -                       }
> -               }
> +       do {
> +               if (!i40e_alloc_mapped_page(rx_ring, bi))
> +                       goto no_buffers;
>

Instead of using a goto you can just use a break here.  See my comment
on how to deal with the return value below.

> -               rx_desc->read.pkt_addr = cpu_to_le64(bi->dma);
> +               /* Refresh the desc even if buffer_addrs didn't change
> +                * because each write-back erases this info.
> +                */
> +               rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
>                 rx_desc->read.hdr_addr = 0;
> -               i++;
> -               if (i == rx_ring->count)
> -                       i = 0;
> -       }
>
> -       if (rx_ring->next_to_use != i)
> -               i40e_release_rx_desc(rx_ring, i);
> +               rx_desc++;
> +               bi++;
> +               ntu++;
> +               if (unlikely(ntu == rx_ring->count)) {
> +                       rx_desc = I40E_RX_DESC(rx_ring, 0);
> +                       bi = rx_ring->rx_bi;
> +                       ntu = 0;
> +               }
> +
> +               /* clear the status bits for the next_to_use descriptor */
> +               rx_desc->wb.qword1.status_error_len = 0;
> +
> +               cleaned_count--;
> +       } while (cleaned_count);
> +
> +       if (rx_ring->next_to_use != ntu)
> +               i40e_release_rx_desc(rx_ring, ntu);
>
>         return false;
>

You probably don't really need the branch.  If you have an allocation
failure you can just break and then return !cleaned_count at the end.

>  no_buffers:
> -       if (rx_ring->next_to_use != i)
> -               i40e_release_rx_desc(rx_ring, i);
> +       if (rx_ring->next_to_use != ntu)
> +               i40e_release_rx_desc(rx_ring, ntu);
>
>         /* make sure to come back via polling to try again after
>          * allocation failure
> @@ -1378,42 +1286,35 @@ no_buffers:
>  }
>
>  /**
> - * i40e_receive_skb - Send a completed packet up the stack
> - * @rx_ring:  rx ring in play
> - * @skb: packet to send up
> - * @vlan_tag: vlan tag for packet
> - **/
> -static void i40e_receive_skb(struct i40e_ring *rx_ring,
> -                            struct sk_buff *skb, u16 vlan_tag)
> -{
> -       struct i40e_q_vector *q_vector = rx_ring->q_vector;
> -
> -       if ((rx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
> -           (vlan_tag & VLAN_VID_MASK))
> -               __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> -
> -       napi_gro_receive(&q_vector->napi, skb);
> -}
> -
> -/**
>   * i40e_rx_checksum - Indicate in skb if hw indicated a good cksum
>   * @vsi: the VSI we care about
>   * @skb: skb currently being received and modified
> - * @rx_status: status value of last descriptor in packet
> - * @rx_error: error value of last descriptor in packet
> - * @rx_ptype: ptype value of last descriptor in packet
> + * @rx_desc: the receive descriptor
> + *
> + * skb->protocol must be set before this function is called
>   **/
>  static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
>                                     struct sk_buff *skb,
> -                                   u32 rx_status,
> -                                   u32 rx_error,
> -                                   u16 rx_ptype)
> +                                   union i40e_rx_desc *rx_desc)
>  {
> -       struct i40e_rx_ptype_decoded decoded = decode_rx_desc_ptype(rx_ptype);
> +       struct i40e_rx_ptype_decoded decoded;
>         bool ipv4, ipv6, tunnel = false;
> +       u32 rx_error, rx_status;
> +       u8 ptype;
> +       u64 qword;
> +

So the ordering is screwed up on this.  There should be the
checksum_none_assert and NETIF_F_RXCSUM check up here.  We don't need
to do any of this decoding if we aren't doing a checksum.

> +       qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> +       ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >> I40E_RXD_QW1_PTYPE_SHIFT;
> +       rx_error = (qword & I40E_RXD_QW1_ERROR_MASK) >>
> +                  I40E_RXD_QW1_ERROR_SHIFT;
> +       rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
> +                   I40E_RXD_QW1_STATUS_SHIFT;
> +       decoded = decode_rx_desc_ptype(ptype);

This code should only be run after we have already tested for
I40E_RX_DESC_STATUS_L3L4P_SHIFT in the descriptor.  It would be the
perfect spot to look at using the staterr check function that checks
for a bit without requiring you to do any byteswapping.

In addition all the Rx error checks can benefit from the same thing as
well.  Odds are you just need to go through and clean this code up so
that you are using the staterr function wherever it is applicable.

>         skb->ip_summed = CHECKSUM_NONE;
>
> +       skb_checksum_none_assert(skb);
> +

Choose one.  Either we force CHECKSUM_NONE or we assert that it must
be 0.  Doing both here is kind of pointless.

>         /* Rx csum enabled and ip headers found? */
>         if (!(vsi->netdev->features & NETIF_F_RXCSUM))
>                 return;
> @@ -1479,7 +1380,7 @@ checksum_fail:
>   *
>   * Returns a hash type to be used by skb_set_hash
>   **/
> -static inline enum pkt_hash_types i40e_ptype_to_htype(u8 ptype)
> +static inline int i40e_ptype_to_htype(u8 ptype)
>  {
>         struct i40e_rx_ptype_decoded decoded = decode_rx_desc_ptype(ptype);
>
> @@ -1507,7 +1408,7 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
>                                 u8 rx_ptype)
>  {
>         u32 hash;
> -       const __le64 rss_mask  =
> +       const __le64 rss_mask =
>                 cpu_to_le64((u64)I40E_RX_DESC_FLTSTAT_RSS_HASH <<
>                             I40E_RX_DESC_STATUS_FLTSTAT_SHIFT);
>
> @@ -1521,338 +1422,409 @@ static inline void i40e_rx_hash(struct i40e_ring *ring,
>  }
>
>  /**
> - * i40e_clean_rx_irq_ps - Reclaim resources after receive; packet split
> - * @rx_ring:  rx ring to clean
> - * @budget:   how many cleans we're allowed
> + * i40e_process_skb_fields - Populate skb header fields from Rx descriptor
> + * @rx_ring: rx descriptor ring packet is being transacted on
> + * @rx_desc: pointer to the EOP Rx descriptor
> + * @skb: pointer to current skb being populated
> + * @rx_ptype: the packet type decoded by hardware
>   *
> - * Returns true if there's any budget left (e.g. the clean is finished)
> + * This function checks the ring, descriptor, and packet information in
> + * order to populate the hash, checksum, VLAN, protocol, and
> + * other fields within the skb.
>   **/
> -static int i40e_clean_rx_irq_ps(struct i40e_ring *rx_ring, const int budget)
> +static inline
> +void i40e_process_skb_fields(struct i40e_ring *rx_ring,
> +                            union i40e_rx_desc *rx_desc, struct sk_buff *skb,
> +                            u8 rx_ptype)
>  {
> -       unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> -       u16 rx_packet_len, rx_header_len, rx_sph, rx_hbo;
> -       u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
> -       struct i40e_vsi *vsi = rx_ring->vsi;
> -       u16 i = rx_ring->next_to_clean;
> -       union i40e_rx_desc *rx_desc;
> -       u32 rx_error, rx_status;
> -       bool failure = false;
> -       u8 rx_ptype;
> -       u64 qword;
> -       u32 copysize;
> +       u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> +       u32 rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
> +                       I40E_RXD_QW1_STATUS_SHIFT;
> +       u32 rsyn = (rx_status & I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
> +                  I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT;

The fewer byteswaps you have to do the better for non-Intel architectures.

> -       if (budget <= 0)
> -               return 0;
> +       if (unlikely(rsyn)) {
> +               i40e_ptp_rx_hwtstamp(rx_ring->vsi->back, skb, rsyn);
> +               rx_ring->last_rx_timestamp = jiffies;
> +       }
>
> -       do {
> -               struct i40e_rx_buffer *rx_bi;
> -               struct sk_buff *skb;
> -               u16 vlan_tag;
> -               /* return some buffers to hardware, one at a time is too slow */
> -               if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
> -                       failure = failure ||
> -                                 i40e_alloc_rx_buffers_ps(rx_ring,
> -                                                          cleaned_count);
> -                       cleaned_count = 0;
> -               }
> +       i40e_rx_hash(rx_ring, rx_desc, skb, rx_ptype);

Since both the Rx hash and the Rx checksum depend on the Rx packet
type information you might want to try combining some of that so that
you can avoid duplication of effort.

> -               i = rx_ring->next_to_clean;
> -               rx_desc = I40E_RX_DESC(rx_ring, i);
> -               qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> -               rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
> -                       I40E_RXD_QW1_STATUS_SHIFT;
> +       /* modifies the skb - consumes the enet header */
> +       skb->protocol = eth_type_trans(skb, rx_ring->netdev);
>
> -               if (!(rx_status & BIT(I40E_RX_DESC_STATUS_DD_SHIFT)))
> -                       break;
> +       i40e_rx_checksum(rx_ring->vsi, skb, rx_desc);
> +}

As a matter of preference I usually prefer to see the Rx checksum work
done before you start removing header data.

>
> -               /* This memory barrier is needed to keep us from reading
> -                * any other fields out of the rx_desc until we know the
> -                * DD bit is set.
> -                */
> -               dma_rmb();
> -               /* sync header buffer for reading */
> -               dma_sync_single_range_for_cpu(rx_ring->dev,
> -                                             rx_ring->rx_bi[0].dma,
> -                                             i * rx_ring->rx_hdr_len,
> -                                             rx_ring->rx_hdr_len,
> -                                             DMA_FROM_DEVICE);
> -               if (i40e_rx_is_programming_status(qword)) {
> -                       i40e_clean_programming_status(rx_ring, rx_desc);
> -                       I40E_RX_INCREMENT(rx_ring, i);
> -                       continue;
> -               }
> -               rx_bi = &rx_ring->rx_bi[i];
> -               skb = rx_bi->skb;
> -               if (likely(!skb)) {
> -                       skb = __netdev_alloc_skb_ip_align(rx_ring->netdev,
> -                                                         rx_ring->rx_hdr_len,
> -                                                         GFP_ATOMIC |
> -                                                         __GFP_NOWARN);
> -                       if (!skb) {
> -                               rx_ring->rx_stats.alloc_buff_failed++;
> -                               failure = true;
> -                               break;
> -                       }
> +/**
> + * i40e_pull_tail - i40e specific version of skb_pull_tail
> + * @rx_ring: rx descriptor ring packet is being transacted on
> + * @skb: pointer to current skb being adjusted
> + *
> + * This function is an i40e specific version of __pskb_pull_tail.  The
> + * main difference between this version and the original function is that
> + * this function can make several assumptions about the state of things
> + * that allow for significant optimizations versus the standard function.
> + * As a result we can do things like drop a frag and maintain an accurate
> + * truesize for the skb.
> + */
> +static void i40e_pull_tail(struct i40e_ring *rx_ring, struct sk_buff *skb)
> +{
> +       struct skb_frag_struct *frag = &skb_shinfo(skb)->frags[0];
> +       unsigned char *va;
> +       unsigned int pull_len;
>
> -                       /* initialize queue mapping */
> -                       skb_record_rx_queue(skb, rx_ring->queue_index);
> -                       /* we are reusing so sync this buffer for CPU use */
> -                       dma_sync_single_range_for_cpu(rx_ring->dev,
> -                                                     rx_ring->rx_bi[0].dma,
> -                                                     i * rx_ring->rx_hdr_len,
> -                                                     rx_ring->rx_hdr_len,
> -                                                     DMA_FROM_DEVICE);
> -               }
> -               rx_packet_len = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
> -                               I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
> -               rx_header_len = (qword & I40E_RXD_QW1_LENGTH_HBUF_MASK) >>
> -                               I40E_RXD_QW1_LENGTH_HBUF_SHIFT;
> -               rx_sph = (qword & I40E_RXD_QW1_LENGTH_SPH_MASK) >>
> -                        I40E_RXD_QW1_LENGTH_SPH_SHIFT;
> -
> -               rx_error = (qword & I40E_RXD_QW1_ERROR_MASK) >>
> -                          I40E_RXD_QW1_ERROR_SHIFT;
> -               rx_hbo = rx_error & BIT(I40E_RX_DESC_ERROR_HBO_SHIFT);
> -               rx_error &= ~BIT(I40E_RX_DESC_ERROR_HBO_SHIFT);
> +       /* it is valid to use page_address instead of kmap since we are
> +        * working with pages allocated out of the lomem pool per
> +        * alloc_page(GFP_ATOMIC)
> +        */
> +       va = skb_frag_address(frag);
>
> -               rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
> -                          I40E_RXD_QW1_PTYPE_SHIFT;
> -               /* sync half-page for reading */
> -               dma_sync_single_range_for_cpu(rx_ring->dev,
> -                                             rx_bi->page_dma,
> -                                             rx_bi->page_offset,
> -                                             PAGE_SIZE / 2,
> -                                             DMA_FROM_DEVICE);
> -               prefetch(page_address(rx_bi->page) + rx_bi->page_offset);
> -               rx_bi->skb = NULL;
> -               cleaned_count++;
> -               copysize = 0;
> -               if (rx_hbo || rx_sph) {
> -                       int len;
> +       /* we need the header to contain the greater of either ETH_HLEN or
> +        * 60 bytes if the skb->len is less than 60 for skb_pad.
> +        */
> +       pull_len = eth_get_headlen(va, I40E_RX_HDR_SIZE);
>
> -                       if (rx_hbo)
> -                               len = I40E_RX_HDR_SIZE;
> -                       else
> -                               len = rx_header_len;
> -                       memcpy(__skb_put(skb, len), rx_bi->hdr_buf, len);
> -               } else if (skb->len == 0) {
> -                       int len;
> -                       unsigned char *va = page_address(rx_bi->page) +
> -                                           rx_bi->page_offset;
> -
> -                       len = min(rx_packet_len, rx_ring->rx_hdr_len);
> -                       memcpy(__skb_put(skb, len), va, len);
> -                       copysize = len;
> -                       rx_packet_len -= len;
> -               }
> -               /* Get the rest of the data if this was a header split */
> -               if (rx_packet_len) {
> -                       skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> -                                       rx_bi->page,
> -                                       rx_bi->page_offset + copysize,
> -                                       rx_packet_len, I40E_RXBUFFER_2048);
> -
> -                       /* If the page count is more than 2, then both halves
> -                        * of the page are used and we need to free it. Do it
> -                        * here instead of in the alloc code. Otherwise one
> -                        * of the half-pages might be released between now and
> -                        * then, and we wouldn't know which one to use.
> -                        * Don't call get_page and free_page since those are
> -                        * both expensive atomic operations that just change
> -                        * the refcount in opposite directions. Just give the
> -                        * page to the stack; he can have our refcount.
> -                        */
> -                       if (page_count(rx_bi->page) > 2) {
> -                               dma_unmap_page(rx_ring->dev,
> -                                              rx_bi->page_dma,
> -                                              PAGE_SIZE,
> -                                              DMA_FROM_DEVICE);
> -                               rx_bi->page = NULL;
> -                               rx_bi->page_dma = 0;
> -                               rx_ring->rx_stats.realloc_count++;
> -                       } else {
> -                               get_page(rx_bi->page);
> -                               /* switch to the other half-page here; the
> -                                * allocation code programs the right addr
> -                                * into HW. If we haven't used this half-page,
> -                                * the address won't be changed, and HW can
> -                                * just use it next time through.
> -                                */
> -                               rx_bi->page_offset ^= PAGE_SIZE / 2;
> -                       }
> +       /* align pull length to size of long to optimize memcpy performance */
> +       skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
>
> -               }
> -               I40E_RX_INCREMENT(rx_ring, i);
> +       /* update all of the pointers */
> +       skb_frag_size_sub(frag, pull_len);
> +       frag->page_offset += pull_len;
> +       skb->data_len -= pull_len;
> +       skb->tail += pull_len;
> +}
>
> -               if (unlikely(
> -                   !(rx_status & BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)))) {
> -                       struct i40e_rx_buffer *next_buffer;
> +/**
> + * i40e_cleanup_headers - Correct empty headers
> + * @rx_ring: rx descriptor ring packet is being transacted on
> + * @skb: pointer to current skb being fixed
> + *
> + * Also address the case where we are pulling data in on pages only
> + * and as such no data is present in the skb header.
> + *
> + * In addition if skb is not at least 60 bytes we need to pad it so that
> + * it is large enough to qualify as a valid Ethernet frame.
> + *
> + * Returns true if an error was encountered and skb was freed.
> + **/
> +static bool i40e_cleanup_headers(struct i40e_ring *rx_ring, struct sk_buff *skb)
> +{

In the ixgbe approach I had a bit in here that was checking the Rx
descriptor and freeing the buffer if there was a packet error
detected.  I'm going to assume it is probably pushed off into a
separate piece in your Rx function, but it looks to me like there
should be a check for I40E_RX_DESC_ERROR_RXE_SHIFT here.

> +       /* place header in linear portion of buffer */
> +       if (skb_is_nonlinear(skb))
> +               i40e_pull_tail(rx_ring, skb);
>
> -                       next_buffer = &rx_ring->rx_bi[i];
> -                       next_buffer->skb = skb;
> -                       rx_ring->rx_stats.non_eop_descs++;
> -                       continue;
> -               }
> +       /* if eth_skb_pad returns an error the skb was freed */
> +       if (eth_skb_pad(skb))
> +               return true;
>
> -               /* ERR_MASK will only have valid bits if EOP set */
> -               if (unlikely(rx_error & BIT(I40E_RX_DESC_ERROR_RXE_SHIFT))) {
> -                       dev_kfree_skb_any(skb);
> -                       continue;
> -               }
> +       return false;
> +}
>
> -               i40e_rx_hash(rx_ring, rx_desc, skb, rx_ptype);
> +/**
> + * i40e_reuse_rx_page - page flip buffer and store it back on the ring
> + * @rx_ring: rx descriptor ring to store buffers on
> + * @old_buff: donor buffer to have page reused
> + *
> + * Synchronizes page for reuse by the adapter
> + **/
> +static void i40e_reuse_rx_page(struct i40e_ring *rx_ring,
> +                              struct i40e_rx_buffer *old_buff)
> +{
> +       struct i40e_rx_buffer *new_buff;
> +       u16 nta = rx_ring->next_to_alloc;
>
> -               if (unlikely(rx_status & I40E_RXD_QW1_STATUS_TSYNVALID_MASK)) {
> -                       i40e_ptp_rx_hwtstamp(vsi->back, skb, (rx_status &
> -                                          I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
> -                                          I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT);
> -                       rx_ring->last_rx_timestamp = jiffies;
> -               }
> +       new_buff = &rx_ring->rx_bi[nta];
>
> -               /* probably a little skewed due to removing CRC */
> -               total_rx_bytes += skb->len;
> -               total_rx_packets++;
> +       /* update, and store next to alloc */
> +       nta++;
> +       rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
>
> -               skb->protocol = eth_type_trans(skb, rx_ring->netdev);
> +       /* transfer page from old buffer to new buffer */
> +       *new_buff = *old_buff;

The ixgbe driver had a call here to sync the page back to the device.
I'll keep my eye out for it elseqhere but this makes a good space to
have something like that.

> +}
>
> -               i40e_rx_checksum(vsi, skb, rx_status, rx_error, rx_ptype);
> +/**
> + * i40e_page_is_reserved - check if reuse is possible
> + * @page: page struct to check
> + */
> +static inline bool i40e_page_is_reserved(struct page *page)
> +{
> +       return (page_to_nid(page) != numa_mem_id()) || page_is_pfmemalloc(page);
> +}
>
> -               vlan_tag = rx_status & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)
> -                        ? le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1)
> -                        : 0;
> -#ifdef I40E_FCOE
> -               if (unlikely(
> -                   i40e_rx_is_fcoe(rx_ptype) &&
> -                   !i40e_fcoe_handle_offload(rx_ring, rx_desc, skb))) {
> -                       dev_kfree_skb_any(skb);
> -                       continue;
> -               }
> +/**
> + * i40e_add_rx_frag - Add contents of Rx buffer to sk_buff
> + * @rx_ring: rx descriptor ring to transact packets on
> + * @rx_buffer: buffer containing page to add
> + * @rx_desc: descriptor containing length of buffer written by hardware
> + * @skb: sk_buff to place the data into
> + *
> + * This function will add the data contained in rx_buffer->page to the skb.
> + * This is done either through a direct copy if the data in the buffer is
> + * less than the skb header size, otherwise it will just attach the page as
> + * a frag to the skb.
> + *
> + * The function will then update the page offset if necessary and return
> + * true if the buffer can be reused by the adapter.
> + **/
> +static bool i40e_add_rx_frag(struct i40e_ring *rx_ring,
> +                            struct i40e_rx_buffer *rx_buffer,
> +                            union i40e_rx_desc *rx_desc,
> +                            struct sk_buff *skb)
> +{
> +       struct page *page = rx_buffer->page;
> +       u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> +       unsigned int size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
> +                           I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
> +#if (PAGE_SIZE < 8192)
> +       unsigned int truesize = I40E_RXBUFFER_2048;
> +#else
> +       unsigned int truesize = ALIGN(size, L1_CACHE_BYTES);
> +       unsigned int last_offset = PAGE_SIZE - I40E_RXBUFFER_2048;
>  #endif
> -               i40e_receive_skb(rx_ring, skb, vlan_tag);
>
> -               rx_desc->wb.qword1.status_error_len = 0;
> +       /* will the data fit in the skb we allocated? if so, just
> +        * copy it as it is pretty small anyway
> +        */
> +       if ((size <= I40E_RX_HDR_SIZE) && !skb_is_nonlinear(skb)) {
> +               unsigned char *va = page_address(page) + rx_buffer->page_offset;
>
> -       } while (likely(total_rx_packets < budget));
> +               memcpy(__skb_put(skb, size), va, ALIGN(size, sizeof(long)));
>
> -       u64_stats_update_begin(&rx_ring->syncp);
> -       rx_ring->stats.packets += total_rx_packets;
> -       rx_ring->stats.bytes += total_rx_bytes;
> -       u64_stats_update_end(&rx_ring->syncp);
> -       rx_ring->q_vector->rx.total_packets += total_rx_packets;
> -       rx_ring->q_vector->rx.total_bytes += total_rx_bytes;
> +               /* page is not reserved, we can reuse buffer as-is */
> +               if (likely(!i40e_page_is_reserved(page)))
> +                       return true;
>
> -       return failure ? budget : total_rx_packets;
> +               /* this page cannot be reused so discard it */
> +               __free_pages(page, 0);
> +               return false;
> +       }
> +
> +       skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
> +                       rx_buffer->page_offset, size, truesize);
> +
> +       /* avoid re-using remote pages */
> +       if (unlikely(i40e_page_is_reserved(page)))
> +               return false;
> +
> +#if (PAGE_SIZE < 8192)
> +       /* if we are only owner of page we can reuse it */
> +       if (unlikely(page_count(page) != 1))
> +               return false;
> +
> +       /* flip page offset to other buffer */
> +       rx_buffer->page_offset ^= truesize;
> +#else
> +       /* move offset up to the next cache line */
> +       rx_buffer->page_offset += truesize;
> +
> +       if (rx_buffer->page_offset > last_offset)
> +               return false;
> +#endif
> +
> +       /* Even if we own the page, we are not allowed to use atomic_set()
> +        * This would break get_page_unless_zero() users.
> +        */
> +       get_page(rx_buffer->page);
> +
> +       return true;
>  }
>
>  /**
> - * i40e_clean_rx_irq_1buf - Reclaim resources after receive; single buffer
> - * @rx_ring:  rx ring to clean
> - * @budget:   how many cleans we're allowed
> + * i40e_fetch_rx_buffer - Allocate skb and populate it
> + * @rx_ring: rx descriptor ring to transact packets on
> + * @rx_desc: descriptor containing info written by hardware
>   *
> - * Returns number of packets cleaned
> + * This function allocates an skb on the fly, and populates it with the page
> + * data from the current receive descriptor, taking care to set up the skb
> + * correctly, as well as handling calling the page recycle function if
> + * necessary.
> + */
> +static inline
> +struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
> +                                    union i40e_rx_desc *rx_desc)
> +{
> +       struct i40e_rx_buffer *rx_buffer;
> +       struct sk_buff *skb;
> +       struct page *page;
> +
> +       rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
> +       page = rx_buffer->page;
> +       prefetchw(page);
> +
> +       skb = rx_buffer->skb;
> +

Keep the skb in the ring, not in the rx_buffer.

> +       if (likely(!skb)) {
> +               void *page_addr = page_address(page) + rx_buffer->page_offset;
> +
> +               /* prefetch first cache line of first page */
> +               prefetch(page_addr);
> +#if L1_CACHE_BYTES < 128
> +               prefetch(page_addr + L1_CACHE_BYTES);
> +#endif
> +
> +               /* allocate a skb to store the frags */
> +               skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
> +                                      I40E_RX_HDR_SIZE,
> +                                      GFP_ATOMIC | __GFP_NOWARN);
> +               if (unlikely(!skb)) {
> +                       rx_ring->rx_stats.alloc_buff_failed++;
> +                       return NULL;
> +               }
> +
> +               /* we will be copying header into skb->data in
> +                * pskb_may_pull so it is in our interest to prefetch
> +                * it now to avoid a possible cache miss
> +                */
> +               prefetchw(skb->data);
> +
> +               skb_record_rx_queue(skb, rx_ring->queue_index);

You can probably hold off on recording the Rx queue until later when
you are processing skb fields.

> +       } else {
> +               /* we are reusing so sync this buffer for CPU use */
> +               dma_sync_single_range_for_cpu(rx_ring->dev,
> +                                             rx_buffer->dma,
> +                                             rx_buffer->page_offset,
> +                                             I40E_RXBUFFER_2048,
> +                                             DMA_FROM_DEVICE);
> +
> +               rx_buffer->skb = NULL;
> +       }
> +

You don't support RSC dso you don't need to copy the code from ixgbe.
You would be better off basing this portion of the code on either igb
or fm10k.

> +       /* pull page into skb */
> +       if (i40e_add_rx_frag(rx_ring, rx_buffer, rx_desc, skb)) {
> +               /* hand second half of page back to the ring */
> +               i40e_reuse_rx_page(rx_ring, rx_buffer);
> +               rx_ring->rx_stats.page_reuse_count++;
> +       } else {
> +               /* we are not reusing the buffer so unmap it */
> +               dma_unmap_page(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
> +                              DMA_FROM_DEVICE);
> +       }
> +
> +       /* clear contents of buffer_info */
> +       rx_buffer->page = NULL;
> +
> +       return skb;
> +}
> +
> +/**
> + * i40e_is_non_eop - process handling of non-EOP buffers
> + * @rx_ring: Rx ring being processed
> + * @rx_desc: Rx descriptor for current buffer
> + * @skb: Current socket buffer containing buffer in progress
> + *
> + * This function updates next to clean.  If the buffer is an EOP buffer
> + * this function exits returning false, otherwise it will place the
> + * sk_buff in the next buffer to be chained and return true indicating
> + * that this is in fact a non-EOP buffer.
> + **/
> +static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
> +                           union i40e_rx_desc *rx_desc,
> +                           struct sk_buff *skb)
> +{
> +       u32 ntc = rx_ring->next_to_clean + 1;
> +
> +       /* fetch, update, and store next to clean */
> +       ntc = (ntc < rx_ring->count) ? ntc : 0;
> +       rx_ring->next_to_clean = ntc;
> +
> +       prefetch(I40E_RX_DESC(rx_ring, ntc));
> +
> +#define staterrlen rx_desc->wb.qword1.status_error_len
> +       if (unlikely(i40e_rx_is_programming_status(le64_to_cpu(staterrlen)))) {
> +               i40e_clean_programming_status(rx_ring, rx_desc);
> +               rx_ring->rx_bi[ntc].skb = skb;
> +               return true;
> +       }
> +       /* if we are the last buffer then there is nothing else to do */
> +#define I40E_RXD_EOF BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)
> +       if (likely(i40e_test_staterr(rx_desc, I40E_RXD_EOF)))
> +               return false;
> +
> +       /* place skb in next buffer to be received */
> +       rx_ring->rx_bi[ntc].skb = skb;
> +       rx_ring->rx_stats.non_eop_descs++;
> +
> +       return true;
> +}
> +
> +/**
> + * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
> + * @rx_ring: rx descriptor ring to transact packets on
> + * @budget: Total limit on number of packets to process
> + *
> + * This function provides a "bounce buffer" approach to Rx interrupt
> + * processing.  The advantage to this is that on systems that have
> + * expensive overhead for IOMMU access this provides a means of avoiding
> + * it by maintaining the mapping of the page to the system.
> + *
> + * Returns amount of work completed
>   **/
> -static int i40e_clean_rx_irq_1buf(struct i40e_ring *rx_ring, int budget)
> +static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>  {
>         unsigned int total_rx_bytes = 0, total_rx_packets = 0;
>         u16 cleaned_count = I40E_DESC_UNUSED(rx_ring);
> -       struct i40e_vsi *vsi = rx_ring->vsi;
> -       union i40e_rx_desc *rx_desc;
> -       u32 rx_error, rx_status;
> -       u16 rx_packet_len;
>         bool failure = false;
> -       u8 rx_ptype;
> -       u64 qword;
> -       u16 i;
>
> -       do {
> -               struct i40e_rx_buffer *rx_bi;
> +       while (likely(total_rx_packets < budget)) {
> +               union i40e_rx_desc *rx_desc;
>                 struct sk_buff *skb;
> +               u32 rx_status;
>                 u16 vlan_tag;
> +               u8 rx_ptype;
> +               u64 qword;
> +
>                 /* return some buffers to hardware, one at a time is too slow */
>                 if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
>                         failure = failure ||
> -                                 i40e_alloc_rx_buffers_1buf(rx_ring,
> -                                                            cleaned_count);
> +                                 i40e_alloc_rx_buffers(rx_ring, cleaned_count);
>                         cleaned_count = 0;
>                 }
>
> -               i = rx_ring->next_to_clean;
> -               rx_desc = I40E_RX_DESC(rx_ring, i);
> +               rx_desc = I40E_RX_DESC(rx_ring, rx_ring->next_to_clean);
> +
>                 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
> +               rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
> +                          I40E_RXD_QW1_PTYPE_SHIFT;
>                 rx_status = (qword & I40E_RXD_QW1_STATUS_MASK) >>
> -                       I40E_RXD_QW1_STATUS_SHIFT;
> +                           I40E_RXD_QW1_STATUS_SHIFT;

These need to be done ins the spot where they are needed.  This
probably isn't the right spot.

>                 if (!(rx_status & BIT(I40E_RX_DESC_STATUS_DD_SHIFT)))
>                         break;
>
> +               /* status_error_len will always be zero for unused descriptors
> +                * because it's cleared in cleanup, and overlaps with hdr_addr
> +                * which is always zero because packet split isn't used, if the
> +                * hardware wrote DD then it will be non-zero
> +                */
> +               if (!rx_desc->wb.qword1.status_error_len)
> +                       break;
> +

You can remove the DD bit check if you added this line.

>                 /* This memory barrier is needed to keep us from reading
>                  * any other fields out of the rx_desc until we know the
>                  * DD bit is set.
>                  */
>                 dma_rmb();
>
> -               if (i40e_rx_is_programming_status(qword)) {
> -                       i40e_clean_programming_status(rx_ring, rx_desc);
> -                       I40E_RX_INCREMENT(rx_ring, i);
> -                       continue;
> -               }
> -               rx_bi = &rx_ring->rx_bi[i];
> -               skb = rx_bi->skb;
> -               prefetch(skb->data);
> -
> -               rx_packet_len = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
> -                               I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
> -
> -               rx_error = (qword & I40E_RXD_QW1_ERROR_MASK) >>
> -                          I40E_RXD_QW1_ERROR_SHIFT;
> -               rx_error &= ~BIT(I40E_RX_DESC_ERROR_HBO_SHIFT);
> +               skb = i40e_fetch_rx_buffer(rx_ring, rx_desc);
> +               if (!skb)
> +                       break;
>
> -               rx_ptype = (qword & I40E_RXD_QW1_PTYPE_MASK) >>
> -                          I40E_RXD_QW1_PTYPE_SHIFT;
> -               rx_bi->skb = NULL;
>                 cleaned_count++;
>
> -               /* Get the header and possibly the whole packet
> -                * If this is an skb from previous receive dma will be 0
> -                */
> -               skb_put(skb, rx_packet_len);
> -               dma_unmap_single(rx_ring->dev, rx_bi->dma, rx_ring->rx_buf_len,
> -                                DMA_FROM_DEVICE);
> -               rx_bi->dma = 0;
> -
> -               I40E_RX_INCREMENT(rx_ring, i);
> -
> -               if (unlikely(
> -                   !(rx_status & BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)))) {
> -                       rx_ring->rx_stats.non_eop_descs++;
> +               if (i40e_is_non_eop(rx_ring, rx_desc, skb))
>                         continue;
> -               }
>
> -               /* ERR_MASK will only have valid bits if EOP set */
> -               if (unlikely(rx_error & BIT(I40E_RX_DESC_ERROR_RXE_SHIFT))) {
> -                       dev_kfree_skb_any(skb);
> +               if (i40e_cleanup_headers(rx_ring, skb))
>                         continue;

You need to move the RXE check into  i40e_cleanup_headers.

> -               }
> -
> -               i40e_rx_hash(rx_ring, rx_desc, skb, rx_ptype);
> -               if (unlikely(rx_status & I40E_RXD_QW1_STATUS_TSYNVALID_MASK)) {
> -                       i40e_ptp_rx_hwtstamp(vsi->back, skb, (rx_status &
> -                                          I40E_RXD_QW1_STATUS_TSYNINDX_MASK) >>
> -                                          I40E_RXD_QW1_STATUS_TSYNINDX_SHIFT);
> -                       rx_ring->last_rx_timestamp = jiffies;
> -               }
>
>                 /* probably a little skewed due to removing CRC */
>                 total_rx_bytes += skb->len;
> -               total_rx_packets++;
>
> -               skb->protocol = eth_type_trans(skb, rx_ring->netdev);
> +               /* populate checksum, VLAN, and protocol */
> +               i40e_process_skb_fields(rx_ring, rx_desc, skb, rx_ptype);
>
> -               i40e_rx_checksum(vsi, skb, rx_status, rx_error, rx_ptype);
> -
> -               vlan_tag = rx_status & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)
> -                        ? le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1)
> -                        : 0;
>  #ifdef I40E_FCOE
>                 if (unlikely(
>                     i40e_rx_is_fcoe(rx_ptype) &&
> @@ -1861,10 +1833,15 @@ static int i40e_clean_rx_irq_1buf(struct i40e_ring *rx_ring, int budget)
>                         continue;
>                 }
>  #endif
> +
> +               vlan_tag = (qword & BIT(I40E_RX_DESC_STATUS_L2TAG1P_SHIFT)) ?
> +                          le16_to_cpu(rx_desc->wb.qword0.lo_dword.l2tag1) : 0;
> +

I'd say you could probably move this into process_skb_fields.

>                 i40e_receive_skb(rx_ring, skb, vlan_tag);
>
> -               rx_desc->wb.qword1.status_error_len = 0;
> -       } while (likely(total_rx_packets < budget));
> +               /* update budget accounting */
> +               total_rx_packets++;
> +       }
>
>         u64_stats_update_begin(&rx_ring->syncp);
>         rx_ring->stats.packets += total_rx_packets;
> @@ -1873,6 +1850,7 @@ static int i40e_clean_rx_irq_1buf(struct i40e_ring *rx_ring, int budget)
>         rx_ring->q_vector->rx.total_packets += total_rx_packets;
>         rx_ring->q_vector->rx.total_bytes += total_rx_bytes;
>
> +       /* guarantee a trip back through this routine if there was a failure */
>         return failure ? budget : total_rx_packets;
>  }

I'm not sure what you hope to gain by polling extra times.  I'd say if
you had an allocation failure you probably just need to wait for the
bad-actor to free up memory.  In addition you should have something
that will force the interrupt to be triggered once every two seconds
anyway.

> @@ -2017,12 +1995,7 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
>         budget_per_ring = max(budget/q_vector->num_ringpairs, 1);
>
>         i40e_for_each_ring(ring, q_vector->rx) {
> -               int cleaned;
> -
> -               if (ring_is_ps_enabled(ring))
> -                       cleaned = i40e_clean_rx_irq_ps(ring, budget_per_ring);
> -               else
> -                       cleaned = i40e_clean_rx_irq_1buf(ring, budget_per_ring);
> +               int cleaned = i40e_clean_rx_irq(ring, budget_per_ring);
>
>                 work_done += cleaned;
>                 /* if we clean as many as budgeted, we must not be done */
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> index 6b2b191..54ddbd4 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
> @@ -102,8 +102,8 @@ enum i40e_dyn_idx_t {
>         (((pf)->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE) ? \
>           I40E_DEFAULT_RSS_HENA_EXPANDED : I40E_DEFAULT_RSS_HENA)
>
> -/* Supported Rx Buffer Sizes */
> -#define I40E_RXBUFFER_512   512    /* Used for packet split */
> +/* Supported Rx Buffer Sizes (a multiple of 128) */
> +#define I40E_RXBUFFER_256   256
>  #define I40E_RXBUFFER_2048  2048
>  #define I40E_RXBUFFER_3072  3072   /* For FCoE MTU of 2158 */
>  #define I40E_RXBUFFER_4096  4096
> @@ -114,9 +114,28 @@ enum i40e_dyn_idx_t {
>   * reserve 2 more, and skb_shared_info adds an additional 384 bytes more,
>   * this adds up to 512 bytes of extra data meaning the smallest allocation
>   * we could have is 1K.
> - * i.e. RXBUFFER_512 --> size-1024 slab
> + * i.e. RXBUFFER_256 --> 960 byte skb (size-1024 slab)
> + * i.e. RXBUFFER_512 --> 1216 byte skb (size-2048 slab)
>   */
> -#define I40E_RX_HDR_SIZE  I40E_RXBUFFER_512
> +#define I40E_RX_HDR_SIZE I40E_RXBUFFER_256
> +#define i40e_rx_desc i40e_32byte_rx_desc
> +
> +/**
> + * i40e_test_staterr - tests bits in Rx descriptor status and error fields
> + * @rx_desc: pointer to receive descriptor (in le64 format)
> + * @stat_err_bits: value to mask
> + *
> + * This function does some fast chicanery in order to return the
> + * value of the mask which is really only used for boolean tests.
> + * The status_error_len doesn't need to be shifted because it begins
> + * at offset zero.
> + */
> +static inline bool i40e_test_staterr(union i40e_rx_desc *rx_desc,
> +                                    const u64 stat_err_bits)
> +{
> +       return !!(rx_desc->wb.qword1.status_error_len &
> +                 cpu_to_le64(stat_err_bits));
> +}

I'd say this should probably be 2 or 3 functions based on what I have
seen.  Basically you have several different shifts you can use so for
each one you could define a different function.

>  /* How many Rx Buffers do we bundle into one write to the hardware ? */
>  #define I40E_RX_BUFFER_WRITE   16      /* Must be power of 2 */
> @@ -142,8 +161,6 @@ enum i40e_dyn_idx_t {
>                 prefetch((n));                          \
>         } while (0)
>
> -#define i40e_rx_desc i40e_32byte_rx_desc
> -
>  #define I40E_MAX_BUFFER_TXD    8
>  #define I40E_MIN_TX_LEN                17
>
> @@ -213,10 +230,8 @@ struct i40e_tx_buffer {
>
>  struct i40e_rx_buffer {
>         struct sk_buff *skb;

The skb pointer can be moved to the rx_ring as well.  No need to keep
it unless you can support interleaving of frames on the ring.

> -       void *hdr_buf;
>         dma_addr_t dma;
>         struct page *page;
> -       dma_addr_t page_dma;
>         unsigned int page_offset;
>  };
>
> @@ -245,16 +260,10 @@ struct i40e_rx_queue_stats {
>  enum i40e_ring_state_t {
>         __I40E_TX_FDIR_INIT_DONE,
>         __I40E_TX_XPS_INIT_DONE,
> -       __I40E_RX_PS_ENABLED,
> +       __UNUSED,
>         __I40E_RX_16BYTE_DESC_ENABLED,
>  };

Just remove the line.  It isn't needed to use the __UNUSED unless you
have a external entity that can see the ring state.

> -#define ring_is_ps_enabled(ring) \
> -       test_bit(__I40E_RX_PS_ENABLED, &(ring)->state)
> -#define set_ring_ps_enabled(ring) \
> -       set_bit(__I40E_RX_PS_ENABLED, &(ring)->state)
> -#define clear_ring_ps_enabled(ring) \
> -       clear_bit(__I40E_RX_PS_ENABLED, &(ring)->state)
>  #define ring_is_16byte_desc_enabled(ring) \
>         test_bit(__I40E_RX_16BYTE_DESC_ENABLED, &(ring)->state)
>  #define set_ring_16byte_desc_enabled(ring) \
> @@ -287,7 +296,6 @@ struct i40e_ring {
>
>         u16 count;                      /* Number of descriptors */
>         u16 reg_idx;                    /* HW register index of the ring */
> -       u16 rx_hdr_len;
>         u16 rx_buf_len;
>         u8  dtype;
>  #define I40E_RX_DTYPE_NO_SPLIT      0
> @@ -330,6 +338,7 @@ struct i40e_ring {
>         struct i40e_q_vector *q_vector; /* Backreference to associated vector */
>
>         struct rcu_head rcu;            /* to avoid race on free */
> +       u16 next_to_alloc;
>  } ____cacheline_internodealigned_in_smp;

The next_to_alloc value can be made part of a union with the ATR bits
used for the Tx.

>  enum i40e_latency_range {
> @@ -353,9 +362,7 @@ struct i40e_ring_container {
>  #define i40e_for_each_ring(pos, head) \
>         for (pos = (head).ring; pos != NULL; pos = pos->next)
>
> -bool i40e_alloc_rx_buffers_ps(struct i40e_ring *rxr, u16 cleaned_count);
> -bool i40e_alloc_rx_buffers_1buf(struct i40e_ring *rxr, u16 cleaned_count);
> -void i40e_alloc_rx_headers(struct i40e_ring *rxr);
> +bool i40e_alloc_rx_buffers(struct i40e_ring *rxr, u16 cleaned_count);
>  netdev_tx_t i40e_lan_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
>  void i40e_clean_tx_ring(struct i40e_ring *tx_ring);
>  void i40e_clean_rx_ring(struct i40e_ring *rx_ring);

I'm stopping my review here, I don't think my mail client can cut it
as I am lagging hard when it saves a draft of the mail.  I figure
there is enough to fix based on just the comments I provided for the
PF that apply to the VF.

- Alex
