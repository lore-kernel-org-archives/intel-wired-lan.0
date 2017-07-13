From: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
Date: Thu, 13 Jul 2017 00:37:38 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V2 04/12] i40e: synchronize
 nvmupdate command and adminq subtask
Message-ID: <366E08EF5744BB44864A4A1D375EDEE3A425E5D7@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Shannon, 

I haven't measured how long the lock might be held. Need to check timestamps in
log files or measure time again to get an idea of how long the lock might get 
held. Will check and add comment in code about potential time mutex might be held. 

You are right. If hw->nvmupd_state is *_WAIT and if condition is true, then we 
wouldn't release the lock. Will fix this. Thank you for reviewing patch.

Regards
Sudheer
-----


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On 
> Behalf Of Shannon Nelson
> Sent: Wednesday, July 12, 2017 8:28 AM
> To: intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] [next PATCH S75-V2 04/12] i40e: 
> synchronize nvmupdate command and adminq subtask
> 
> 
> 
> On 7/11/2017 5:01 AM, Alice Michael wrote:
> > From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> >
> > During NVM update, state machine gets into unrecoverable state 
> > because i40e_clean_adminq_subtask can get scheduled after the admin 
> > queue command but before other state variables are updated. This 
> > causes incorrect input to i40e_nvmupd_check_wait_event and state 
> > transitions don't happen.
> >
> > This issue existed before but surfaced after commit 373149fc99a0
> > ("i40e: Decrease the scope of rtnl lock")
> 
> I had a feeling that patch might bite you.  I suspect there may still 
> be some other occasional timing issues cropping up.
> 
> >
> > This fix adds locking around admin queue command and update of state 
> > variables so that adminq_subtask will have accurate information 
> > whenever it gets scheduled.
> >
> > Signed-off-by: Sudheer Mogilappagari 
> > <sudheer.mogilappagari@intel.com>
> > ---
> >   drivers/net/ethernet/intel/i40e/i40e_nvm.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> > index 17607a2..04f2192 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
> > @@ -753,6 +753,11 @@ i40e_status i40e_nvmupd_command(struct
> i40e_hw *hw,
> >   		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
> >   	}
> >
> > +	/* Acquire lock to prevent race condition where adminq_task
> > +	 * can execute after i40e_nvmupd_nvm_read/write but before state
> > +	 * variables (nvm_wait_opcode, nvm_release_on_done) are updated
> > +	 */
> > +	mutex_lock(&hw->aq.arq_mutex);
> 
> Have you done any testing to see how long you might end up holding 
> this lock?  I suppose it is limited by the max length of the 
> synchronous AQ polling timeout.  You might mention that maximum time 
> limitation here or in the commit notes, since this is a mutex over a 
> possibly long I/O operation.
> 
> >   	switch (hw->nvmupd_state) {
> >   	case I40E_NVMUPD_STATE_INIT:
> >   		status = i40e_nvmupd_state_init(hw, cmd, bytes, perrno); @@ 
> > -788,6 +793,7 @@ i40e_status i40e_nvmupd_command(struct
> i40e_hw *hw,
> 
> 
> There's a return statement in the *_WAIT cases that should have a 
> mutex_unlock(), or should have a goto to the unlock at the end of the 
> function, or you'll end up never again receiving AR events.
> 
> sln
> 
> >   		*perrno = -ESRCH;
> >   		break;
> >   	}
> > +	mutex_unlock(&hw->aq.arq_mutex);
> >   	return status;
> >   }
> >
> >
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
