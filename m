From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 Jun 2018 23:05:42 +0800
Subject: [Intel-wired-lan] [PATCH v3 06/11] igc: Add transmit and
 receive fastpath and interrupt handlers
In-Reply-To: <20180624084511.10198-1-sasha.neftin@intel.com>
References: <20180624084511.10198-1-sasha.neftin@intel.com>
Message-ID: <201806242238.PPRIb7BV%fengguang.wu@intel.com>
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

   drivers/net/ethernet/intel/igc/igc_main.c:3017:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3017:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3017:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3018:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3018:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3018:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3019:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3019:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3019:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3021:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3021:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3021:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3022:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3022:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3022:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2123:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2123:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2123:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2131:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2131:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2131:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2553:25: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2553:25:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2553:25:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2579:23: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2579:23: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2609:27: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2609:27: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2355:33: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2355:33: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:2366:25: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:87:6: sparse: symbol 'igc_reset' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:97:6: sparse: symbol 'igc_power_up_link' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:124:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:124:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:124:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:143:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:143:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:143:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:153:6: sparse: symbol 'igc_free_tx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:184:6: sparse: symbol 'igc_unmap_and_free_tx_resource' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:256:5: sparse: symbol 'igc_setup_tx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:318:6: sparse: symbol 'igc_clean_rx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:377:6: sparse: symbol 'igc_free_rx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:414:5: sparse: symbol 'igc_setup_rx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:498:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:498:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:498:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:501:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:501:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:501:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:503:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:503:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:503:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:504:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:504:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:504:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:509:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:509:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:509:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:524:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:524:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:524:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:541:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:541:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:541:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:488:6: sparse: symbol 'igc_configure_rx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:577:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:577:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:577:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:581:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:581:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:581:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:583:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:583:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:583:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:585:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:585:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:585:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:588:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:588:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:588:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:596:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:596:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:596:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:568:6: sparse: symbol 'igc_configure_tx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:651:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:651:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:651:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:666:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:666:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:666:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:625:6: sparse: symbol 'igc_setup_rctl' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:679:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:679:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:679:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:690:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:690:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:690:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:673:6: sparse: symbol 'igc_setup_tctl' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:951:13: sparse: symbol 'igc_xmit_frame_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1348:6: sparse: symbol 'igc_alloc_rx_buffers' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1739:5: sparse: symbol 'igc_up' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1774:6: sparse: symbol 'igc_update_stats' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1793:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1793:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1793:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1807:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1807:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1807:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1782:6: sparse: symbol 'igc_down' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:1844:6: sparse: symbol 'igc_reinit_locked' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1982:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1982:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1982:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1984:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1984:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1984:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2034:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2034:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2034:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2062:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2062:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2062:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3193:5: sparse: symbol 'igc_open' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:3227:5: sparse: symbol 'igc_close' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:3292:31: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3292:31:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3292:31:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3394:21: sparse: incorrect type in assignment (different address spaces) @@    expected unsigned char [usertype] *hw_addr @@    got unsigned char [nounsigned char [usertype] *hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3394:21:    expected unsigned char [usertype] *hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3394:21:    got unsigned char [noderef] [usertype] <asn:2>*io_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3424:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3424:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3424:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:3425:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3425:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:3425:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:3509:27: sparse: incorrect type in argument 1 (different address spaces) @@    expected void volatile [noderef] <asn:2>*addr @@    got olatile [noderef] <asn:2>*addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:3509:27:    expected void volatile [noderef] <asn:2>*addr
   drivers/net/ethernet/intel/igc/igc_main.c:3509:27:    got unsigned char [usertype] *flash_address
>> drivers/net/ethernet/intel/igc/igc_main.c:3528:6: sparse: symbol 'igc_set_flag_queue_pairs' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:3541:14: sparse: symbol 'igc_get_max_rss_queues' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:3556:31: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:3556:31: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
