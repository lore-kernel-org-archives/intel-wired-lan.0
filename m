From: kernel test robot <lkp@intel.com>
Date: Wed, 16 Feb 2022 13:27:39 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 35410c10918a84c9685cd644686ca637bb3c046b
Message-ID: <620c8b4b.HhW/pbU4pUmZkW7W%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 35410c10918a84c9685cd644686ca637bb3c046b  ice: initialize local variable 'tlv'

elapsed time: 733m

configs tested: 167
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220214
mips                 randconfig-c004-20220214
i386                          randconfig-c001
mips                 randconfig-c004-20220216
sh                           se7751_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                      fuloong2e_defconfig
sh                        sh7763rdp_defconfig
arm                        realview_defconfig
csky                                defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
m68k                       m5208evb_defconfig
arm                            hisi_defconfig
sh                        edosk7705_defconfig
sh                          lboxre2_defconfig
openrisc                         alldefconfig
arm                       omap2plus_defconfig
arm                        shmobile_defconfig
sh                             espt_defconfig
sh                             sh03_defconfig
arm                            lart_defconfig
mips                          rb532_defconfig
arm                          badge4_defconfig
sh                           se7750_defconfig
arm                           stm32_defconfig
arm                      integrator_defconfig
arm                           sunxi_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5475evb_defconfig
powerpc                      arches_defconfig
arm                          pxa910_defconfig
arm                           u8500_defconfig
powerpc                     taishan_defconfig
arm                        oxnas_v6_defconfig
sh                                  defconfig
m68k                             alldefconfig
arm                       aspeed_g5_defconfig
xtensa                  nommu_kc705_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
arm                         at91_dt_defconfig
powerpc                    klondike_defconfig
x86_64                              defconfig
h8300                               defconfig
i386                             alldefconfig
sh                           se7724_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
arm                        cerfcube_defconfig
mips                      loongson3_defconfig
arm                  randconfig-c002-20220214
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a013-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a015-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a016-20220214
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
riscv                    nommu_k210_defconfig
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220216
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220216
arm                  randconfig-c002-20220216
i386                          randconfig-c001
mips                 randconfig-c004-20220216
arm                        neponset_defconfig
powerpc                      ppc44x_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                          rm200_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
powerpc                     kmeter1_defconfig
powerpc                     tqm8560_defconfig
arm                          ep93xx_defconfig
arm                        spear3xx_defconfig
arm                         lpc32xx_defconfig
powerpc                  mpc885_ads_defconfig
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
