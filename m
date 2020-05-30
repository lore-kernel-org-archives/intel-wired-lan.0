From: kbuild test robot <lkp@intel.com>
Date: Sat, 30 May 2020 09:35:01 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 63/73]
 drivers/net/ethernet/intel/idpf/idpf_dev.h:7:10: fatal error: 'iecm.h' file
 not found
Message-ID: <202005300959.PqGpsNoo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   4b1ba063a5a5cf9c533aa0b2ca8a423df159773e
commit: aa7e88603b12ac786bfd7a5e8b13b924922384ec [63/73] idpf: Introduce idpf driver
config: x86_64-allyesconfig (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 2d068e534f1671459e1b135852c1b3c10502e929)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        git checkout aa7e88603b12ac786bfd7a5e8b13b924922384ec
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

In file included from drivers/net/ethernet/intel/idpf/idpf_main.c:8:
>> drivers/net/ethernet/intel/idpf/idpf_dev.h:7:10: fatal error: 'iecm.h' file not found
#include "iecm.h"
^~~~~~~~
1 error generated.

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
Size: 73646 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200530/536182e4/attachment-0001.bin>
