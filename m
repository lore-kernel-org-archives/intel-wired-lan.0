From: kbuild test robot <lkp@intel.com>
Date: Thu, 2 May 2019 05:06:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 1397/1564]
 drivers/net/ethernet/aquantia/atlantic/aq_main.c:26:12: sparse: sparse:
 symbol 'aq_ndev_driver_name' was not declared. Should it be static?
Message-ID: <201905020544.AMb7YA2G%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   27b3ae8c760033d085ce5a45020983fdabd2a7c9
commit: 58608082e66ddf9643cf6b98fe81c216a410ced1 [1397/1564] net: aquantia: create global service workqueue
reproduce:
        # apt-get install sparse
        git checkout 58608082e66ddf9643cf6b98fe81c216a410ced1
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/aquantia/atlantic/aq_main.c:26:12: sparse: sparse: symbol 'aq_ndev_driver_name' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
