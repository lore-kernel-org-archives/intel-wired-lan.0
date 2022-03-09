From: kernel test robot <lkp@intel.com>
Date: Wed, 09 Mar 2022 21:01:27 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 443ebdd68b443ea0798c883e8aabf10d75268e92
Message-ID: <6228a527.ctYAZyInWIiWjTL1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: 443ebdd68b443ea0798c883e8aabf10d75268e92  ixgbevf: add disable link state

elapsed time: 1142m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
sh                ecovec24-romimage_defconfig
m68k                          multi_defconfig
sh                   sh7724_generic_defconfig
arm                        mini2440_defconfig
sh                           se7206_defconfig
xtensa                          iss_defconfig
nds32                             allnoconfig
arm                          simpad_defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220309
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220308
riscv                randconfig-r042-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
arm                           spitz_defconfig
x86_64                           allyesconfig
powerpc                      obs600_defconfig
mips                malta_qemu_32r6_defconfig
arm                            mmp2_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
mips                          ath79_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308
hexagon              randconfig-r045-20220309
hexagon              randconfig-r041-20220309
riscv                randconfig-r042-20220309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
