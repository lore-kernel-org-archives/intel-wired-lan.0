From: kernel test robot <lkp@intel.com>
Date: Sat, 10 Jul 2021 20:00:31 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 e84671cd9648eb1f2b346378c100b4ebfbd1b01c
Message-ID: <60e98bdf.7qQXUq2eZiVc8/nw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: e84671cd9648eb1f2b346378c100b4ebfbd1b01c  ice: fix build issue if CONFIG_1588_PTP_CLOCk=m

elapsed time: 721m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
powerpc                        fsp2_defconfig
arm                          lpd270_defconfig
mips                      maltasmvp_defconfig
sh                           se7780_defconfig
mips                           gcw0_defconfig
m68k                            q40_defconfig
mips                        jmr3927_defconfig
arm                        clps711x_defconfig
powerpc                      ep88xc_defconfig
arm                        mvebu_v7_defconfig
xtensa                generic_kc705_defconfig
riscv                    nommu_virt_defconfig
sh                              ul2_defconfig
arm                         nhk8815_defconfig
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
arm                       aspeed_g5_defconfig
arc                            hsdk_defconfig
arm                          ep93xx_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                      acadia_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a005-20210710
x86_64               randconfig-a004-20210710
x86_64               randconfig-a002-20210710
x86_64               randconfig-a003-20210710
x86_64               randconfig-a006-20210710
x86_64               randconfig-a001-20210710
i386                 randconfig-a006-20210709
i386                 randconfig-a004-20210709
i386                 randconfig-a001-20210709
i386                 randconfig-a003-20210709
i386                 randconfig-a005-20210709
i386                 randconfig-a002-20210709
i386                 randconfig-a015-20210709
i386                 randconfig-a016-20210709
i386                 randconfig-a011-20210709
i386                 randconfig-a012-20210709
i386                 randconfig-a013-20210709
i386                 randconfig-a014-20210709
x86_64               randconfig-a004-20210709
x86_64               randconfig-a005-20210709
x86_64               randconfig-a002-20210709
x86_64               randconfig-a006-20210709
x86_64               randconfig-a003-20210709
x86_64               randconfig-a001-20210709
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210709
x86_64               randconfig-a015-20210709
x86_64               randconfig-a011-20210709
x86_64               randconfig-a012-20210709
x86_64               randconfig-a014-20210709
x86_64               randconfig-a016-20210709
x86_64               randconfig-a013-20210709

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
