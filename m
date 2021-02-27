From: kernel test robot <lkp@intel.com>
Date: Sat, 27 Feb 2021 23:05:33 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 94c839566603f723f6914a6b23014a6110636ec8
Message-ID: <603a5fbd.oYtwqLJcusfzVIEG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 94c839566603f723f6914a6b23014a6110636ec8  igb: unbreak I2C bit-banging on i350

elapsed time: 723m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7724_defconfig
powerpc                      arches_defconfig
mips                      bmips_stb_defconfig
arm                          simpad_defconfig
sh                     magicpanelr2_defconfig
arm                             pxa_defconfig
arm                        shmobile_defconfig
m68k                            mac_defconfig
riscv                            allmodconfig
powerpc                        icon_defconfig
parisc                generic-32bit_defconfig
powerpc                     sequoia_defconfig
xtensa                       common_defconfig
mips                   sb1250_swarm_defconfig
powerpc                  mpc885_ads_defconfig
arm                        spear6xx_defconfig
m68k                        m5407c3_defconfig
arc                         haps_hs_defconfig
mips                          malta_defconfig
powerpc                    gamecube_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a005-20210227
i386                 randconfig-a006-20210227
i386                 randconfig-a004-20210227
i386                 randconfig-a001-20210227
i386                 randconfig-a003-20210227
i386                 randconfig-a002-20210227
x86_64               randconfig-a015-20210227
x86_64               randconfig-a011-20210227
x86_64               randconfig-a012-20210227
x86_64               randconfig-a016-20210227
x86_64               randconfig-a013-20210227
x86_64               randconfig-a014-20210227
i386                 randconfig-a013-20210227
i386                 randconfig-a012-20210227
i386                 randconfig-a011-20210227
i386                 randconfig-a014-20210227
i386                 randconfig-a016-20210227
i386                 randconfig-a015-20210227
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210227
x86_64               randconfig-a002-20210227
x86_64               randconfig-a003-20210227
x86_64               randconfig-a005-20210227
x86_64               randconfig-a004-20210227
x86_64               randconfig-a006-20210227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
