From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 7 Dec 2017 09:16:09 -0800
Subject: [Intel-wired-lan] [next-queue 06/10] ixgbe: restore offloaded
 SAs after a reset
In-Reply-To: <90efb41d-2cab-f623-8b3d-318f3ad6e135@oracle.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-7-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UdOG5H02Tqin4OhEvp=6ZDn365g04JvVOVAiTyCnncPew@mail.gmail.com>
 <90efb41d-2cab-f623-8b3d-318f3ad6e135@oracle.com>
Message-ID: <CAKgT0UfDFyH8qjg_-cdGYx5f06iTwydcMTcZ5FvhKJ+=2bNTLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Dec 6, 2017 at 9:43 PM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 12/5/2017 9:30 AM, Alexander Duyck wrote:
>>
>> On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
>> <shannon.nelson@oracle.com> wrote:
>>>
>>> On a chip reset most of the table contents are lost, so must be
>>> restored.  This scans the driver's ipsec tables and restores both
>>> the filled and empty table slots to their pre-reset values.
>>>
>>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>>> ---
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  2 +
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 53
>>> ++++++++++++++++++++++++++
>>>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  1 +
>>>   3 files changed, 56 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> index 9487750..7e8bca7 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>>> @@ -1009,7 +1009,9 @@ s32 ixgbe_negotiate_fc(struct ixgbe_hw *hw, u32
>>> adv_reg, u32 lp_reg,
>>>                         u32 adv_sym, u32 adv_asm, u32 lp_sym, u32
>>> lp_asm);
>>>   #ifdef CONFIG_XFRM_OFFLOAD
>>>   void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter);
>>> +void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter);
>>>   #else
>>>   static inline void ixgbe_init_ipsec_offload(struct ixgbe_adapter
>>> *adapter) { };
>>> +static inline void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter) {
>>> };
>>>   #endif /* CONFIG_XFRM_OFFLOAD */
>>>   #endif /* _IXGBE_H_ */
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> index 7b01d92..b93ee7f 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>> @@ -292,6 +292,59 @@ static void ixgbe_ipsec_start_engine(struct
>>> ixgbe_adapter *adapter)
>>>   }
>>>
>>>   /**
>>> + * ixgbe_ipsec_restore - restore the ipsec HW settings after a reset
>>> + * @adapter: board private structure
>>> + **/
>>> +void ixgbe_ipsec_restore(struct ixgbe_adapter *adapter)
>>> +{
>>> +       struct ixgbe_ipsec *ipsec = adapter->ipsec;
>>> +       struct ixgbe_hw *hw = &adapter->hw;
>>> +       u32 zbuf[4] = {0, 0, 0, 0};
>>
>>
>> zbuf should be a static const.
>
>
> Yep
>
>>
>>> +       int i;
>>> +
>>> +       if (!(adapter->flags2 & IXGBE_FLAG2_IPSEC_ENABLED))
>>> +               return;
>>> +
>>> +       /* clean up the engine settings */
>>> +       ixgbe_ipsec_stop_engine(adapter);
>>> +
>>> +       /* start the engine */
>>> +       ixgbe_ipsec_start_engine(adapter);
>>> +
>>> +       /* reload the IP addrs */
>>> +       for (i = 0; i < IXGBE_IPSEC_MAX_RX_IP_COUNT; i++) {
>>> +               struct rx_ip_sa *ipsa = &ipsec->ip_tbl[i];
>>> +
>>> +               if (ipsa->used)
>>> +                       ixgbe_ipsec_set_rx_ip(hw, i, ipsa->ipaddr);
>>> +               else
>>> +                       ixgbe_ipsec_set_rx_ip(hw, i, zbuf);
>>
>>
>> If we are doing a restore do we actually need to write the zero
>> values? If we did a reset I thought you had a function that was going
>> through and zeroing everything out. If so this now becomes redundant.
>
>
> Currently ixgbe_ipsec_clear_hw_tables() only gets run at at probe.  It
> should probably get run at remove as well.  Doing this is a bit of safety
> paranoia, and making sure the CAM memory structures that don't get cleared
> on reset have exactly what I expect in them.

You might just move ixgbe_ipsec_clear_hw_tables into the rest logic
itself. Then it covers all cases where you would be resetting the
hardware and expecting a consistent state. It will mean writing some
registers twice during the reset but it is probably better just to
make certain everything stays in a known good state after a reset.

>>
>>> +       }
>>> +
>>> +       /* reload the Rx keys */
>>> +       for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
>>> +               struct rx_sa *rsa = &ipsec->rx_tbl[i];
>>> +
>>> +               if (rsa->used)
>>> +                       ixgbe_ipsec_set_rx_sa(hw, i, rsa->xs->id.spi,
>>> +                                             rsa->key, rsa->salt,
>>> +                                             rsa->mode, rsa->iptbl_ind);
>>> +               else
>>> +                       ixgbe_ipsec_set_rx_sa(hw, i, 0, zbuf, 0, 0, 0);
>>
>>
>> same here
>>
>>> +       }
>>> +
>>> +       /* reload the Tx keys */
>>> +       for (i = 0; i < IXGBE_IPSEC_MAX_SA_COUNT; i++) {
>>> +               struct tx_sa *tsa = &ipsec->tx_tbl[i];
>>> +
>>> +               if (tsa->used)
>>> +                       ixgbe_ipsec_set_tx_sa(hw, i, tsa->key,
>>> tsa->salt);
>>> +               else
>>> +                       ixgbe_ipsec_set_tx_sa(hw, i, zbuf, 0);
>>
>>
>> and here
>>
>>> +       }
>>> +}
>>> +
>>> +/**
>>>    * ixgbe_ipsec_find_empty_idx - find the first unused security
>>> parameter index
>>>    * @ipsec: pointer to ipsec struct
>>>    * @rxtable: true if we need to look in the Rx table
>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> index 01fd89b..6eabf92 100644
>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>>> @@ -5347,6 +5347,7 @@ static void ixgbe_configure(struct ixgbe_adapter
>>> *adapter)
>>>
>>>          ixgbe_set_rx_mode(adapter->netdev);
>>>          ixgbe_restore_vlan(adapter);
>>> +       ixgbe_ipsec_restore(adapter);
>>>
>>>          switch (hw->mac.type) {
>>>          case ixgbe_mac_82599EB:
>>> --
>>> 2.7.4
>>>
>>> _______________________________________________
>>> Intel-wired-lan mailing list
>>> Intel-wired-lan at osuosl.org
>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
