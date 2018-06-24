From: kbuild test robot <lkp@intel.com>
Date: Mon, 25 Jun 2018 02:13:07 +0800
Subject: [Intel-wired-lan] [PATCH v3 11/11] igc: Add watchdog
In-Reply-To: <20180624084528.10419-1-sasha.neftin@intel.com>
References: <20180624084528.10419-1-sasha.neftin@intel.com>
Message-ID: <201806250203.KOhPmAKq%fengguang.wu@intel.com>
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

   drivers/net/ethernet/intel/igc/igc_main.c:2832:23: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2832:23: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2862:27: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2862:27: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2608:33: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2608:33: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2619:25: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:91:6: sparse: symbol 'igc_reset' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:111:6: sparse: symbol 'igc_power_up_link' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:154:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:154:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:154:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:173:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:173:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:173:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:183:6: sparse: symbol 'igc_free_tx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:214:6: sparse: symbol 'igc_unmap_and_free_tx_resource' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:286:5: sparse: symbol 'igc_setup_tx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:348:6: sparse: symbol 'igc_clean_rx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:407:6: sparse: symbol 'igc_free_rx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:444:5: sparse: symbol 'igc_setup_rx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:528:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:528:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:528:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:531:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:531:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:531:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:533:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:533:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:533:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:534:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:534:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:534:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:539:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:539:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:539:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:554:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:554:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:554:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:571:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:571:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:571:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:518:6: sparse: symbol 'igc_configure_rx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:607:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:607:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:607:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:611:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:611:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:611:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:613:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:613:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:613:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:615:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:615:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:615:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:618:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:618:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:618:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:626:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:626:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:626:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:598:6: sparse: symbol 'igc_configure_tx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:681:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:681:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:681:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:696:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:696:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:696:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:655:6: sparse: symbol 'igc_setup_rctl' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:709:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:709:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:709:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:720:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:720:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:720:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:703:6: sparse: symbol 'igc_setup_tctl' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:981:13: sparse: symbol 'igc_xmit_frame_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1378:6: sparse: symbol 'igc_alloc_rx_buffers' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1769:5: sparse: symbol 'igc_up' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1804:6: sparse: symbol 'igc_update_stats' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1823:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1823:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1823:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1837:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1837:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1837:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1812:6: sparse: symbol 'igc_down' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1874:6: sparse: symbol 'igc_reinit_locked' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:2012:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2012:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2012:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2014:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2014:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2014:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2064:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2064:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2064:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2092:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2092:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2092:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:2337:6: sparse: symbol 'igc_has_link' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:2551:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2551:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2551:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2553:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2553:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2553:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3447:5: sparse: symbol 'igc_open' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:3481:5: sparse: symbol 'igc_close' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:3546:31: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3546:31:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3546:31:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3649:21: sparse: incorrect type in assignment (different address spaces) @@    expected unsigned char [usertype] *hw_addr @@    got unsigned char [nounsigned char [usertype] *hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3649:21:    expected unsigned char [usertype] *hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3649:21:    got unsigned char [noderef] [usertype] <asn:2>*io_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3707:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3707:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3707:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3708:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3708:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3708:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3764:27: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got olatile [noderef] <asn:2>*addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3764:27:    expected void volatile [noderef] <asn:2>*addr
   drivers/net/ethernet/intel/igc/igc_main.c:3764:27:    got unsigned char [usertype] *flash_address
   drivers/net/ethernet/intel/igc/igc_main.c:3810:27: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got olatile [noderef] <asn:2>*addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3810:27:    expected void volatile [noderef] <asn:2>*addr
   drivers/net/ethernet/intel/igc/igc_main.c:3810:27:    got unsigned char [usertype] *flash_address
   drivers/net/ethernet/intel/igc/igc_main.c:3829:6: sparse: symbol 'igc_set_flag_queue_pairs' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:3842:14: sparse: symbol 'igc_get_max_rss_queues' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:3857:31: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:3857:31: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
