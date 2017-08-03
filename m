From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 3 Aug 2017 09:46:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 20/86] ERROR:
 "__cmpxchg_u64" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
Message-ID: <201708030920.z9cJ1omX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Corinna,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   15278d958d1b662a77605c8dc133fe1cacbea04e
commit: 524ab9f5f109d36a2aba84a0b563232aea8582af [20/86] igb: Remove incorrect ""unexpected SYS WRAP" log message
config: parisc-allmodconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 524ab9f5f109d36a2aba84a0b563232aea8582af
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

>> ERROR: "__cmpxchg_u64" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50750 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170803/3aeae5da/attachment-0001.bin>
