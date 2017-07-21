From: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
Date: Fri, 21 Jul 2017 03:53:55 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 65/70]
 drivers/net/ethernet/intel/i40e/i40e_nvm.c:781:3-9: preceding lock on line
 760
In-Reply-To: <alpine.DEB.2.20.1707200835140.2016@hadrien>
References: <alpine.DEB.2.20.1707200835140.2016@hadrien>
Message-ID: <366E08EF5744BB44864A4A1D375EDEE3A4260B85@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Julia, 

Shannon Nelson had identified the same issue. We have fixed the issue and patch will go upstream soon. 

Thanks
Sudheer

-----Original Message-----
From: Julia Lawall [mailto:julia.lawall at lip6.fr] 
Sent: Wednesday, July 19, 2017 11:37 PM
To: Mogilappagari, Sudheer <sudheer.mogilappagari@intel.com>
Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org; kbuild-all at 01.org
Subject: [jkirsher-next-queue:dev-queue 65/70] drivers/net/ethernet/intel/i40e/i40e_nvm.c:781:3-9: preceding lock on line 760

Please check whether the lock taken on line 760 should be released before line 781.

julia

---------- Forwarded message ----------
Date: Mon, 17 Jul 2017 22:56:23 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [jkirsher-next-queue:dev-queue 65/70]
    drivers/net/ethernet/intel/i40e/i40e_nvm.c:781:3-9: preceding lock on line
    760

CC: kbuild-all at 01.org
CC: intel-wired-lan at lists.osuosl.org
TO: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   3877e478d6f9bf4da407060eb1ebaac7358e734d
commit: 60d764593812ff8c70e2ecd7605c475d234f3a15 [65/70] i40e: synchronize nvmupdate command and adminq subtask
:::::: branch date: 8 hours ago
:::::: commit date: 8 hours ago

>> drivers/net/ethernet/intel/i40e/i40e_nvm.c:781:3-9: preceding lock on 
>> line 760

git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout 60d764593812ff8c70e2ecd7605c475d234f3a15
vim +781 drivers/net/ethernet/intel/i40e/i40e_nvm.c

