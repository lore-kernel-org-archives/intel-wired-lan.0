From: kernel test robot <lkp@intel.com>
Date: Sat, 24 Jul 2021 23:22:29 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 b370eb8c4502c5e7ea0de48d7642ba632861f610
Message-ID: <60fc3035.P5lsgasfB8h99KJ+%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: b370eb8c4502c5e7ea0de48d7642ba632861f610  i40e: Fix ATR queue selection

elapsed time: 721m

configs tested: 124
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210723
i386                 randconfig-c001-20210724
powerpc                      tqm8xx_defconfig
powerpc                      obs600_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
powerpc                        icon_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
arm                         lubbock_defconfig
h8300                               defconfig
mips                      loongson3_defconfig
m68k                         amcore_defconfig
mips                    maltaup_xpa_defconfig
xtensa                       common_defconfig
arm                            mps2_defconfig
powerpc                  iss476-smp_defconfig
sparc                       sparc64_defconfig
powerpc                          allmodconfig
powerpc                     akebono_defconfig
arm                     davinci_all_defconfig
mips                     cu1000-neo_defconfig
m68k                        m5407c3_defconfig
sh                          sdk7786_defconfig
mips                        nlm_xlp_defconfig
m68k                       m5208evb_defconfig
arm                            lart_defconfig
ia64                        generic_defconfig
arm                            dove_defconfig
sh                        sh7785lcr_defconfig
xtensa                    xip_kc705_defconfig
arm                            xcep_defconfig
arm                             ezx_defconfig
mips                      pistachio_defconfig
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
powerpc                           allnoconfig
i386                 randconfig-a005-20210724
i386                 randconfig-a003-20210724
i386                 randconfig-a004-20210724
i386                 randconfig-a002-20210724
i386                 randconfig-a001-20210724
i386                 randconfig-a006-20210724
i386                 randconfig-a005-20210723
i386                 randconfig-a003-20210723
i386                 randconfig-a004-20210723
i386                 randconfig-a002-20210723
i386                 randconfig-a001-20210723
i386                 randconfig-a006-20210723
x86_64               randconfig-a011-20210723
x86_64               randconfig-a016-20210723
x86_64               randconfig-a013-20210723
x86_64               randconfig-a014-20210723
x86_64               randconfig-a012-20210723
x86_64               randconfig-a015-20210723
i386                 randconfig-a016-20210724
i386                 randconfig-a013-20210724
i386                 randconfig-a012-20210724
i386                 randconfig-a014-20210724
i386                 randconfig-a011-20210724
i386                 randconfig-a015-20210724
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
x86_64               randconfig-c001-20210723
x86_64               randconfig-c001-20210724
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723
x86_64               randconfig-a011-20210724
x86_64               randconfig-a016-20210724
x86_64               randconfig-a013-20210724
x86_64               randconfig-a014-20210724
x86_64               randconfig-a012-20210724
x86_64               randconfig-a015-20210724

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
