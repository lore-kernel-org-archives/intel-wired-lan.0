From: kbuild test robot <lkp@intel.com>
Date: Thu, 19 Jul 2018 11:45:14 +0800
Subject: [Intel-wired-lan] [PATCH v4 07/11] igc: Add HW initialization
 code
In-Reply-To: <20180718081803.15752-1-sasha.neftin@intel.com>
References: <20180718081803.15752-1-sasha.neftin@intel.com>
Message-ID: <201807191136.Z0vjGQyx%fengguang.wu@intel.com>
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

>> drivers/net/ethernet/intel/igc/igc_mac.c:228:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:228:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:228:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_mac.c:229:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:229:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:229:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_mac.c:82:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:82:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:82:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_mac.c:173:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:173:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:173:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_mac.c:174:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:174:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:174:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_mac.c:175:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:175:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:175:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_mac.c:177:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:177:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:177:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_mac.c:370:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_mac.c:370:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_mac.c:370:9:    got unsigned char [usertype] *__val
--
>> drivers/net/ethernet/intel/igc/igc_i225.c:56:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_i225.c:56:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_i225.c:56:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_i225.c:114:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_i225.c:114:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_i225.c:114:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_i225.c:138:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_i225.c:138:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_i225.c:138:9:    got unsigned char [usertype] *__val

vim +228 drivers/net/ethernet/intel/igc/igc_mac.c

   197	
   198	/**
   199	 *  igc_set_fc_watermarks - Set flow control high/low watermarks
   200	 *  @hw: pointer to the HW structure
   201	 *
   202	 *  Sets the flow control high/low threshold (watermark) registers.  If
   203	 *  flow control XON frame transmission is enabled, then set XON frame
   204	 *  transmission as well.
   205	 **/
   206	static s32 igc_set_fc_watermarks(struct igc_hw *hw)
   207	{
   208		u32 fcrtl = 0, fcrth = 0;
   209		s32 ret_val = 0;
   210	
   211		/* Set the flow control receive threshold registers.  Normally,
   212		 * these registers will be set to a default threshold that may be
   213		 * adjusted later by the driver's runtime code.  However, if the
   214		 * ability to transmit pause frames is not enabled, then these
   215		 * registers will be set to 0.
   216		 */
   217		if (hw->fc.current_mode & igc_fc_tx_pause) {
   218			/* We need to set up the Receive Threshold high and low water
   219			 * marks as well as (optionally) enabling the transmission of
   220			 * XON frames.
   221			 */
   222			fcrtl = hw->fc.low_water;
   223			if (hw->fc.send_xon)
   224				fcrtl |= IGC_FCRTL_XONE;
   225	
   226			fcrth = hw->fc.high_water;
   227		}
 > 228		wr32(IGC_FCRTL, fcrtl);
   229		wr32(IGC_FCRTH, fcrth);
   230	
   231		return ret_val;
   232	}
   233	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
