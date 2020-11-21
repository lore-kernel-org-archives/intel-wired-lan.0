From: kernel test robot <lkp@intel.com>
Date: Sat, 21 Nov 2020 23:46:52 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 d2624e70a2f53b6f402fdaeabe7db798148618c5
Message-ID: <5fb9366c.0eIzvyNcmTfSijJZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git  master
branch HEAD: d2624e70a2f53b6f402fdaeabe7db798148618c5  dpaa2-eth: select XGMAC_MDIO for MDIO bus support

elapsed time: 968m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           efm32_defconfig
sh                          rsk7203_defconfig
sh                          rsk7269_defconfig
nds32                             allnoconfig
sh                             sh03_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                            qcom_defconfig
arm                     eseries_pxa_defconfig
powerpc                      walnut_defconfig
mips                          rm200_defconfig
arm                       netwinder_defconfig
arm                             mxs_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
sh                           se7721_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                          rv32_defconfig
mips                         bigsur_defconfig
sparc                            allyesconfig
powerpc                     sequoia_defconfig
sh                            shmin_defconfig
powerpc                       holly_defconfig
sh                           sh2007_defconfig
arm                      integrator_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
xtensa                  cadence_csp_defconfig
arm                       imx_v6_v7_defconfig
arm                            pleb_defconfig
mips                        maltaup_defconfig
ia64                          tiger_defconfig
xtensa                  audio_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
mips                     loongson1b_defconfig
powerpc64                           defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
m68k                        stmark2_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
alpha                               defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
xtensa                generic_kc705_defconfig
sh                          landisk_defconfig
um                             i386_defconfig
ia64                         bigsur_defconfig
c6x                                 defconfig
arm                  colibri_pxa300_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                 canyonlands_defconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      ppc6xx_defconfig
arm                           sunxi_defconfig
sh                           se7750_defconfig
powerpc                      obs600_defconfig
i386                                defconfig
arm                           tegra_defconfig
xtensa                              defconfig
arm                        mini2440_defconfig
powerpc                        cell_defconfig
arm                           omap1_defconfig
ia64                      gensparse_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc836x_mds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20201120
x86_64               randconfig-a003-20201120
x86_64               randconfig-a004-20201120
x86_64               randconfig-a005-20201120
x86_64               randconfig-a001-20201120
x86_64               randconfig-a002-20201120
i386                 randconfig-a004-20201120
i386                 randconfig-a003-20201120
i386                 randconfig-a002-20201120
i386                 randconfig-a005-20201120
i386                 randconfig-a001-20201120
i386                 randconfig-a006-20201120
i386                 randconfig-a012-20201120
i386                 randconfig-a013-20201120
i386                 randconfig-a011-20201120
i386                 randconfig-a016-20201120
i386                 randconfig-a014-20201120
i386                 randconfig-a015-20201120
i386                 randconfig-a012-20201121
i386                 randconfig-a013-20201121
i386                 randconfig-a011-20201121
i386                 randconfig-a016-20201121
i386                 randconfig-a014-20201121
i386                 randconfig-a015-20201121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201120
x86_64               randconfig-a011-20201120
x86_64               randconfig-a014-20201120
x86_64               randconfig-a016-20201120
x86_64               randconfig-a012-20201120
x86_64               randconfig-a013-20201120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
