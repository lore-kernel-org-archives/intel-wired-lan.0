From: kernel test robot <lkp@intel.com>
Date: Wed, 02 Mar 2022 16:24:16 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:40GbE] BUILD SUCCESS
 0a62b2098987ca690070eff2374eee126118af77
Message-ID: <621f29b0.SM93/Si5tmAIXYqS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 40GbE
branch HEAD: 0a62b2098987ca690070eff2374eee126118af77  iavf: Remove non-inclusive language

elapsed time: 722m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
sh                          kfr2r09_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc837x_mds_defconfig
sh                     magicpanelr2_defconfig
powerpc                         ps3_defconfig
arm                       multi_v4t_defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
arm                          iop32x_defconfig
arc                    vdk_hs38_smp_defconfig
arm                     eseries_pxa_defconfig
mips                        vocore2_defconfig
powerpc                      mgcoge_defconfig
arm                          gemini_defconfig
sh                          polaris_defconfig
sh                        sh7757lcr_defconfig
sh                          urquell_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
h8300                            alldefconfig
arm                       imx_v6_v7_defconfig
m68k                          multi_defconfig
arc                           tb10x_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20220301
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     mpc5200_defconfig
arm                                 defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     powernv_defconfig
arm                     davinci_all_defconfig
powerpc                      pmac32_defconfig
mips                            e55_defconfig
powerpc                          g5_defconfig
powerpc                     mpc512x_defconfig
arm                        spear3xx_defconfig
powerpc                    ge_imp3a_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
