From: kernel test robot <lkp@intel.com>
Date: Thu, 25 Feb 2021 20:54:09 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 045cf476dfdf9cae79a59523d513f3d9bf0699a6
Message-ID: <60379df1.eaO7LgZnHroPseoe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 045cf476dfdf9cae79a59523d513f3d9bf0699a6  i40e: Fix NULL ptr dereference on VSI filter sync

elapsed time: 722m

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
nios2                            allyesconfig
arc                        nsim_700_defconfig
powerpc                     stx_gp3_defconfig
um                            kunit_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
mips                        omega2p_defconfig
s390                             allmodconfig
powerpc                     akebono_defconfig
h8300                       h8s-sim_defconfig
sh                          rsk7264_defconfig
mips                            e55_defconfig
powerpc                     kilauea_defconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_rdb_defconfig
i386                                defconfig
arm                  colibri_pxa270_defconfig
sh                     sh7710voipgw_defconfig
arm                           sama5_defconfig
riscv                            allyesconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
sh                      rts7751r2d1_defconfig
mips                           gcw0_defconfig
arm                         vf610m4_defconfig
arm                             ezx_defconfig
arm                        oxnas_v6_defconfig
mips                      maltaaprp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
i386                 randconfig-a013-20210223
i386                 randconfig-a012-20210223
i386                 randconfig-a011-20210223
i386                 randconfig-a014-20210223
i386                 randconfig-a016-20210223
i386                 randconfig-a015-20210223
riscv                    nommu_k210_defconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
