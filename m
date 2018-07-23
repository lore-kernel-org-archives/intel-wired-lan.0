From: kbuild test robot <lkp@intel.com>
Date: Tue, 24 Jul 2018 04:54:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:XDP-hints-EXPERIMENTAL 1/1]
 drivers/net//ethernet/intel/i40e/i40e_txrx.c:8:10: fatal error: asm/msr.h:
 No such file or directory
Message-ID: <201807240456.eoQnKjga%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git XDP-hints-EXPERIMENTAL
head:   58e0270bb7ac94a31ff0fe372385cfce4198b56c
commit: 58e0270bb7ac94a31ff0fe372385cfce4198b56c [1/1] i40e: Initial support to add hw hints for xdp
config: powerpc-defconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 58e0270bb7ac94a31ff0fe372385cfce4198b56c
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

>> drivers/net//ethernet/intel/i40e/i40e_txrx.c:8:10: fatal error: asm/msr.h: No such file or directory
    #include <asm/msr.h>
             ^~~~~~~~~~~
   compilation terminated.

vim +8 drivers/net//ethernet/intel/i40e/i40e_txrx.c

     3	
     4	#include <linux/prefetch.h>
     5	#include <net/busy_poll.h>
     6	#include <linux/bpf_trace.h>
     7	#include <net/xdp.h>
   > 8	#include <asm/msr.h>
     9	#include "i40e.h"
    10	#include "i40e_trace.h"
    11	#include "i40e_prototype.h"
    12	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23435 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180724/80727c70/attachment-0001.bin>
