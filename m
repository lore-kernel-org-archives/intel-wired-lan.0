From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 10 Aug 2018 10:39:02 +0300
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 66/79]
 drivers/net/ethernet/intel/i40e/i40e_main.c:9854 i40e_service_task() warn:
 bit shifter '__I40E_CLIENT_RESET' used for logical '&'
Message-ID: <20180810073902.xh3wzenm3hkwxqrp@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[ The off by one warnings are complaining about when "vsi_idx == 0" -dan]

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a900477780d793c5da76d2e686af77bbebd20ad0
commit: fcf279589ba8def6453afd36d5962f65fef67a74 [66/79] i40e: Introduce recovery mode support

New smatch warnings:
drivers/net/ethernet/intel/i40e/i40e_main.c:9854 i40e_service_task() warn: bit shifter '__I40E_CLIENT_RESET' used for logical '&'
drivers/net/ethernet/intel/i40e/i40e_main.c:13670 i40e_init_recovery_mode() error: dereferencing freed memory 'pf'

Old smatch warnings:
drivers/net/ethernet/intel/i40e/i40e_main.c:13088 i40e_veb_setup() warn: potential off by one 'pf->vsi[]' limit 'pf->num_alloc_vsi'
drivers/net/ethernet/intel/i40e/i40e_main.c:13088 i40e_veb_setup() warn: potential off by one 'pf->vsi[]' limit 'pf->num_alloc_vsi'

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=fcf279589ba8def6453afd36d5962f65fef67a74
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout fcf279589ba8def6453afd36d5962f65fef67a74
vim +9854 drivers/net/ethernet/intel/i40e/i40e_main.c

