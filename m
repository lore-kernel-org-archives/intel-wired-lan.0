From: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
Date: Tue, 26 Oct 2021 09:06:12 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix delay after global
 reset
In-Reply-To: <4e29d380-54eb-a39c-9402-4d6aaebcea48@molgen.mpg.de>
References: <20210902103106.51917-1-jedrzej.jagielski@intel.com>
 <4e29d380-54eb-a39c-9402-4d6aaebcea48@molgen.mpg.de>
Message-ID: <DM6PR11MB27316E837C7598ADA38816BAF0849@DM6PR11MB2731.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Paul,
Thank you for your suggestions.

> Dear Jedrzej,
> 
> 
> Thank you for your patch.
> 
> Am 02.09.21 um 12:31 schrieb Jedrzej Jagielski:
> 
> Please be more specific in the commit message summary:
> 
> i40e: Increase delay to 1 s after global reset
> > i40e: Increase delay to 1 s after global EMP reset

OK, this will be fixed in the next patch.

> 
> 
> > Recently simplified i40e_rebuild causes that FW sometimes
> > is not ready after NVM update, the ping does not return.
> 
> On what card was this happening updating the firmware from what version 
> to what version?

There is no specific version of the firmware. It depends only on the
driver version. Changes in the driver has altered the initialization,
which resulted in this  defect we are trying to fix right now.

> 
> > Modify the delay in case of EMPR reset.
> 
> Please write out EMP once.
> 
> Maybe: Increase the delay ?
> 
> > Old delay was introduced for specific cards for 710 series.
> 
> Old delay of 300 ms ?

OK, it will be done.
> 
> > Now it works for all the cards and delay was increased.
> 
> Which cards did you test with?

Before submitting the patch it was tested on X710 but the original issue 
had been found on the XL710. This is timing issue between software and
firmware. We know that it is supposed to be fixed in firmware but until then
we have to prevent the loss of ping after NVM update.
> 
> How did you choose one second (more than three times the current one)? 
> Is there some datasheet?

This amount of time has been chosen by testing.

> 
> > Fixes: 1fa51a650e1d ("i40e: Add delay after EMP reset for firmware to recover")
> > Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> > Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++---------
> >   1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 000991afcf27..e0c9e0e84aef 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -10535,15 +10535,9 @@ static void i40e_rebuild(struct i40e_pf *pf, bool reinit, bool lock_acquired)
> >   	}
> >   	i40e_get_oem_version(&pf->hw);
> >   
> > -	if (test_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state) &&
> > -	    ((hw->aq.fw_maj_ver == 4 && hw->aq.fw_min_ver <= 33) ||
> > -	     hw->aq.fw_maj_ver < 4) && hw->mac.type == I40E_MAC_XL710) {
> > -		/* The following delay is necessary for 4.33 firmware and older
> > -		 * to recover after EMP reset. 200 ms should suffice but we
> > -		 * put here 300 ms to be sure that FW is ready to operate
> > -		 * after reset.
> > -		 */
> > -		mdelay(300);
> > +	if (test_and_clear_bit(__I40E_EMP_RESET_INTR_RECEIVED, pf->state)) {
> > +		/* The following delay is necessary for firmware update. */
> > +		mdelay(1000);
> >   	}
> 
> One second is quite excessive in modern times. Is there a way to poll a 
> register to see if the reset was successful?
> 
There is no such a register in SW, and FW returns not correct value when asked
for it.

> Also, this might regress some setups, where timing is important, and 
> where the maximum of 300 ms delay is crucial for the application.

This is EMP reset. It is being performed only in case of emergencies,
to recover the card from the fault state and after NVM update.

> 
> >   
> >   	/* re-verify the eeprom if we just had an EMP reset */
> > 
> 
> So, NACK from my side. Quirks should be added for cards/firmware 
> versions, which explicitly need more time than no delay or 300 ms.

As this was not root caused as the card or firmware specific, and  EMP reset
happens mostly only after NVM updates I strongly believe it is better to 
increase the delay than to lose the ping after the NVM update process.

> 
> 
> Kind regards,
> 
> Paul

Kind regards,
Jedrzej
