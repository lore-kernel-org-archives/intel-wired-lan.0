From: kernel test robot <lkp@intel.com>
Date: Tue, 2 Mar 2021 13:58:47 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 104/119]
 drivers/net/ethernet/intel/ice/ice_main.c:2074: undefined reference to
 `ice_flush_fdir_ctx'
Message-ID: <202103021346.s6Qaua0e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   3a3e187b7b489df5ae729aeee86b2db852b76a92
commit: 8bfd891bb1c66c899f87e66b72ff0211abcfb321 [104/119] ice: Check FDIR program status for AVF
config: i386-randconfig-a012-20210302 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=8bfd891bb1c66c899f87e66b72ff0211abcfb321
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 8bfd891bb1c66c899f87e66b72ff0211abcfb321
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_service_task':
>> drivers/net/ethernet/intel/ice/ice_main.c:2074: undefined reference to `ice_flush_fdir_ctx'
   ld: drivers/net/ethernet/intel/ice/ice_txrx.o: in function `ice_clean_rx_irq':
>> drivers/net/ethernet/intel/ice/ice_txrx.c:1122: undefined reference to `ice_vc_fdir_irq_handler'


vim +2074 drivers/net/ethernet/intel/ice/ice_main.c

  2036	
  2037	/**
  2038	 * ice_service_task - manage and run subtasks
  2039	 * @work: pointer to work_struct contained by the PF struct
  2040	 */
  2041	static void ice_service_task(struct work_struct *work)
  2042	{
  2043		struct ice_pf *pf = container_of(work, struct ice_pf, serv_task);
  2044		unsigned long start_time = jiffies;
  2045	
  2046		/* subtasks */
  2047	
  2048		/* process reset requests first */
  2049		ice_reset_subtask(pf);
  2050	
  2051		/* bail if a reset/recovery cycle is pending or rebuild failed */
  2052		if (ice_is_reset_in_progress(pf->state) ||
  2053		    test_bit(__ICE_SUSPENDED, pf->state) ||
  2054		    test_bit(__ICE_NEEDS_RESTART, pf->state)) {
  2055			ice_service_task_complete(pf);
  2056			return;
  2057		}
  2058	
  2059		ice_clean_adminq_subtask(pf);
  2060		ice_check_media_subtask(pf);
  2061		ice_check_for_hang_subtask(pf);
  2062		ice_sync_fltr_subtask(pf);
  2063		ice_handle_mdd_event(pf);
  2064		ice_watchdog_subtask(pf);
  2065	
  2066		if (ice_is_safe_mode(pf)) {
  2067			ice_service_task_complete(pf);
  2068			return;
  2069		}
  2070	
  2071		ice_process_vflr_event(pf);
  2072		ice_clean_mailboxq_subtask(pf);
  2073		ice_sync_arfs_fltrs(pf);
> 2074		ice_flush_fdir_ctx(pf);
  2075		/* Clear __ICE_SERVICE_SCHED flag to allow scheduling next event */
  2076		ice_service_task_complete(pf);
  2077	
  2078		/* If the tasks have taken longer than one service timer period
  2079		 * or there is more work to be done, reset the service timer to
  2080		 * schedule the service task now.
  2081		 */
  2082		if (time_after(jiffies, (start_time + pf->serv_tmr_period)) ||
  2083		    test_bit(__ICE_MDD_EVENT_PENDING, pf->state) ||
  2084		    test_bit(__ICE_VFLR_EVENT_PENDING, pf->state) ||
  2085		    test_bit(__ICE_MAILBOXQ_EVENT_PENDING, pf->state) ||
  2086		    test_bit(__ICE_FD_VF_FLUSH_CTX, pf->state) ||
  2087		    test_bit(__ICE_ADMINQ_EVENT_PENDING, pf->state))
  2088			mod_timer(&pf->serv_tmr, jiffies);
  2089	}
  2090	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31064 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210302/91ef61a1/attachment-0001.bin>
