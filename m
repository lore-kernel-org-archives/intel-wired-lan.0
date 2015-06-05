From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 6 Jun 2015 01:23:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 81/84]
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:891:5: sparse: symbol
 'ixgbe_setup_mac_link_t_X550em' was not declared. Should it be static?
Message-ID: <201506060155.snCKv8gq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ed04bbe7774e898c5896259b15c78ec0eecc9023
commit: a678b61d4fe6be6a4f773c9e6fc09b60d293ff96 [81/84] ixgbe: add X550 support for external PHY and forced 1G/10G support
reproduce:
  # apt-get install sparse
  git checkout a678b61d4fe6be6a4f773c9e6fc09b60d293ff96
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:213:24: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:213:24:    expected unsigned int [unsigned] [assigned] [usertype] address
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:213:24:    got restricted __be32 [usertype] <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:215:23: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:215:23:    expected unsigned short [unsigned] [assigned] [usertype] length
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:215:23:    got restricted __be16 [usertype] <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:265:32: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:265:32:    expected unsigned int [unsigned] [assigned] [usertype] address
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:265:32:    got restricted __be32 [usertype] <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:266:31: sparse: incorrect type in assignment (different base types)
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:266:31:    expected unsigned short [unsigned] [assigned] [usertype] length
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:266:31:    got restricted __be16 [usertype] <noident>
>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:891:5: sparse: symbol 'ixgbe_setup_mac_link_t_X550em' was not declared. Should it be static?
>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1190:5: sparse: symbol 'ixgbe_handle_lasi_ext_t_x550em' was not declared. Should it be static?
>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1338:5: sparse: symbol 'ixgbe_setup_internal_phy_t_x550em' was not declared. Should it be static?
   drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1110:12: warning: 'ixgbe_enable_lasi_ext_t_x550em' defined but not used [-Wunused-function]
    static s32 ixgbe_enable_lasi_ext_t_x550em(struct ixgbe_hw *hw)
               ^

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
