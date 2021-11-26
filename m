From: kernel test robot <lkp@intel.com>
Date: Fri, 26 Nov 2021 22:45:59 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 1bc0d12c31e7e35dcb167e62c8bcde3c7c09d95d
Message-ID: <61a0f327.yzRGavxJ7WKkXxHo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 1bc0d12c31e7e35dcb167e62c8bcde3c7c09d95d  ixgbevf: switch to napi_build_skb()

Error/Warning reports:

https://lore.kernel.org/lkml/202111251527.xSdxs2Xm-lkp at intel.com

possible Error/Warning in current branch (please contact us if interested):

aarch64-linux-ld: ice_gnss.c:(.text+0x270): undefined reference to `tty_insert_flip_string_fixed_flag'
aarch64-linux-ld: ice_gnss.c:(.text+0x278): undefined reference to `tty_flip_buffer_push'
aarch64-linux-ld: ice_gnss.c:(.text+0x3c0): undefined reference to `tty_std_termios'
aarch64-linux-ld: ice_gnss.c:(.text+0x488): undefined reference to `tty_termios_encode_baud_rate'
aarch64-linux-ld: ice_gnss.c:(.text+0x4b4): undefined reference to `tty_port_init'
aarch64-linux-ld: ice_gnss.c:(.text+0x4c4): undefined reference to `tty_port_link_device'
aarch64-linux-ld: ice_gnss.c:(.text+0x4cc): undefined reference to `tty_register_driver'
aarch64-linux-ld: ice_gnss.c:(.text+0x4d8): undefined reference to `tty_port_destroy'
aarch64-linux-ld: ice_gnss.c:(.text+0x4f4): undefined reference to `tty_driver_kref_put'
aarch64-linux-ld: ice_gnss.c:(.text+0x7f0): undefined reference to `tty_unregister_driver'
ice_gnss.c:(.text+0x204): undefined reference to `tty_buffer_request_room'
ice_gnss.c:(.text+0x300): undefined reference to `__tty_alloc_driver'
ice_gnss.c:(.text+0x7b4): undefined reference to `tty_port_destroy'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm64-buildonly-randconfig-r003-20211125
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_driver_kref_put
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_flip_buffer_push
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_insert_flip_string_fixed_flag
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_port_destroy
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_port_init
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_port_link_device
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_register_driver
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_std_termios
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_termios_encode_baud_rate
    |-- aarch64-linux-ld:ice_gnss.c:(.text):undefined-reference-to-tty_unregister_driver
    |-- ice_gnss.c:(.text):undefined-reference-to-__tty_alloc_driver
    |-- ice_gnss.c:(.text):undefined-reference-to-tty_buffer_request_room
    `-- ice_gnss.c:(.text):undefined-reference-to-tty_port_destroy

elapsed time: 2687m

configs tested: 59
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20211125
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
arc                  randconfig-r043-20211124
riscv                randconfig-r042-20211124
s390                 randconfig-r044-20211124
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
hexagon              randconfig-r045-20211124
hexagon              randconfig-r041-20211124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
