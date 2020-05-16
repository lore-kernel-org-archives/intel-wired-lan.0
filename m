From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 May 2020 13:31:55 +0800
Subject: [Intel-wired-lan] [iecm/idpf V1 14/14] idpf: Introduce idpf
 driver
In-Reply-To: <20200515063500.48301-15-alice.michael@intel.com>
References: <20200515063500.48301-15-alice.michael@intel.com>
Message-ID: <202005161327.KV4UeKpU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alice,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[also build test ERROR on linus/master v5.7-rc5 next-20200515]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Alice-Michael/iecm-idpf-series-cover-letter/20200515-230855
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: x86_64-allyesconfig (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 9d4cf5bd421fb6467ff5f00e26a37527246dd4d6)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
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
Size: 73506 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200516/234fe3b1/attachment-0001.bin>
