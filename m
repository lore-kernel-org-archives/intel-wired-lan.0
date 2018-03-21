From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@gmail.com>
Date: Wed, 21 Mar 2018 18:00:59 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: add support for XDP_REDIRECT
In-Reply-To: <CAKgT0UftD7Me9MBzsvqqWW_BpbisZ+wbJV4vWTYh+3hMWqdk5g@mail.gmail.com>
References: <20180321161537.4435-1-bjorn.topel@gmail.com>
 <CAKgT0UftD7Me9MBzsvqqWW_BpbisZ+wbJV4vWTYh+3hMWqdk5g@mail.gmail.com>
Message-ID: <CAJ+HfNi9xfzDcOmnei4qK4qq7+Es2mm70YCcCPyfOvn8uzBX5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

2018-03-21 17:40 GMT+01:00 Alexander Duyck <alexander.duyck@gmail.com>:
> On Wed, Mar 21, 2018 at 9:15 AM, Bj?rn T?pel <bjorn.topel@gmail.com> wrote:
>> From: Bj?rn T?pel <bjorn.topel@intel.com>
>>
>> The driver now acts upon the XDP_REDIRECT return action. Two new ndos
>> are implemented, ndo_xdp_xmit and ndo_xdp_flush.
>>
>> XDP_REDIRECT action enables XDP program to redirect frames to other
>> netdevs. The target redirect/forward netdev might release the XDP data
>> page within the ndo_xdp_xmit function (triggered by xdp_do_redirect),
>> which meant that the i40e page count logic had to be tweaked.
>>
>> An example. i40e_clean_rx_irq is entered, and one rx_buffer is pulled
>> from the hardware descriptor ring. Say that the actual page refcount
>> is 1. XDP is enabled, and the redirect action is triggered. The target
>> netdev ndo_xdp_xmit decreases the page refcount, resulting in the page
>> being freed. The prior assumption was that the function owned the page
>> until i40e_put_rx_buffer was called, increasing the refcount again.
>>
>> Now, we don't allow a refcount less than 2. Another option would be
>> calling xdp_do_redirect *after* i40e_put_rx_buffer, but that would
>> have required new/more conditionals.
>>
>> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +
>>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 83 +++++++++++++++++++++++------
>>  drivers/net/ethernet/intel/i40e/i40e_txrx.h |  2 +
>>  3 files changed, 72 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> index 79ab52276d12..2fb4261b4fd9 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
>> @@ -11815,6 +11815,8 @@ static const struct net_device_ops i40e_netdev_ops = {
>>         .ndo_bridge_getlink     = i40e_ndo_bridge_getlink,
>>         .ndo_bridge_setlink     = i40e_ndo_bridge_setlink,
>>         .ndo_bpf                = i40e_xdp,
>> +       .ndo_xdp_xmit           = i40e_xdp_xmit,
>> +       .ndo_xdp_flush          = i40e_xdp_flush,
>>  };
>>
>>  /**
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> index c6972bd07e49..2106ae04d053 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
>> @@ -1589,8 +1589,8 @@ static bool i40e_alloc_mapped_page(struct i40e_ring *rx_ring,
>>         bi->page = page;
>>         bi->page_offset = i40e_rx_offset(rx_ring);
>>
>> -       /* initialize pagecnt_bias to 1 representing we fully own page */
>> -       bi->pagecnt_bias = 1;
>> +       page_ref_add(page, USHRT_MAX - 1);
>> +       bi->pagecnt_bias = USHRT_MAX;
>>
>>         return true;
>>  }
>> @@ -1956,8 +1956,8 @@ static bool i40e_can_reuse_rx_page(struct i40e_rx_buffer *rx_buffer)
>>          * the pagecnt_bias and page count so that we fully restock the
>>          * number of references the driver holds.
>>          */
>> -       if (unlikely(!pagecnt_bias)) {
>> -               page_ref_add(page, USHRT_MAX);
>> +       if (unlikely(pagecnt_bias == 1)) {
>> +               page_ref_add(page, USHRT_MAX - 1);
>>                 rx_buffer->pagecnt_bias = USHRT_MAX;
>>         }
>>
>
> I think I would be more comfortable with this if this patch was moved
> to a separate patch. I also assume similar changes are needed for
> ixgbe, are they not?
>

Yes, ixgbe need a similar change. I'll send a patch for that!

As for i40e, only when the the xdp_do_redirect path is added, the
refcount need to change. That said, I'll split the page reference
counting from the XDP_REDIRECT code in a V2.

>> @@ -2215,7 +2215,7 @@ static int i40e_xmit_xdp_ring(struct xdp_buff *xdp,
>>  static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
>>                                     struct xdp_buff *xdp)
>>  {
>> -       int result = I40E_XDP_PASS;
>> +       int err, result = I40E_XDP_PASS;
>>         struct i40e_ring *xdp_ring;
>>         struct bpf_prog *xdp_prog;
>>         u32 act;
>> @@ -2234,6 +2234,10 @@ static struct sk_buff *i40e_run_xdp(struct i40e_ring *rx_ring,
>>                 xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
>>                 result = i40e_xmit_xdp_ring(xdp, xdp_ring);
>>                 break;
>> +       case XDP_REDIRECT:
>> +               err = xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog);
>> +               result = !err ? I40E_XDP_TX : I40E_XDP_CONSUMED;
>> +               break;
>>         default:
>>                 bpf_warn_invalid_xdp_action(act);
>>         case XDP_ABORTED:
>> @@ -2269,6 +2273,16 @@ static void i40e_rx_buffer_flip(struct i40e_ring *rx_ring,
>>  #endif
>>  }
>>
>> +static inline void i40e_xdp_ring_update_tail(struct i40e_ring *xdp_ring)
>> +{
>> +       /* Force memory writes to complete before letting h/w
>> +        * know there are new descriptors to fetch.
>> +        */
>> +       wmb();
>> +
>> +       writel(xdp_ring->next_to_use, xdp_ring->tail);
>> +}
>> +
>
> I don't know if you have seen the other changes going by but this
> needs to use writel_relaxed, not just standard writel if you are
> following a wmb.
>

Hmm, other writel_relaxed changes for the i40e driver?

I thought writel only implied smp_wmb, but it's stronger iow. I'll
change to writel_relaxed, or just a writel w/o the fence.

>>  /**
>>   * i40e_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>>   * @rx_ring: rx descriptor ring to transact packets on
>> @@ -2403,16 +2417,9 @@ static int i40e_clean_rx_irq(struct i40e_ring *rx_ring, int budget)
>>         }
>>
>>         if (xdp_xmit) {
>> -               struct i40e_ring *xdp_ring;
>> -
>> -               xdp_ring = rx_ring->vsi->xdp_rings[rx_ring->queue_index];
>> -
>> -               /* Force memory writes to complete before letting h/w
>> -                * know there are new descriptors to fetch.
>> -                */
>> -               wmb();
>> -
>> -               writel(xdp_ring->next_to_use, xdp_ring->tail);
>> +               i40e_xdp_ring_update_tail(
>> +                       rx_ring->vsi->xdp_rings[rx_ring->queue_index]);
>> +               xdp_do_flush_map();
>
> I think I preferred this with the xdp_ring variable. It is more
> readable then this folded up setup.
>

Yes, indeed!

>>         }
>>
>>         rx_ring->skb = skb;
>> @@ -3660,3 +3667,49 @@ netdev_tx_t i40e_lan_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
>>
>>         return i40e_xmit_frame_ring(skb, tx_ring);
>>  }
>> +
>> +/**
>> + * i40e_xdp_xmit - Implements ndo_xdp_xmit
>> + * @dev: netdev
>> + * @xdp: XDP buffer
>> + *
>> + * Returns Zero if sent, else an error code
>> + **/
>> +int i40e_xdp_xmit(struct net_device *dev, struct xdp_buff *xdp)
>> +{
>> +       struct i40e_netdev_priv *np = netdev_priv(dev);
>> +       unsigned int queue_index = smp_processor_id();
>> +       struct i40e_vsi *vsi = np->vsi;
>> +       int err;
>> +
>> +       if (test_bit(__I40E_VSI_DOWN, vsi->state))
>> +               return -EINVAL;
>> +
>> +       if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
>> +               return -EINVAL;
>> +
>
> In order for this bit of logic to work you have to guarantee that you
> cannot have another ring running an XDP_TX using the same Tx queue. I
> don't know if XDP_REDIRECT is mutually exclusive with XDP_TX in the
> same bpf program or not. One thing you might look at doing is adding a
> test with a flag to verify that the processor IDs are all less than
> vsi->num_queue_pairs and if so set the flag, and based on that flag
> XDP_TX would use similar logic to what is used here to determine which
> queue to transmit on instead of just assuming it will use the Tx queue
> matched with the Rx queue. Then you could also use that flag in this
> test to determine if you support this mode or not.
>

XDP_REDIRECT and XDP_TX are mutually exclusive, so we're good here!

Finally, thanks for the quick review! Much appreciated!


Bj?rn

>> +       err = i40e_xmit_xdp_ring(xdp, vsi->xdp_rings[queue_index]);
>> +       if (err != I40E_XDP_TX)
>> +               return -ENOMEM;
>> +
>> +       return 0;
>> +}
>> +
>> +/**
>> + * i40e_xdp_flush - Implements ndo_xdp_flush
>> + * @dev: netdev
>> + **/
>> +void i40e_xdp_flush(struct net_device *dev)
>> +{
>> +       struct i40e_netdev_priv *np = netdev_priv(dev);
>> +       unsigned int queue_index = smp_processor_id();
>> +       struct i40e_vsi *vsi = np->vsi;
>> +
>> +       if (test_bit(__I40E_VSI_DOWN, vsi->state))
>> +               return;
>> +
>> +       if (!i40e_enabled_xdp_vsi(vsi) || queue_index >= vsi->num_queue_pairs)
>> +               return;
>> +
>> +       i40e_xdp_ring_update_tail(vsi->xdp_rings[queue_index]);
>> +}
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> index 2444f338bb0c..a97e59721393 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
>> @@ -510,6 +510,8 @@ u32 i40e_get_tx_pending(struct i40e_ring *ring, bool in_sw);
>>  void i40e_detect_recover_hung(struct i40e_vsi *vsi);
>>  int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size);
>>  bool __i40e_chk_linearize(struct sk_buff *skb);
>> +int i40e_xdp_xmit(struct net_device *dev, struct xdp_buff *xdp);
>> +void i40e_xdp_flush(struct net_device *dev);
>>
>>  /**
>>   * i40e_get_head - Retrieve head from head writeback
>> --
>> 2.7.4
>>
