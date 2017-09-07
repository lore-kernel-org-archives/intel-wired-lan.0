From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 7 Sep 2017 13:18:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 84/86] ERROR:
 "__bad_cmpxchg" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
Message-ID: <201709071323.ZN4PPVep%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jacob,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   c0b59b2886df475ed66cf9a6bfc46dbf514a327f
commit: 9cf7ec23684982ae9304c7eb01047e25f3edf07d [84/86] i40e/i40evf: organize and re-number feature flags
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9cf7ec23684982ae9304c7eb01047e25f3edf07d
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   ERROR: "__aeabi_uldivmod" [net/netfilter/xt_hashlimit.ko] undefined!
>> ERROR: "__bad_cmpxchg" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63770 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170907/5b6a69eb/attachment-0001.bin>
