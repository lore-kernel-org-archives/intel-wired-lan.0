From: kernel test robot <lkp@intel.com>
Date: Fri, 04 Sep 2020 13:18:21 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 56823cd9594698aa11c6da0c708517fed65fe60b
Message-ID: <5f51ce1d.rrWJJwu5zXrRWBZn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 56823cd9594698aa11c6da0c708517fed65fe60b  igc: Reject schedules with a base_time in the future

Error/Warning in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2273:15: error: redefinition of 'truesize'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
`-- sparc-allyesconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize

elapsed time: 720m

configs tested: 138
configs skipped: 11

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
xtensa                generic_kc705_defconfig
sparc                               defconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     powernv_defconfig
arm                            lart_defconfig
sh                          rsk7203_defconfig
mips                      fuloong2e_defconfig
mips                            ar7_defconfig
arm                         lpc32xx_defconfig
powerpc                        cell_defconfig
mips                        workpad_defconfig
openrisc                         alldefconfig
powerpc                      ep88xc_defconfig
arm                           viper_defconfig
um                            kunit_defconfig
sh                          r7780mp_defconfig
powerpc                          g5_defconfig
um                             i386_defconfig
sh                            shmin_defconfig
powerpc                         ps3_defconfig
powerpc                    mvme5100_defconfig
sh                           se7780_defconfig
arc                        vdk_hs38_defconfig
mips                           rs90_defconfig
mips                         tb0226_defconfig
ia64                             allmodconfig
mips                         bigsur_defconfig
arm                         lubbock_defconfig
arm                            hisi_defconfig
sh                         ap325rxa_defconfig
arc                                 defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
arm                    vt8500_v6_v7_defconfig
alpha                            alldefconfig
x86_64                              defconfig
sh                               alldefconfig
powerpc                     ep8248e_defconfig
arm                          imote2_defconfig
sh                          urquell_defconfig
powerpc64                           defconfig
mips                        nlm_xlr_defconfig
powerpc                     mpc512x_defconfig
mips                         tb0287_defconfig
powerpc                       maple_defconfig
powerpc                      ppc64e_defconfig
openrisc                 simple_smp_defconfig
sh                   sh7724_generic_defconfig
mips                           mtx1_defconfig
arm                           stm32_defconfig
microblaze                    nommu_defconfig
sh                          lboxre2_defconfig
arm                        spear6xx_defconfig
arc                             nps_defconfig
arm                        keystone_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200902
i386                 randconfig-a005-20200902
i386                 randconfig-a006-20200902
i386                 randconfig-a002-20200902
i386                 randconfig-a001-20200902
i386                 randconfig-a003-20200902
x86_64               randconfig-a013-20200902
x86_64               randconfig-a016-20200902
x86_64               randconfig-a011-20200902
x86_64               randconfig-a012-20200902
x86_64               randconfig-a015-20200902
x86_64               randconfig-a014-20200902
i386                 randconfig-a016-20200903
i386                 randconfig-a015-20200903
i386                 randconfig-a011-20200903
i386                 randconfig-a013-20200903
i386                 randconfig-a014-20200903
i386                 randconfig-a012-20200903
i386                 randconfig-a016-20200902
i386                 randconfig-a015-20200902
i386                 randconfig-a011-20200902
i386                 randconfig-a013-20200902
i386                 randconfig-a014-20200902
i386                 randconfig-a012-20200902
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20200902
x86_64               randconfig-a006-20200902
x86_64               randconfig-a003-20200902
x86_64               randconfig-a005-20200902
x86_64               randconfig-a001-20200902
x86_64               randconfig-a002-20200902
x86_64               randconfig-a013-20200903
x86_64               randconfig-a016-20200903
x86_64               randconfig-a011-20200903
x86_64               randconfig-a012-20200903
x86_64               randconfig-a015-20200903
x86_64               randconfig-a014-20200903

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
