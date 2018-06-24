From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 Jun 2018 22:11:13 +0800
Subject: [Intel-wired-lan] [PATCH v3 05/11] igc: Add support for Tx/Rx
 rings
In-Reply-To: <20180624084508.10153-1-sasha.neftin@intel.com>
References: <20180624084508.10153-1-sasha.neftin@intel.com>
Message-ID: <201806242124.6630ndHa%fengguang.wu@intel.com>
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

   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
   drivers/net/ethernet/intel/igc/igc_main.c:1991:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1991:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1991:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1992:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1992:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1992:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1994:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1994:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1994:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1997:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1997:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1997:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1998:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1998:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1998:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2025:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2025:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2025:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2027:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2027:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2027:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2028:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2028:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2028:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2029:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2029:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2029:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2031:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2031:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2031:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2032:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2032:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2032:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1144:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1144:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1144:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1152:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1152:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1152:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1563:25: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1563:25:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1563:25:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1589:23: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:1589:23: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:1619:27: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:1619:27: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:1365:33: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:1365:33: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:1376:25: sparse: expression using sizeof(void)
   drivers/net/ethernet/intel/igc/igc_main.c:77:6: sparse: symbol 'igc_reset' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:87:6: sparse: symbol 'igc_power_up_link' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:114:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:114:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:114:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:133:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:133:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:133:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:143:6: sparse: symbol 'igc_free_tx_resources' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:174:6: sparse: symbol 'igc_unmap_and_free_tx_resource' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:233:5: sparse: symbol 'igc_setup_tx_resources' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:295:6: sparse: symbol 'igc_clean_rx_ring' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:341:6: sparse: symbol 'igc_free_rx_resources' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:378:5: sparse: symbol 'igc_setup_rx_resources' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:462:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:462:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:462:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:465:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:465:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:465:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:467:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:467:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:467:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:468:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:468:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:468:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:473:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:473:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:473:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:488:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:488:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:488:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:505:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:505:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:505:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:452:6: sparse: symbol 'igc_configure_rx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:541:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:541:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:541:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:545:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:545:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:545:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:547:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:547:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:547:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:549:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:549:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:549:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:552:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:552:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:552:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:560:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:560:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:560:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:532:6: sparse: symbol 'igc_configure_tx_ring' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:615:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:615:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:615:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:630:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:630:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:630:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:589:6: sparse: symbol 'igc_setup_rctl' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:643:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:643:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:643:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:654:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:654:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:654:9:    got unsigned char [usertype] *__val
>> drivers/net/ethernet/intel/igc/igc_main.c:637:6: sparse: symbol 'igc_setup_tctl' was not declared. Should it be static?
>> drivers/net/ethernet/intel/igc/igc_main.c:739:6: sparse: symbol 'igc_alloc_rx_buffers' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:822:5: sparse: symbol 'igc_up' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:857:6: sparse: symbol 'igc_down' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:921:6: sparse: symbol 'igc_update_stats' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:1003:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1003:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1003:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1005:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1005:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1005:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1055:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1055:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1055:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:1083:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:1083:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:1083:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2203:5: sparse: symbol 'igc_open' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:2237:5: sparse: symbol 'igc_close' was not declared. Should it be static?
   drivers/net/ethernet/intel/igc/igc_main.c:2302:31: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2302:31:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2302:31:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c:2404:21: sparse: incorrect type in assignment (different address spaces) @@    expected unsigned char [usertype] *hw_addr @@    got unsigned char [nounsigned char [usertype] *hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:2404:21:    expected unsigned char [usertype] *hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:2404:21:    got unsigned char [noderef] [usertype] <asn:2>*io_addr
   include/linux/slab.h:631:13: sparse: call with no type!
--
>> drivers/net/ethernet/intel/igc/e1000_base.c:26:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:26:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:26:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:34:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:34:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:34:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:54:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:54:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:54:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:57:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:57:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:57:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:63:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:63:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:63:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:64:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:64:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:64:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:72:17: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:72:17:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:72:17:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:73:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:73:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:73:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:76:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:76:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:76:9:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/e1000_base.c:77:9: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/e1000_base.c:77:9:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/e1000_base.c:77:9:    got unsigned char [usertype] *__val

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
