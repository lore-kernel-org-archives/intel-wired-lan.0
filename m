From: kbuild test robot <lkp@intel.com>
Date: Fri, 12 Apr 2019 09:24:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE 575/594] ERROR:
 "__divdi3" [net/sched/sch_taprio.ko] undefined!
Message-ID: <201904120952.xfjck5v8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git 100GbE
head:   d179065ab4587ac5b0d6af3541a332006e231029
commit: 7b9eba7ba0c1b24df42b70b62d154b284befbccf [575/594] net/sched: taprio: fix picos_per_byte miscalculation
config: m68k-allmodconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 7b9eba7ba0c1b24df42b70b62d154b284befbccf
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

>> ERROR: "__divdi3" [net/sched/sch_taprio.ko] undefined!

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48603 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190412/885461b2/attachment-0001.bin>
