From: kbuild test robot <lkp@intel.com>
Date: Wed, 20 May 2020 04:32:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 183/183]
 drivers/net/ethernet/intel/idpf/idpf_dev.h:7:10: fatal error: iecm.h: No
 such file or directory
Message-ID: <202005200428.AHEQoK3C%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7c7dd63d321082aff5fb170d27beab8a756e3434
commit: 7c7dd63d321082aff5fb170d27beab8a756e3434 [183/183] idpf: Introduce idpf driver
config: arm64-allyesconfig (attached as .config)
compiler: aarch64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7c7dd63d321082aff5fb170d27beab8a756e3434
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> cc1: warning: drivers/net/ethernet/intel/idpf/../include: No such file or directory [-Wmissing-include-dirs]
In file included from drivers/net/ethernet/intel/idpf/idpf_main.c:8:
>> drivers/net/ethernet/intel/idpf/idpf_dev.h:7:10: fatal error: iecm.h: No such file or directory
7 | #include "iecm.h"
|          ^~~~~~~~
compilation terminated.

vim +7 drivers/net/ethernet/intel/idpf/idpf_dev.h

     6	
   > 7	#include "iecm.h"
     8	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 71872 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200520/7dca7ef3/attachment-0001.bin>
