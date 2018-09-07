From: kbuild test robot <lkp@intel.com>
Date: Fri, 7 Sep 2018 15:25:03 +0800
Subject: [Intel-wired-lan] [PATCH v2 2/2] net: ethernet: i40evf: fix
 potential build error
In-Reply-To: <1536114430-21356-2-git-send-email-dongsheng.wang@hxt-semitech.com>
References: <1536114430-21356-2-git-send-email-dongsheng.wang@hxt-semitech.com>
Message-ID: <201809071557.VVFCvL4J%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Wang,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.19-rc2 next-20180906]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wang-Dongsheng/net-ethernet-i40e-fix-build-error/20180907-063122
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40evf/i40evf_ethtool.o: In function `__i40e_add_stat_strings':
>> i40evf_ethtool.c:(.text+0xeb0): multiple definition of `__i40e_add_stat_strings'
   drivers/net/ethernet/intel/i40e/i40e_ethtool.o:i40e_ethtool.c:(.text+0x5e20): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64499 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180907/43644654/attachment-0001.bin>
