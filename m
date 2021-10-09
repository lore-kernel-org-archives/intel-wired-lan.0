From: kernel test robot <lkp@intel.com>
Date: Sun, 10 Oct 2021 04:42:49 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 117/129]
 ice_main.c:undefined reference to `ice_gnss_exit'
Message-ID: <202110100446.b8Uk47Yx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   45f840993bd1843d39fc79a01eab2995a290ad4b
commit: 89614a6907441033da91287488be6bfe91ec3e67 [117/129] ice: add TTY device for GNSS module for E810T device
config: csky-randconfig-r031-20211009 (attached as .config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=89614a6907441033da91287488be6bfe91ec3e67
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 89614a6907441033da91287488be6bfe91ec3e67
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_prepare_for_reset':
>> ice_main.c:(.text+0x310e): undefined reference to `ice_gnss_exit'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_load_pkg':
   ice_main.c:(.text+0x3174): undefined reference to `ice_gnss_exit'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_remove':
   ice_main.c:(.text+0x379c): undefined reference to `ice_gnss_exit'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_shutdown':
   ice_main.c:(.text+0x3820): undefined reference to `ice_gnss_exit'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_rebuild':
>> ice_main.c:(.text+0x3b10): undefined reference to `ice_gnss_init'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_do_reset':
   ice_main.c:(.text+0x3c68): undefined reference to `ice_gnss_init'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_main.o: in function `ice_probe':
   ice_main.c:(.text+0x7bda): undefined reference to `ice_gnss_init'
>> csky-linux-ld: ice_main.c:(.text+0x7c30): undefined reference to `ice_gnss_init'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_lib.o: in function `ice_init_feature_support':
>> ice_lib.c:(.text+0x35b2): undefined reference to `ice_gnss_is_gps_present'
   csky-linux-ld: drivers/net/ethernet/intel/ice/ice_lib.o: in function `ice_vsi_ctx_set_antispoof':
   ice_lib.c:(.text+0x3650): undefined reference to `ice_gnss_is_gps_present'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41092 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211010/e8cab599/attachment-0001.bin>
