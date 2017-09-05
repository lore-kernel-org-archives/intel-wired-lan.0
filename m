From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 5 Sep 2017 22:00:27 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: avoid NVM acquire deadlock
	during NVM update
In-Reply-To: <63fe2862-d5f7-8ad5-a171-a1a3af89a1bb@kpanic.de>
References: <20170901204249.3835-1-jacob.e.keller@intel.com>
 <63fe2862-d5f7-8ad5-a171-a1a3af89a1bb@kpanic.de>
Message-ID: <02874ECE860811409154E81DA85FBB5882A9B0C1@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Stefan Assmann [mailto:sassmann at kpanic.de]
> Sent: Saturday, September 02, 2017 10:35 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>; Intel Wired LAN <intel-wired-
> lan at lists.osuosl.org>
> Cc: Singhai, Anjali <anjali.singhai@intel.com>
> Subject: Re: [PATCH] i40e: avoid NVM acquire deadlock during NVM update
> 
> On 01.09.2017 22:42, Jacob Keller wrote:
> > From: Anjali Singhai Jain <anjali.singhai@intel.com>
> >
> > X722 devices use the AdminQ to access the NVM, and this requires taking
> > the AdminQ lock. Because of this, we lock the AdminQ during
> > i40e_read_nvm(), which is also called in places where the lock is
> > already held, such as the firmware update path which wants to lock once
> > and then unlock when finished after performing several tasks.
> >
> > Although this should have only affected X722 devices, commit
> > 96a39aed25e6 ("i40e: Acquire NVM lock before reads on all devices",
> > 2016-12-02) added locking for all NVM reads, regardless of device
> > family.
> >
> > This resulted in us accidentally causing NVM acquire timeouts on all
> > devices, causing failed firmware updates which left the eeprom in
> > a corrupt state.
> >
> > Create unsafe non-locked variants of i40e_read_nvm_word and
> > i40e_read_nvm_buffer, __i40e_read_nvm_word and __i40e_read_nvm_buffer
> > respectively. These variants will not take the NVM lock and are expected
> > to only be called in places where the NVM lock is already held if
> > needed.
> >
> > Since the only caller of i40e_read_nvm_buffer() was in such a path,
> > remove it entirely in favor of the unsafe version. If necessary we can
> > always add it back in the future.
> >
> > Additionally, we now need to hold the NVM lock in i40e_validate_checksum
> > because the call to i40e_calc_nvm_checksum now assumes that the NVM lock
> > is held. We can further move the call to read I40E_SR_SW_CHECKSUM_WORD
> > up a bit so that we do not need to acquire the NVM lock twice.
> >
> > This should resolve firmware updates and also fix potential raise that
> > could have caused the driver to report an invalid NVM checksum upon
> > driver load.
> >
> > Reported-by: Stefan Assmann <sassmann@kpanic.de>
> > Fixes: 96a39aed25e6 ("i40e: Acquire NVM lock before reads on all devices", 2016-
> 12-02)
> > Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> > Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > ---
> >
> > This is a more complete version of the patch suggested by Stefan, found
> > at https://patchwork.ozlabs.org/patch/808699/ and it should be able to
> > avoid needing the 2nd patch in his series, which reverted a workqueue
> > change. The code is slightly refactored from what he suggested, and also
> > includes the i40e_nvm_read_buffer() function, as well as fixing up the
> > issues in i40e_validate_checksum().
> >
> > Stefan, can you let me know if this works for you? I didn't have any
> > issues, but I'd like to confirm this fix is acceptable to you.
> 
> Hi Jacob,
> 
> I've reflashed all the NICs I had available, everything went smoothly.
> Let's get your patch in asap.
> 
> Thanks!
> 
>   Stefan

Excellent news!

Thanks,
Jake
