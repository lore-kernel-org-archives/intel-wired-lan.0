From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 26 Oct 2021 19:26:10 +0000
Subject: [Intel-wired-lan] [net-next PATCH v5] ice: support immediate
 firmware activation via devlink reload
In-Reply-To: <e3cafbba-4f77-2ad8-6e94-62ffd2ab1dce@molgen.mpg.de>
References: <20211026015537.424232-1-jacob.e.keller@intel.com>
 <e3cafbba-4f77-2ad8-6e94-62ffd2ab1dce@molgen.mpg.de>
Message-ID: <7e6884c8-4357-fbb7-d25e-6628f57120df@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/25/2021 10:19 PM, Paul Menzel wrote:
>> Changes since v4
>> * completely re-write commit message for clarity
>> * Update devlink ice.rst with documentation about reload
>> * expand the terms "EMP" and "empr" for clarity
>> * Rename the ice_devlink_reload_down to ice_devlink_reload_empr_start and
>>    rename ice_devlink_reload_up to ice_devlink_reload_empr_finish. This is
>>    done to clarify their functionality. It is also done because any future
>>    support for devlink reload with driver reinit will want to continue
>>    re-using these functions to support firmware activation.
>> * Increase the maximum wait time for EMP reset to complete to 2 minutes.
>>    It turns out that in practice the reset might take a while (longer than
>>    the original 20 seconds I had in v4 and earlier).
> 
> Wow, two minutes for a device reset. Systems with coreboot as firmware 
> (depending on the amount of memory) boot in less than one second. ;-) 
> Kexec might also be faster, or would it also take the same amount of 
> time for Linux to bring the device up?
> 

So the problem isn't really the HW reset but I think issues with the
driver rebuild flow. I picked a significantly larger value to avoid
giving up too early here because our testers reported some issues...

But that has got me thinking that we should really resolve the issues
with handling the rebuild...

It would make more sense to further investigate rather than blindly
increasing this timeout...

>> * Move the clearing of fw_emp_reset_disabled into the ice_rebuild logic.
>>    This ensures the flag is properly cleared even when the EMP reset was
>>    caused by another physical function.
>> * Add comments explaining the various reset levels that the firmware can
>>    report.
>>
>> Changes since v3
>> * correctly read response of NVM write activate from synchronous reply value
>>    instead of from the ARQ event. This fixes a bug where we never reported
>>    that EMP reset is available.
>>
>> Changes since v2
>> * ensure DEVLINK_F_RELOAD gets set
>> * rebase to avoid conflicts
>>
>>
>>   Documentation/networking/devlink/ice.rst      |  24 ++-
>>   drivers/net/ethernet/intel/ice/ice.h          |   1 +
>>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   7 +
>>   drivers/net/ethernet/intel/ice/ice_common.c   |  12 ++
>>   drivers/net/ethernet/intel/ice/ice_devlink.c  | 102 ++++++++++
>>   .../net/ethernet/intel/ice/ice_fw_update.c    | 181 +++++++++++++++---
>>   .../net/ethernet/intel/ice/ice_fw_update.h    |   2 +
>>   drivers/net/ethernet/intel/ice/ice_main.c     |   8 +
>>   drivers/net/ethernet/intel/ice/ice_nvm.c      |  19 +-
>>   drivers/net/ethernet/intel/ice/ice_nvm.h      |   2 +-
>>   drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>   11 files changed, 333 insertions(+), 29 deletions(-)
>>
> 
> [?]
> 
>> +/**
>> + * ice_devlink_reload_empr_finish - Wait for EMP reset to finish
>> + * @devlink: pointer to the devlink instance reloading
>> + * @action: the action requested
>> + * @limit: limits imposed by userspace, such as not resetting
>> + * @actions_performed: on return, indicate what actions actually performed
>> + * @extack: netlink extended ACK structure
>> + *
>> + * Wait for driver to finish rebuilding after EMP reset is completed. This
>> + * includes time to wait for both the actual device reset as well as the time
>> + * for the driver's rebuild to complete.
>> + */
>> +static int
>> +ice_devlink_reload_empr_finish(struct devlink *devlink,
>> +			       enum devlink_reload_action action,
>> +			       enum devlink_reload_limit limit,
>> +			       u32 *actions_performed,
>> +			       struct netlink_ext_ack *extack)
>> +{
>> +	struct ice_pf *pf = devlink_priv(devlink);
>> +	int err;
>> +
>> +	*actions_performed = BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE);
>> +
>> +	/* It can take a while for the device and driver to complete the reset
>> +	 * and rebuild process.
>> +	 */
>> +	err = ice_wait_for_reset(pf, 120 * HZ);
>> +	if (err) {
>> +		NL_SET_ERR_MSG_MOD(extack, "Device still resetting");
> 
> Some information for the user what to do might be nice. (How does the 
> log message look like?) Maybe:
> 
>      Device still resetting after 2 min. Please reboot the system.
> 
> [?]
> 
> Thank you again for improving the patch set, and taking so much time to 
> answer my questions.
> 

I can improve the messaging here.

> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
> 

