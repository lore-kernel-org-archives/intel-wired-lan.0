From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 9 Dec 2016 09:54:55 -0800
Subject: [Intel-wired-lan] [PATCH v2 1/3] i40e: Initial support for XDP
In-Reply-To: <CAKgT0Uc7e_Sx8yE9ZrFDMY7mYu8sC1Kv+hVhC-YLp4V-M2v9hA@mail.gmail.com>
References: <20161209082212.29549-1-bjorn.topel@gmail.com>
 <20161209082212.29549-2-bjorn.topel@gmail.com>
 <CAKgT0Uc7e_Sx8yE9ZrFDMY7mYu8sC1Kv+hVhC-YLp4V-M2v9hA@mail.gmail.com>
Message-ID: <584AEFEF.8030408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-12-09 09:15 AM, Alexander Duyck wrote:
> On Fri, Dec 9, 2016 at 12:22 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> This commit adds basic XDP support for i40e derived NICs. All XDP
>> actions will end up in XDP_DROP.
>>
>> Only the default/main VSI has support for enabling XDP.
>>
>> Acked-by: John Fastabend <john.r.fastabend@intel.com>
>> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e.h         |  13 +++
>>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   3 +
>>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  77 +++++++++++++
>>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    | 146 ++++++++++++++++++++-----
>>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   2 +
>>  5 files changed, 216 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>> index ba8d30984bee..05d805f439e6 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>> @@ -545,6 +545,8 @@ struct i40e_vsi {
>>         struct i40e_ring **rx_rings;
>>         struct i40e_ring **tx_rings;
>>
>> +       struct bpf_prog *xdp_prog;
>> +

This is being protected by rcu right at least in patch 3 this seems to
be the case? We should add __rcu annotation here,

  struct bpf_prog __rcu *xdp_prog

Then also run

  make C=2 ./drivers/net/ethernet/intel/i40e/

This should help catch any rcu errors. Oh you also need the PROVE_RCU
config option set in .config

I wonder if patch 3 could be squashed with patch 1 here? Do you think
that this patch is easier to read without it.

>>         u32  active_filters;
>>         u32  promisc_threshold;
>>
>> @@ -904,4 +906,15 @@ i40e_status i40e_get_npar_bw_setting(struct i40e_pf *pf);
>>  i40e_status i40e_set_npar_bw_setting(struct i40e_pf *pf);
>>  i40e_status i40e_commit_npar_bw_setting(struct i40e_pf *pf);
>>  void i40e_print_link_message(struct i40e_vsi *vsi, bool isup);
>> +
>> +/**
>> + * i40e_enabled_xdp_vsi - Check if VSI has XDP enabled
>> + * @vsi: pointer to a vsi
>> + *
>> + * Returns true if the VSI has XDP enabled.
>> + **/
>> +static inline bool i40e_enabled_xdp_vsi(const struct i40e_vsi *vsi)
>> +{
>> +       return vsi->xdp_prog;
>> +}
> 
> It might be better to have this return !!vsi->xdp_prog.  That way it
> is explicity casting the return value as a boolean value.
> 
>>  #endif /* _I40E_H_ */
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> index cc1465aac2ef..831bbc208fc8 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
>> @@ -1254,6 +1254,9 @@ static int i40e_set_ringparam(struct net_device *netdev,
>>         if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
>>                 return -EINVAL;
>>
>> +       if (i40e_enabled_xdp_vsi(vsi))
>> +               return -EINVAL;
>> +
>>         if (ring->tx_pending > I40E_MAX_NUM_DESCRIPTORS ||
>>             ring->tx_pending < I40E_MIN_NUM_DESCRIPTORS ||
>>             ring->rx_pending > I40E_MAX_NUM_DESCRIPTORS ||
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index da4cbe32eb86..b247c3231170 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -24,6 +24,7 @@
>>   *
>>   ******************************************************************************/
>>
>> +#include <linux/bpf.h>
>>  #include <linux/etherdevice.h>
>>  #include <linux/of_net.h>
>>  #include <linux/pci.h>
>> @@ -2431,6 +2432,13 @@ static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
>>         struct i40e_netdev_priv *np = netdev_priv(netdev);
>>         struct i40e_vsi *vsi = np->vsi;
>>
>> +       if (i40e_enabled_xdp_vsi(vsi)) {
>> +               int max_frame = new_mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
>> +
>> +               if (max_frame > I40E_RXBUFFER_2048)
>> +                       return -EINVAL;
>> +       }
>> +
> 
> I suppose this works for now, but we should probably be using a value
> smaller than 2048.  Most likely we are going to need to restrict this
> down to about 1.5K or something in that neighborhood.  I am already
> looking at changes that clean most of this up to prep it for the DMA
> and page count fixes.  To resolve the jumbo frames case we are
> probably looking at using a 3K buffer size with an order 1 page on
> x86.  That will give us enough room for adding headers and/or any
> trailers needed to the frame.
> 

Also looks like we are trying to standardize on 256B of headroom for
headers. So when we add the adjust_head support this will need another
256B addition here. And we will have to do an offset on the DMA region.

I thought Alex was maybe trying to clean some of this up so it would
be easier to do this. I vaguely remember something about SKB_PAD.

>>         netdev_info(netdev, "changing MTU from %d to %d\n",
>>                     netdev->mtu, new_mtu);
>>         netdev->mtu = new_mtu;
>> @@ -3085,6 +3093,15 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>>         ring->tail = hw->hw_addr + I40E_QRX_TAIL(pf_q);
>>         writel(0, ring->tail);
>>
>> +       if (i40e_enabled_xdp_vsi(vsi)) {
>> +               struct bpf_prog *prog;
>> +
>> +               prog = bpf_prog_add(vsi->xdp_prog, 1);
>> +               if (IS_ERR(prog))
>> +                       return PTR_ERR(prog);
>> +               ring->xdp_prog = prog;
>> +       }
>> +
>>         i40e_alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
>>
>>         return 0;
>> @@ -9234,6 +9251,65 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
>>         return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>>  }
>>
>> +/**
>> + * i40e_xdp_setup - Add/remove an XDP program to a VSI
>> + * @vsi: the VSI to add the program
>> + * @prog: the XDP program
>> + **/
>> +static int i40e_xdp_setup(struct i40e_vsi *vsi,
>> +                         struct bpf_prog *prog)
>> +{
>> +       struct i40e_pf *pf = vsi->back;
>> +       struct net_device *netdev = vsi->netdev;
>> +       int frame_size = netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
>> +
>> +       if (prog && prog->xdp_adjust_head)

I think we want a follow on patch to enable adjust head next. It would
be best to get this in the same kernel version but not necessarily in
the same series.

>> +               return -EOPNOTSUPP;
>> +
>> +       if (frame_size > I40E_RXBUFFER_2048)
>> +               return -EINVAL;
>> +
>> +       if (!(pf->flags & I40E_FLAG_MSIX_ENABLED))
>> +               return -EINVAL;
>> +
> 
> Why would MSI-X matter?  Is this because you are trying to reserve
> extra Tx rings for the XDP program?
> 
> If so we might want to update i40e to make it more ixgbe like since it
> can in theory support multiple queues with a single vector.  It might
> be useful to add comments on why each of these criteria must be met
> when you perform the checks.
> 
>> +       if (!i40e_enabled_xdp_vsi(vsi) && !prog)
>> +               return 0;
>> +
>> +       i40e_prep_for_reset(pf);
>> +
>> +       if (vsi->xdp_prog)
>> +               bpf_prog_put(vsi->xdp_prog);
>> +       vsi->xdp_prog = prog;
>> +

So I worry a bit about correctness here. Patch 3 likely fixes this but
between patch 1 and 3 it seems like there could be some race here.

This makes me think patch3 should be merged here.

>> +       i40e_reset_and_rebuild(pf, true);
>> +       return 0;
>> +}
>> +
>> +/**
>> + * i40e_xdp - NDO for enabled/query
>> + * @dev: the netdev
>> + * @xdp: XDP program
>> + **/
>> +static int i40e_xdp(struct net_device *dev,
>> +                   struct netdev_xdp *xdp)
>> +{
>> +       struct i40e_netdev_priv *np = netdev_priv(dev);
>> +       struct i40e_vsi *vsi = np->vsi;
>> +
>> +       if (vsi->type != I40E_VSI_MAIN)
>> +               return -EINVAL;
>> +
>> +       switch (xdp->command) {
>> +       case XDP_SETUP_PROG:
>> +               return i40e_xdp_setup(vsi, xdp->prog);
>> +       case XDP_QUERY_PROG:
>> +               xdp->prog_attached = i40e_enabled_xdp_vsi(vsi);
>> +               return 0;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
>> +
>>  static const struct net_device_ops i40e_netdev_ops = {
>>         .ndo_open               = i40e_open,
>>         .ndo_stop               = i40e_close,
>> @@ -9270,6 +9346,7 @@ static const struct net_device_ops i40e_netdev_ops = {
>>         .ndo_features_check     = i40e_features_check,
>>         .ndo_bridge_getlink     = i40e_ndo_bridge_getlink,
>>         .ndo_bridge_setlink     = i40e_ndo_bridge_setlink,
>> +       .ndo_xdp                = i40e_xdp,
>>  };
>>
>>  /**
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> index 352cf7cd2ef4..d835a51dafa6 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> @@ -24,6 +24,7 @@
>>   *
>>   ******************************************************************************/
>>
>> +#include <linux/bpf.h>
>>  #include <linux/prefetch.h>
>>  #include <net/busy_poll.h>
>>  #include "i40e.h"
>> @@ -1040,6 +1041,11 @@ void i40e_clean_rx_ring(struct i40e_ring *rx_ring)
>>         rx_ring->next_to_alloc = 0;
>>         rx_ring->next_to_clean = 0;
>>         rx_ring->next_to_use = 0;
>> +
>> +       if (rx_ring->xdp_prog) {
>> +               bpf_prog_put(rx_ring->xdp_prog);
>> +               rx_ring->xdp_prog = NULL;
>> +       }
>>  }
>>
>>  /**
>> @@ -1600,30 +1606,104 @@ static bool i40e_add_rx_frag(struct i40e_ring *rx_ring,
>>  }
>>
>>  /**
>> + * i40e_run_xdp - Runs an XDP program for an Rx ring
>> + * @rx_ring: Rx ring used for XDP
>> + * @rx_buffer: current Rx buffer
>> + * @rx_desc: current Rx descriptor
>> + * @xdp_prog: the XDP program to run
>> + *
>> + * Returns true if the XDP program consumed the incoming frame. False
>> + * means pass the frame to the good old stack.
>> + **/
>> +static bool i40e_run_xdp(struct i40e_ring *rx_ring,
>> +                        struct i40e_rx_buffer *rx_buffer,
>> +                        union i40e_rx_desc *rx_desc,
>> +                        struct bpf_prog *xdp_prog)
>> +{
>> +       u64 qword = le64_to_cpu(rx_desc->wb.qword1.status_error_len);
>> +       unsigned int size = (qword & I40E_RXD_QW1_LENGTH_PBUF_MASK) >>
>> +                           I40E_RXD_QW1_LENGTH_PBUF_SHIFT;
>> +       struct xdp_buff xdp;
>> +       u32 xdp_action;
>> +
>> +       WARN_ON(!i40e_test_staterr(rx_desc,
>> +                                  BIT(I40E_RX_DESC_STATUS_EOF_SHIFT)));
>> +
> 
> We can't just do a WARN_ON if we don't have the end of the frame.
> Also it probably doesn't even matter unless we are looking at the
> first frame.  I would argue that this might be better as a BUG_ON
> since it should not happen.
> 

Or if its really just a catch all for something that shouldn't happen
go ahead and drop it.

>> +       xdp.data = page_address(rx_buffer->page) + rx_buffer->page_offset;
>> +       xdp.data_end = xdp.data + size;
>> +       xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp);
>> +
>> +       switch (xdp_action) {
>> +       case XDP_PASS:
>> +               return false;
>> +       default:
>> +               bpf_warn_invalid_xdp_action(xdp_action);
>> +       case XDP_ABORTED:
>> +       case XDP_TX:
>> +       case XDP_DROP:
>> +               if (likely(!i40e_page_is_reserved(rx_buffer->page))) {
>> +                       i40e_reuse_rx_page(rx_ring, rx_buffer);
>> +                       rx_ring->rx_stats.page_reuse_count++;
>> +                       break;
>> +               }
>> +
>> +               /* we are not reusing the buffer so unmap it */
>> +               dma_unmap_page(rx_ring->dev, rx_buffer->dma, PAGE_SIZE,
>> +                              DMA_FROM_DEVICE);
>> +               __free_pages(rx_buffer->page, 0);
>> +       }
>> +
>> +       /* clear contents of buffer_info */
>> +       rx_buffer->page = NULL;
>> +       return true; /* Swallowed by XDP */
>> +}
>> +
>> +/**
>>   * i40e_fetch_rx_buffer - Allocate skb and populate it
>>   * @rx_ring: rx descriptor ring to transact packets on
>>   * @rx_desc: descriptor containing info written by hardware
>> + * @skb: The allocated skb, if any
>>   *
>> - * This function allocates an skb on the fly, and populates it with the page
>> - * data from the current receive descriptor, taking care to set up the skb
>> - * correctly, as well as handling calling the page recycle function if
>> - * necessary.
>> + * Unless XDP is enabled, this function allocates an skb on the fly,
>> + * and populates it with the page data from the current receive
>> + * descriptor, taking care to set up the skb correctly, as well as
>> + * handling calling the page recycle function if necessary.
>> + *
>> + * If the received frame was handled by XDP, true is
>> + * returned. Otherwise, the skb is returned to the caller via the skb
>> + * parameter.
>>   */
>>  static inline
>> -struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
>> -                                    union i40e_rx_desc *rx_desc)
>> +bool i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
>> +                         union i40e_rx_desc *rx_desc,
>> +                         struct sk_buff **skb)
>>  {
>>         struct i40e_rx_buffer *rx_buffer;
>> -       struct sk_buff *skb;
>>         struct page *page;
>>
>>         rx_buffer = &rx_ring->rx_bi[rx_ring->next_to_clean];
>>         page = rx_buffer->page;
>>         prefetchw(page);
>>
>> -       skb = rx_buffer->skb;
> 
> I'm not sure where this line came from.  It was dropped from the
> driver in next-queue a while ago so I don't think your patch applies
> currently.
> 
>> +       /* we are reusing so sync this buffer for CPU use */
>> +       dma_sync_single_range_for_cpu(rx_ring->dev,
>> +                                     rx_buffer->dma,
>> +                                     rx_buffer->page_offset,
>> +                                     I40E_RXBUFFER_2048,
>> +                                     DMA_FROM_DEVICE);
> 
> I would prefer if moving this piece up was handled in a separate
> patch.  It just makes things more readable that way and I have patches
> I will be submitting that will pull this and the few lines ahead of it
> out of the fetch_rx_buffer entirely.
> 
>> +
>> +       if (rx_ring->xdp_prog) {
>> +               bool xdp_consumed;
>> +
>> +               xdp_consumed = i40e_run_xdp(rx_ring, rx_buffer,
>> +                                           rx_desc, rx_ring->xdp_prog);

So here is the race I commented on above if we NULL xdp_prog between
'if' block and i40e_run_xdp.


>> +               if (xdp_consumed)
>> +                       return true;
>> +       }
>>
>> -       if (likely(!skb)) {
>> +       *skb = rx_buffer->skb;
>> +
>> +       if (likely(!*skb)) {
> 
> Instead of making skb a double pointer we can just change a few things
> to make this all simpler.  For example one thing we could look at
> doing is taking an hlist_nulls type approach where we signal with a
> value of 1 to indicate that XDP stole the buffer so there is no skb to
> assign.  Then you just have to clean it up in i40e_is_non_eop by doing
> a "&" and continue from there, or could add your own block after
> i40e_is_non_eop.
> 
> For that matter we coudl probably consolidate a few things into
> i40e_cleanup_headers and have it handled there.
> 
>>                 void *page_addr = page_address(page) + rx_buffer->page_offset;
>>
>>                 /* prefetch first cache line of first page */
>> @@ -1633,32 +1713,25 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
>>  #endif
>>
>>                 /* allocate a skb to store the frags */
>> -               skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
>> -                                      I40E_RX_HDR_SIZE,
>> -                                      GFP_ATOMIC | __GFP_NOWARN);
>> -               if (unlikely(!skb)) {
>> +               *skb = __napi_alloc_skb(&rx_ring->q_vector->napi,
>> +                                       I40E_RX_HDR_SIZE,
>> +                                       GFP_ATOMIC | __GFP_NOWARN);
>> +               if (unlikely(!*skb)) {
>>                         rx_ring->rx_stats.alloc_buff_failed++;
>> -                       return NULL;
>> +                       return false;
>>                 }
>>
>>                 /* we will be copying header into skb->data in
>>                  * pskb_may_pull so it is in our interest to prefetch
>>                  * it now to avoid a possible cache miss
>>                  */
>> -               prefetchw(skb->data);
>> +               prefetchw((*skb)->data);
>>         } else {
>>                 rx_buffer->skb = NULL;
>>         }
>>
>> -       /* we are reusing so sync this buffer for CPU use */
>> -       dma_sync_single_range_for_cpu(rx_ring->dev,
>> -                                     rx_buffer->dma,
>> -                                     rx_buffer->page_offset,
>> -                                     I40E_RXBUFFER_2048,
>> -                                     DMA_FROM_DEVICE);
>> -
>>         /* pull page into skb */
>> -       if (i40e_add_rx_frag(rx_ring, rx_buffer, rx_desc, skb)) {
>> +       if (i40e_add_rx_frag(rx_ring, rx_buffer, rx_desc, *skb)) {
>>                 /* hand second half of page back to the ring */
>>                 i40e_reuse_rx_page(rx_ring, rx_buffer);
>>                 rx_ring->rx_stats.page_reuse_count++;
>> @@ -1671,7 +1744,7 @@ struct sk_buff *i40e_fetch_rx_buffer(struct i40e_ring *rx_ring,
>>         /* clear contents of buffer_info */
>>         rx_buffer->page = NULL;
>>
>> -       return skb;
>> +       return false;
>>  }
>>
>>  /**
>> @@ -1716,6 +1789,20 @@ static bool i40e_is_non_eop(struct i40e_ring *rx_ring,
>>  }
>>
>>  /**
>> + * i40e_update_rx_next_to_clean - Bumps the next-to-clean for an Rx ing
>> + * @rx_ring: Rx ring to bump
>> + **/
>> +static void i40e_update_rx_next_to_clean(struct i40e_ring *rx_ring)
>> +{
>> +       u32 ntc = rx_ring->next_to_clean + 1;
>> +
>> +       ntc = (ntc < rx_ring->count) ? ntc : 0;
>> +       rx_ring->next_to_clean = ntc;
>> +
>> +       prefetch(I40E_RX_DESC(rx_ring, ntc));
>> +}
>> +
>> +/**
>>   * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>>   * @rx_ring: rx descriptor ring to transact packets on
>>   * @budget: Total limit on number of packets to process
>> @@ -1739,6 +1826,7 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>>                 u16 vlan_tag;
>>                 u8 rx_ptype;
>>                 u64 qword;
>> +               bool xdp_consumed;
>>
>>                 /* return some buffers to hardware, one at a time is too slow */
>>                 if (cleaned_count >= I40E_RX_BUFFER_WRITE) {
>> @@ -1764,7 +1852,15 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>>                  */
>>                 dma_rmb();
>>
>> -               skb = i40e_fetch_rx_buffer(rx_ring, rx_desc);
>> +               xdp_consumed = i40e_fetch_rx_buffer(rx_ring, rx_desc, &skb);
>> +               if (xdp_consumed) {
>> +                       cleaned_count++;
>> +
>> +                       i40e_update_rx_next_to_clean(rx_ring);
>> +                       total_rx_packets++;
>> +                       continue;
>> +               }
>> +
> 
> There are a few bits here that aren't quite handled correctly.  It
> looks like we are getting the total_rx_packets, but you didn't update
> total_rx_bytes.
> 
>>                 if (!skb)
>>                         break;
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> index e065321ce8ed..957d856a82c4 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> @@ -341,6 +341,8 @@ struct i40e_ring {
>>
>>         struct rcu_head rcu;            /* to avoid race on free */
>>         u16 next_to_alloc;
>> +
>> +       struct bpf_prog *xdp_prog;
>>  } ____cacheline_internodealigned_in_smp;
>>
> 
> You might be better off moving this further up in the structure.
> Maybe into the slot after *tail.  Otherwise it is going to be in a
> pretty noisy cache line, although it looks like nobody ever really
> bothered to optimize the i40e_ring structure so that you had read
> mostly and write mostly cache lines anyway so maybe you don't need to
> bother.

Maybe another patch to clean up the structures.

> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 

