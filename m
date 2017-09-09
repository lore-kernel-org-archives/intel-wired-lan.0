From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 9 Sep 2017 15:03:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 102/105]
 i40e_main.c:undefined reference to `__udivdi3'
Message-ID: <201709091514.TDAG5kIt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b5118ed9bab9539d1d4e767636fd13826dbe2df1
commit: 6f7611dd5de1549e5a6ed6c0bade156af9975f84 [102/105] i40e: Refactor VF BW rate limiting
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 6f7611dd5de1549e5a6ed6c0bade156af9975f84
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.o: In function `i40e_set_bw_limit':
>> i40e_main.c:(.text+0x9fb9): undefined reference to `__udivdi3'
   net/netfilter/xt_hashlimit.o: In function `hashlimit_mt_common.isra.6':
   xt_hashlimit.c:(.text+0xee1): undefined reference to `__udivdi3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60699 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170909/40fe06c1/attachment-0001.bin>
