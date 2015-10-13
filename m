From: kbuild test robot <lkp@intel.com>
Date: Tue, 13 Oct 2015 10:11:22 +0800
Subject: [Intel-wired-lan] [PATCH v4 4/4] Adds hardware supported cross
	timestamp
In-Reply-To: <1444675522-4198-5-git-send-email-christopher.s.hall@intel.com>
Message-ID: <201510131041.EeBC9X7V%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Christopher,

[auto build test ERROR on net/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Christopher-S-Hall/Patchset-enabling-hardware-based-cross-timestamps-for-next-gen-Intel-platforms/20151013-095135
config: x86_64-randconfig-x010-10130227 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/ptp.c: In function 'e1000e_phc_get_ts':
>> drivers/net/ethernet/intel/e1000e/ptp.c:107:61: error: dereferencing pointer to incomplete type 'struct correlated_ts'
     struct e1000_adapter *adapter = (struct e1000_adapter *)cts->private;
                                                                ^
   drivers/net/ethernet/intel/e1000e/ptp.c: In function 'e1000e_phc_getsynctime':
>> drivers/net/ethernet/intel/e1000e/ptp.c:155:23: error: storage size of 'art_correlated_ts' isn't known
     struct correlated_ts art_correlated_ts;
                          ^
>> drivers/net/ethernet/intel/e1000e/ptp.c:155:23: warning: unused variable 'art_correlated_ts' [-Wunused-variable]

vim +107 drivers/net/ethernet/intel/e1000e/ptp.c

   101	}
   102	
   103	#define MAX_HW_WAIT_COUNT (3)
   104	
   105	static int e1000e_phc_get_ts(struct correlated_ts *cts)
   106	{
 > 107		struct e1000_adapter *adapter = (struct e1000_adapter *)cts->private;
   108		struct e1000_hw *hw = &adapter->hw;
   109		int i;
   110		u32 tsync_ctrl;
   111		int ret;
   112	
   113		tsync_ctrl = er32(TSYNCTXCTL);
   114		tsync_ctrl |= E1000_TSYNCTXCTL_START_SYNC |
   115			E1000_TSYNCTXCTL_MAX_ALLOWED_DLY_MASK;
   116		ew32(TSYNCTXCTL, tsync_ctrl);
   117		for (i = 0; i < MAX_HW_WAIT_COUNT; ++i) {
   118			udelay(1);
   119			tsync_ctrl = er32(TSYNCTXCTL);
   120			if (tsync_ctrl & E1000_TSYNCTXCTL_SYNC_COMP)
   121				break;
   122		}
   123	
   124		if (i == MAX_HW_WAIT_COUNT) {
   125			ret = -ETIMEDOUT;
   126		} else {
   127			ret = 0;
   128			cts->system_ts = er32(PLTSTMPH);
   129			cts->system_ts <<= 32;
   130			cts->system_ts |= er32(PLTSTMPL);
   131			cts->device_ts = er32(SYSSTMPH);
   132			cts->device_ts <<= 32;
   133			cts->device_ts |= er32(SYSSTMPL);
   134		}
   135	
   136		return ret;
   137	}
   138	
   139	/**
   140	 * e1000e_phc_getsynctime - Reads the current time from the hardware clock and
   141	 * correlated system time
   142	 * @ptp: ptp clock structure
   143	 * @devts: timespec structure to hold the current device time value
   144	 * @systs: timespec structure to hold the current system time value
   145	 *
   146	 * Read device and system (ART) clock simultaneously and return the correct
   147	 * clock values in ns after converting into a struct timespec.
   148	 **/
   149	static int e1000e_phc_getsynctime(struct ptp_clock_info *ptp, u64 *dev,
   150					  u64 *sys )
   151	{
   152		struct e1000_adapter *adapter = container_of(ptp, struct e1000_adapter,
   153							     ptp_clock_info);
   154		unsigned long flags;
 > 155		struct correlated_ts art_correlated_ts;
   156		int ret;
   157	
   158		art_correlated_ts.get_ts = e1000e_phc_get_ts;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30837 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151013/609243da/attachment-0001.obj>
