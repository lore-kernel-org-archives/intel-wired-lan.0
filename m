From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Wed, 6 Dec 2017 21:43:22 -0800
Subject: [Intel-wired-lan] [next-queue 03/10] ixgbe: add ipsec engine
 start and stop routines
In-Reply-To: <CAKgT0UfJDtGBJEij3TBKAaS_QFukMSiG9TieA49kKXdPwLi9PA@mail.gmail.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-4-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UfJDtGBJEij3TBKAaS_QFukMSiG9TieA49kKXdPwLi9PA@mail.gmail.com>
Message-ID: <2110823d-e8a2-987e-ca91-6cc77ea0f5c6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/5/2017 8:22 AM, Alexander Duyck wrote:
> On Mon, Dec 4, 2017 at 9:35 PM, Shannon Nelson
> <shannon.nelson@oracle.com> wrote:
>> Add in the code for running and stopping the hardware ipsec
>> encryption/decryption engine.  It is good to keep the engine
>> off when not in use in order to save on the power draw.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
>> ---
>>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 140 +++++++++++++++++++++++++
>>   1 file changed, 140 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>> index 14dd011..38a1a16 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>> @@ -148,10 +148,150 @@ void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
>>   }
>>
>>   /**
>> + * ixgbe_ipsec_stop_data
>> + * @adapter: board private structure
>> + **/
>> +static void ixgbe_ipsec_stop_data(struct ixgbe_adapter *adapter)
>> +{
>> +       struct ixgbe_hw *hw = &adapter->hw;
>> +       bool link = adapter->link_up;
>> +       u32 t_rdy, r_rdy;
>> +       u32 reg;
>> +
>> +       /* halt data paths */
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>> +       reg |= IXGBE_SECTXCTRL_TX_DIS;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg);
>> +
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
>> +       reg |= IXGBE_SECRXCTRL_RX_DIS;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, reg);
>> +
>> +       IXGBE_WRITE_FLUSH(hw);
>> +
>> +       /* If the tx fifo doesn't have link, but still has data,
>> +        * we can't clear the tx sec block.  Set the MAC loopback
>> +        * before block clear
>> +        */
>> +       if (!link) {
>> +               reg = IXGBE_READ_REG(hw, IXGBE_MACC);
>> +               reg |= IXGBE_MACC_FLU;
>> +               IXGBE_WRITE_REG(hw, IXGBE_MACC, reg);
>> +
>> +               reg = IXGBE_READ_REG(hw, IXGBE_HLREG0);
>> +               reg |= IXGBE_HLREG0_LPBK;
>> +               IXGBE_WRITE_REG(hw, IXGBE_HLREG0, reg);
>> +
>> +               IXGBE_WRITE_FLUSH(hw);
>> +               mdelay(3);
>> +       }
>> +
>> +       /* wait for the paths to empty */
>> +       do {
>> +               mdelay(10);
>> +               t_rdy = IXGBE_READ_REG(hw, IXGBE_SECTXSTAT) &
>> +                       IXGBE_SECTXSTAT_SECTX_RDY;
>> +               r_rdy = IXGBE_READ_REG(hw, IXGBE_SECRXSTAT) &
>> +                       IXGBE_SECRXSTAT_SECRX_RDY;
>> +       } while (!t_rdy && !r_rdy);
> 
> This piece seems buggy to me. There should be some sort of limit on
> how long you are willing to delay. Otherwise a surprise remove can
> cause this to spin forever when the register reads return all 1's.

Yep - I had meant to limit that.  Thanks.

