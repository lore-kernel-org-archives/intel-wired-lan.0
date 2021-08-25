From: kernel test robot <lkp@intel.com>
Date: Thu, 26 Aug 2021 03:02:33 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 6084fa7f75514f91862da8ac710eb1f0c881cca6
Message-ID: <612693c9.6Q1ikuMLZvDSFCCP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 6084fa7f75514f91862da8ac710eb1f0c881cca6  i40e: Fix issue when maximum queues is exceeded

elapsed time: 1083m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       ebony_defconfig
arm                           sama5_defconfig
m68k                          amiga_defconfig
m68k                          sun3x_defconfig
xtensa                       common_defconfig
h8300                               defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ep88xc_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
powerpc                     tqm5200_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
mips                     decstation_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            migor_defconfig
arm                          pcm027_defconfig
mips                      loongson3_defconfig
mips                        nlm_xlp_defconfig
m68k                                defconfig
arc                          axs103_defconfig
xtensa                         virt_defconfig
mips                     loongson2k_defconfig
powerpc                    socrates_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath25_defconfig
arm                       imx_v4_v5_defconfig
sh                          sdk7786_defconfig
powerpc                        icon_defconfig
m68k                          multi_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a014-20210825
x86_64               randconfig-a015-20210825
x86_64               randconfig-a016-20210825
x86_64               randconfig-a013-20210825
x86_64               randconfig-a012-20210825
x86_64               randconfig-a011-20210825
i386                 randconfig-a011-20210825
i386                 randconfig-a016-20210825
i386                 randconfig-a012-20210825
i386                 randconfig-a014-20210825
i386                 randconfig-a013-20210825
i386                 randconfig-a015-20210825
arc                  randconfig-r043-20210825
riscv                randconfig-r042-20210825
s390                 randconfig-r044-20210825
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20210825
x86_64               randconfig-a001-20210825
x86_64               randconfig-a006-20210825
x86_64               randconfig-a003-20210825
x86_64               randconfig-a004-20210825
x86_64               randconfig-a002-20210825

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
