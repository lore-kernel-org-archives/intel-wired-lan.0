From: kbuild test robot <lkp@intel.com>
Date: Fri, 29 May 2020 04:46:56 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/101] cc1:
 warning: drivers/net/ethernet/intel/idpf/../include: No such file or
 directory
Message-ID: <202005290454.g4d19ubh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   3ef27f2497f6408f432049c5d117d425048ae1e7
commit: 4f3de7b8a4f2d62fdb138f1878d3885e4f7cb47a [91/101] idpf: Introduce idpf driver
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4f3de7b8a4f2d62fdb138f1878d3885e4f7cb47a
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> cc1: warning: drivers/net/ethernet/intel/idpf/../include: No such file or directory [-Wmissing-include-dirs]
In file included from drivers/net/ethernet/intel/idpf/idpf_main.c:8:
drivers/net/ethernet/intel/idpf/idpf_dev.h:7:10: fatal error: iecm.h: No such file or directory
7 | #include "iecm.h"
|          ^~~~~~~~
compilation terminated.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62526 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200529/e4c8d15d/attachment-0001.bin>
