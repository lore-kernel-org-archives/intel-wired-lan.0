From: kernel test robot <lkp@intel.com>
Date: Fri, 25 Dec 2020 00:14:35 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 6785a05b2d2bca150764f324ae8191378f1829a3
Message-ID: <5fe4be6b.pq32LNN1MGCZh+RH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git  dev-queue
branch HEAD: 6785a05b2d2bca150764f324ae8191378f1829a3  e1000e: Export S0ix flags to ethtool

elapsed time: 723m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
sh                           se7343_defconfig
mips                      maltasmvp_defconfig
arm                          prima2_defconfig
sparc                            alldefconfig
mips                       bmips_be_defconfig
powerpc                mpc7448_hpc2_defconfig
microblaze                      mmu_defconfig
sh                                  defconfig
m68k                       bvme6000_defconfig
sh                  sh7785lcr_32bit_defconfig
openrisc                    or1ksim_defconfig
sh                           se7705_defconfig
arm                          pxa3xx_defconfig
m68k                        mvme16x_defconfig
sh                        sh7763rdp_defconfig
sh                             espt_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201223
i386                 randconfig-a005-20201223
i386                 randconfig-a006-20201223
i386                 randconfig-a004-20201223
i386                 randconfig-a003-20201223
i386                 randconfig-a001-20201223
i386                 randconfig-a011-20201223
i386                 randconfig-a016-20201223
i386                 randconfig-a014-20201223
i386                 randconfig-a012-20201223
i386                 randconfig-a015-20201223
i386                 randconfig-a013-20201223
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
x86_64               randconfig-a015-20201223
x86_64               randconfig-a014-20201223
x86_64               randconfig-a016-20201223
x86_64               randconfig-a012-20201223
x86_64               randconfig-a013-20201223
x86_64               randconfig-a011-20201223
x86_64               randconfig-a001-20201224
x86_64               randconfig-a006-20201224
x86_64               randconfig-a004-20201224
x86_64               randconfig-a002-20201224
x86_64               randconfig-a003-20201224
x86_64               randconfig-a005-20201224

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
