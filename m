From: kernel test robot <lkp@intel.com>
Date: Thu, 24 Feb 2022 20:37:44 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 859ca48e6262e340023ac5cdbe1e6c8763243bc1
Message-ID: <62177c18.QcA7HuJGSNq1myKc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 859ca48e6262e340023ac5cdbe1e6c8763243bc1  ice: remove PF pointer from ice_check_vf_init

elapsed time: 724m

configs tested: 131
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220223
sh                             sh03_defconfig
sh                          sdk7780_defconfig
arm                            pleb_defconfig
powerpc                      bamboo_defconfig
sh                             espt_defconfig
arc                              alldefconfig
sh                          rsk7201_defconfig
sh                          r7780mp_defconfig
sh                           se7724_defconfig
mips                           xway_defconfig
arm                            hisi_defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7269_defconfig
mips                           jazz_defconfig
sh                        sh7763rdp_defconfig
sh                            migor_defconfig
powerpc                      makalu_defconfig
arm                       aspeed_g5_defconfig
powerpc                     tqm8555_defconfig
powerpc                     redwood_defconfig
powerpc                      pasemi_defconfig
sh                     magicpanelr2_defconfig
powerpc                      ep88xc_defconfig
ia64                             alldefconfig
arm                           viper_defconfig
sh                        sh7785lcr_defconfig
nios2                               defconfig
csky                                defconfig
arm                           tegra_defconfig
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
s390                 randconfig-r044-20220224
arc                  randconfig-r043-20220224
riscv                randconfig-r042-20220224
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
powerpc              randconfig-c003-20220224
powerpc              randconfig-c003-20220223
x86_64                        randconfig-c007
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
mips                 randconfig-c004-20220224
mips                 randconfig-c004-20220223
i386                          randconfig-c001
riscv                randconfig-c006-20220223
riscv                randconfig-c006-20220224
powerpc                      walnut_defconfig
arm                           omap1_defconfig
powerpc                        icon_defconfig
powerpc                      obs600_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
arm                         bcm2835_defconfig
arm                           spitz_defconfig
powerpc                      ppc44x_defconfig
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        neponset_defconfig
arm                          moxart_defconfig
mips                        maltaup_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220223
hexagon              randconfig-r041-20220223
riscv                randconfig-r042-20220223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
