From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 18 Jul 2017 11:04:55 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 55/147]
 net/core/filter.c:undefined reference to `__dev_map_lookup_elem'
Message-ID: <201707181120.25Vx2o6E%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a6883c63dd1a60482d881feabb784f43145e128f
commit: 97f91a7cf04ff605845c20948b8a80e54cbd3376 [55/147] bpf: add bpf_redirect_map helper routine
config: blackfin-TCM-BF537_defconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 97f91a7cf04ff605845c20948b8a80e54cbd3376
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All errors (new ones prefixed by >>):

   net/core/filter.o: In function `xdp_do_redirect_map':
>> net/core/filter.c:(.text+0x40d6): undefined reference to `__dev_map_lookup_elem'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 10985 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170718/e48fbc13/attachment.bin>
