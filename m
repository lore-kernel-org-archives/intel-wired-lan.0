From: kernel test robot <lkp@intel.com>
Date: Wed, 12 Jan 2022 20:37:19 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 f1f62d37baf6f3ca96f3edb6f888bf90fe57cef2
Message-ID: <61decb7f.v4YuhbC1J0xtG1TF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: f1f62d37baf6f3ca96f3edb6f888bf90fe57cef2  ice: fix an error code in ice_cfg_phy_fec()

elapsed time: 2117m

configs tested: 142
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
mips                 randconfig-c004-20220111
sh                               alldefconfig
powerpc                  storcenter_defconfig
xtensa                          iss_defconfig
sh                              ul2_defconfig
m68k                          hp300_defconfig
arm                         axm55xx_defconfig
um                             i386_defconfig
sparc                            alldefconfig
arm                           stm32_defconfig
sh                                  defconfig
powerpc                      ep88xc_defconfig
arm                        mini2440_defconfig
sh                            migor_defconfig
m68k                                defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
mips                          rb532_defconfig
h8300                     edosk2674_defconfig
arm                     eseries_pxa_defconfig
nds32                             allnoconfig
powerpc                    klondike_defconfig
sh                        edosk7705_defconfig
sh                         microdev_defconfig
arm                          iop32x_defconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
arm                           viper_defconfig
mips                 decstation_r4k_defconfig
arm                        clps711x_defconfig
powerpc                      arches_defconfig
mips                       bmips_be_defconfig
powerpc                      pcm030_defconfig
arm                         assabet_defconfig
xtensa                       common_defconfig
s390                             allyesconfig
arm                  randconfig-c002-20220111
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
parisc                              defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func

clang tested configs:
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
s390                 randconfig-c005-20220111
mips                 randconfig-c004-20220111
arm                     davinci_all_defconfig
powerpc                 mpc836x_mds_defconfig
arm                                 defconfig
arm                          pxa168_defconfig
powerpc                     ksi8560_defconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
mips                           ip27_defconfig
powerpc                          allmodconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        fsp2_defconfig
powerpc                    ge_imp3a_defconfig
arm                            mmp2_defconfig
arm                         hackkit_defconfig
powerpc                   lite5200b_defconfig
riscv                             allnoconfig
arm                          ixp4xx_defconfig
riscv                          rv32_defconfig
arm                         bcm2835_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
arm                      pxa255-idp_defconfig
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
hexagon              randconfig-r045-20220111
hexagon              randconfig-r041-20220111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
