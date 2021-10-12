From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 12 Oct 2021 17:34:16 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 4/9] ice: introduce
 ice_ptp_init_phc function
In-Reply-To: <fd7b8b1e-0d08-51ab-3688-c82902046784@molgen.mpg.de>
References: <20211012010715.1684027-1-jacob.e.keller@intel.com>
 <20211012010715.1684027-5-jacob.e.keller@intel.com>
 <fd7b8b1e-0d08-51ab-3688-c82902046784@molgen.mpg.de>
Message-ID: <9f886ccc-aabc-a021-98d0-9bc0ce5576d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/12/2021 1:23 AM, Paul Menzel wrote:
> Dear Jacob,
> 
> 
> Thank you for the patch.
> 
> Am 12.10.21 um 03:07 schrieb Jacob Keller:
>> When we enable support for E822 devices, there are some additional
>> steps required to initialize the PTP hardware clock. To make this easier
>> to implement as device-specific behavior, refactor the register setups
>> in ice_ptp_init_owner to a new ice_ptp_init_phc function defined in
>> ice_ptp_hw.c
>>
>> This function will have a common section, and an e810 specific
>> sub-implementation.
>>
>> This will enable easily extending the functionality to cover the E822
>> specific setup required to initialize the hardware clock generation
>> unit. It also makes it clear which steps are E810 specific vs which ones
>> are necessary for all ice devices.
>>
>> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_ptp.c    | 38 +++++++++------------
>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 34 ++++++++++++++++++
>>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
>>   3 files changed, 52 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> index 155842447ebe..4fffae345bf9 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
>> @@ -1815,24 +1815,14 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
>>   	struct device *dev = ice_pf_to_dev(pf);
>>   	struct ice_hw *hw = &pf->hw;
>>   	struct timespec64 ts;
>> -	u8 src_idx;
>>   	int err;
>>   
>> -	wr32(hw, GLTSYN_SYNC_DLAY, 0);
>> -
>> -	/* Clear some HW residue and enable source clock */
>> -	src_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>> -
>> -	/* Enable source clocks */
>> -	wr32(hw, GLTSYN_ENA(src_idx), GLTSYN_ENA_TSYN_ENA_M);
>> -
>> -	/* Enable PHY time sync */
>> -	err = ice_ptp_init_phy_e810(hw);
>> -	if (err)
>> -		goto err_exit;
>> -
>> -	/* Clear event status indications for auxiliary pins */
>> -	(void)rd32(hw, GLTSYN_STAT(src_idx));
>> +	err = ice_ptp_init_phc(hw);
>> +	if (err) {
>> +		dev_err(dev, "Failed to initialize PHC, err %d\n",
> 
> Thank you for adding logging. For users it?d be great, if the message 
> contained some solution to the problem. Something like (no idea if 
> true): The hardware is brocken and won?t work, please check with the vendor.
> 

There are many prints within this driver and throughout the kernel of
this nature which simply report an error. While in some cases it may
make sense to add an additional message about what can be attempted to
recover, I don't believe it is accepted practice or desirable to put
such a generic statement into an error message.

>> +			err);
>> +		return err;
>> +	}
>>   
>>   	/* Acquire the global hardware lock */
>>   	if (!ice_ptp_lock(hw)) {
>> @@ -1877,12 +1867,16 @@ static int ice_ptp_init_owner(struct ice_pf *pf)
>>   }
>>   
>>   /**
>> - * ice_ptp_init - Initialize the PTP support after device probe or reset
>> + * ice_ptp_init - Initialize PTP hardware clock support
>>    * @pf: Board private structure
>>    *
>> - * This function sets device up for PTP support. The first time it is run, it
>> - * will create a clock device. It does not create a clock device if one
>> - * already exists. It also reconfigures the device after a reset.
>> + * Setup the device for interacting with the PTP hardware clock for all
> 
> Nit: The verb is spelled with a space: Set up
> 


Ah. Not sure if its a style guide thing or simply changing usage, but
I've definitely seen many uses of "setup" as a verb. At least in kernel
"set up" appears more favored overall.

If I need to re-spin this for a functional reason, I can fix it.

>> + * functions, both the function that owns the clock hardware, and the
>> + * functions connected to the clock hardware.
>> + *
>> + * The clock owner will allocate and register a ptp_clock with the
>> + * PTP_1588_CLOCK infrastructure. All functions allocate a kthread and work
>> + * items used for asynchronous work such as Tx timestamps and periodic work.
>>    */
>>   void ice_ptp_init(struct ice_pf *pf)
>>   {
>> @@ -1895,7 +1889,9 @@ void ice_ptp_init(struct ice_pf *pf)
>>   	if (!ice_is_e810(hw))
>>   		return;
>>   
>> -	/* Check if this PF owns the source timer */
>> +	/* If this function owns the clock hardware, it must allocate and
>> +	 * configure the PTP clock device to represent it.
>> +	 */
>>   	if (hw->func_caps.ts_func_info.src_tmr_owned) {
>>   		err = ice_ptp_init_owner(pf);
>>   		if (err)
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> index b75aa7bcd421..9787d45c2fdb 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
>> @@ -213,6 +213,21 @@ int ice_ptp_init_phy_e810(struct ice_hw *hw)
>>   	return err;
>>   }
>>   
>> +/**
>> + * ice_ptp_init_phc_e810 - Perform E810 specific PHC initialization
>> + * @hw: pointer to HW struct
>> + *
>> + * Perform E810-specific PTP hardware clock initialization steps.
>> + */
>> +static int ice_ptp_init_phc_e810(struct ice_hw *hw)
>> +{
>> +	/* Ensure synchronization delay is zero */
>> +	wr32(hw, GLTSYN_SYNC_DLAY, 0);
>> +
>> +	/* Initialize the PHY */
>> +	return ice_ptp_init_phy_e810(hw);
>> +}
>> +
>>   /**
>>    * ice_ptp_prep_phy_time_e810 - Prepare PHY port with initial time
>>    * @hw: Board private structure
>> @@ -840,3 +855,22 @@ bool ice_is_pca9575_present(struct ice_hw *hw)
>>   
>>   	return false;
>>   }
>> +
>> +/**
>> + * ice_ptp_init_phc - Initialize PTP hardware clock
>> + * @hw: pointer to the HW struct
>> + *
>> + * Perform the steps required to initialize the PTP hardware clock.
>> + */
>> +int ice_ptp_init_phc(struct ice_hw *hw)
>> +{
>> +	u8 src_idx = hw->func_caps.ts_func_info.tmr_index_owned;
>> +
>> +	/* Enable source clocks */
>> +	wr32(hw, GLTSYN_ENA(src_idx), GLTSYN_ENA_TSYN_ENA_M);
>> +
>> +	/* Clear event err indications for auxiliary pins */
>> +	(void)rd32(hw, GLTSYN_STAT(src_idx));
>> +
>> +	return ice_ptp_init_phc_e810(hw);
>> +}
>> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>> index 4ca1b6fc5ba8..06819d91e3bc 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>> +++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
>> @@ -27,6 +27,7 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval);
>>   int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj);
>>   int ice_read_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx, u64 *tstamp);
>>   int ice_clear_phy_tstamp(struct ice_hw *hw, u8 block, u8 idx);
>> +int ice_ptp_init_phc(struct ice_hw *hw);
>>   
>>   /* E810 family functions */
>>   int ice_ptp_init_phy_e810(struct ice_hw *hw);
>>
> 
> The rest looks good:
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 

Thanks for the review!

> 
> Kind regards,
> 
> Paul
> 

