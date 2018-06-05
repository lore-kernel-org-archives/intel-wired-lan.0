From: zhuyj <zyjzyj2000@gmail.com>
Date: Tue, 5 Jun 2018 11:31:01 +0800
Subject: [Intel-wired-lan] [net-queue PATCH] ixgbe: check that ipsec is
 available on the chip
In-Reply-To: <CAD=hENe=mx_h1zqF1h2=jir8s64UhRfLKogZDu_jhfC3iz9BNw@mail.gmail.com>
References: <1528138710-31848-1-git-send-email-shannon.nelson@oracle.com>
 <CAD=hENe=mx_h1zqF1h2=jir8s64UhRfLKogZDu_jhfC3iz9BNw@mail.gmail.com>
Message-ID: <CAD=hENfF5KpyFhh-Dmji0u6LoO5iqWXza9ET-540OjH6k=GrKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

If ipsec offload is not enabled, can we run "ethtool -K" to enable it
in ixgbe(82599)? And also, we can run "ethtool -k"  to check ixgbe
support ipsec offload or not. Then the user can know the ixgbe chip
support ipsec offload or not before he comes accross a bug.

Zhu Yanjun

On Tue, Jun 5, 2018 at 11:25 AM, zhuyj <zyjzyj2000@gmail.com> wrote:
> Can we add ipsec state to "ethtool -k"? So we run "ethtool -k" to
> check ipsec offload enabled or not.
>
> Zhu Yanjun
>
> On Tue, Jun 5, 2018 at 2:58 AM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Check the writability of the IPsec configuration registers
>> before setting up the offload.
>>
>> Fixes: 49a94d74d948 ("ixgbe: add ipsec engine start and stop routines")
>> Reported-by: Andre Tomt <andre@tomt.net>
>> Cc: Alexander Duyck <alexander.h.duyck@intel.com>
>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 20 +++++++++++++++++++-
>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>> index 344a1f2..003b53f 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>> @@ -210,7 +210,10 @@ static void ixgbe_ipsec_stop_engine(struct ixgbe_adapter *adapter)
>>         struct ixgbe_hw *hw = &adapter->hw;
>>         u32 reg;
>>
>> -       ixgbe_ipsec_stop_data(adapter);
>> +       /* stop data if it has been running */
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>> +       if (!(reg & IXGBE_SECTXCTRL_SECTX_DIS))
>> +               ixgbe_ipsec_stop_data(adapter);
>>
>>         /* disable Rx and Tx SA lookup */
>>         IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, 0);
>> @@ -966,12 +969,27 @@ void ixgbe_ipsec_rx(struct ixgbe_ring *rx_ring,
>>   **/
>>  void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>>  {
>> +       struct ixgbe_hw *hw = &adapter->hw;
>>         struct ixgbe_ipsec *ipsec;
>>         size_t size;
>> +       u32 reg1, reg2;
>>
>>         if (adapter->hw.mac.type == ixgbe_mac_82598EB)
>>                 return;
>>
>> +       /* verify that the ipsec offload is available by checking
>> +        * the writability of the engine DISable bit - can we clear
>> +        * the bit?  If not, don't set up ipsec.  If yes, the put
>> +        * it back and continue the setup.
>> +        */
>> +       reg1 = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>> +       reg2 = reg1 & ~IXGBE_SECTXCTRL_SECTX_DIS;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg2);
>> +       reg2 = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>> +       if (reg2 & IXGBE_SECTXCTRL_SECTX_DIS)
>> +               return;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg1);
>> +
>>         ipsec = kzalloc(sizeof(*ipsec), GFP_KERNEL);
>>         if (!ipsec)
>>                 goto err1;
>> --
>> 2.7.4
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
