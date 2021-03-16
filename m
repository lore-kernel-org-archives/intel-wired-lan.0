From: kernel test robot <lkp@intel.com>
Date: Wed, 17 Mar 2021 00:14:28 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 3335369bad99c40b3513da2d165e6ae83f3f3c8b
Message-ID: <6050d964.f7QG0W71OUj9ea5m%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: 3335369bad99c40b3513da2d165e6ae83f3f3c8b  e1000e: Remove the runtime suspend restriction on CNP+

elapsed time: 725m

configs tested: 108
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
m68k                             alldefconfig
sh                          urquell_defconfig
powerpc                      obs600_defconfig
arm                         s3c6400_defconfig
arm                           u8500_defconfig
arm                          imote2_defconfig
sh                          rsk7269_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                       imx_v6_v7_defconfig
sh                             espt_defconfig
arm                         palmz72_defconfig
sh                           se7705_defconfig
h8300                       h8s-sim_defconfig
mips                        bcm47xx_defconfig
ia64                             alldefconfig
xtensa                           allyesconfig
powerpc                     mpc5200_defconfig
powerpc                     pq2fads_defconfig
arm                       netwinder_defconfig
arm                         orion5x_defconfig
openrisc                            defconfig
sh                   secureedge5410_defconfig
arm                             rpc_defconfig
arm                          exynos_defconfig
powerpc                     skiroot_defconfig
powerpc                      bamboo_defconfig
arm                         lubbock_defconfig
powerpc                     taishan_defconfig
arm                            mps2_defconfig
mips                  cavium_octeon_defconfig
powerpc                   lite5200b_defconfig
m68k                          sun3x_defconfig
powerpc                      acadia_defconfig
m68k                            mac_defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
