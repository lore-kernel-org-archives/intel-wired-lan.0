From: kernel test robot <lkp@intel.com>
Date: Thu, 23 Dec 2021 08:48:20 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 7f5e12af5fe2990e876d57c48a83bc9d2ffce8ae
Message-ID: <61c3c754.h4vuqrTO9XAxhkbE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 7f5e12af5fe2990e876d57c48a83bc9d2ffce8ae  igc: Fix TX timestamp support for non-MSI-X platforms

elapsed time: 1801m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
openrisc                  or1klitex_defconfig
powerpc                     pq2fads_defconfig
arm                        spear6xx_defconfig
sh                         microdev_defconfig
arm                        mvebu_v7_defconfig
sh                           sh2007_defconfig
arm                       aspeed_g4_defconfig
m68k                         apollo_defconfig
powerpc                     pseries_defconfig
parisc                              defconfig
arm                           sama5_defconfig
arm                          imote2_defconfig
powerpc                    amigaone_defconfig
openrisc                            defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
mips                      bmips_stb_defconfig
sh                            shmin_defconfig
um                               alldefconfig
arm                          ixp4xx_defconfig
arm                         cm_x300_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
xtensa                          iss_defconfig
mips                           ip32_defconfig
m68k                             allyesconfig
arm                            zeus_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
xtensa                    smp_lx200_defconfig
arm                        vexpress_defconfig
powerpc                          allmodconfig
mips                          rm200_defconfig
mips                       bmips_be_defconfig
mips                        bcm47xx_defconfig
sh                             shx3_defconfig
arm                           sunxi_defconfig
mips                           ip22_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                    mvme5100_defconfig
mips                        workpad_defconfig
arm                           tegra_defconfig
mips                     loongson2k_defconfig
powerpc                       ppc64_defconfig
arm                           spitz_defconfig
arm                             ezx_defconfig
arm                  randconfig-c002-20211223
arm                  randconfig-c002-20211220
arm                  randconfig-c002-20211222
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a002-20211222
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a005-20211222
i386                 randconfig-a001-20211222
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a005-20211220
arc                  randconfig-r043-20211220
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20211222
x86_64               randconfig-a014-20211222
x86_64               randconfig-a012-20211222
x86_64               randconfig-a011-20211222
x86_64               randconfig-a015-20211222
x86_64               randconfig-a016-20211222
i386                 randconfig-a012-20211222
i386                 randconfig-a011-20211222
i386                 randconfig-a013-20211222
i386                 randconfig-a014-20211222
i386                 randconfig-a015-20211222
i386                 randconfig-a016-20211222
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220
hexagon              randconfig-r041-20211220

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
