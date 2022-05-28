From: kernel test robot <lkp@intel.com>
Date: Sat, 28 May 2022 13:27:43 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 fe6f053672f543c0818cd76ebb5230cdbcbfb636
Message-ID: <6291b2cf.A3nnlaGpj2JFt2f7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: fe6f053672f543c0818cd76ebb5230cdbcbfb636  igb: Remove duplicate defines

elapsed time: 724m

configs tested: 125
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
m68k                          sun3x_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
parisc64                            defconfig
powerpc64                           defconfig
um                                  defconfig
sh                               alldefconfig
arm                           sama5_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
sh                          r7780mp_defconfig
s390                             allyesconfig
sh                            shmin_defconfig
arm                           u8500_defconfig
sh                           se7712_defconfig
powerpc                      pcm030_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
arm                          pxa910_defconfig
arc                      axs103_smp_defconfig
i386                                defconfig
powerpc                mpc7448_hpc2_defconfig
sh                     magicpanelr2_defconfig
arm                  randconfig-c002-20220526
arm                  randconfig-c002-20220524
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220526
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220526
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220526
riscv                randconfig-r042-20220524
arc                  randconfig-r043-20220527
arc                  randconfig-r043-20220525
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220524
x86_64                        randconfig-c007
s390                 randconfig-c005-20220524
i386                          randconfig-c001
powerpc              randconfig-c003-20220524
riscv                randconfig-c006-20220524
mips                 randconfig-c004-20220524
mips                     loongson2k_defconfig
mips                          malta_defconfig
mips                  cavium_octeon_defconfig
mips                           ip22_defconfig
arm                      pxa255-idp_defconfig
arm                       aspeed_g4_defconfig
mips                     cu1830-neo_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220527
hexagon              randconfig-r041-20220527
s390                 randconfig-r044-20220527
riscv                randconfig-r042-20220527

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
