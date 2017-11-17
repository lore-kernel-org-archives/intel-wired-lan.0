From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 17 Nov 2017 10:33:58 -0800
Subject: [Intel-wired-lan] [RFC PATCH jkirsher/next-queue 7/9] ixgbe:
 add tx ipsec offload
In-Reply-To: <CAKgT0UcXGGOP=2wyfW6N3OWXR+Ku-Bce0Mq4SRCMLqG_U=4Oew@mail.gmail.com>
References: <1510862087-1924-1-git-send-email-shannon.nelson@oracle.com>
 <1510862087-1924-8-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UcXGGOP=2wyfW6N3OWXR+Ku-Bce0Mq4SRCMLqG_U=4Oew@mail.gmail.com>
Message-ID: <03813da2-9507-eeb5-4e31-7b5e504cba45@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/17/2017 9:43 AM, Alexander Duyck wrote:
> On Thu, Nov 16, 2017 at 11:54 AM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Add the Tx offload mechanisms.
>>
>> Currently this is slightly broken and not setting up the Tx checksum
>> offload correctly, so is best used with
>>          ethtool -K ethN tx off
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> 
> So the one piece that really seems to be missing here is any update to
> ixgbe_features_check. That seems like it should be an integral part of
> all this. With that you would be able to disable features like
> checksum and TSO until you know how they would be configured and you
> can push the checksum offload and segmentation up into the stack until
> you can sort out how you do both the ipsec offload and those other
> offloads.

That would make sense.

> 
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 44 ++++++++++++++++++++++-----
>>   1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 7f503d3..a434675 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -2423,8 +2423,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
>>                                  continue;
>>                          }
>>                  }
>> -
>>   #endif /* IXGBE_FCOE */
>> +
>>                  ixgbe_rx_skb(q_vector, skb);
>>
>>                  /* update budget accounting */
> 
> This is white space noise and can be dropped from the patch.
> 
>> @@ -7791,9 +7791,10 @@ static void ixgbe_service_task(struct work_struct *work)
>>
>>   static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>>                       struct ixgbe_tx_buffer *first,
>> -                    u8 *hdr_len)
>> +                    u8 *hdr_len,
>> +                    struct ixgbe_ipsec_tx_data *itd)
>>   {
>> -       u32 vlan_macip_lens, type_tucmd, mss_l4len_idx;
>> +       u32 vlan_macip_lens, type_tucmd, mss_l4len_idx, fcoe_sof_eof = 0;
> 
> I realize that fcoe_sof_eof is probably what we were calling that part
> of the context descriptor, but you may want to choose a name that
> better describes how we are using this field.

I just figured to name it in keeping with the parameter name in 
ixgbe_tx_ctxtdesc().  Perhaps changing it in both places to something 
like fcoef_saidx would better match the datasheet.  Of course, since 
it's a multifaceted and useful field, maybe I'll name it "Mitch" :-).

Then there's the context descriptor field name itself: seqnum_seed. 
Where did that come from?  I'm tempted to rename that thing too.


