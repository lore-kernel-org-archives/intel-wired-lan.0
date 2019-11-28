From: kbuild test robot <lkp@intel.com>
Date: Thu, 28 Nov 2019 17:40:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 39/39] make[6]:
 *** No rule to make target 'drivers/net/ethernet/intel/igc/igc_ptp.o',
 needed by 'drivers/net/ethernet/intel/igc/built-in.a'.
Message-ID: <201911281728.FDyIKJ1i%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ce1c9d877445c0fb1fc4f3b20d28f6c5ee08e6df
commit: ce1c9d877445c0fb1fc4f3b20d28f6c5ee08e6df [39/39] igc: Add basic skeleton for PTP
config: x86_64-randconfig-s1-20191128 (attached as .config)
compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
reproduce:
        git checkout ce1c9d877445c0fb1fc4f3b20d28f6c5ee08e6df
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[6]: *** No rule to make target 'drivers/net/ethernet/intel/igc/igc_ptp.o', needed by 'drivers/net/ethernet/intel/igc/built-in.a'.
   make[6]: Target '__build' not remade because of errors.

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32280 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191128/8b9b941c/attachment-0001.bin>
