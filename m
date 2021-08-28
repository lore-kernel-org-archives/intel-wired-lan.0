From: kernel test robot <lkp@intel.com>
Date: Sat, 28 Aug 2021 21:58:27 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 938322faadc5ccaa5a6d8c180593f2be4bb725bc
Message-ID: <612a4103.L3eAX7PsZUDO7wIW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: 938322faadc5ccaa5a6d8c180593f2be4bb725bc  iavf: Fix ping is lost after untrusted VF had tried to change MAC

elapsed time: 14116m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
i386                 randconfig-c001-20210819
mips                         rt305x_defconfig
powerpc                 linkstation_defconfig
arm                       netwinder_defconfig
powerpc                         ps3_defconfig
arm                         hackkit_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
powerpc                      pmac32_defconfig
powerpc                    sam440ep_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
m68k                         amcore_defconfig
arm                           viper_defconfig
sh                          rsk7269_defconfig
arm64                            alldefconfig
sh                        apsh4ad0a_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                           allyesconfig
mips                          rm200_defconfig
sh                   sh7770_generic_defconfig
arm                          iop32x_defconfig
powerpc                        icon_defconfig
sh                          rsk7203_defconfig
mips                     cu1000-neo_defconfig
arm                            pleb_defconfig
powerpc                          g5_defconfig
h8300                     edosk2674_defconfig
sh                           se7712_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a004-20210818
x86_64               randconfig-a006-20210818
x86_64               randconfig-a003-20210818
x86_64               randconfig-a005-20210818
x86_64               randconfig-a002-20210818
x86_64               randconfig-a001-20210818
i386                 randconfig-a004-20210818
i386                 randconfig-a006-20210818
i386                 randconfig-a002-20210818
i386                 randconfig-a001-20210818
i386                 randconfig-a003-20210818
i386                 randconfig-a005-20210818
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210818
s390                 randconfig-c005-20210818
powerpc              randconfig-c003-20210818
mips                 randconfig-c004-20210818
x86_64               randconfig-c007-20210818
i386                 randconfig-c001-20210818
arm                  randconfig-c002-20210818
x86_64               randconfig-a004-20210819
x86_64               randconfig-a006-20210819
x86_64               randconfig-a003-20210819
x86_64               randconfig-a002-20210819
x86_64               randconfig-a005-20210819
x86_64               randconfig-a001-20210819
i386                 randconfig-a004-20210819
i386                 randconfig-a006-20210819
i386                 randconfig-a001-20210819
i386                 randconfig-a002-20210819
i386                 randconfig-a003-20210819
i386                 randconfig-a005-20210819
x86_64               randconfig-a013-20210818
x86_64               randconfig-a011-20210818
x86_64               randconfig-a012-20210818
x86_64               randconfig-a016-20210818
x86_64               randconfig-a014-20210818
x86_64               randconfig-a015-20210818
i386                 randconfig-a015-20210818
i386                 randconfig-a011-20210818
i386                 randconfig-a013-20210818
i386                 randconfig-a014-20210818
i386                 randconfig-a016-20210818
i386                 randconfig-a012-20210818
hexagon              randconfig-r041-20210818
riscv                randconfig-r042-20210818
s390                 randconfig-r044-20210818
hexagon              randconfig-r045-20210818
hexagon              randconfig-r041-20210819
hexagon              randconfig-r045-20210819

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
