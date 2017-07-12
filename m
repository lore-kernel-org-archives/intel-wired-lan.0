From: kbuild test robot <lkp@intel.com>
Date: Wed, 12 Jul 2017 22:12:54 +0800
Subject: [Intel-wired-lan] [PATCH 6/6] [next-queue]net: i40e: Add
 support to set max bandwidth rates for TCs offloaded via tc/mqprio
In-Reply-To: <149976834155.2896.1061095686386969972.stgit@anamdev.jf.intel.com>
Message-ID: <201707122241.Fc9Iuutb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Amritha,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.12]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Amritha-Nambiar/Configuring-traffic-classes-via-new-hardware-offload-mechanism-in-tc-mqprio/20170711-215943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `i40e_set_bw_limit':
   (.text+0x11aabd9): undefined reference to `__udivdi3'
   drivers/built-in.o: In function `i40e_rebuild':
>> i40e_main.c:(.text+0x11af884): undefined reference to `__udivdi3'
   drivers/built-in.o: In function `__i40e_setup_tc':
   i40e_main.c:(.text+0x11b0cb5): undefined reference to `__udivdi3'
   i40e_main.c:(.text+0x11b0e99): undefined reference to `__udivdi3'
   i40e_main.c:(.text+0x11b0f25): undefined reference to `__udivdi3'
   drivers/built-in.o:(.text+0x1297fb8): more undefined references to `__udivdi3' follow

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59805 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170712/c97065e2/attachment-0001.bin>
