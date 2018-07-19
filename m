From: kbuild test robot <lkp@intel.com>
Date: Thu, 19 Jul 2018 14:01:59 +0800
Subject: [Intel-wired-lan] [PATCH v4 08/11] igc: Add NVM support
In-Reply-To: <20180718081806.15824-1-sasha.neftin@intel.com>
References: <20180718081806.15824-1-sasha.neftin@intel.com>
Message-ID: <201807191400.pg5KKGyA%fengguang.wu@intel.com>
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

>> drivers/net/ethernet/intel/igc/igc_nvm.c:52:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_nvm.c:52:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_nvm.c:52:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_nvm.c:65:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_nvm.c:65:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_nvm.c:65:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_nvm.c:85:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_nvm.c:85:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_nvm.c:85:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_nvm.c:117:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_nvm.c:117:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_nvm.c:117:17:    got unsigned char [usertype] *__val

vim +52 drivers/net/ethernet/intel/igc/igc_nvm.c

    37	
    38	/**
    39	 *  igc_acquire_nvm - Generic request for access to EEPROM
    40	 *  @hw: pointer to the HW structure
    41	 *
    42	 *  Set the EEPROM access request bit and wait for EEPROM access grant bit.
    43	 *  Return successful if access grant bit set, else clear the request for
    44	 *  EEPROM access and return -IGC_ERR_NVM (-1).
    45	 **/
    46	s32 igc_acquire_nvm(struct igc_hw *hw)
    47	{
    48		s32 timeout = IGC_NVM_GRANT_ATTEMPTS;
    49		u32 eecd = rd32(IGC_EECD);
    50		s32 ret_val = 0;
    51	
  > 52		wr32(IGC_EECD, eecd | IGC_EECD_REQ);
    53		eecd = rd32(IGC_EECD);
    54	
    55		while (timeout) {
    56			if (eecd & IGC_EECD_GNT)
    57				break;
    58			udelay(5);
    59			eecd = rd32(IGC_EECD);
    60			timeout--;
    61		}
    62	
    63		if (!timeout) {
    64			eecd &= ~IGC_EECD_REQ;
    65			wr32(IGC_EECD, eecd);
    66			hw_dbg("Could not acquire NVM grant\n");
    67			ret_val = -IGC_ERR_NVM;
    68		}
    69	
    70		return ret_val;
    71	}
    72	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
