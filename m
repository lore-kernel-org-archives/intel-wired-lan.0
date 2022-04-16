From: kernel test robot <lkp@intel.com>
Date: Sat, 16 Apr 2022 19:39:40 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 d08ed852560eb71445547f3df7b05bf5c5c69cc4
Message-ID: <625aaafc.qP6WPEJRnUql2tEX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: d08ed852560eb71445547f3df7b05bf5c5c69cc4  net: lan966x: Make sure to release ptp interrupt

elapsed time: 730m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                     taishan_defconfig
arc                           tb10x_defconfig
m68k                           sun3_defconfig
powerpc                       eiger_defconfig
powerpc                 linkstation_defconfig
m68k                          sun3x_defconfig
powerpc                        cell_defconfig
xtensa                    smp_lx200_defconfig
s390                          debug_defconfig
powerpc                 mpc834x_itx_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                   motionpro_defconfig
powerpc                      cm5200_defconfig
arm                            mps2_defconfig
um                                  defconfig
arc                     haps_hs_smp_defconfig
x86_64                              defconfig
powerpc                     tqm8555_defconfig
arm                  randconfig-c002-20220414
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nios2                               defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arc                  randconfig-r043-20220415
s390                 randconfig-r044-20220415
riscv                randconfig-r042-20220415
arc                  randconfig-r043-20220414
arc                  randconfig-r043-20220416
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220414
arm                  randconfig-c002-20220414
i386                          randconfig-c001
powerpc                      ppc64e_defconfig
mips                     cu1000-neo_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
hexagon              randconfig-r045-20220415
hexagon              randconfig-r041-20220415
hexagon              randconfig-r041-20220414
riscv                randconfig-r042-20220414
s390                 randconfig-r044-20220414
s390                 randconfig-r044-20220416
hexagon              randconfig-r041-20220416
hexagon              randconfig-r045-20220416
riscv                randconfig-r042-20220416
hexagon              randconfig-r045-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
