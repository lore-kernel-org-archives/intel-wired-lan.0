From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 27 Oct 2021 22:56:57 +0000
Subject: [Intel-wired-lan] [net-next PATCH v5] ice: support immediate
 firmware activation via devlink reload
In-Reply-To: <e3cafbba-4f77-2ad8-6e94-62ffd2ab1dce@molgen.mpg.de>
References: <20211026015537.424232-1-jacob.e.keller@intel.com>
 <e3cafbba-4f77-2ad8-6e94-62ffd2ab1dce@molgen.mpg.de>
Message-ID: <d72d3aa5-d8f9-8e66-36c2-e266932bdfd9@intel.com>
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

The original timeout was 20 seconds. Our testers reported some cases
where we reported "timed out" but the reset completed eventually. I was
probably a bit lazy here with just increasing it to 2 minutes.

Thanks for pushing here, since I did some better investigation on what
actually caused the slow rebuild. It turns out part of the NVM
initialization procedure was very slow. ~10 seconds per PF, serialized
due to NVM resource forcing each PF to take turns.

This was caused by our method for locating some data from the Option ROM
segment of the flash.

Fixing this reduced the time to reset by ~20 seconds from 31 seconds on
my system down to 12 total. Looking through some simple timing logs I
wasn't able to spot any other obvious offenders. The actual reset
appears to be done relatively quickly, but the process to go through and
restore driver state is the bulk of the work.

I still kept the total timeout here in v6 to 1 minute, since there are
some cases where multiple PFs reloading at once serialize (RTNL lock,
NVM semaphore, etc). This can lead to a long time to process and finish
rebuilding all PFs.

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

I did change this to be "device still resetting after 1 minute". I'm not
sure I want to codify "reboot the system" in this message.

> Thank you again for improving the patch set, and taking so much time to 
> answer my questions.
> 

Thanks for your detailed review!

> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul
> 

