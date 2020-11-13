From: kernel test robot <lkp@intel.com>
Date: Fri, 13 Nov 2020 12:49:11 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 50/96]
 drivers/net/ethernet/intel/igc/igc_ptp.c:450:21: sparse: sparse: cast to
 restricted __be32
Message-ID: <202011131208.X8ZMYl5e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   3f69b6741396fada730c8a1ccc0bfa8c771b9dab
commit: cf576c848e1829ce268474d0510dab01a4235e36 [50/96] igc: Add support for PTP getcrosststamp()
config: i386-randconfig-s002-20201113 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-107-gaf3512a6-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=cf576c848e1829ce268474d0510dab01a4235e36
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout cf576c848e1829ce268474d0510dab01a4235e36
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/net/ethernet/intel/igc/igc_ptp.c:450:21: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:450:21: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:450:21: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:450:21: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:450:21: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:450:21: sparse: sparse: cast to restricted __be32

vim +450 drivers/net/ethernet/intel/igc/igc_ptp.c

   434	
   435	static void igc_ptm_gather_report(struct igc_adapter *adapter)
   436	{
   437		struct igc_hw *hw = &adapter->hw;
   438		u32 t2_curr_h, t2_curr_l;
   439		ktime_t t1, t2_curr;
   440	
   441		t1 = ktime_set(rd32(IGC_PTM_T1_TIM0_H),
   442			       rd32(IGC_PTM_T1_TIM0_L));
   443	
   444		t2_curr_l = rd32(IGC_PTM_CURR_T2_L);
   445		t2_curr_h = rd32(IGC_PTM_CURR_T2_H);
   446	
   447		/* FIXME: There's an ambiguity on what endianness some PCIe PTM
   448		 * messages should use. Find a more robust way to handle this.
   449		 */
 > 450		t2_curr_h = be32_to_cpu(t2_curr_h);
   451	
   452		t2_curr = ((s64)t2_curr_h << 32 | t2_curr_l);
   453	
   454		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
   455	
   456		mutex_lock(&adapter->ptm_time_lock);
   457	
   458		/* Because get_device_system_crosststamp() requires that the
   459		 * historic timestamp is before the PTM device/host
   460		 * timestamps, we keep track of the current and previous
   461		 * snapshot (historic timestamp).
   462		 */
   463		memcpy(&adapter->prev_snapshot,
   464		       &adapter->curr_snapshot, sizeof(adapter->prev_snapshot));
   465		ktime_get_snapshot(&adapter->curr_snapshot);
   466	
   467		adapter->ptm_device_time = t1;
   468		adapter->ptm_host_time = igc_device_tstamp_to_system(t2_curr);
   469		mutex_unlock(&adapter->ptm_time_lock);
   470	
   471		mod_delayed_work(system_wq, &adapter->ptm_report,
   472				 msecs_to_jiffies(IGC_PTM_CYCLE_TIME_MSECS));
   473	}
   474	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41744 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201113/f66e13a9/attachment-0001.bin>
