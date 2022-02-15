From: kernel test robot <lkp@intel.com>
Date: Tue, 15 Feb 2022 15:25:17 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 d206823813087e50d4d4ac0ec7c982ea3a54c146
Message-ID: <620b555d.h0b+PF+vY3+eRD3x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: d206823813087e50d4d4ac0ec7c982ea3a54c146  ice: fix concurrent reset and removal of VFs

elapsed time: 738m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220214
mips                 randconfig-c004-20220214
nios2                            alldefconfig
sh                          r7780mp_defconfig
sh                            titan_defconfig
ia64                         bigsur_defconfig
powerpc                   motionpro_defconfig
powerpc                     asp8347_defconfig
arm                          lpd270_defconfig
xtensa                         virt_defconfig
arc                     haps_hs_smp_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
sh                     magicpanelr2_defconfig
mips                          rb532_defconfig
parisc                              defconfig
sh                           se7751_defconfig
powerpc                       maple_defconfig
parisc                           alldefconfig
microblaze                          defconfig
sparc                               defconfig
arm64                            alldefconfig
arm                        mvebu_v7_defconfig
m68k                          hp300_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
sh                           se7721_defconfig
powerpc                           allnoconfig
arm                         lpc18xx_defconfig
powerpc                      bamboo_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20220214
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
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220214
i386                 randconfig-c001-20220214
powerpc              randconfig-c003-20220214
arm                  randconfig-c002-20220214
mips                 randconfig-c004-20220214
x86_64               randconfig-c007-20220214
arm                         lpc32xx_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                        workpad_defconfig
arm                         s3c2410_defconfig
powerpc                     ppa8548_defconfig
mips                          ath25_defconfig
powerpc                     mpc5200_defconfig
arm                  colibri_pxa300_defconfig
arm                         bcm2835_defconfig
mips                     cu1830-neo_defconfig
arm                       spear13xx_defconfig
arm                       aspeed_g4_defconfig
arm                          pcm027_defconfig
mips                         tb0287_defconfig
arm                          moxart_defconfig
powerpc                    gamecube_defconfig
mips                     loongson2k_defconfig
arm                       netwinder_defconfig
arm                       versatile_defconfig
powerpc                      ppc44x_defconfig
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
i386                 randconfig-a002-20220214
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
