From: kernel test robot <lkp@intel.com>
Date: Tue, 24 Aug 2021 13:54:42 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:1GbE] BUILD SUCCESS
 4051f68318ca9f3d3becef3b54e70ad2c146df97
Message-ID: <612489a2.Gb5NunF2xKtrze64%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 1GbE
branch HEAD: 4051f68318ca9f3d3becef3b54e70ad2c146df97  e1000e: Do not take care about recovery NVM checksum

elapsed time: 5084m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210821
mips                           ip28_defconfig
arm                            qcom_defconfig
mips                            ar7_defconfig
powerpc                     rainier_defconfig
sh                      rts7751r2d1_defconfig
m68k                             allmodconfig
mips                          rb532_defconfig
arm                         lpc32xx_defconfig
arm                           tegra_defconfig
arm                        multi_v7_defconfig
arm                        clps711x_defconfig
mips                         tb0219_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         palmz72_defconfig
sh                             shx3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         socfpga_defconfig
powerpc64                           defconfig
mips                         db1xxx_defconfig
mips                    maltaup_xpa_defconfig
sh                        dreamcast_defconfig
m68k                          multi_defconfig
nios2                            alldefconfig
sh                        sh7763rdp_defconfig
arm                           u8500_defconfig
xtensa                              defconfig
sh                        edosk7705_defconfig
powerpc                     pq2fads_defconfig
arm                            pleb_defconfig
riscv                    nommu_virt_defconfig
arm                          badge4_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      ppc44x_defconfig
sh                             sh03_defconfig
arm                            xcep_defconfig
sh                            migor_defconfig
arm                         orion5x_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
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
i386                 randconfig-a006-20210820
i386                 randconfig-a001-20210820
i386                 randconfig-a002-20210820
i386                 randconfig-a005-20210820
i386                 randconfig-a003-20210820
i386                 randconfig-a004-20210820
x86_64               randconfig-a005-20210820
x86_64               randconfig-a006-20210820
x86_64               randconfig-a001-20210820
x86_64               randconfig-a003-20210820
x86_64               randconfig-a004-20210820
x86_64               randconfig-a002-20210820
x86_64               randconfig-a014-20210821
x86_64               randconfig-a016-20210821
x86_64               randconfig-a015-20210821
x86_64               randconfig-a013-20210821
x86_64               randconfig-a012-20210821
x86_64               randconfig-a011-20210821
arc                  randconfig-r043-20210821
riscv                randconfig-r042-20210821
s390                 randconfig-r044-20210821
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20210821
x86_64               randconfig-a001-20210821
x86_64               randconfig-a006-20210821
x86_64               randconfig-a003-20210821
x86_64               randconfig-a004-20210821
x86_64               randconfig-a002-20210821
i386                 randconfig-a006-20210821
i386                 randconfig-a001-20210821
i386                 randconfig-a002-20210821
i386                 randconfig-a005-20210821
i386                 randconfig-a004-20210821
i386                 randconfig-a003-20210821

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