> 
>> +
>> +       /* undo loopback if we played with it earlier */
>> +       if (!link) {
>> +               reg = IXGBE_READ_REG(hw, IXGBE_MACC);
>> +               reg &= ~IXGBE_MACC_FLU;
>> +               IXGBE_WRITE_REG(hw, IXGBE_MACC, reg);
>> +
>> +               reg = IXGBE_READ_REG(hw, IXGBE_HLREG0);
>> +               reg &= ~IXGBE_HLREG0_LPBK;
>> +               IXGBE_WRITE_REG(hw, IXGBE_HLREG0, reg);
>> +
>> +               IXGBE_WRITE_FLUSH(hw);
>> +       }
>> +}
>> +
>> +/**
>> + * ixgbe_ipsec_stop_engine
>> + * @adapter: board private structure
>> + **/
>> +static void ixgbe_ipsec_stop_engine(struct ixgbe_adapter *adapter)
>> +{
>> +       struct ixgbe_hw *hw = &adapter->hw;
>> +       u32 reg;
>> +
>> +       ixgbe_ipsec_stop_data(adapter);
>> +
>> +       /* disable Rx and Tx SA lookup */
>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, 0);
>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, 0);
>> +
>> +       /* disable the Rx and Tx engines and full packet store-n-forward */
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECTXCTRL);
>> +       reg |= IXGBE_SECTXCTRL_SECTX_DIS;
>> +       reg &= ~IXGBE_SECTXCTRL_STORE_FORWARD;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, reg);
>> +
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECRXCTRL);
>> +       reg |= IXGBE_SECRXCTRL_SECRX_DIS;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, reg);
>> +
>> +       /* restore the "tx security buffer almost full threshold" to 0x250 */
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXBUFFAF, 0x250);
>> +
>> +       /* Set minimum IFG between packets back to the default 0x1 */
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG);
>> +       reg = (reg & 0xfffffff0) | 0x1;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXMINIFG, reg);
>> +
>> +       /* final set for normal (no ipsec offload) processing */
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, IXGBE_SECTXCTRL_SECTX_DIS);
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, IXGBE_SECRXCTRL_SECRX_DIS);
>> +
>> +       IXGBE_WRITE_FLUSH(hw);
>> +}
>> +
>> +/**
>> + * ixgbe_ipsec_start_engine
>> + * @adapter: board private structure
>> + *
>> + * NOTE: this increases power consumption whether being used or not
>> + **/
>> +static void ixgbe_ipsec_start_engine(struct ixgbe_adapter *adapter)
>> +{
>> +       struct ixgbe_hw *hw = &adapter->hw;
>> +       u32 reg;
>> +
>> +       ixgbe_ipsec_stop_data(adapter);
>> +
>> +       /* Set minimum IFG between packets to 3 */
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECTXMINIFG);
>> +       reg = (reg & 0xfffffff0) | 0x3;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXMINIFG, reg);
>> +
>> +       /* Set "tx security buffer almost full threshold" to 0x15 so that the
>> +        * almost full indication is generated only after buffer contains at
>> +        * least an entire jumbo packet.
>> +        */
>> +       reg = IXGBE_READ_REG(hw, IXGBE_SECTXBUFFAF);
>> +       reg = (reg & 0xfffffc00) | 0x15;
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXBUFFAF, reg);
>> +
>> +       /* restart the data paths by clearing the DISABLE bits */
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECRXCTRL, 0);
>> +       IXGBE_WRITE_REG(hw, IXGBE_SECTXCTRL, IXGBE_SECTXCTRL_STORE_FORWARD);
>> +
>> +       /* enable Rx and Tx SA lookup */
>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, IXGBE_RXTXIDX_IPS_EN);
>> +       IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, IXGBE_RXTXIDX_IPS_EN);
>> +
>> +       IXGBE_WRITE_FLUSH(hw);
>> +}
>> +
> 
> It would probably make sense to add a data member to the hardware
> structure that tracks if you have IPsec enabled or not. Then you don't
> have to track the IPS_EN bits in patch 2 like you currently are and
> could instead either not do IPsec SA updates if IPsec is not enabled,
> or use the enable value to determine what you write for IPS_EN instead
> of having to read registers.

As I responded earlier, the datasheet says to be sure to not change the 
EN bit while writing the Rx tables.  I'm going to use the same logic on 
both Tx and Rx tables.

sln

> 
>> +/**
>>    * ixgbe_init_ipsec_offload - initialize security registers for IPSec operation
>>    * @adapter: board private structure
>>    **/
>>   void ixgbe_init_ipsec_offload(struct ixgbe_adapter *adapter)
>>   {
>>          ixgbe_ipsec_clear_hw_tables(adapter);
>> +       ixgbe_ipsec_stop_engine(adapter);
>>   }
>> --
>> 2.7.4
>>
>> _______________________________________________
>> Intel-wired-lan mailing list
>> Intel-wired-lan at osuosl.org
>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
