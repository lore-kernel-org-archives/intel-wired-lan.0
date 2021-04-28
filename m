From: kernel test robot <lkp@intel.com>
Date: Wed, 28 Apr 2021 20:02:26 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 776a417daec6a28fdf89426ea98126f8a03c79a1
Message-ID: <60894ed2.Xjjc9j7e9HKKm/By%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 776a417daec6a28fdf89426ea98126f8a03c79a1  ixgbevf: add correct exception tracing for XDP

elapsed time: 726m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
powerpc                     akebono_defconfig
arm                         socfpga_defconfig
mips                    maltaup_xpa_defconfig
arm                       spear13xx_defconfig
ia64                             allmodconfig
powerpc                    mvme5100_defconfig
csky                                defconfig
arm                         lpc32xx_defconfig
sh                           se7343_defconfig
riscv                          rv32_defconfig
arm                         axm55xx_defconfig
ia64                         bigsur_defconfig
mips                            e55_defconfig
arm                           viper_defconfig
mips                      maltasmvp_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5208evb_defconfig
arm                           corgi_defconfig
powerpc                    socrates_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7619_defconfig
i386                             alldefconfig
mips                           ip27_defconfig
powerpc                      mgcoge_defconfig
mips                  maltasmvp_eva_defconfig
mips                           mtx1_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pmac32_defconfig
sh                     magicpanelr2_defconfig
mips                     loongson1c_defconfig
arm                         orion5x_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210428
i386                 randconfig-a002-20210428
i386                 randconfig-a001-20210428
i386                 randconfig-a006-20210428
i386                 randconfig-a003-20210428
i386                 randconfig-a004-20210428
x86_64               randconfig-a015-20210428
x86_64               randconfig-a016-20210428
x86_64               randconfig-a011-20210428
x86_64               randconfig-a014-20210428
x86_64               randconfig-a013-20210428
x86_64               randconfig-a012-20210428
i386                 randconfig-a012-20210428
i386                 randconfig-a014-20210428
i386                 randconfig-a013-20210428
i386                 randconfig-a011-20210428
i386                 randconfig-a015-20210428
i386                 randconfig-a016-20210428
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210428
x86_64               randconfig-a002-20210428
x86_64               randconfig-a005-20210428
x86_64               randconfig-a006-20210428
x86_64               randconfig-a001-20210428
x86_64               randconfig-a003-20210428

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
