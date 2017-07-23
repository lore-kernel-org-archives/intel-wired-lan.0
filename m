From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 23 Jul 2017 14:58:52 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 78/101] ERROR:
 "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
Message-ID: <201707231451.SEgUsR3R%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   94e0787e2073e3d2b826a4ba35adfcfa7c727f31
commit: 853571d07cc6206862951f1984afaf14822a9a12 [78/101] i40e: Refactor VF BW rate limiting function to be reused on the PF as well
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 853571d07cc6206862951f1984afaf14822a9a12
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60927 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170723/b90ac35b/attachment-0001.bin>
