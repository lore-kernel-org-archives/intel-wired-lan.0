From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 31 Mar 2016 11:59:23 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 96/98] ERROR:
 "__bad_udelay" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
Message-ID: <201603311122.yRzxdoCp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   62c49de14a0d4c9804cf5105d38a4199be524518
commit: 0d336745706a44425ee5bcdb098221e565d857c2 [96/98] ixgbe: Add support for x550em_a 10G MAC type
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0d336745706a44425ee5bcdb098221e565d857c2
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "__bad_udelay" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56942 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160331/ba90c077/attachment-0001.obj>
