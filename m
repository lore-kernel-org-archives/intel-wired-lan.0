From: kernel test robot <lkp@intel.com>
Date: Thu, 25 Nov 2021 15:57:12 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 94/108]
 ice_gnss.c:undefined reference to `tty_buffer_request_room'
Message-ID: <202111251527.xSdxs2Xm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   1bc0d12c31e7e35dcb167e62c8bcde3c7c09d95d
commit: d837bf714865bcefbf83c3f4e7b886a50ecda8b1 [94/108] ice: add TTY for GNSS module for E810T device
config: arm64-buildonly-randconfig-r003-20211125 (https://download.01.org/0day-ci/archive/20211125/202111251527.xSdxs2Xm-lkp at intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=d837bf714865bcefbf83c3f4e7b886a50ecda8b1
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout d837bf714865bcefbf83c3f4e7b886a50ecda8b1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: in function `ice_gnss_read':
>> ice_gnss.c:(.text+0x204): undefined reference to `tty_buffer_request_room'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x270): undefined reference to `tty_insert_flip_string_fixed_flag'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x278): undefined reference to `tty_flip_buffer_push'
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: in function `ice_gnss_create_tty_driver':
>> ice_gnss.c:(.text+0x300): undefined reference to `__tty_alloc_driver'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x3c0): undefined reference to `tty_std_termios'
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `tty_std_termios' which may bind externally can not be used when making a shared object; recompile with -fPIC
   ice_gnss.c:(.text+0x3c0): dangerous relocation: unsupported relocation
   aarch64-linux-ld: ice_gnss.c:(.text+0x3c4): undefined reference to `tty_std_termios'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x488): undefined reference to `tty_termios_encode_baud_rate'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4b4): undefined reference to `tty_port_init'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4c4): undefined reference to `tty_port_link_device'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4cc): undefined reference to `tty_register_driver'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4d8): undefined reference to `tty_port_destroy'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4f4): undefined reference to `tty_driver_kref_put'
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: in function `ice_gnss_exit':
>> ice_gnss.c:(.text+0x7b4): undefined reference to `tty_port_destroy'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x7f0): undefined reference to `tty_unregister_driver'
   aarch64-linux-ld: ice_gnss.c:(.text+0x81c): undefined reference to `tty_driver_kref_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
