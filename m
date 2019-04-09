From: kbuild test robot <lkp@intel.com>
Date: Wed, 10 Apr 2019 04:33:08 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/93] ERROR:
 "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
Message-ID: <201904100404.991wuqNy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7d150c75aed54f069f2bac6385ef3ffe8f6b8ddf
commit: e5ce07e126190433f802dffacf5013dc19f8c1e5 [91/93] ixgbe: implement support for SDP/PPS output on X550 hardware
config: i386-randconfig-i1-201914 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout e5ce07e126190433f802dffacf5013dc19f8c1e5
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29461 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190410/f42e2f49/attachment-0001.bin>
