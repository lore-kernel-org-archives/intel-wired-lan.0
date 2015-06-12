From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 11:35:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/91]
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4279:6: sparse: symbol
 'ixgbe_clear_vxlan_port' was not declared. Should it be static?
Message-ID: <201506121128.L8wLrPre%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   3b9a14f8368be49d9a07dbdcfcf6ff1cc92f9c85
commit: 3b9a14f8368be49d9a07dbdcfcf6ff1cc92f9c85 [91/91] ixgbe: Add support for VXLAN RX offloads
reproduce:
  # apt-get install sparse
  git checkout 3b9a14f8368be49d9a07dbdcfcf6ff1cc92f9c85
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:667:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:667:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:779:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:779:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:785:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:785:33: sparse: cast to restricted __le64
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4279:6: sparse: symbol 'ixgbe_clear_vxlan_port' was not declared. Should it be static?
   include/linux/etherdevice.h:79:32: sparse: restricted __be16 degrades to integer

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
