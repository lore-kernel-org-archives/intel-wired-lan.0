From: kbuild test robot <lkp@intel.com>
Date: Wed, 18 Mar 2020 13:40:14 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 49/49]
 drivers/net/ethernet/intel/igc/igc_diag.c:119:9-10: WARNING: return of 0/1
 in function 'igc_reg_test' with return type bool
Message-ID: <202003181310.IqYz3010%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a6017405fcd0cda0cd9f35b34cae92400cf9e3e3
commit: a6017405fcd0cda0cd9f35b34cae92400cf9e3e3 [49/49] igc: add support to interrupt, eeprom, registers and link self-tests

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/igc/igc_diag.c:119:9-10: WARNING: return of 0/1 in function 'igc_reg_test' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
