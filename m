From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 24 Sep 2017 14:44:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 103/109]
 i40e_main.c:undefined reference to `__udivdi3'
Message-ID: <201709241437.Ry9Z9Jyt%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   b4f0b6a5a1092bc70e1ad42af295037974075f13
commit: f2fb739e8b8396be3106d1435240808ed59e32eb [103/109] i40e: Refactor VF BW rate limiting
config: i386-randconfig-sb0-09241307 (attached as .config)
compiler: gcc-5 (Debian 5.4.1-2) 5.4.1 20160904
reproduce:
        git checkout f2fb739e8b8396be3106d1435240808ed59e32eb
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.o: In function `i40e_set_bw_limit':
>> i40e_main.c:(.text+0x61fb): undefined reference to `__udivdi3'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28555 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170924/12379c27/attachment-0001.bin>
