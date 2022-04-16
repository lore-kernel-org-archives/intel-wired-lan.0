From: kernel test robot <lkp@intel.com>
Date: Sun, 17 Apr 2022 02:36:06 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 135e9e05924290c0416ae187444b106d207b5fb6
Message-ID: <625b0c96.9kIy+VfZHItQ32um%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 135e9e05924290c0416ae187444b106d207b5fb6  ice: Fix race during aux device (un)plugging

elapsed time: 1142m

configs tested: 127
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
powerpc              randconfig-c003-20220414
s390                          debug_defconfig
openrisc                         alldefconfig
arm                            xcep_defconfig
powerpc                      tqm8xx_defconfig
sh                          polaris_defconfig
m68k                             allyesconfig
sh                          r7780mp_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
openrisc                            defconfig
sh                           se7724_defconfig
sh                                  defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
arm                           imxrt_defconfig
arm                        shmobile_defconfig
sh                          landisk_defconfig
powerpc64                        alldefconfig
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7722_defconfig
i386                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                   motionpro_defconfig
powerpc                      cm5200_defconfig
arm                            mps2_defconfig
x86_64                              defconfig
powerpc                     tqm8555_defconfig
arc                     haps_hs_smp_defconfig
um                                  defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220415
arm                  randconfig-c002-20220414
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
i386                              debian-10.3
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220414
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
arm                         lpc32xx_defconfig
arm                       mainstone_defconfig
mips                         tb0287_defconfig
i386                             allyesconfig
arm                       aspeed_g4_defconfig
arm                          ixp4xx_defconfig
mips                          malta_defconfig
powerpc                     pseries_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                  colibri_pxa300_defconfig
arm                       imx_v4_v5_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220414
s390                 randconfig-r044-20220414
hexagon              randconfig-r045-20220414
riscv                randconfig-r042-20220414

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
