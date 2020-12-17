From: kernel test robot <lkp@intel.com>
Date: Thu, 17 Dec 2020 21:50:05 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 7eb000bdbe7c7da811ef51942b356f6e819b13ba
Message-ID: <5fdb620d.G9NuHSLJ3MsE/W7S%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git  master
branch HEAD: 7eb000bdbe7c7da811ef51942b356f6e819b13ba  net: korina: fix return value

elapsed time: 722m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                                 defconfig
mips                        jmr3927_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
xtensa                  nommu_kc705_defconfig
ia64                             allmodconfig
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
arm                       multi_v4t_defconfig
h8300                     edosk2674_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
arc                         haps_hs_defconfig
powerpc                     tqm8548_defconfig
ia64                      gensparse_defconfig
sh                            hp6xx_defconfig
powerpc                        icon_defconfig
ia64                          tiger_defconfig
arc                           tb10x_defconfig
xtensa                       common_defconfig
arm                          pxa168_defconfig
mips                        nlm_xlp_defconfig
nios2                               defconfig
arm                          moxart_defconfig
mips                           rs90_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       maple_defconfig
arm                         s3c6400_defconfig
sh                          sdk7786_defconfig
powerpc                     ppa8548_defconfig
powerpc                      ppc44x_defconfig
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
riscv                    nommu_virt_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

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
