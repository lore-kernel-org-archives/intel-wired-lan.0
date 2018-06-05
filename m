From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 5 Jun 2018 09:22:55 -0700
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: check that ipsec is
 available on the chip
In-Reply-To: <CAD=hENc6JZYrGuN77T-NcwBMt0+jT0mB2M5ONTzrfpFT6ZX88w@mail.gmail.com>
References: <1528138710-31848-1-git-send-email-shannon.nelson@oracle.com>
 <CAD=hENe=mx_h1zqF1h2=jir8s64UhRfLKogZDu_jhfC3iz9BNw@mail.gmail.com>
 <e18490a9-1b97-d351-9f85-d8f0d35cc1fa@oracle.com>
 <CAD=hENc6JZYrGuN77T-NcwBMt0+jT0mB2M5ONTzrfpFT6ZX88w@mail.gmail.com>
Message-ID: <87fad9bf-6708-4b1d-55c2-49e8d4cd952b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/5/2018 5:10 AM, zhuyj wrote:
>   In the mainline kernel source code, it seems that the above does not
> exist. Do you use the latest ixgbe source code from e1000 maillist?
> And can we use "ethtool -K" to enable/disable ipsec offload?

I believe it is in Linux v4.15 and later.  Be sure to enable 
CONFIG_INET_ESP_OFFLOAD and CONFIG_INET6_ESP_OFFLOAD to enable all the 
IPsec offload features.

Since the output shows "[fixed]", the user is not able to change it on 
the fly.

sln

> 
> On Tue, Jun 5, 2018 at 3:40 PM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> On 6/4/2018 8:25 PM, zhuyj wrote:
>>>
>>> Can we add ipsec state to "ethtool -k"? So we run "ethtool -k" to
>>> check ipsec offload enabled or not.
>>
>>
>> It is already there - see
>> # ethtool -k ens1f0 | grep esp
>> tx-esp-segmentation: on [fixed]
>> esp-hw-offload: on [fixed]
>> esp-tx-csum-hw-offload: on [fixed]
>>
>> sln
>>
>>
>>>
>>> Zhu Yanjun
>>>
>>> On Tue, Jun 5, 2018 at 2:58 AM, Shannon Nelson
>>> <shannon.nelson@oracle.com> wrote:
>>>>
>>>> Check the writability of the IPsec configuration registers
>>>> before setting up the offload.
>>>>
>>>> Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
>>>> Reported-by: Andre Tomt <andre@tomt.net>
>>>> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
>>>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 20
>>>> +++++++++++++++++++-
>>>>    1 file changed, 19 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>> index 344a1f2..003b53f 100644
>>>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>>>> @@ -210,7 +210,10 @@ static void ixgbe_ipsec_stop_engine(struct
>>>> ixgbe_adapter *adapter)
>>>>           struct ixgbe_hw *hw = &adapter->hw;
>>>>           u32 reg;
>>>>
>>>> -       ixgbe_ipsec_stop_data(adapter);
>>>> +       /* stop data if it has been running */
>>>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>>>> +       if (!(reg & IXGBE_SECTXCTRL_SECTX_DIS))
>>>> +               ixgbe_ipsec_stop_data(adapter);
>>>>
>>>>           /* disable Rx and Tx SA lookup */
>>>>           IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, 0);
>>>> @@ -966,12 +969,27 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>>>>     **/
>>>>    void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>>>>    {
>>>> +       struct ixgbe_hw *hw = &adapter->hw;
>>>>           struct ixgbe_ipsec *ipsec;
>>>>           size_t size;
>>>> +       u32 reg1, reg2;
>>>>
>>>>           if (adapter->hw.mac.type == ixgbe_mac_82598EB)
>>>>                   return;
>>>>
>>>> +       /* verify that the ipsec offload is available by checking
>>>> +        * the writability of the engine DISable bit - can we clear
>>>> +        * the bit?  If not, don't set up ipsec.  If yes, the put
>>>> +        * it back and continue the setup.
>>>> +        */
>>>> +       reg1 = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>>>> +       reg2 = reg1 & ~IXGBE_SECTXCTRL_SECTX_DIS;
>>>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg2);
>>>> +       reg2 = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>>>> +       if (reg2 & IXGBE_SECTXCTRL_SECTX_DIS)
>>>> +               return;
>>>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg1);
>>>> +
>>>>           ipsec = kzalloc(sizeof(*ipsec), GFP_KERNEL);
>>>>           if (!ipsec)
>>>>                   goto err1;
>>>> --
>>>> 2.7.4
>>>>
>>>> _______________________________________________
>>>> Intel-wired-lan mailing list
>>>> Intel-wired-lan at osuosl.org
>>>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
