From: kernel test robot <lkp@intel.com>
Date: Thu, 14 Jan 2021 21:53:24 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 3441a6c937ab2711d89406b88a97c28690a31ec3
Message-ID: <60004cd4.OBUAp2OXlLWZWSuP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  100GbE
branch HEAD: 3441a6c937ab2711d89406b88a97c28690a31ec3  ice: Improve MSI-X vector enablement fallback logic

elapsed time: 723m

configs tested: 137
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
s390                          debug_defconfig
openrisc                            defconfig
arc                        nsim_700_defconfig
arm                           sunxi_defconfig
mips                           ip28_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
mips                    maltaup_xpa_defconfig
ia64                         bigsur_defconfig
powerpc                      ppc44x_defconfig
mips                  cavium_octeon_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
sparc64                             defconfig
m68k                        stmark2_defconfig
arc                        nsimosci_defconfig
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
powerpc                     rainier_defconfig
powerpc                     sbc8548_defconfig
m68k                       m5475evb_defconfig
powerpc                 linkstation_defconfig
mips                     loongson1c_defconfig
arm                             ezx_defconfig
sh                            shmin_defconfig
sh                           se7712_defconfig
mips                        jmr3927_defconfig
m68k                                defconfig
arm                           corgi_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
arm                         assabet_defconfig
arm                        multi_v7_defconfig
sh                           se7751_defconfig
sparc                            allyesconfig
powerpc                      cm5200_defconfig
sh                           se7750_defconfig
m68k                            q40_defconfig
arm                       imx_v6_v7_defconfig
arm                           tegra_defconfig
mips                      pistachio_defconfig
arm                         hackkit_defconfig
arm                         socfpga_defconfig
arm                             mxs_defconfig
xtensa                       common_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                                  defconfig
arm                      pxa255-idp_defconfig
sparc64                          alldefconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
sh                           se7721_defconfig
sh                           se7722_defconfig
nds32                             allnoconfig
mips                        maltaup_defconfig
csky                             alldefconfig
arm                          iop32x_defconfig
powerpc                     tqm8541_defconfig
sh                         ap325rxa_defconfig
arm                         palmz72_defconfig
s390                             alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                     tqm8540_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
x86_64               randconfig-a011-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
