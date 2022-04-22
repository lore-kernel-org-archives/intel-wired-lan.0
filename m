From: kernel test robot <lkp@intel.com>
Date: Fri, 22 Apr 2022 11:03:44 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 aa81e73a7797ffcb0b94d9aefb4898e15ea8d5fa
Message-ID: <62621b10.ZC8QGfu5X03Mwoyw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: aa81e73a7797ffcb0b94d9aefb4898e15ea8d5fa  i40e: i40e_main: fix a missing check on list iterator

elapsed time: 1992m

configs tested: 145
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
ia64                          tiger_defconfig
powerpc                     sequoia_defconfig
arm                          exynos_defconfig
arc                                 defconfig
powerpc                     asp8347_defconfig
sh                           se7712_defconfig
sh                        apsh4ad0a_defconfig
mips                         cobalt_defconfig
arm                            qcom_defconfig
arm                        trizeps4_defconfig
m68k                          hp300_defconfig
sh                                  defconfig
arc                      axs103_smp_defconfig
powerpc                     ep8248e_defconfig
sh                   sh7724_generic_defconfig
powerpc                       ppc64_defconfig
sh                          rsk7269_defconfig
mips                     loongson1b_defconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
arm                        keystone_defconfig
powerpc                  storcenter_defconfig
powerpc64                           defconfig
parisc                           alldefconfig
m68k                       m5208evb_defconfig
powerpc                      pcm030_defconfig
xtensa                    smp_lx200_defconfig
s390                             allyesconfig
mips                        bcm47xx_defconfig
sh                          polaris_defconfig
arm                        spear6xx_defconfig
mips                            ar7_defconfig
powerpc                     pq2fads_defconfig
sparc64                             defconfig
arm                          iop32x_defconfig
arm                         assabet_defconfig
sh                   secureedge5410_defconfig
sh                   rts7751r2dplus_defconfig
h8300                       h8s-sim_defconfig
arm                          pxa910_defconfig
arm                           stm32_defconfig
mips                           xway_defconfig
xtensa                          iss_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
powerpc                      arches_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
arm                  randconfig-c002-20220421
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220420
arc                  randconfig-r043-20220421
s390                 randconfig-r044-20220421
riscv                randconfig-r042-20220421
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
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220421
mips                 randconfig-c004-20220421
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220421
powerpc              randconfig-c003-20220421
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
powerpc                      ppc64e_defconfig
mips                           rs90_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8560_defconfig
powerpc                     tqm5200_defconfig
mips                malta_qemu_32r6_defconfig
mips                      bmips_stb_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
s390                 randconfig-r044-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
