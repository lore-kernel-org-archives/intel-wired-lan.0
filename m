From: kernel test robot <lkp@intel.com>
Date: Sat, 12 Mar 2022 16:44:22 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 a075367b3cee3005455587230f535d04d17c3934
Message-ID: <622c5d66.Nl2E9LwtZr48luLi%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: a075367b3cee3005455587230f535d04d17c3934  ice: Add inline flow director support for channels

elapsed time: 1774m

configs tested: 125
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
x86_64                              defconfig
arm                            zeus_defconfig
i386                             alldefconfig
mips                        vocore2_defconfig
m68k                       m5208evb_defconfig
sh                          rsk7203_defconfig
sh                            shmin_defconfig
xtensa                         virt_defconfig
mips                       capcella_defconfig
mips                      maltasmvp_defconfig
alpha                            alldefconfig
arm                       imx_v6_v7_defconfig
ia64                      gensparse_defconfig
m68k                       bvme6000_defconfig
powerpc                         ps3_defconfig
m68k                        m5407c3_defconfig
xtensa                           alldefconfig
arm                      integrator_defconfig
h8300                       h8s-sim_defconfig
powerpc                      bamboo_defconfig
arm                         vf610m4_defconfig
mips                         db1xxx_defconfig
powerpc                      ep88xc_defconfig
sh                            hp6xx_defconfig
powerpc                   motionpro_defconfig
h8300                     edosk2674_defconfig
arm                           stm32_defconfig
mips                 decstation_r4k_defconfig
sh                        sh7757lcr_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220310
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                          g5_defconfig
arm                             mxs_defconfig
arm                      tct_hammer_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
mips                        qi_lb60_defconfig
arm                     am200epdkit_defconfig
arm                            dove_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                     cu1830-neo_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310
s390                 randconfig-r044-20220310

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
