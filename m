From: kernel test robot <lkp@intel.com>
Date: Thu, 11 Mar 2021 22:05:08 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:1GbE] BUILD SUCCESS
 75e3560bc704ed78377869fa362223a6b17916f5
Message-ID: <604a2394.VBqvVUzGo3CFVE8p%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 1GbE
branch HEAD: 75e3560bc704ed78377869fa362223a6b17916f5  e1000e: Fix error handling in e1000_set_d0_lplu_state_82571

elapsed time: 721m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7724_defconfig
mips                        omega2p_defconfig
arm                        oxnas_v6_defconfig
arm                       versatile_defconfig
sh                           sh2007_defconfig
arm                           viper_defconfig
mips                        vocore2_defconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
arm                  colibri_pxa300_defconfig
powerpc                  mpc866_ads_defconfig
m68k                        m5307c3_defconfig
mips                          malta_defconfig
arm                          badge4_defconfig
mips                      pic32mzda_defconfig
powerpc                          allmodconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
arm                            mps2_defconfig
arm                         hackkit_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     pseries_defconfig
arm                            xcep_defconfig
sh                              ul2_defconfig
mips                      maltaaprp_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
