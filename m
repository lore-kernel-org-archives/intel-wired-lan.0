From: kbuild test robot <lkp@intel.com>
Date: Wed, 12 Jul 2017 06:32:57 +0800
Subject: [Intel-wired-lan] [PATCH 5/6] [next-queue]net: i40e: Refactor
 VF BW rate limiting function to be reused on the PF as well
In-Reply-To: <149976833611.2896.14684072908307834234.stgit@anamdev.jf.intel.com>
Message-ID: <201707120606.yM4kSXlx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Amritha,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.12 next-20170711]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Amritha-Nambiar/Configuring-traffic-classes-via-new-hardware-offload-mechanism-in-tc-mqprio/20170711-215943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   ERROR: "__udivdi3" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!
>> ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60446 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170712/704bf57b/attachment-0001.bin>
