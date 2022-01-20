From: kernel test robot <lkp@intel.com>
Date: Thu, 20 Jan 2022 15:04:59 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 ff9fc0a31d85fcf0011eb4bc4ecaf47d3cc9e21c
Message-ID: <61e9099b.kdvRn5xFhKekS6dI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: ff9fc0a31d85fcf0011eb4bc4ecaf47d3cc9e21c  Merge branch 'ipv4-avoid-pathological-hash-tables'

elapsed time: 798m

configs tested: 164
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        vdk_hs38_defconfig
m68k                            q40_defconfig
sh                ecovec24-romimage_defconfig
mips                             allmodconfig
arc                         haps_hs_defconfig
sh                             espt_defconfig
nios2                            alldefconfig
sh                         ap325rxa_defconfig
sh                          urquell_defconfig
arc                           tb10x_defconfig
mips                         mpc30x_defconfig
sh                         ecovec24_defconfig
arm                         cm_x300_defconfig
arm                         lpc18xx_defconfig
arc                      axs103_smp_defconfig
powerpc                     asp8347_defconfig
xtensa                       common_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                   currituck_defconfig
riscv                            allmodconfig
sh                          rsk7201_defconfig
sh                          sdk7780_defconfig
powerpc                     sequoia_defconfig
xtensa                  nommu_kc705_defconfig
arm                            lart_defconfig
sh                          r7780mp_defconfig
xtensa                           allyesconfig
mips                           ip32_defconfig
arm                      integrator_defconfig
openrisc                 simple_smp_defconfig
sh                             sh03_defconfig
csky                             alldefconfig
m68k                          atari_defconfig
sh                           se7619_defconfig
xtensa                generic_kc705_defconfig
sh                          r7785rp_defconfig
x86_64                           alldefconfig
arc                     haps_hs_smp_defconfig
sh                          lboxre2_defconfig
powerpc                      pcm030_defconfig
h8300                            allyesconfig
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
arm                  randconfig-c002-20220120
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a012-20220117
i386                 randconfig-a016-20220117
i386                 randconfig-a014-20220117
i386                 randconfig-a015-20220117
i386                 randconfig-a011-20220117
i386                 randconfig-a013-20220117
riscv                randconfig-r042-20220119
riscv                randconfig-r042-20220117
arc                  randconfig-r043-20220116
arc                  randconfig-r043-20220117
s390                 randconfig-r044-20220119
s390                 randconfig-r044-20220117
arc                  randconfig-r043-20220118
arc                  randconfig-r043-20220119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                 mpc836x_rdk_defconfig
arm                         shannon_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     cu1000-neo_defconfig
powerpc                     ksi8560_defconfig
powerpc                  mpc885_ads_defconfig
arm                         s5pv210_defconfig
arm                     am200epdkit_defconfig
powerpc                     ppa8548_defconfig
mips                     loongson2k_defconfig
mips                malta_qemu_32r6_defconfig
mips                           ip22_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220118
hexagon              randconfig-r045-20220116
hexagon              randconfig-r045-20220117
hexagon              randconfig-r045-20220118
hexagon              randconfig-r045-20220119
riscv                randconfig-r042-20220116
hexagon              randconfig-r041-20220118
hexagon              randconfig-r041-20220119
s390                 randconfig-r044-20220118
s390                 randconfig-r044-20220116
hexagon              randconfig-r041-20220116
hexagon              randconfig-r041-20220117
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
