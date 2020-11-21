From: kernel test robot <lkp@intel.com>
Date: Sat, 21 Nov 2020 23:22:43 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 9e8ac63fe1bc346275b27d5d8016e465402d3c34
Message-ID: <5fb930c3.MBfItD4k7L7VAevt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  master
branch HEAD: 9e8ac63fe1bc346275b27d5d8016e465402d3c34  Merge branch 'mptcp-more-miscellaneous-mptcp-fixes'

elapsed time: 866m

configs tested: 147
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
nds32                               defconfig
arm                         lpc32xx_defconfig
powerpc                       holly_defconfig
sh                           sh2007_defconfig
arm                      integrator_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                  maltasmvp_eva_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc5200_defconfig
arm                           corgi_defconfig
powerpc                     powernv_defconfig
mips                      pic32mzda_defconfig
arm                         hackkit_defconfig
mips                      fuloong2e_defconfig
arm                          simpad_defconfig
arm                        trizeps4_defconfig
arc                        nsimosci_defconfig
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
mips                        maltaup_defconfig
arm                           tegra_defconfig
xtensa                              defconfig
arm                        mini2440_defconfig
powerpc                        cell_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201120
i386                 randconfig-a003-20201120
i386                 randconfig-a002-20201120
i386                 randconfig-a005-20201120
i386                 randconfig-a001-20201120
i386                 randconfig-a006-20201120
x86_64               randconfig-a015-20201121
x86_64               randconfig-a011-20201121
x86_64               randconfig-a014-20201121
x86_64               randconfig-a016-20201121
x86_64               randconfig-a012-20201121
x86_64               randconfig-a013-20201121
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
x86_64               randconfig-a006-20201120
x86_64               randconfig-a003-20201120
x86_64               randconfig-a004-20201120
x86_64               randconfig-a005-20201120
x86_64               randconfig-a001-20201120
x86_64               randconfig-a002-20201120
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
x86_64               randconfig-a006-20201121
x86_64               randconfig-a003-20201121
x86_64               randconfig-a004-20201121
x86_64               randconfig-a005-20201121
x86_64               randconfig-a002-20201121
x86_64               randconfig-a001-20201121

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
