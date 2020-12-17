From: kernel test robot <lkp@intel.com>
Date: Thu, 17 Dec 2020 23:27:38 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 WARNING c929b995e9037188f8ebd7f2f8df8b60da940e0d
Message-ID: <5fdb78ea.PVURzvw4QpiKPLg1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  dev-queue
branch HEAD: c929b995e9037188f8ebd7f2f8df8b60da940e0d  i40e, xsk: Simplify the do-while allocation loop

Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_dcb.c:1639:6: warning: 'mfs_max' is used uninitialized in this function [-Wuninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:547:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arc-randconfig-r036-20201217
|   `-- drivers-net-ethernet-intel-i40e-i40e_dcb.c:warning:mfs_max-is-used-uninitialized-in-this-function
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- parisc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- powerpc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- riscv-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- s390-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used

elapsed time: 720m

configs tested: 121
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                                 defconfig
mips                        jmr3927_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
xtensa                  nommu_kc705_defconfig
ia64                             allmodconfig
sh                      rts7751r2d1_defconfig
arm                           h3600_defconfig
m68k                        stmark2_defconfig
sh                        sh7757lcr_defconfig
mips                  cavium_octeon_defconfig
arm                       mainstone_defconfig
sh                   sh7724_generic_defconfig
arm                           sama5_defconfig
h8300                    h8300h-sim_defconfig
arm                         orion5x_defconfig
powerpc                    adder875_defconfig
sh                             espt_defconfig
sparc                       sparc32_defconfig
powerpc                     akebono_defconfig
mips                      fuloong2e_defconfig
powerpc                      cm5200_defconfig
sh                        apsh4ad0a_defconfig
arm                          ep93xx_defconfig
m68k                           sun3_defconfig
arm                         hackkit_defconfig
powerpc                      pcm030_defconfig
mips                     decstation_defconfig
arm                             ezx_defconfig
mips                        vocore2_defconfig
mips                           ip22_defconfig
ia64                          tiger_defconfig
arc                           tb10x_defconfig
xtensa                       common_defconfig
arm                          pxa168_defconfig
mips                        nlm_xlp_defconfig
nios2                               defconfig
arm                          moxart_defconfig
mips                           rs90_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       maple_defconfig
arm                         s3c6400_defconfig
sh                          sdk7786_defconfig
powerpc                     ppa8548_defconfig
powerpc                      ppc44x_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
