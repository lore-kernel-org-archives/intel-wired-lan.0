From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 7 Dec 2017 09:20:59 -0800
Subject: [Intel-wired-lan] [next-queue 07/10] ixgbe: process the Rx
 ipsec offload
In-Reply-To: <eb6a3c29-ba18-ec42-0a95-76f0af0cd1b4@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-8-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UdJxfXZoHifkUFtnwwhuV9WLgEFO3ccqfTnS-nX5a7wHQ@mail.gmail.com>
 <eb6a3c29-ba18-ec42-0a95-76f0af0cd1b4@oracle.com>
Message-ID: <CAKgT0UdLHYLVEAgm6x3-L=_7pTL9Xu-R9c15HpnbwLyXG2bCFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 6, 2017 at 9:43 PM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 12/5/2017 9:40 AM, Alexander Duyck wrote:
>>
>> On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
>> <shannon.nelson@oracle.com> wrote:
>>>
>>> If the chip sees and decrypts an ipsec offload, set up the skb
>>> sp pointer with the ralated SA info.  Since the chip is rude
>>> enough to keep to itself the table index it used for the
>>> decryption, we have to do our own table lookup, using the
>>> hash for speed.
>>>
>>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>>> ---
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  6 ++
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 89
>>> ++++++++++++++++++++++++++
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  3 +
>>>   3 files changed, 98 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> index 7e8bca7..77f07dc 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> @@ -1009,9 +1009,15 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32
>>> adv_reg, u32 lp_reg,
>>>                         u32 adv_sym, u32 adv_asm, u32 lp_sym, u32
>>> lp_asm);
>>>   #ifdef CONFIG_XFRM_OFFLOAD
>>>   void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
>>> +void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>>> +                   union ixgbe_adv_rx_desc *rx_desc,
>>> +                   struct sk_buff *skb);
>>>   void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
>>>   #else
>>>   static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter
>>> *adapter) { };
>>> +static inline void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>>> +                                 union ixgbe_adv_rx_desc *rx_desc,
>>> +                                 struct sk_buff *skb) { };
>>>   static inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) {
>>> };
>>>   #endif /* CONFIG_XFRM_OFFLOAD */
>>>   #endif /* _IXGBE_H_ */
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> index b93ee7f..fd06d9b 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> @@ -379,6 +379,35 @@ static int ixgbe_ipsec_find_empty_idx(struct
>>> ixgbe_ipsec *ipsec, bool rxtable)
>>>   }
>>>
>>>   /**
>>> + * ixgbe_ipsec_find_rx_state - find the state that matches
>>> + * @ipsec: pointer to ipsec struct
>>> + * @daddr: inbound address to match
>>> + * @proto: protocol to match
>>> + * @spi: SPI to match
>>> + *
>>> + * Returns a pointer to the matching SA state information
>>> + **/
>>> +static struct xfrm_state *ixgbe_ipsec_find_rx_state(struct ixgbe_ipsec
>>> *ipsec,
>>> +                                                   __be32 daddr, u8
>>> proto,
>>> +                                                   __be32 spi)
>>> +{
>>> +       struct rx_sa *rsa;
>>> +       struct xfrm_state *ret = NULL;
>>> +
>>> +       rcu_read_lock();
>>> +       hash_for_each_possible_rcu(ipsec->rx_sa_list, rsa, hlist, spi)
>>> +               if (spi == rsa->xs->id.spi &&
>>> +                   daddr == rsa->xs->id.daddr.a4 &&
>>> +                   proto == rsa->xs->id.proto) {
>>> +                       ret = rsa->xs;
>>> +                       xfrm_state_hold(ret);
>>> +                       break;
>>> +               }
>>> +       rcu_read_unlock();
>>> +       return ret;
>>> +}
>>> +
>>
>>
>> You need to choose a bucket, not just walk through all buckets.
>
>
> I may be wrong, but I believe that is what is happening here, where the spi
> is the hash key.  As the function description says "iterate over all
> possible objects hashing to the same bucket".  Besides, I basically cribbed
> this directly from our Mellanox friends (thanks!).

You're right. I misread that.
