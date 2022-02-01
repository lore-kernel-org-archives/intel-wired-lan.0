From: kernel test robot <lkp@intel.com>
Date: Tue, 01 Feb 2022 23:15:42 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 6533e558c6505e94c3e0ed4281ed5e31ec985f4d
Message-ID: <61f94e9e.rlNI8U7ylRewDwzP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: 6533e558c6505e94c3e0ed4281ed5e31ec985f4d  i40e: Fix reset path while removing the driver

elapsed time: 727m

configs tested: 153
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220131
powerpc              randconfig-c003-20220131
i386                          randconfig-c001
sh                          rsk7203_defconfig
mips                           xway_defconfig
um                               alldefconfig
powerpc                 mpc834x_mds_defconfig
sh                            titan_defconfig
m68k                           sun3_defconfig
xtensa                       common_defconfig
arc                        nsimosci_defconfig
sh                          rsk7269_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     sequoia_defconfig
arm                       multi_v4t_defconfig
arc                          axs103_defconfig
powerpc                    sam440ep_defconfig
mips                      fuloong2e_defconfig
arm                       aspeed_g5_defconfig
mips                         tb0226_defconfig
parisc                           alldefconfig
m68k                       m5208evb_defconfig
powerpc                      arches_defconfig
riscv                    nommu_k210_defconfig
arm                           stm32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     asp8347_defconfig
arm                      footbridge_defconfig
sh                          kfr2r09_defconfig
sh                           se7724_defconfig
ia64                        generic_defconfig
sh                           se7343_defconfig
sh                             shx3_defconfig
sh                     sh7710voipgw_defconfig
h8300                            allyesconfig
arm                          gemini_defconfig
powerpc                       eiger_defconfig
powerpc                        cell_defconfig
microblaze                      mmu_defconfig
sh                               alldefconfig
m68k                          sun3x_defconfig
mips                      maltasmvp_defconfig
powerpc                      bamboo_defconfig
mips                        jmr3927_defconfig
openrisc                         alldefconfig
mips                         db1xxx_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220130
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
i386                          randconfig-c001
riscv                randconfig-c006-20220201
powerpc              randconfig-c003-20220201
mips                 randconfig-c004-20220201
arm                  randconfig-c002-20220201
powerpc                          allyesconfig
arm                             mxs_defconfig
arm                        spear3xx_defconfig
arm                           sama7_defconfig
powerpc                     kilauea_defconfig
mips                           ip22_defconfig
arm                       versatile_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
mips                       lemote2f_defconfig
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a011-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
