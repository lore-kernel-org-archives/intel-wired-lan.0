From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 1 Aug 2017 21:09:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 59/86]
 i40e_main.c:undefined reference to `__udivdi3'
Message-ID: <201708012144.OKVvRamV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   15278d958d1b662a77605c8dc133fe1cacbea04e
commit: 1451f99eab72d440eec69536f7b3413a58ad1690 [59/86] i40e: Refactor VF BW rate limiting function to be reused on the PF as well
config: i386-allyesconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 1451f99eab72d440eec69536f7b3413a58ad1690
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.o: In function `i40e_set_bw_limit':
>> i40e_main.c:(.text+0x97f9): undefined reference to `__udivdi3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60411 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170801/a25b7e31/attachment-0001.bin>
