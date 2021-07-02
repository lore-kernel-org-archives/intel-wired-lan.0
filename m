From: kernel test robot <lkp@intel.com>
Date: Fri, 02 Jul 2021 18:05:20 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 a066033403c006965ea54ed13134c3e71598af2c
Message-ID: <60dee4e0.4ub3koTmiwF6dYWO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: a066033403c006965ea54ed13134c3e71598af2c  iavf: Fix ping is lost after untrusted VF had tried to change MAC

elapsed time: 721m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip28_defconfig
arm                         assabet_defconfig
riscv                             allnoconfig
arm                          badge4_defconfig
mips                      fuloong2e_defconfig
arm                         vf610m4_defconfig
sh                           se7619_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7780_defconfig
mips                     cu1830-neo_defconfig
powerpc                    socrates_defconfig
arm                            lart_defconfig
ia64                        generic_defconfig
arc                                 defconfig
sh                           se7722_defconfig
sh                         ap325rxa_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
sh                        edosk7760_defconfig
arm                        magician_defconfig
mips                         bigsur_defconfig
s390                             allyesconfig
arc                     nsimosci_hs_defconfig
xtensa                  nommu_kc705_defconfig
sh                          rsk7203_defconfig
mips                     loongson2k_defconfig
m68k                        m5272c3_defconfig
arm                        multi_v7_defconfig
mips                         tb0287_defconfig
arm                       imx_v4_v5_defconfig
arm                       mainstone_defconfig
arm                        shmobile_defconfig
mips                           jazz_defconfig
riscv                            alldefconfig
powerpc               mpc834x_itxgp_defconfig
sh                        sh7785lcr_defconfig
arm                              alldefconfig
sh                          urquell_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                  storcenter_defconfig
mips                      pistachio_defconfig
sh                     magicpanelr2_defconfig
arc                     haps_hs_smp_defconfig
m68k                         apollo_defconfig
sh                         microdev_defconfig
xtensa                           alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
sh                               allmodconfig
parisc                              defconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
i386                 randconfig-a015-20210701
i386                 randconfig-a016-20210701
i386                 randconfig-a011-20210701
i386                 randconfig-a012-20210701
i386                 randconfig-a013-20210701
i386                 randconfig-a014-20210701
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-b001-20210630
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
