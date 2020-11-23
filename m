From: kernel test robot <lkp@intel.com>
Date: Mon, 23 Nov 2020 17:22:05 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 cc8971275fe3eea2c629a5a0edb89b058c9167c8
Message-ID: <5fbb7f3d.SB9abPivNrF09Uud%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  1GbE
branch HEAD: cc8971275fe3eea2c629a5a0edb89b058c9167c8  e1000e: fix S0ix flow to allow S0i3.2 subset entry

elapsed time: 721m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          polaris_defconfig
arm                         s3c6400_defconfig
mips                        omega2p_defconfig
arm                          ep93xx_defconfig
xtensa                           allyesconfig
powerpc                 linkstation_defconfig
arm                         s5pv210_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     pq2fads_defconfig
arm                         bcm2835_defconfig
arm                         lubbock_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
arm                            lart_defconfig
m68k                          atari_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
arm                            qcom_defconfig
c6x                        evmc6678_defconfig
powerpc                       ebony_defconfig
sparc                               defconfig
arc                 nsimosci_hs_smp_defconfig
c6x                        evmc6472_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        mini2440_defconfig
arm                        magician_defconfig
mips                      pic32mzda_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
sparc                       sparc64_defconfig
mips                    maltaup_xpa_defconfig
mips                      maltasmvp_defconfig
mips                  maltasmvp_eva_defconfig
mips                          rm200_defconfig
sh                            shmin_defconfig
h8300                               defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201123
i386                 randconfig-a003-20201123
i386                 randconfig-a002-20201123
i386                 randconfig-a005-20201123
i386                 randconfig-a001-20201123
i386                 randconfig-a006-20201123
x86_64               randconfig-a015-20201123
x86_64               randconfig-a011-20201123
x86_64               randconfig-a014-20201123
x86_64               randconfig-a016-20201123
x86_64               randconfig-a012-20201123
x86_64               randconfig-a013-20201123
i386                 randconfig-a012-20201123
i386                 randconfig-a013-20201123
i386                 randconfig-a011-20201123
i386                 randconfig-a016-20201123
i386                 randconfig-a014-20201123
i386                 randconfig-a015-20201123
i386                 randconfig-a012-20201122
i386                 randconfig-a013-20201122
i386                 randconfig-a011-20201122
i386                 randconfig-a016-20201122
i386                 randconfig-a014-20201122
i386                 randconfig-a015-20201122
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                               rhel-8.3
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201123
x86_64               randconfig-a003-20201123
x86_64               randconfig-a004-20201123
x86_64               randconfig-a005-20201123
x86_64               randconfig-a002-20201123
x86_64               randconfig-a001-20201123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
