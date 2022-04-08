From: kernel test robot <lkp@intel.com>
Date: Fri, 08 Apr 2022 16:17:45 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 0931ef5f3432e8d2398d4bd9185bcd0e982ffceb
Message-ID: <624fefa9.xp7l45Ns5+TkeAD4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 0931ef5f3432e8d2398d4bd9185bcd0e982ffceb  igc: Fix suspending when PTM is active

elapsed time: 720m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arc                        nsimosci_defconfig
m68k                        m5407c3_defconfig
powerpc                    amigaone_defconfig
mips                     loongson1b_defconfig
sh                          kfr2r09_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7780_defconfig
sh                           se7722_defconfig
sparc64                          alldefconfig
arm                          pxa910_defconfig
powerpc                    sam440ep_defconfig
arm                     eseries_pxa_defconfig
mips                        bcm47xx_defconfig
powerpc                      bamboo_defconfig
sh                ecovec24-romimage_defconfig
arm                             pxa_defconfig
sparc                               defconfig
powerpc                      pcm030_defconfig
powerpc64                           defconfig
powerpc                       ppc64_defconfig
ia64                        generic_defconfig
arm                       multi_v4t_defconfig
powerpc                         ps3_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220406
arm                  randconfig-c002-20220407
arm                  randconfig-c002-20220408
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
arc                  randconfig-r043-20220406
arc                  randconfig-r043-20220407
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
powerpc                      pasemi_defconfig
arm                            mps2_defconfig
arm                     davinci_all_defconfig
powerpc                   microwatt_defconfig
powerpc                    socrates_defconfig
mips                     cu1000-neo_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      obs600_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220406
s390                 randconfig-r044-20220407
riscv                randconfig-r042-20220407
hexagon              randconfig-r045-20220406
hexagon              randconfig-r041-20220407
hexagon              randconfig-r045-20220407

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
