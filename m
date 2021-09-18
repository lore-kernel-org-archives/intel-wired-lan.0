From: kernel test robot <lkp@intel.com>
Date: Sun, 19 Sep 2021 02:52:21 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 c3c7816f0ac9597ce1e55a026380cbdf48b2ae6c
Message-ID: <61463565.aq5GM/hXMiMZ4DXc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: c3c7816f0ac9597ce1e55a026380cbdf48b2ae6c  iavf: Fix displaying queue statistics shown by ethtool

elapsed time: 1528m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210918
arm                            zeus_defconfig
powerpc                     pq2fads_defconfig
powerpc                      pasemi_defconfig
sparc                            alldefconfig
powerpc                 mpc834x_mds_defconfig
s390                       zfcpdump_defconfig
powerpc                      arches_defconfig
m68k                       m5275evb_defconfig
mips                     loongson1b_defconfig
mips                           xway_defconfig
um                                  defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                       maple_defconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                        spear6xx_defconfig
mips                        bcm47xx_defconfig
xtensa                              defconfig
x86_64               randconfig-c001-20210918
arm                  randconfig-c002-20210918
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
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
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210917
i386                 randconfig-a005-20210917
i386                 randconfig-a006-20210917
i386                 randconfig-a002-20210917
i386                 randconfig-a003-20210917
i386                 randconfig-a001-20210917
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a016-20210917
i386                 randconfig-a015-20210917
i386                 randconfig-a011-20210917
i386                 randconfig-a012-20210917
i386                 randconfig-a013-20210917
i386                 randconfig-a014-20210917
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916
hexagon              randconfig-r045-20210918
hexagon              randconfig-r041-20210918

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
