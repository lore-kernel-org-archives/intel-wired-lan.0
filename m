From: kernel test robot <lkp@intel.com>
Date: Thu, 10 Feb 2022 16:15:43 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 c686b8f1ad8b452e9551575f2cc6b04b547a7373
Message-ID: <6204c9af.nbcLpIh6CzhaM2pO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: c686b8f1ad8b452e9551575f2cc6b04b547a7373  ice: fix concurrent reset and removal of VFs

elapsed time: 725m

configs tested: 150
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
powerpc              randconfig-c003-20220210
m68k                          hp300_defconfig
x86_64                              defconfig
powerpc                      ep88xc_defconfig
mips                     loongson1b_defconfig
sh                        edosk7760_defconfig
sh                   secureedge5410_defconfig
m68k                       m5275evb_defconfig
mips                         db1xxx_defconfig
powerpc                        warp_defconfig
xtensa                  nommu_kc705_defconfig
riscv                            allyesconfig
sh                          r7785rp_defconfig
h8300                               defconfig
mips                         cobalt_defconfig
sh                          r7780mp_defconfig
arm                        mvebu_v7_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
sh                              ul2_defconfig
arm                         lpc18xx_defconfig
sh                          polaris_defconfig
m68k                         amcore_defconfig
ia64                             allyesconfig
openrisc                 simple_smp_defconfig
sh                           se7206_defconfig
m68k                             alldefconfig
arm                       aspeed_g5_defconfig
arc                        nsim_700_defconfig
arm                           h3600_defconfig
arm                             ezx_defconfig
sh                           sh2007_defconfig
sh                            hp6xx_defconfig
sh                        dreamcast_defconfig
um                                  defconfig
s390                                defconfig
powerpc                      chrp32_defconfig
m68k                       m5475evb_defconfig
sh                             sh03_defconfig
powerpc                        cell_defconfig
h8300                            allyesconfig
sh                          kfr2r09_defconfig
arm                          badge4_defconfig
h8300                    h8300h-sim_defconfig
mips                      loongson3_defconfig
powerpc                      ppc40x_defconfig
arm                         nhk8815_defconfig
powerpc                    klondike_defconfig
powerpc                       ppc64_defconfig
arc                              alldefconfig
s390                          debug_defconfig
m68k                          amiga_defconfig
openrisc                            defconfig
arm                         vf610m4_defconfig
sh                           se7721_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  randconfig-c002-20220210
arm                  randconfig-c002-20220209
ia64                             allmodconfig
ia64                                defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220209
arc                  randconfig-r043-20220208
arc                  randconfig-r043-20220209
riscv                randconfig-r042-20220210
riscv                randconfig-r042-20220209
arc                  randconfig-r043-20220210
s390                 randconfig-r044-20220210
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220209
riscv                randconfig-c006-20220210
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220209
powerpc              randconfig-c003-20220210
arm                  randconfig-c002-20220210
i386                          randconfig-c001
mips                 randconfig-c004-20220209
mips                 randconfig-c004-20220210
arm                  randconfig-c002-20220209
powerpc                     ksi8560_defconfig
arm                       aspeed_g4_defconfig
mips                            e55_defconfig
arm                        spear3xx_defconfig
powerpc                      ppc44x_defconfig
powerpc                    mvme5100_defconfig
powerpc                     kilauea_defconfig
powerpc                   microwatt_defconfig
riscv                             allnoconfig
powerpc                     mpc512x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220210
hexagon              randconfig-r041-20220210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
