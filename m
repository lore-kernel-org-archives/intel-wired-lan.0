From: kernel test robot <lkp@intel.com>
Date: Fri, 18 Mar 2022 22:54:54 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 e7dc1b68b7a33ffe3687f5344704978e42c3ef6a
Message-ID: <62349d3e.15orlRede+yJrW4r%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: e7dc1b68b7a33ffe3687f5344704978e42c3ef6a  igc: Fix BUG: scheduling while atomic

elapsed time: 727m

configs tested: 136
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                          randconfig-c001
mips                           gcw0_defconfig
m68k                          atari_defconfig
sh                        edosk7705_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
s390                             allyesconfig
um                             i386_defconfig
powerpc                      bamboo_defconfig
sh                              ul2_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
alpha                            alldefconfig
powerpc                     tqm8555_defconfig
openrisc                  or1klitex_defconfig
powerpc                      pcm030_defconfig
sh                   rts7751r2dplus_defconfig
sh                ecovec24-romimage_defconfig
sparc                            alldefconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
m68k                       m5208evb_defconfig
sparc64                             defconfig
powerpc                        warp_defconfig
arm                        clps711x_defconfig
riscv                               defconfig
sh                          rsk7201_defconfig
sparc                               defconfig
sh                   sh7770_generic_defconfig
ia64                            zx1_defconfig
sh                           se7780_defconfig
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220317
arc                  randconfig-r043-20220318
riscv                randconfig-r042-20220317
arc                  randconfig-r043-20220317
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220318
s390                 randconfig-c005-20220318
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220318
riscv                randconfig-c006-20220318
mips                 randconfig-c004-20220318
i386                          randconfig-c001
s390                 randconfig-c005-20220317
arm                  randconfig-c002-20220317
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
mips                   sb1250_swarm_defconfig
powerpc                       ebony_defconfig
powerpc                     mpc512x_defconfig
riscv                            alldefconfig
mips                      maltaaprp_defconfig
mips                     loongson1c_defconfig
powerpc                 mpc836x_mds_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220318
riscv                randconfig-r042-20220318
hexagon              randconfig-r041-20220317
s390                 randconfig-r044-20220318
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
