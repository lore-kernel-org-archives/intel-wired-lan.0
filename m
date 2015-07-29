From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 29 Jul 2015 15:11:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 127/128]
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:153:1-7: WARNING: end returns
 can be simpified
Message-ID: <201507291522.YuNdtPvl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   246db26b0ce1ae0eb1cf19195155a2e02ad3d257
commit: 3c7e68b9d8870417bce21f7ae21cfe74828f974f [127/128] ixgbe: Add logic to reset CS4227 when needed


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:153:1-7: WARNING: end returns can be simpified

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
