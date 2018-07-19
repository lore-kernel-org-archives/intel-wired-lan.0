From: kbuild test robot <lkp@intel.com>
Date: Thu, 19 Jul 2018 09:23:17 +0800
Subject: [Intel-wired-lan] [PATCH v4 05/11] igc: Add support for Tx/Rx
 rings
In-Reply-To: <20180718081756.15622-1-sasha.neftin@intel.com>
References: <20180718081756.15622-1-sasha.neftin@intel.com>
Message-ID: <201807190921.H1cBoyX1%fengguang.wu@intel.com>
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

>> drivers/net/ethernet/intel/igc/igc_base.c:26:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:26:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:26:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:34:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:34:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:34:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:54:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:54:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:54:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:57:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:57:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:57:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:63:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:63:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:63:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:64:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:64:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:64:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:72:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:72:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:72:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:73:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:73:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:73:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:76:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:76:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:76:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_base.c:77:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_base.c:77:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_base.c:77:9:    got unsigned char [usertype] *__val

vim +26 drivers/net/ethernet/intel/igc/igc_base.c

     8	
     9	/**
    10	 *  igc_rx_fifo_flush_base - Clean rx fifo after Rx enable
    11	 *  @hw: pointer to the HW structure
    12	 *
    13	 *  After Rx enable, if manageability is enabled then there is likely some
    14	 *  bad data at the start of the fifo and possibly in the DMA fifo.  This
    15	 *  function clears the fifos and flushes any packets that came in as rx was
    16	 *  being enabled.
    17	 **/
    18	void igc_rx_fifo_flush_base(struct igc_hw *hw)
    19	{
    20		u32 rctl, rlpml, rxdctl[4], rfctl, temp_rctl, rx_enabled;
    21		int i, ms_wait;
    22	
    23		/* disable IPv6 options as per hardware errata */
    24		rfctl = rd32(IGC_RFCTL);
    25		rfctl |= IGC_RFCTL_IPV6_EX_DIS;
  > 26		wr32(IGC_RFCTL, rfctl);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
