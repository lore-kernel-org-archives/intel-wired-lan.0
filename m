From: kernel test robot <lkp@intel.com>
Date: Sat, 26 Sep 2020 12:11:22 +0800
Subject: [Intel-wired-lan] [PATCH next-queue v1 3/3] igc: Add support
 for PTP getcrosststamp()
In-Reply-To: <20200925232834.2704711-4-vinicius.gomes@intel.com>
References: <20200925232834.2704711-4-vinicius.gomes@intel.com>
Message-ID: <202009261229.ixDMmAy4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to pci/next ipvs/master v5.9-rc6 next-20200925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Vinicius-Costa-Gomes/igc-Add-support-for-PCIe-PTM/20200926-073053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f6b01c642e977d12e008e6e6dbec747de73d836f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Vinicius-Costa-Gomes/igc-Add-support-for-PCIe-PTM/20200926-073053
        git checkout f6b01c642e977d12e008e6e6dbec747de73d836f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/igc/igc_ptp.c: In function 'igc_ptm_gather_report':
>> drivers/net/ethernet/intel/igc/igc_ptp.c:459:27: error: implicit declaration of function 'convert_art_ns_to_tsc' [-Werror=implicit-function-declaration]
     459 |  adapter->ptm_host_time = convert_art_ns_to_tsc(t2_curr);
         |                           ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/igc/igc_ptp.c:459:27: error: incompatible types when assigning to type 'struct system_counterval_t' from type 'int'
   cc1: some warnings being treated as errors

vim +/convert_art_ns_to_tsc +459 drivers/net/ethernet/intel/igc/igc_ptp.c

   425	
   426	static void igc_ptm_gather_report(struct igc_adapter *adapter)
   427	{
   428		struct igc_hw *hw = &adapter->hw;
   429		u32 t2_curr_h, t2_curr_l;
   430		ktime_t t1, t2_curr;
   431	
   432		t1 = ktime_set(rd32(IGC_PTM_T1_TIM0_H),
   433			       rd32(IGC_PTM_T1_TIM0_L));
   434	
   435		t2_curr_l = rd32(IGC_PTM_CURR_T2_L);
   436		t2_curr_h = rd32(IGC_PTM_CURR_T2_H);
   437	
   438		/* FIXME: There's an ambiguity on what endianness some PCIe PTM
   439		 * messages should use. Find a more robust way to handle this.
   440		 */
   441		t2_curr_h = be32_to_cpu(t2_curr_h);
   442	
   443		t2_curr = ((s64)t2_curr_h << 32 | t2_curr_l);
   444	
   445		wr32(IGC_PTM_STAT, IGC_PTM_STAT_VALID);
   446	
   447		mutex_lock(&adapter->ptm_time_lock);
   448	
   449		/* Because get_device_system_crosststamp() requires that the
   450		 * historic timestamp is before the PTM device/host
   451		 * timestamps, we keep track of the current and previous
   452		 * snapshot (historic timestamp).
   453		 */
   454		memcpy(&adapter->prev_snapshot,
   455		       &adapter->curr_snapshot, sizeof(adapter->prev_snapshot));
   456		ktime_get_snapshot(&adapter->curr_snapshot);
   457	
   458		adapter->ptm_device_time = t1;
 > 459		adapter->ptm_host_time = convert_art_ns_to_tsc(t2_curr);
   460		mutex_unlock(&adapter->ptm_time_lock);
   461	
   462		mod_delayed_work(system_wq, &adapter->ptm_report,
   463				 msecs_to_jiffies(IGC_PTM_CYCLE_TIME_MSECS));
   464	}
   465	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65176 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200926/e9db674f/attachment-0001.bin>
