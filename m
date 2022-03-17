From: kernel test robot <lkp@intel.com>
Date: Fri, 18 Mar 2022 05:43:48 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 c54f50f36922803fd55716084441d5b54f20bfe3
Message-ID: <6233ab94.EKGQBOYj/lE05Zg5%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: c54f50f36922803fd55716084441d5b54f20bfe3  ice: Add mpls+tso support

elapsed time: 808m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
i386                          randconfig-c001
arm                      footbridge_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
arm                            lart_defconfig
sh                         ap325rxa_defconfig
arm                           h3600_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
microblaze                          defconfig
sh                      rts7751r2d1_defconfig
powerpc64                           defconfig
mips                           jazz_defconfig
x86_64                              defconfig
xtensa                              defconfig
m68k                        m5407c3_defconfig
arm                           stm32_defconfig
arm                          pxa910_defconfig
mips                         bigsur_defconfig
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20220317
riscv                randconfig-r042-20220317
s390                 randconfig-r044-20220317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                    socrates_defconfig
mips                     cu1000-neo_defconfig
arm                             mxs_defconfig
powerpc                     kilauea_defconfig
mips                         tb0287_defconfig
mips                          malta_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220317
hexagon              randconfig-r045-20220317

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
