From: kernel test robot <lkp@intel.com>
Date: Tue, 15 Mar 2022 22:04:18 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 bdd6a89de44b9e07d0b106076260d2367fe0e49a
Message-ID: <62309ce2.UI2bz6FtjDIq9IXr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: bdd6a89de44b9e07d0b106076260d2367fe0e49a  nfp: flower: avoid newline at the end of message in NL_SET_ERR_MSG_MOD

elapsed time: 799m

configs tested: 136
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
x86_64                              defconfig
arm                       imx_v6_v7_defconfig
arm                         nhk8815_defconfig
powerpc                      pasemi_defconfig
xtensa                              defconfig
sh                              ul2_defconfig
arm                         lpc18xx_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
parisc                           alldefconfig
arm                         vf610m4_defconfig
powerpc                    klondike_defconfig
mips                       capcella_defconfig
powerpc                      ppc40x_defconfig
h8300                    h8300h-sim_defconfig
arm                             pxa_defconfig
arc                         haps_hs_defconfig
powerpc                      bamboo_defconfig
csky                             alldefconfig
powerpc                 mpc837x_mds_defconfig
arm                            xcep_defconfig
parisc                generic-32bit_defconfig
sh                           se7705_defconfig
arm                        mini2440_defconfig
sh                        sh7785lcr_defconfig
sh                               j2_defconfig
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
arc                  randconfig-r043-20220314
s390                 randconfig-r044-20220313
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     tqm8560_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
arm                       cns3420vb_defconfig
arm                      pxa255-idp_defconfig
arm                        magician_defconfig
arm                       aspeed_g4_defconfig
arm                   milbeaut_m10v_defconfig
mips                malta_qemu_32r6_defconfig
i386                             allyesconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
hexagon              randconfig-r045-20220314
hexagon              randconfig-r045-20220313
riscv                randconfig-r042-20220314
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
