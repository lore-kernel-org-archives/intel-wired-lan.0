From: kernel test robot <lkp@intel.com>
Date: Thu, 10 Dec 2020 19:29:22 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 da9482332d581bb8ea69eca34d7f75a3c6247475
Message-ID: <5fd20692.A9XFfbZfQNr/7RoC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  master
branch HEAD: da9482332d581bb8ea69eca34d7f75a3c6247475  ptp: clockmatrix: deprecate firmware older than 4.8.7

elapsed time: 744m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          kfr2r09_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
xtensa                generic_kc705_defconfig
s390                             allyesconfig
mips                         mpc30x_defconfig
openrisc                 simple_smp_defconfig
m68k                        stmark2_defconfig
powerpc                      tqm8xx_defconfig
arc                        vdk_hs38_defconfig
powerpc                      walnut_defconfig
ia64                         bigsur_defconfig
m68k                         apollo_defconfig
powerpc                     tqm8555_defconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
um                             i386_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           viper_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                          rsk7264_defconfig
sh                             sh03_defconfig
arm                          simpad_defconfig
powerpc                  iss476-smp_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7760_defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0219_defconfig
mips                     cu1000-neo_defconfig
powerpc                     rainier_defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
arm                       versatile_defconfig
powerpc                        icon_defconfig
arc                              allyesconfig
arm                           tegra_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
arm                          ep93xx_defconfig
arm                        cerfcube_defconfig
arm                       multi_v4t_defconfig
riscv                    nommu_k210_defconfig
powerpc                 mpc8540_ads_defconfig
sh                             shx3_defconfig
powerpc                      pmac32_defconfig
nios2                            alldefconfig
arm                       aspeed_g5_defconfig
powerpc                 canyonlands_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
