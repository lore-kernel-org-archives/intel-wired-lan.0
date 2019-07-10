From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 10 Jul 2019 17:53:35 +0300
Subject: [Intel-wired-lan] [PATCH v3] e1000e: PCIm function state support
In-Reply-To: <9e661c44-4547-58a1-fc90-64132eda2e80@molgen.mpg.de>
References: <20190625143911.37284-1-vitaly.lifshits@intel.com>
 <9e661c44-4547-58a1-fc90-64132eda2e80@molgen.mpg.de>
Message-ID: <3363d8cb-a2f0-2918-7a39-3e5c8fef4999@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 6/28/2019 11:57, Paul Menzel wrote:
> Dear Vitaly,
> 
> 
> Thank you for the patch. Some suggestions below.
> 
> On 06/25/19 16:39, Vitaly Lifshits wrote:
>> Due to commit: 5d8682588605 ("[misc] mei: me: allow runtime
>> 			pm for platform with D0i3")
> 
> Do not indent it but integrate it into the line.
> 
>> When disconnecting the cable and reconnecting it the NIC
> 
> s/When/when/
> 
>> enters DMoff state. This caused wrong link indication
>> and duplex mismatch. This bug is described in:
>> https://bugzilla.redhat.com/show_bug.cgi?id=1689436
> 
> Isn?t there a tag Link: or Bugzilla: to mention these URLs?
> Maybe add it below? (See `git log --grep bugzilla` for how this
> is used.)
> 
>> Checking PCIm function state and performing PHY reset after a
>> timeout in watchdog task solves this issue.
> 
> In what data sheet is the function state described?
> 
>> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
>> ---
>>
>> V2: Fixed typos in commit massage
>> V3: Fixed minor typo
>> ---
>>   drivers/net/ethernet/intel/e1000e/defines.h |  3 +++
>>   drivers/net/ethernet/intel/e1000e/netdev.c  | 18 +++++++++++++++++-
>>   2 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
>> index fd550dee4982..13877fe300f1 100644
>> --- a/drivers/net/ethernet/intel/e1000e/defines.h
>> +++ b/drivers/net/ethernet/intel/e1000e/defines.h
>> @@ -222,6 +222,9 @@
>>   #define E1000_STATUS_PHYRA      0x00000400      /* PHY Reset Asserted */
>>   #define E1000_STATUS_GIO_MASTER_ENABLE	0x00080000	/* Master Req status */
>>   
>> +/* PCIm function state */
>> +#define E1000_STATUS_PCIM_STATE         0x40000000
> 
> Shouldn?t the name be something E1000_STATUS_PCIM_STATE_DMOFF?
> 
>> +
>>   #define HALF_DUPLEX 1
>>   #define FULL_DUPLEX 2
>>   
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index b081a1ef6859..c6a10fd30e4e 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -5173,8 +5173,9 @@ static void e1000_watchdog_task(struct work_struct *work)
>>   	struct e1000_mac_info *mac = &adapter->hw.mac;
>>   	struct e1000_phy_info *phy = &adapter->hw.phy;
>>   	struct e1000_ring *tx_ring = adapter->tx_ring;
>> +	u32 dmoff_exit_timeout = 100, tries = 0;
> 
> Shouldn?t a macro be used for the time-out value?
> 
>>   	struct e1000_hw *hw = &adapter->hw;
>> -	u32 link, tctl;
>> +	u32 link, tctl, pcim_state;
>>   
>>   	if (test_bit(__E1000_DOWN, &adapter->state))
>>   		return;
>> @@ -5199,6 +5200,21 @@ static void e1000_watchdog_task(struct work_struct *work)
>>   			/* Cancel scheduled suspend requests. */
>>   			pm_runtime_resume(netdev->dev.parent);
>>   
>> +			/* Checking if MAC is in DMoff state*/
>> +			pcim_state = er32(STATUS);
>> +			while (pcim_state & E1000_STATUS_PCIM_STATE) {
>> +				if (tries++ == dmoff_exit_timeout) {
>> +					e_dbg("Error in exiting dmoff\n");
> 
> Shouldn?t this be a user visible error message? If so, please elaborate and
> mention the time-out.
> 
>> Couldn?t exit DMoff after %i s. Your card might not work correctly,
>> TIMEOUTMACRONAME
> 
>> +					break;
>> +				}
>> +				usleep_range(10000, 20000);
>> +				pcim_state = er32(STATUS);
>> +
>> +				/* Checking if MAC exited DMoff state */
>> +				if (!(pcim_state & E1000_STATUS_PCIM_STATE))
> 
> If the macro name is more specific, the comment could be removed. If not,
> the comment should use imperative mood (as below): Check if ?.
> 
> Also can the while loop and if condition be refactored, as the condition
> check if the same?
> 
>> +					e1000_phy_hw_reset(&adapter->hw);
>> +			}
>> +
>>   			/* update snapshot of PHY registers on LSC */
>>   			e1000_phy_read_status(adapter);
>>   			mac->ops.get_link_up_info(&adapter->hw,
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> 
Paul, thanks for your comments. I worked with Vitalik on this - we will 
address your suggestions and re-submit the patch.
