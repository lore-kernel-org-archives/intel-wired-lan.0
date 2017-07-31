From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 31 Jul 2017 21:37:49 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 62/86] ERROR:
 "__udivdi3" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
Message-ID: <201707312144.QQdcXQQs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jacob,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   15278d958d1b662a77605c8dc133fe1cacbea04e
commit: f6e1b4408c77ad5cc1407631905fd9edfff91594 [62/86] i40e: remove workaround for resetting XPS on newer kernels
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout f6e1b4408c77ad5cc1407631905fd9edfff91594
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
Size: 61068 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170731/532a89e9/attachment-0001.bin>
