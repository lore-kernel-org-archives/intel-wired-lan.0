From: kernel test robot <lkp@intel.com>
Date: Sat, 18 Sep 2021 12:56:21 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 cd5506cc3e612dd01dfee3ec7b6afe6f6e8f5204
Message-ID: <61457175.Ypann4tAGvTfEkcZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: cd5506cc3e612dd01dfee3ec7b6afe6f6e8f5204  iavf: Fix refreshing iavf adapter stats on ethtool request

elapsed time: 1692m

configs tested: 98
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210918
arc                          axs101_defconfig
mips                        maltaup_defconfig
powerpc                  iss476-smp_defconfig
arm                              alldefconfig
m68k                       bvme6000_defconfig
powerpc64                        alldefconfig
um                                  defconfig
openrisc                 simple_smp_defconfig
arm                        oxnas_v6_defconfig
mips                           ip28_defconfig
powerpc                    klondike_defconfig
powerpc                      cm5200_defconfig
arm                       versatile_defconfig
sh                          kfr2r09_defconfig
x86_64                              defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
i386                 randconfig-a016-20210917
i386                 randconfig-a015-20210917
i386                 randconfig-a011-20210917
i386                 randconfig-a012-20210917
i386                 randconfig-a013-20210917
i386                 randconfig-a014-20210917
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
