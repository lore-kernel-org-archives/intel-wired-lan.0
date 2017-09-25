From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 25 Sep 2017 23:27:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 103/109] ERROR:
 "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
Message-ID: <201709252332.9DgWIvGW%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   1f147da0a4ea86c8634c23faa5ac1fcd59fbadb8
commit: fb5b9ae97b5be1b46c6602cb19c8c31483805698 [103/109] i40e: Refactor VF BW rate limiting
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout fb5b9ae97b5be1b46c6602cb19c8c31483805698
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63992 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170925/48995780/attachment-0001.bin>
