From: kernel test robot <lkp@intel.com>
Date: Sat, 22 Jan 2022 18:48:34 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 d69aa713cce12bd6869d4c2ead52ed17edf60dd9
Message-ID: <61ebe102.e0bLmqvjdf/V1vtr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: d69aa713cce12bd6869d4c2ead52ed17edf60dd9  ice: Fix KASAN error in LAG NETDEV_UNREGISTER handler

elapsed time: 727m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220120
nds32                             allnoconfig
sh                        apsh4ad0a_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          polaris_defconfig
m68k                            q40_defconfig
powerpc                  storcenter_defconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
sh                        sh7763rdp_defconfig
arm                           stm32_defconfig
s390                             allmodconfig
arc                          axs103_defconfig
mips                          rb532_defconfig
sh                                  defconfig
sh                          rsk7203_defconfig
sh                           se7206_defconfig
parisc                generic-32bit_defconfig
xtensa                  cadence_csp_defconfig
m68k                         apollo_defconfig
x86_64                           alldefconfig
arm                           tegra_defconfig
nios2                               defconfig
mips                           gcw0_defconfig
nios2                         10m50_defconfig
mips                             allyesconfig
arm                           h5000_defconfig
arm                          exynos_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
sh                     sh7710voipgw_defconfig
mips                      maltasmvp_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                         wii_defconfig
powerpc                      ppc40x_defconfig
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
arc                              allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220121
arc                  randconfig-r043-20220121
s390                 randconfig-r044-20220121
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
x86_64                        randconfig-c007
arm                  randconfig-c002-20220120
riscv                randconfig-c006-20220120
powerpc              randconfig-c003-20220120
mips                 randconfig-c004-20220120
i386                          randconfig-c001
mips                      maltaaprp_defconfig
arm                         shannon_defconfig
powerpc                   bluestone_defconfig
arm                        vexpress_defconfig
arm                                 defconfig
arm                   milbeaut_m10v_defconfig
powerpc                          allmodconfig
mips                           rs90_defconfig
powerpc                     tqm8540_defconfig
powerpc                      pmac32_defconfig
powerpc                       ebony_defconfig
arm                  colibri_pxa270_defconfig
riscv                            alldefconfig
powerpc                 mpc832x_rdb_defconfig
mips                        bcm63xx_defconfig
powerpc                    mvme5100_defconfig
arm                        spear3xx_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220122
hexagon              randconfig-r045-20220122
hexagon              randconfig-r041-20220122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
