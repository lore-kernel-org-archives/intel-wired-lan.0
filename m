From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 12:23:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 89/91]
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1467:5: sparse: symbol
 'ixgbe_get_lcd_t_x550em' was not declared. Should it be static?
Message-ID: <201506121203.9UfHmWd1%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   3b9a14f8368be49d9a07dbdcfcf6ff1cc92f9c85
commit: 4c70bf2016f43810dfd475484eff7cd50b706008 [89/91] ixgbe: Add support for entering low power link up state
reproduce:
  # apt-get install sparse
  git checkout 4c70bf2016f43810dfd475484eff7cd50b706008
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:227:24: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:227:24:    expected unsigned int [unsigned] [assigned] [usertype] address
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:227:24:    got restricted __be32 [usertype] <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:229:23: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:229:23:    expected unsigned short [unsigned] [assigned] [usertype] length
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:229:23:    got restricted __be16 [usertype] <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:279:32: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:279:32:    expected unsigned int [unsigned] [assigned] [usertype] address
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:279:32:    got restricted __be32 [usertype] <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:280:31: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:280:31:    expected unsigned short [unsigned] [assigned] [usertype] length
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:280:31:    got restricted __be16 [usertype] <noident>
>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1467:5: sparse: symbol 'ixgbe_get_lcd_t_x550em' was not declared. Should it be static?
>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1504:5: sparse: symbol 'ixgbe_enter_lplu_t_x550em' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
