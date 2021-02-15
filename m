From: kernel test robot <lkp@intel.com>
Date: Tue, 16 Feb 2021 05:18:25 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 9db0da9087c3dcf2f0b2b93b4e5e652310f1bbcd
Message-ID: <602ae521.4AYMJdmrTyepkAFn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 9db0da9087c3dcf2f0b2b93b4e5e652310f1bbcd  iavf: Fix return of set the new channel count

elapsed time: 725m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
m68k                          hp300_defconfig
sh                          rsk7264_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     rainier_defconfig
arm                         nhk8815_defconfig
arm                      tct_hammer_defconfig
sh                           se7751_defconfig
ia64                      gensparse_defconfig
arm                           viper_defconfig
sh                           se7721_defconfig
arm                             pxa_defconfig
mips                          rm200_defconfig
powerpc                     pseries_defconfig
arm                          badge4_defconfig
powerpc64                        alldefconfig
xtensa                    xip_kc705_defconfig
m68k                       m5208evb_defconfig
openrisc                            defconfig
mips                        omega2p_defconfig
sh                                  defconfig
sh                           se7722_defconfig
sh                          landisk_defconfig
arm                         socfpga_defconfig
mips                       bmips_be_defconfig
sh                           se7343_defconfig
arm                        neponset_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
riscv                    nommu_virt_defconfig
arm                           tegra_defconfig
s390                                defconfig
riscv                    nommu_k210_defconfig
mips                           ip27_defconfig
arm                            pleb_defconfig
arm                      jornada720_defconfig
powerpc                      chrp32_defconfig
arm                         hackkit_defconfig
c6x                        evmc6457_defconfig
arc                      axs103_smp_defconfig
powerpc                   lite5200b_defconfig
m68k                        mvme147_defconfig
powerpc                      obs600_defconfig
powerpc                     sbc8548_defconfig
xtensa                  audio_kc705_defconfig
arm                         vf610m4_defconfig
mips                          ath79_defconfig
powerpc                    sam440ep_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          atari_defconfig
mips                           ci20_defconfig
powerpc                       maple_defconfig
powerpc                      cm5200_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a003-20210215
i386                 randconfig-a005-20210215
i386                 randconfig-a002-20210215
i386                 randconfig-a006-20210215
i386                 randconfig-a004-20210215
i386                 randconfig-a001-20210215
x86_64               randconfig-a016-20210215
x86_64               randconfig-a013-20210215
x86_64               randconfig-a012-20210215
x86_64               randconfig-a015-20210215
x86_64               randconfig-a014-20210215
x86_64               randconfig-a011-20210215
i386                 randconfig-a016-20210215
i386                 randconfig-a014-20210215
i386                 randconfig-a012-20210215
i386                 randconfig-a013-20210215
i386                 randconfig-a011-20210215
i386                 randconfig-a015-20210215
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210215
x86_64               randconfig-a002-20210215
x86_64               randconfig-a001-20210215
x86_64               randconfig-a004-20210215
x86_64               randconfig-a005-20210215
x86_64               randconfig-a006-20210215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
