From: William Tu <u9012063@gmail.com>
Date: Sat, 11 Mar 2017 12:05:02 -0800
Subject: [Intel-wired-lan] [net-next PATCH v4 1/2] ixgbe: add XDP
	support for pass and drop actions
In-Reply-To: <58C42A52.10609@gmail.com>
References: <20170310191134.17927.55334.stgit@john-Precision-Tower-5810>
 <CALDO+SY4UH1_qc971_-y5Tn=1Kzy-a8AoxJdyzghm+-_=FnrHg@mail.gmail.com>
 <58C42A52.10609@gmail.com>
Message-ID: <CALDO+SbbaPLT8NmZfK5HDxP9FvYFG=q=R8Vwqh=UKPMVwRhtOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, Mar 11, 2017 at 8:48 AM, John Fastabend
<john.fastabend@gmail.com> wrote:
> On 17-03-11 07:49 AM, William Tu wrote:
>> On Fri, Mar 10, 2017 at 11:11 AM, John Fastabend
>> <john.fastabend@gmail.com> wrote:
>>> Basic XDP drop support for ixgbe. Uses READ_ONCE/xchg semantics on XDP
>>> programs instead of rcu primitives as suggested by Daniel Borkmann and
>>> Alex Duyck.
>>>
>>> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
>>> ---
>
> [...]
>
>>>  /**
>>>   * ixgbe_clean_rx_irq - Clean completed descriptors from Rx ring - bounce buf
>>>   * @q_vector: structure containing interrupt and ring information
>>> @@ -2184,6 +2230,7 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>>                 union ixgbe_adv_rx_desc *rx_desc;
>>>                 struct ixgbe_rx_buffer *rx_buffer;
>>>                 struct sk_buff *skb;
>>> +               struct xdp_buff xdp;
>>>                 unsigned int size;
>>>
>>>                 /* return some buffers to hardware, one at a time is too slow */
>>> @@ -2205,15 +2252,29 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>>
>>>                 rx_buffer = ixgbe_get_rx_buffer(rx_ring, rx_desc, &skb, size);
>>>
>>> -               /* retrieve a buffer from the ring */
>>> -               if (skb)
>>> +               if (!skb) {
>>> +                       xdp.data = page_address(rx_buffer->page) +
>>> +                                               rx_buffer->page_offset;
>>> +                       xdp.data_hard_start = xdp.data -
>>> +                                               ixgbe_rx_offset(rx_ring);
>
> We have ixgbe_rx_offset(rx_ring) headroom to support adding headers.
>
>>> +                       xdp.data_end = xdp.data + size;
>>> +
>>> +                       skb = ixgbe_run_xdp(rx_ring, &xdp);
>>> +               }
>>> +
>>> +               if (IS_ERR(skb)) {
>>> +                       total_rx_packets++;
>>> +                       total_rx_bytes += size;
>>> +                       rx_buffer->pagecnt_bias++;
>>> +               } else if (skb) {
>>>                         ixgbe_add_rx_frag(rx_ring, rx_buffer, skb, size);
>>> -               else if (ring_uses_build_skb(rx_ring))
>>> +               } else if (ring_uses_build_skb(rx_ring)) {
>>>                         skb = ixgbe_build_skb(rx_ring, rx_buffer,
>>> -                                             rx_desc, size);
>>> -               else
>>> +                                             &xdp, rx_desc);
>>> +               } else {
>>>                         skb = ixgbe_construct_skb(rx_ring, rx_buffer,
>>> -                                                 rx_desc, size);
>>> +                                                 &xdp, rx_desc);
>>> +               }
>>>
>>>                 /* exit if we failed to retrieve a buffer */
>>>                 if (!skb) {
>
> [...]
>
>>> +static int ixgbe_xdp_setup(struct net_device *dev, struct bpf_prog *prog)
>>> +{
>>> +       int i, frame_size = dev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
>>> +       struct ixgbe_adapter *adapter = netdev_priv(dev);
>>> +       struct bpf_prog *old_prog;
>>> +
>>> +       if (adapter->flags & IXGBE_FLAG_SRIOV_ENABLED)
>>> +               return -EINVAL;
>>> +
>>> +       if (adapter->flags & IXGBE_FLAG_DCB_ENABLED)
>>> +               return -EINVAL;
>>> +
>>> +       /* verify ixgbe ring attributes are sufficient for XDP */
>>> +       for (i = 0; i < adapter->num_rx_queues; i++) {
>>> +               struct ixgbe_ring *ring = adapter->rx_ring[i];
>>> +
>>> +               if (ring_is_rsc_enabled(ring))
>>> +                       return -EINVAL;
>>> +
>>> +               if (frame_size > ixgbe_rx_bufsz(ring))
>>> +                       return -EINVAL;
>>> +       }
>>> +
>>> +       old_prog = xchg(&adapter->xdp_prog, prog);
>>> +       for (i = 0; i < adapter->num_rx_queues; i++)
>>> +               xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
>>> +
>>> +       if (old_prog)
>>> +               bpf_prog_put(old_prog);
>>> +
>>> +       return 0;
>>> +}
>>
>> Since the patch does not support xdp_adjust_head() yet, should we
>> detect and return -EOPNOTSUPP?
>>
>
> It actually should support xdp_adjust_head() :)
>
> At least I tested the xdp tunnel program in ./bpf/samples/ and it worked.
> Also I do a standard test where I push the packet up the stack after adding
> headers and that appears to work although I wonder a bit about some of the
> skb metadata. By working in this case I just use tshark and verify the pkt
> is received with the new header by the stack.
>
>> --William
>
Oh, you're right, that's my mistake. It has adjust head support. thanks!
--William
