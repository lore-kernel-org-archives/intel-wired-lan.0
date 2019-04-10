From: kbuild test robot <lkp@intel.com>
Date: Wed, 10 Apr 2019 09:00:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 91/92] ERROR:
 "__aeabi_uldivmod" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
Message-ID: <201904100938.syQPKPsW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   1fb63ba6081fcff6e3749feb161ec011458d3072
commit: e5ce07e126190433f802dffacf5013dc19f8c1e5 [91/92] ixgbe: implement support for SDP/PPS output on X550 hardware
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e5ce07e126190433f802dffacf5013dc19f8c1e5
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 68340 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190410/4fd7c077/attachment-0001.bin>
