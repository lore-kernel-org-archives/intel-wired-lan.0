From: kernel test robot <lkp@intel.com>
Date: Tue, 15 Mar 2022 20:48:49 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 35d262354e0af95026f495b3e9d5ba0763160b0d
Message-ID: <62308b31.7Jp5EhgpKx8fwvko%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 35d262354e0af95026f495b3e9d5ba0763160b0d  ice: destroy flow director filter mutex after releasing VSIs

elapsed time: 722m

configs tested: 107
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
x86_64                              defconfig
arm                       imx_v6_v7_defconfig
arm                         nhk8815_defconfig
powerpc                      pasemi_defconfig
xtensa                              defconfig
h8300                    h8300h-sim_defconfig
arm                             pxa_defconfig
arc                         haps_hs_defconfig
sh                         ap325rxa_defconfig
m68k                         amcore_defconfig
m68k                       bvme6000_defconfig
sh                          rsk7201_defconfig
xtensa                  nommu_kc705_defconfig
sh                            hp6xx_defconfig
m68k                          atari_defconfig
arm                  randconfig-c002-20220314
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a002-20220314
x86_64               randconfig-a001-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a005-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a005-20220314
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     tqm8560_defconfig
arm                   milbeaut_m10v_defconfig
mips                           mtx1_defconfig
arm                         shannon_defconfig
mips                            e55_defconfig
arm                        neponset_defconfig
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a011-20220314
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
i386                 randconfig-a012-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a013-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a016-20220314
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