> 
>>          struct sk_buff *skb = first->skb;
>>          union {
>>                  struct iphdr *v4;
>> @@ -7872,7 +7873,14 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>>          vlan_macip_lens |= (ip.hdr - skb->data) << IXGBE_ADVTXD_MACLEN_SHIFT;
>>          vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
>>
>> -       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, 0, type_tucmd,
>> +#ifdef CONFIG_XFRM_OFFLOAD
>> +       if (first->tx_flags & IXGBE_TX_FLAGS_IPSEC) {
>> +               fcoe_sof_eof |= itd->sa_idx;
>> +               type_tucmd |= itd->flags | itd->trailer_len;
>> +       }
> 
> Reading the datasheet for the X550, as per section 7.13.4.3 it looks
> like these parts expect no trailer to be added to the packet in the
> case of TSO. Do you know if the trailer is provided with a packet
> being sent for TSO? If so it needs to be stripped, and it will be
> added by hardware.

Yep, I think you're right.

> 
>> +#endif /* CONFIG_XFRM_OFFLOAD */
>> +
>> +       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, fcoe_sof_eof, type_tucmd,
>>                            mss_l4len_idx);
>>
>>          return 1;
> 
> 
> 
>> @@ -7888,10 +7896,12 @@ static inline bool ixgbe_ipv6_csum_is_sctp(struct sk_buff *skb)
>>   }
>>
>>   static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>> -                         struct ixgbe_tx_buffer *first)
>> +                         struct ixgbe_tx_buffer *first,
>> +                         struct ixgbe_ipsec_tx_data *itd)
>>   {
>>          struct sk_buff *skb = first->skb;
>>          u32 vlan_macip_lens = 0;
>> +       u32 fcoe_sof_eof = 0;
>>          u32 type_tucmd = 0;
>>
>>          if (skb->ip_summed != CHECKSUM_PARTIAL) {
>> @@ -7932,7 +7942,15 @@ static void ixgbe_tx_csum(struct ixgbe_ring *tx_ring,
>>          vlan_macip_lens |= skb_network_offset(skb) << IXGBE_ADVTXD_MACLEN_SHIFT;
>>          vlan_macip_lens |= first->tx_flags & IXGBE_TX_FLAGS_VLAN_MASK;
>>
>> -       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens, 0, type_tucmd, 0);
>> +#ifdef CONFIG_XFRM_OFFLOAD
>> +       if (first->tx_flags & IXGBE_TX_FLAGS_IPSEC) {
>> +               fcoe_sof_eof |= itd->sa_idx;
>> +               type_tucmd |= itd->flags | itd->trailer_len;
>> +       }
>> +#endif /* CONFIG_XFRM_OFFLOAD */
>> +
>> +       ixgbe_tx_ctxtdesc(tx_ring, vlan_macip_lens,
>> +                         fcoe_sof_eof, type_tucmd, 0);
>>   }
>>
> 
> So I am not sure what flags you would need to be adding to the
> type_tucmd portion of the context descriptor. From what I can tell it
> should just be the trailer length that gets dropped in there.

That's correct.

sln

> 
>>   #define IXGBE_SET_FLAG(_input, _flag, _result) \
>> @@ -7980,6 +7998,11 @@ static void ixgbe_tx_olinfo_status(union ixgbe_adv_tx_desc *tx_desc,
>>                                          IXGBE_TX_FLAGS_IPV4,
>>                                          IXGBE_ADVTXD_POPTS_IXSM);
>>
>> +       /* enble IPsec */
>> +       olinfo_status |= IXGBE_SET_FLAG(tx_flags,
>> +                                       IXGBE_TX_FLAGS_IPSEC,
>> +                                       IXGBE_ADVTXD_POPTS_IPSEC);
>> +
>>          /*
>>           * Check Context must be set if Tx switch is enabled, which it
>>           * always is for case where virtual functions are running
>> @@ -8444,6 +8467,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>>          u32 tx_flags = 0;
>>          unsigned short f;
>>          u16 count = TXD_USE_COUNT(skb_headlen(skb));
>> +       struct ixgbe_ipsec_tx_data ipsec_tx;
>>          __be16 protocol = skb->protocol;
>>          u8 hdr_len = 0;
>>
>> @@ -8532,6 +8556,10 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>>                  }
>>          }
>>
>> +       if ((adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED) &&
>> +           ixgbe_ipsec_tx(tx_ring, skb, &ipsec_tx))
>> +               tx_flags |= IXGBE_TX_FLAGS_IPSEC | IXGBE_TX_FLAGS_CC;
>> +
>>          /* record initial flags and protocol */
>>          first->tx_flags = tx_flags;
>>          first->protocol = protocol;
>> @@ -8548,11 +8576,11 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>>          }
>>
>>   #endif /* IXGBE_FCOE */
>> -       tso = ixgbe_tso(tx_ring, first, &hdr_len);
>> +       tso = ixgbe_tso(tx_ring, first, &hdr_len, &ipsec_tx);
>>          if (tso < 0)
>>                  goto out_drop;
>>          else if (!tso)
>> -               ixgbe_tx_csum(tx_ring, first);
>> +               ixgbe_tx_csum(tx_ring, first, &ipsec_tx);
>>
>>          /* add the ATR filter if ATR is on */
>>          if (test_bit(__IXGBE_TX_FDIR_INIT_DONE, &tx_ring->state))
