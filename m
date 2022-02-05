From: kernel test robot <lkp@intel.com>
Date: Sat, 05 Feb 2022 19:03:27 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 05dd97705a52bc00d8f4b911fd5b705754743ade
Message-ID: <61fe597f.+mjEpXppfihZh3W2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 05dd97705a52bc00d8f4b911fd5b705754743ade  ice: change "can't set link" message to dbg level

elapsed time: 720m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
sh                             shx3_defconfig
sh                     sh7710voipgw_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                        warp_defconfig
mips                         tb0226_defconfig
openrisc                  or1klitex_defconfig
sparc64                             defconfig
arc                           tb10x_defconfig
sh                           se7206_defconfig
sh                             sh03_defconfig
arm                       aspeed_g5_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
powerpc                      ppc6xx_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
arm                            qcom_defconfig
arm                        oxnas_v6_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc834x_itx_defconfig
arm                          gemini_defconfig
m68k                        mvme147_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
arc                      axs103_smp_defconfig
sh                           se7751_defconfig
openrisc                    or1ksim_defconfig
mips                           gcw0_defconfig
powerpc                    klondike_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
m68k                          multi_defconfig
arm                            zeus_defconfig
powerpc                     redwood_defconfig
sh                              ul2_defconfig
arc                     nsimosci_hs_defconfig
arm                        shmobile_defconfig
m68k                        m5407c3_defconfig
ia64                        generic_defconfig
arm                        mini2440_defconfig
mips                            gpr_defconfig
sh                          polaris_defconfig
sh                           se7780_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           h3600_defconfig
csky                             alldefconfig
mips                         mpc30x_defconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
arm                         axm55xx_defconfig
powerpc                     rainier_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
arm                  randconfig-c002-20220205
arm                  randconfig-c002-20220204
arm                  randconfig-c002-20220202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                                defconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
s390                 randconfig-r044-20220130
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
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                 mpc832x_rdb_defconfig
mips                         tb0287_defconfig
powerpc                     skiroot_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r041-20220130
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
