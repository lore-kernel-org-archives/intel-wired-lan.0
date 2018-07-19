From: kbuild test robot <lkp@intel.com>
Date: Thu, 19 Jul 2018 15:19:35 +0800
Subject: [Intel-wired-lan] [PATCH v4 09/11] igc: Add code for PHY support
In-Reply-To: <20180718081809.15868-1-sasha.neftin@intel.com>
References: <20180718081809.15868-1-sasha.neftin@intel.com>
Message-ID: <201807191553.eqyPCzot%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.18-rc5 next-20180718]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sasha-Neftin/igc-Add-skeletal-frame-for-Intel-R-2-5G-Ethernet-Controller-support/20180719-055021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/igc/igc_phy.c:198:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_phy.c:198:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_phy.c:198:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_phy.c:203:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_phy.c:203:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_phy.c:203:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_phy.c:245:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_phy.c:245:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_phy.c:245:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_phy.c:302:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_phy.c:302:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_phy.c:302:9:    got unsigned char [usertype] *__val

vim +198 drivers/net/ethernet/intel/igc/igc_phy.c

   171	
   172	/**
   173	 *  igc_phy_hw_reset - PHY hardware reset
   174	 *  @hw: pointer to the HW structure
   175	 *
   176	 *  Verify the reset block is not blocking us from resetting.  Acquire
   177	 *  semaphore (if necessary) and read/set/write the device control reset
   178	 *  bit in the PHY.  Wait the appropriate delay time for the device to
   179	 *  reset and release the semaphore (if necessary).
   180	 **/
   181	s32 igc_phy_hw_reset(struct igc_hw *hw)
   182	{
   183		struct igc_phy_info *phy = &hw->phy;
   184		s32  ret_val;
   185		u32 ctrl;
   186	
   187		ret_val = igc_check_reset_block(hw);
   188		if (ret_val) {
   189			ret_val = 0;
   190			goto out;
   191		}
   192	
   193		ret_val = phy->ops.acquire(hw);
   194		if (ret_val)
   195			goto out;
   196	
   197		ctrl = rd32(IGC_CTRL);
 > 198		wr32(IGC_CTRL, ctrl | IGC_CTRL_PHY_RST);
   199		wrfl();
   200	
   201		udelay(phy->reset_delay_us);
   202	
   203		wr32(IGC_CTRL, ctrl);
   204		wrfl();
   205	
   206		usleep_range(1500, 2000);
   207	
   208		phy->ops.release(hw);
   209	
   210		ret_val = phy->ops.get_cfg_done(hw);
   211	
   212	out:
   213		return ret_val;
   214	}
   215	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