74d0d0ede Shannon Nelson        2014-11-13  690
cd552cb49 Shannon Nelson        2014-07-09  691  /**
cd552cb49 Shannon Nelson        2014-07-09  692   * i40e_nvmupd_command - Process an NVM update command
cd552cb49 Shannon Nelson        2014-07-09  693   * @hw: pointer to hardware structure
cd552cb49 Shannon Nelson        2014-07-09  694   * @cmd: pointer to nvm update command
cd552cb49 Shannon Nelson        2014-07-09  695   * @bytes: pointer to the data buffer
79afe839a Shannon Nelson        2015-07-23  696   * @perrno: pointer to return error code
cd552cb49 Shannon Nelson        2014-07-09  697   *
cd552cb49 Shannon Nelson        2014-07-09  698   * Dispatches command depending on what update state is current
cd552cb49 Shannon Nelson        2014-07-09  699   **/
cd552cb49 Shannon Nelson        2014-07-09  700  i40e_status i40e_nvmupd_command(struct i40e_hw *hw,
cd552cb49 Shannon Nelson        2014-07-09  701  				struct i40e_nvm_access *cmd,
79afe839a Shannon Nelson        2015-07-23  702  				u8 *bytes, int *perrno)
cd552cb49 Shannon Nelson        2014-07-09  703  {
cd552cb49 Shannon Nelson        2014-07-09  704  	i40e_status status;
0af8e9db2 Shannon Nelson        2015-08-28  705  	enum i40e_nvmupd_cmd upd_cmd;
cd552cb49 Shannon Nelson        2014-07-09  706
cd552cb49 Shannon Nelson        2014-07-09  707  	/* assume success */
79afe839a Shannon Nelson        2015-07-23  708  	*perrno = 0;
cd552cb49 Shannon Nelson        2014-07-09  709
0af8e9db2 Shannon Nelson        2015-08-28  710  	/* early check for status command and debug msgs */
0af8e9db2 Shannon Nelson        2015-08-28  711  	upd_cmd = i40e_nvmupd_validate_command(hw, cmd, perrno);
0af8e9db2 Shannon Nelson        2015-08-28  712
fed2db998 Shannon Nelson        2016-04-12  713  	i40e_debug(hw, I40E_DEBUG_NVM, "%s state %d nvm_release_on_hold %d opc 0x%04x cmd 0x%08x config 0x%08x offset 0x%08x data_size 0x%08x\n",
0af8e9db2 Shannon Nelson        2015-08-28  714  		   i40e_nvm_update_state_str[upd_cmd],
0af8e9db2 Shannon Nelson        2015-08-28  715  		   hw->nvmupd_state,
fed2db998 Shannon Nelson        2016-04-12  716  		   hw->nvm_release_on_done, hw->nvm_wait_opcode,
1d73b2db4 Shannon Nelson        2015-12-23  717  		   cmd->command, cmd->config, cmd->offset, cmd->data_size);
0af8e9db2 Shannon Nelson        2015-08-28  718
0af8e9db2 Shannon Nelson        2015-08-28  719  	if (upd_cmd == I40E_NVMUPD_INVALID) {
0af8e9db2 Shannon Nelson        2015-08-28  720  		*perrno = -EFAULT;
0af8e9db2 Shannon Nelson        2015-08-28  721  		i40e_debug(hw, I40E_DEBUG_NVM,
0af8e9db2 Shannon Nelson        2015-08-28  722  			   "i40e_nvmupd_validate_command returns %d errno %d\n",
0af8e9db2 Shannon Nelson        2015-08-28  723  			   upd_cmd, *perrno);
0af8e9db2 Shannon Nelson        2015-08-28  724  	}
0af8e9db2 Shannon Nelson        2015-08-28  725
0af8e9db2 Shannon Nelson        2015-08-28  726  	/* a status request returns immediately rather than
0af8e9db2 Shannon Nelson        2015-08-28  727  	 * going into the state machine
0af8e9db2 Shannon Nelson        2015-08-28  728  	 */
0af8e9db2 Shannon Nelson        2015-08-28  729  	if (upd_cmd == I40E_NVMUPD_STATUS) {
fed2db998 Shannon Nelson        2016-04-12  730  		if (!cmd->data_size) {
fed2db998 Shannon Nelson        2016-04-12  731  			*perrno = -EFAULT;
fed2db998 Shannon Nelson        2016-04-12  732  			return I40E_ERR_BUF_TOO_SHORT;
fed2db998 Shannon Nelson        2016-04-12  733  		}
fed2db998 Shannon Nelson        2016-04-12  734
0af8e9db2 Shannon Nelson        2015-08-28  735  		bytes[0] = hw->nvmupd_state;
fed2db998 Shannon Nelson        2016-04-12  736
fed2db998 Shannon Nelson        2016-04-12  737  		if (cmd->data_size >= 4) {
fed2db998 Shannon Nelson        2016-04-12  738  			bytes[1] = 0;
fed2db998 Shannon Nelson        2016-04-12  739  			*((u16 *)&bytes[2]) = hw->nvm_wait_opcode;
fed2db998 Shannon Nelson        2016-04-12  740  		}
fed2db998 Shannon Nelson        2016-04-12  741
81fa7c97b Maciej Sosin          2016-10-11  742  		/* Clear error status on read */
81fa7c97b Maciej Sosin          2016-10-11  743  		if (hw->nvmupd_state == I40E_NVMUPD_STATE_ERROR)
81fa7c97b Maciej Sosin          2016-10-11  744  			hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
81fa7c97b Maciej Sosin          2016-10-11  745
0af8e9db2 Shannon Nelson        2015-08-28  746  		return 0;
0af8e9db2 Shannon Nelson        2015-08-28  747  	}
0af8e9db2 Shannon Nelson        2015-08-28  748
81fa7c97b Maciej Sosin          2016-10-11  749  	/* Clear status even it is not read and log */
81fa7c97b Maciej Sosin          2016-10-11  750  	if (hw->nvmupd_state == I40E_NVMUPD_STATE_ERROR) {
81fa7c97b Maciej Sosin          2016-10-11  751  		i40e_debug(hw, I40E_DEBUG_NVM,
81fa7c97b Maciej Sosin          2016-10-11  752  			   "Clearing I40E_NVMUPD_STATE_ERROR state without reading\n");
81fa7c97b Maciej Sosin          2016-10-11  753  		hw->nvmupd_state = I40E_NVMUPD_STATE_INIT;
81fa7c97b Maciej Sosin          2016-10-11  754  	}
81fa7c97b Maciej Sosin          2016-10-11  755
60d764593 Sudheer Mogilappagari 2017-07-16  756  	/* Acquire lock to prevent race condition where adminq_task
60d764593 Sudheer Mogilappagari 2017-07-16  757  	 * can execute after i40e_nvmupd_nvm_read/write but before state
60d764593 Sudheer Mogilappagari 2017-07-16  758  	 * variables (nvm_wait_opcode, nvm_release_on_done) are updated
60d764593 Sudheer Mogilappagari 2017-07-16  759  	 */
60d764593 Sudheer Mogilappagari 2017-07-16 @760  	mutex_lock(&hw->aq.arq_mutex);
cd552cb49 Shannon Nelson        2014-07-09  761  	switch (hw->nvmupd_state) {
cd552cb49 Shannon Nelson        2014-07-09  762  	case I40E_NVMUPD_STATE_INIT:
79afe839a Shannon Nelson        2015-07-23  763  		status = i40e_nvmupd_state_init(hw, cmd, bytes, perrno);
cd552cb49 Shannon Nelson        2014-07-09  764  		break;
cd552cb49 Shannon Nelson        2014-07-09  765
cd552cb49 Shannon Nelson        2014-07-09  766  	case I40E_NVMUPD_STATE_READING:
79afe839a Shannon Nelson        2015-07-23  767  		status = i40e_nvmupd_state_reading(hw, cmd, bytes, perrno);
cd552cb49 Shannon Nelson        2014-07-09  768  		break;
cd552cb49 Shannon Nelson        2014-07-09  769
cd552cb49 Shannon Nelson        2014-07-09  770  	case I40E_NVMUPD_STATE_WRITING:
79afe839a Shannon Nelson        2015-07-23  771  		status = i40e_nvmupd_state_writing(hw, cmd, bytes, perrno);
cd552cb49 Shannon Nelson        2014-07-09  772  		break;
cd552cb49 Shannon Nelson        2014-07-09  773
2f1b5bc84 Shannon Nelson        2015-08-28  774  	case I40E_NVMUPD_STATE_INIT_WAIT:
2f1b5bc84 Shannon Nelson        2015-08-28  775  	case I40E_NVMUPD_STATE_WRITE_WAIT:
fed2db998 Shannon Nelson        2016-04-12  776  		/* if we need to stop waiting for an event, clear
fed2db998 Shannon Nelson        2016-04-12  777  		 * the wait info and return before doing anything else
fed2db998 Shannon Nelson        2016-04-12  778  		 */
fed2db998 Shannon Nelson        2016-04-12  779  		if (cmd->offset == 0xffff) {
fed2db998 Shannon Nelson        2016-04-12  780  			i40e_nvmupd_check_wait_event(hw, hw->nvm_wait_opcode);
fed2db998 Shannon Nelson        2016-04-12 @781  			return 0;
fed2db998 Shannon Nelson        2016-04-12  782  		}
fed2db998 Shannon Nelson        2016-04-12  783
2f1b5bc84 Shannon Nelson        2015-08-28  784  		status = I40E_ERR_NOT_READY;
2f1b5bc84 Shannon Nelson        2015-08-28  785  		*perrno = -EBUSY;
2f1b5bc84 Shannon Nelson        2015-08-28  786  		break;
2f1b5bc84 Shannon Nelson        2015-08-28  787
cd552cb49 Shannon Nelson        2014-07-09  788  	default:
cd552cb49 Shannon Nelson        2014-07-09  789  		/* invalid state, should never happen */
74d0d0ede Shannon Nelson        2014-11-13  790  		i40e_debug(hw, I40E_DEBUG_NVM,
74d0d0ede Shannon Nelson        2014-11-13  791  			   "NVMUPD: no such state %d\n", hw->nvmupd_state);
cd552cb49 Shannon Nelson        2014-07-09  792  		status = I40E_NOT_SUPPORTED;
79afe839a Shannon Nelson        2015-07-23  793  		*perrno = -ESRCH;
cd552cb49 Shannon Nelson        2014-07-09  794  		break;
cd552cb49 Shannon Nelson        2014-07-09  795  	}
60d764593 Sudheer Mogilappagari 2017-07-16  796  	mutex_unlock(&hw->aq.arq_mutex);
cd552cb49 Shannon Nelson        2014-07-09  797  	return status;
cd552cb49 Shannon Nelson        2014-07-09  798  }
cd552cb49 Shannon Nelson        2014-07-09  799

:::::: The code at line 781 was first introduced by commit
:::::: fed2db99824334b3a7219da6b45d70f448449d7d i40e: Specify AQ event opcode to wait for

:::::: TO: Shannon Nelson <shannon.nelson@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
