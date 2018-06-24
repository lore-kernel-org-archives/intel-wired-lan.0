From: kbuild test robot <lkp@intel.com>
Date: Mon, 25 Jun 2018 01:23:51 +0800
Subject: [Intel-wired-lan] [PATCH v3 09/11] igc: Add code for PHY support
In-Reply-To: <20180624084521.10330-1-sasha.neftin@intel.com>
References: <20180624084521.10330-1-sasha.neftin@intel.com>
Message-ID: <201806250159.5JPYRzj9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.18-rc2 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sasha-Neftin/igc-Add-skeletal-frame-for-Intel-R-2-5G-Ethernet-Controller-support/20180624-164739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/igc/e1000_phy.c:197:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_phy.c:197:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_phy.c:197:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_phy.c:202:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_phy.c:202:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_phy.c:202:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_phy.c:244:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_phy.c:244:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_phy.c:244:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_phy.c:301:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_phy.c:301:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_phy.c:301:9:    got unsigned char [usertype] *__val

vim +197 drivers/net/ethernet/intel/igc/e1000_phy.c

   170	
   171	/**
   172	 *  igc_phy_hw_reset - PHY hardware reset
   173	 *  @hw: pointer to the HW structure
   174	 *
   175	 *  Verify the reset block is not blocking us from resetting.  Acquire
   176	 *  semaphore (if necessary) and read/set/write the device control reset
   177	 *  bit in the PHY.  Wait the appropriate delay time for the device to
   178	 *  reset and release the semaphore (if necessary).
   179	 **/
   180	s32 igc_phy_hw_reset(struct e1000_hw *hw)
   181	{
   182		struct e1000_phy_info *phy = &hw->phy;
   183		s32  ret_val;
   184		u32 ctrl;
   185	
   186		ret_val = igc_check_reset_block(hw);
   187		if (ret_val) {
   188			ret_val = 0;
   189			goto out;
   190		}
   191	
   192		ret_val = phy->ops.acquire(hw);
   193		if (ret_val)
   194			goto out;
   195	
   196		ctrl = rd32(E1000_CTRL);
 > 197		wr32(E1000_CTRL, ctrl | E1000_CTRL_PHY_RST);
   198		wrfl();
   199	
   200		udelay(phy->reset_delay_us);
   201	
   202		wr32(E1000_CTRL, ctrl);
   203		wrfl();
   204	
   205		usleep_range(1500, 2000);
   206	
   207		phy->ops.release(hw);
   208	
   209		ret_val = phy->ops.get_cfg_done(hw);
   210	
   211	out:
   212		return ret_val;
   213	}
   214	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
