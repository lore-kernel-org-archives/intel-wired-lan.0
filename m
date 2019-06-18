From: kbuild test robot <lkp@intel.com>
Date: Tue, 18 Jun 2019 15:40:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 35/35]
 drivers/net/ethernet/intel/iavf/iavf_main.c:151:6: sparse: sparse: symbol
 'iavf_debug_d' was not declared. Should it be static?
Message-ID: <201906181502.baIuT9Wk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   d51cc48b07a8f27832ae377ba75c4a7cb295407a
commit: d51cc48b07a8f27832ae377ba75c4a7cb295407a [35/35] iavf: Fix up debug print macro
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-rc1-7-g2b96cd8-dirty
        git checkout d51cc48b07a8f27832ae377ba75c4a7cb295407a
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