a1c9a9d9 Jeff Kirsher          2013-12-28  9827  
41c445ff Jesse Brandeburg      2013-09-11  9828  /**
41c445ff Jesse Brandeburg      2013-09-11  9829   * i40e_service_task - Run the driver's async subtasks
41c445ff Jesse Brandeburg      2013-09-11  9830   * @work: pointer to work_struct containing our data
41c445ff Jesse Brandeburg      2013-09-11  9831   **/
41c445ff Jesse Brandeburg      2013-09-11  9832  static void i40e_service_task(struct work_struct *work)
41c445ff Jesse Brandeburg      2013-09-11  9833  {
41c445ff Jesse Brandeburg      2013-09-11  9834  	struct i40e_pf *pf = container_of(work,
41c445ff Jesse Brandeburg      2013-09-11  9835  					  struct i40e_pf,
41c445ff Jesse Brandeburg      2013-09-11  9836  					  service_task);
41c445ff Jesse Brandeburg      2013-09-11  9837  	unsigned long start_time = jiffies;
41c445ff Jesse Brandeburg      2013-09-11  9838  
e57a2fea Shannon Nelson        2014-06-03  9839  	/* don't bother with service tasks if a reset is in progress */
0da36b97 Jacob Keller          2017-04-19  9840  	if (test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
e57a2fea Shannon Nelson        2014-06-03  9841  		return;
e57a2fea Shannon Nelson        2014-06-03  9842  
0da36b97 Jacob Keller          2017-04-19  9843  	if (test_and_set_bit(__I40E_SERVICE_SCHED, pf->state))
91089033 Mitch Williams        2016-11-21  9844  		return;
91089033 Mitch Williams        2016-11-21  9845  
fcf27958 Mariusz Stachura      2018-08-02  9846  	if (!test_bit(__I40E_RECOVERY_MODE, pf->state)) {
07d44190 Sudheer Mogilappagari 2017-12-18  9847  		i40e_detect_recover_hung(pf->vsi[pf->lan_vsi]);
2818ccd9 Jesse Brandeburg      2016-01-13  9848  		i40e_sync_filters_subtask(pf);
41c445ff Jesse Brandeburg      2013-09-11  9849  		i40e_reset_subtask(pf);
41c445ff Jesse Brandeburg      2013-09-11  9850  		i40e_handle_mdd_event(pf);
41c445ff Jesse Brandeburg      2013-09-11  9851  		i40e_vc_process_vflr_event(pf);
41c445ff Jesse Brandeburg      2013-09-11  9852  		i40e_watchdog_subtask(pf);
41c445ff Jesse Brandeburg      2013-09-11  9853  		i40e_fdir_reinit_subtask(pf);
fcf27958 Mariusz Stachura      2018-08-02 @9854  		if (pf->flags & __I40E_CLIENT_RESET) {
0ef2d5af Mitch Williams        2017-01-24  9855  			/* Client subtask will reopen next time through. */
fcf27958 Mariusz Stachura      2018-08-02  9856  			i40e_notify_client_of_netdev_close(
fcf27958 Mariusz Stachura      2018-08-02  9857  						pf->vsi[pf->lan_vsi], true);
0ef2d5af Mitch Williams        2017-01-24  9858  		} else {
e3219ce6 Anjali Singhai Jain   2016-01-20  9859  			i40e_client_subtask(pf);
5f76a704 Jacob Keller          2018-03-16  9860  			if (test_and_clear_bit(__I40E_CLIENT_L2_CHANGE,
5f76a704 Jacob Keller          2018-03-16  9861  					       pf->state))
0ef2d5af Mitch Williams        2017-01-24  9862  				i40e_notify_client_of_l2_param_changes(
0ef2d5af Mitch Williams        2017-01-24  9863  							pf->vsi[pf->lan_vsi]);
0ef2d5af Mitch Williams        2017-01-24  9864  		}
6a899024 Singhai, Anjali       2015-12-14  9865  		i40e_sync_udp_filters_subtask(pf);
fcf27958 Mariusz Stachura      2018-08-02  9866  
fcf27958 Mariusz Stachura      2018-08-02  9867  	} else {
fcf27958 Mariusz Stachura      2018-08-02  9868  		i40e_reset_subtask(pf);
fcf27958 Mariusz Stachura      2018-08-02  9869  	}
fcf27958 Mariusz Stachura      2018-08-02  9870  	i40e_sync_filters_subtask(pf);
41c445ff Jesse Brandeburg      2013-09-11  9871  	i40e_clean_adminq_subtask(pf);
41c445ff Jesse Brandeburg      2013-09-11  9872  
91089033 Mitch Williams        2016-11-21  9873  	/* flush memory to make sure state is correct before next watchdog */
91089033 Mitch Williams        2016-11-21  9874  	smp_mb__before_atomic();
0da36b97 Jacob Keller          2017-04-19  9875  	clear_bit(__I40E_SERVICE_SCHED, pf->state);
41c445ff Jesse Brandeburg      2013-09-11  9876  
41c445ff Jesse Brandeburg      2013-09-11  9877  	/* If the tasks have taken longer than one timer cycle or there
41c445ff Jesse Brandeburg      2013-09-11  9878  	 * is more work to be done, reschedule the service task now
41c445ff Jesse Brandeburg      2013-09-11  9879  	 * rather than wait for the timer to tick again.
41c445ff Jesse Brandeburg      2013-09-11  9880  	 */
41c445ff Jesse Brandeburg      2013-09-11  9881  	if (time_after(jiffies, (start_time + pf->service_timer_period)) ||
0da36b97 Jacob Keller          2017-04-19  9882  	    test_bit(__I40E_ADMINQ_EVENT_PENDING, pf->state)		 ||
0da36b97 Jacob Keller          2017-04-19  9883  	    test_bit(__I40E_MDD_EVENT_PENDING, pf->state)		 ||
0da36b97 Jacob Keller          2017-04-19  9884  	    test_bit(__I40E_VFLR_EVENT_PENDING, pf->state))
41c445ff Jesse Brandeburg      2013-09-11  9885  		i40e_service_event_schedule(pf);
41c445ff Jesse Brandeburg      2013-09-11  9886  }
41c445ff Jesse Brandeburg      2013-09-11  9887  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
