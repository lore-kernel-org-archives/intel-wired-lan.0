From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 27 Jul 2016 01:56:08 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 30/30]
 drivers/net/ethernet/intel/e1000e/ich8lan.c:5889:9: error:
 'FLAGS2_CHECK_SYSTIM_OVERFLOW' undeclared here (not in a function)
Message-ID: <201607270106.9yzqfevE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   f694b9029f5afb5bfa03d09f1eef39a845c382ed
commit: f694b9029f5afb5bfa03d09f1eef39a845c382ed [30/30] e1000e: convert systim overflow check to use flags2
config: x86_64-randconfig-x011-201630 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        git checkout f694b9029f5afb5bfa03d09f1eef39a845c382ed
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/e1000e/ich8lan.c:5889:9: error: 'FLAGS2_CHECK_SYSTIM_OVERFLOW' undeclared here (not in a function)
          | FLAGS2_CHECK_SYSTIM_OVERFLOW,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/FLAGS2_CHECK_SYSTIM_OVERFLOW +5889 drivers/net/ethernet/intel/e1000e/ich8lan.c

  5883					  | FLAG_HAS_AMT
  5884					  | FLAG_HAS_FLASH
  5885					  | FLAG_HAS_JUMBO_FRAMES
  5886					  | FLAG_APME_IN_WUC,
  5887		.flags2			= FLAG2_HAS_PHY_STATS
  5888					  | FLAG2_HAS_EEE
> 5889					  | FLAGS2_CHECK_SYSTIM_OVERFLOW,
  5890		.pba			= 26,
  5891		.max_hw_frame_size	= 9022,
  5892		.get_variants		= e1000_get_variants_ich8lan,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 26488 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160727/cc459e6b/attachment-0001.obj>
