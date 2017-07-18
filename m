From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 18 Jul 2017 10:11:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 55/149]
 (.text.xdp_do_redirect_map+0x2c): undefined reference to
 `__dev_map_lookup_elem'
Message-ID: <201707181045.PcSC3NmJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   c5adb4de1b6d3a3d695e0c2776d84201e4cf009c
commit: 97f91a7cf04ff605845c20948b8a80e54cbd3376 [55/149] bpf: add bpf_redirect_map helper routine
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 97f91a7cf04ff605845c20948b8a80e54cbd3376
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All errors (new ones prefixed by >>):

   net/core/filter.o: In function `xdp_do_redirect_map':
>> (.text.xdp_do_redirect_map+0x2c): undefined reference to `__dev_map_lookup_elem'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 14752 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170718/d4f1717f/attachment-0001.bin>
