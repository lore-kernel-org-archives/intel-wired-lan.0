From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Feb 2022 13:12:01 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 5dbbbd01cbba831233c6ea9a3e6bfa133606d3c0
Message-ID: <6205f021.1XDQ+zY4xiHrXxYI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 5dbbbd01cbba831233c6ea9a3e6bfa133606d3c0  ice: Avoid RTNL lock when re-creating auxiliary device

elapsed time: 721m

configs tested: 151
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
arc                           tb10x_defconfig
mips                       bmips_be_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                            defconfig
mips                 decstation_r4k_defconfig
m68k                          multi_defconfig
nios2                            alldefconfig
powerpc                      pasemi_defconfig
sh                        sh7785lcr_defconfig
sh                          lboxre2_defconfig
arm                       omap2plus_defconfig
arc                    vdk_hs38_smp_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
arm                          simpad_defconfig
parisc                generic-64bit_defconfig
openrisc                 simple_smp_defconfig
arm                        shmobile_defconfig
arm                        mini2440_defconfig
mips                           ip32_defconfig
arm                           h3600_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8541_defconfig
arm                         s3c6400_defconfig
csky                             alldefconfig
arm                     eseries_pxa_defconfig
alpha                            alldefconfig
mips                            gpr_defconfig
riscv                    nommu_k210_defconfig
h8300                     edosk2674_defconfig
parisc                              defconfig
m68k                          hp300_defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
powerpc                 linkstation_defconfig
sh                         microdev_defconfig
arm                        multi_v7_defconfig
openrisc                         alldefconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
m68k                       m5275evb_defconfig
arm                  randconfig-c002-20220211
arm                  randconfig-c002-20220210
arm                  randconfig-c002-20220209
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
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
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a003
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
riscv                randconfig-c006-20220211
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220211
arm                  randconfig-c002-20220211
i386                          randconfig-c001
mips                 randconfig-c004-20220211
riscv                randconfig-c006-20220209
powerpc              randconfig-c003-20220209
mips                 randconfig-c004-20220209
arm                  randconfig-c002-20220209
mips                            e55_defconfig
arm                        mvebu_v5_defconfig
powerpc                      katmai_defconfig
arm                                 defconfig
powerpc                     ksi8560_defconfig
mips                       lemote2f_defconfig
powerpc                     mpc5200_defconfig
powerpc                     akebono_defconfig
powerpc                       ebony_defconfig
mips                      pic32mzda_defconfig
mips                       rbtx49xx_defconfig
powerpc                     kilauea_defconfig
powerpc                     tqm5200_defconfig
arm                           omap1_defconfig
powerpc                      ppc44x_defconfig
powerpc                        icon_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220211
hexagon              randconfig-r041-20220211
riscv                randconfig-r042-20220211
hexagon              randconfig-r045-20220210
hexagon              randconfig-r041-20220210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
