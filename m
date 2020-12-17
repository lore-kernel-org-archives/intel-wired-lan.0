From: kernel test robot <lkp@intel.com>
Date: Thu, 17 Dec 2020 21:50:09 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 61b513f1cf38a45b129536548b836432fdfe7259
Message-ID: <5fdb6211.69tIQ8TBAr1R+wbA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git  dev-queue
branch HEAD: 61b513f1cf38a45b129536548b836432fdfe7259  e1000e: Export S0ix flags to ethtool

elapsed time: 723m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
sh                          landisk_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     taishan_defconfig
arm                       multi_v4t_defconfig
h8300                               defconfig
powerpc                  mpc885_ads_defconfig
arm                         hackkit_defconfig
powerpc                     tqm5200_defconfig
arm                           h5000_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
powerpc                     pq2fads_defconfig
sh                         apsh4a3a_defconfig
arm                        keystone_defconfig
arm                         mv78xx0_defconfig
mips                           jazz_defconfig
mips                     cu1000-neo_defconfig
sh                         microdev_defconfig
arc                        nsim_700_defconfig
mips                         mpc30x_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      pcm030_defconfig
mips                     decstation_defconfig
arm                             ezx_defconfig
mips                        vocore2_defconfig
mips                           ip22_defconfig
powerpc                    adder875_defconfig
powerpc                        fsp2_defconfig
sparc64                             defconfig
arm                       aspeed_g4_defconfig
sh                         ap325rxa_defconfig
arm                          badge4_defconfig
h8300                    h8300h-sim_defconfig
mips                   sb1250_swarm_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
