From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 18 Mar 2016 23:44:01 +0800
Subject: [Intel-wired-lan] [linux-next:master 4836/12950]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8203:5: sparse: symbol
 '__ixgbe_setup_tc' was not declared. Should it be static?
Message-ID: <201603182332.ZrvaiiNr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   5e3497cca281616e7930b74a0076b7324dcc2057
commit: e4c6734eaab90695db0ea8456307790cb0c1ccb5 [4836/12950] net: rework ndo tc op to consume additional qdisc handle parameter
reproduce:
        # apt-get install sparse
        git checkout e4c6734eaab90695db0ea8456307790cb0c1ccb5
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:675:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:675:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:787:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:787:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:793:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:793:33: sparse: cast to restricted __le64
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:8203:5: sparse: symbol '__ixgbe_setup_tc' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
