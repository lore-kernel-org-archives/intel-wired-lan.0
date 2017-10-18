From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 19 Oct 2017 07:00:33 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 37/39] ERROR:
 "__divdi3" [net/sched/sch_cbs.ko] undefined!
Message-ID: <201710190729.zc2JyfBZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   88a7d465ca675dbd825299a37c6f9dd52035403c
commit: a5e3a5e6c2eafeeeb4efe6a8339afb8bfd94b4fe [37/39] net/sched: Introduce Credit Based Shaper (CBS) qdisc
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout a5e3a5e6c2eafeeeb4efe6a8339afb8bfd94b4fe
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> ERROR: "__divdi3" [net/sched/sch_cbs.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61884 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171019/6e185700/attachment-0001.bin>
