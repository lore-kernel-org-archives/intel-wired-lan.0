From: kernel test robot <lkp@intel.com>
Date: Fri, 2 Jul 2021 02:32:30 +0800
Subject: [Intel-wired-lan] [net-next 13/13] ice: support
 crosstimestamping on E822 devices if supported
In-Reply-To: <20210701002713.3486336-14-jacob.e.keller@intel.com>
References: <20210701002713.3486336-14-jacob.e.keller@intel.com>
Message-ID: <202107020218.mbKEueKv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jacob,

I love your patch! Yet something to improve:

[auto build test ERROR on b6df00789e2831fff7a2c65aa7164b2a4dcbe599]

url:    https://github.com/0day-ci/linux/commits/Jacob-Keller/ice-implement-support-for-PTP-on-E822-hardware/20210701-082948
base:   b6df00789e2831fff7a2c65aa7164b2a4dcbe599
config: mips-allyesconfig (attached as .config)
compiler: mips-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/1695c69f19bd3a68f3eaeac925b74dd1dc0fbf22
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jacob-Keller/ice-implement-support-for-PTP-on-E822-hardware/20210701-082948
        git checkout 1695c69f19bd3a68f3eaeac925b74dd1dc0fbf22
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_get_syncdevicetime':
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1347:14: error: implicit declaration of function 'convert_art_ns_to_tsc' [-Werror=implicit-function-declaration]
    1347 |    *system = convert_art_ns_to_tsc(hh_ts);
         |              ^~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1347:14: error: incompatible types when assigning to type 'struct system_counterval_t' from type 'int'
   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_set_funcs_e822':
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1549:6: error: implicit declaration of function 'boot_cpu_has'; did you mean 'boot_cpu_data'? [-Werror=implicit-function-declaration]
    1549 |  if (boot_cpu_has(X86_FEATURE_ART) &&
         |      ^~~~~~~~~~~~
         |      boot_cpu_data
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1549:19: error: 'X86_FEATURE_ART' undeclared (first use in this function); did you mean 'X86_FEATURE_ANY'?
    1549 |  if (boot_cpu_has(X86_FEATURE_ART) &&
         |                   ^~~~~~~~~~~~~~~
         |                   X86_FEATURE_ANY
   drivers/net/ethernet/intel/ice/ice_ptp.c:1549:19: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1550:19: error: 'X86_FEATURE_TSC_KNOWN_FREQ' undeclared (first use in this function)
    1550 |      boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/convert_art_ns_to_tsc +1347 drivers/net/ethernet/intel/ice/ice_ptp.c

  1331	
  1332		for (i = 0; i < MAX_HH_LOCK_TRIES; i++) {
  1333			/* Wait for sync to complete */
  1334			hh_art_ctl = rd32(hw, GLHH_ART_CTL);
  1335			if (hh_art_ctl & GLHH_ART_CTL_ACTIVE_M) {
  1336				udelay(1);
  1337				continue;
  1338			} else {
  1339				u32 hh_ts_lo, hh_ts_hi, tmr_idx;
  1340				u64 hh_ts;
  1341	
  1342				tmr_idx = hw->func_caps.ts_func_info.tmr_index_assoc;
  1343				/* Read ART time */
  1344				hh_ts_lo = rd32(hw, GLHH_ART_TIME_L);
  1345				hh_ts_hi = rd32(hw, GLHH_ART_TIME_H);
  1346				hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
> 1347				*system = convert_art_ns_to_tsc(hh_ts);
  1348				/* Read Device source clock time */
  1349				hh_ts_lo = rd32(hw, GLTSYN_HHTIME_L(tmr_idx));
  1350				hh_ts_hi = rd32(hw, GLTSYN_HHTIME_H(tmr_idx));
  1351				hh_ts = ((u64)hh_ts_hi << 32) | hh_ts_lo;
  1352				*device = ns_to_ktime(hh_ts);
  1353				break;
  1354			}
  1355		}
  1356		/* Release HW lock */
  1357		hh_lock = rd32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id));
  1358		hh_lock = hh_lock & ~PFHH_SEM_BUSY_M;
  1359		wr32(hw, PFHH_SEM + (PFTSYN_SEM_BYTES * hw->pf_id), hh_lock);
  1360	
  1361		if (i == MAX_HH_LOCK_TRIES)
  1362			return -ETIMEDOUT;
  1363	
  1364		return 0;
  1365	}
  1366	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 70682 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210702/7a641a3d/attachment-0001.bin>
