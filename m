From: kernel test robot <lkp@intel.com>
Date: Wed, 05 Jan 2022 19:34:56 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 b712941c8085e638bb92456e866ed3de4404e3d5
Message-ID: <61d58260.1grlBLjZzBNRinMI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: b712941c8085e638bb92456e866ed3de4404e3d5  iavf: Fix limit of total number of queues to active queues of VF

elapsed time: 721m

configs tested: 127
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20220105
sh                          polaris_defconfig
mips                      fuloong2e_defconfig
powerpc                    klondike_defconfig
powerpc                 canyonlands_defconfig
ia64                             allyesconfig
powerpc                           allnoconfig
powerpc                      bamboo_defconfig
arc                        nsim_700_defconfig
sh                        edosk7705_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 linkstation_defconfig
arm                           stm32_defconfig
powerpc                        warp_defconfig
arm                          lpd270_defconfig
arm                        shmobile_defconfig
arm                           u8500_defconfig
h8300                               defconfig
arm                         axm55xx_defconfig
sh                           sh2007_defconfig
i386                             alldefconfig
nds32                               defconfig
arm                            zeus_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                  randconfig-c002-20220105
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
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
x86_64               randconfig-a005-20220105
x86_64               randconfig-a001-20220105
x86_64               randconfig-a004-20220105
x86_64               randconfig-a006-20220105
x86_64               randconfig-a003-20220105
x86_64               randconfig-a002-20220105
i386                 randconfig-a003-20220105
i386                 randconfig-a005-20220105
i386                 randconfig-a004-20220105
i386                 randconfig-a006-20220105
i386                 randconfig-a002-20220105
i386                 randconfig-a001-20220105
arc                  randconfig-r043-20220105
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20220105
arm                  randconfig-c002-20220105
i386                 randconfig-c001-20220105
riscv                randconfig-c006-20220105
powerpc              randconfig-c003-20220105
x86_64               randconfig-c007-20220105
powerpc                  mpc885_ads_defconfig
arm                        multi_v5_defconfig
riscv                          rv32_defconfig
mips                           ip28_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     akebono_defconfig
arm                         hackkit_defconfig
arm                              alldefconfig
powerpc                      obs600_defconfig
powerpc                          g5_defconfig
arm                          collie_defconfig
mips                   sb1250_swarm_defconfig
arm                         socfpga_defconfig
mips                           ip22_defconfig
mips                        qi_lb60_defconfig
arm                           spitz_defconfig
arm                         s3c2410_defconfig
x86_64               randconfig-a012-20220105
x86_64               randconfig-a015-20220105
x86_64               randconfig-a014-20220105
x86_64               randconfig-a013-20220105
x86_64               randconfig-a011-20220105
x86_64               randconfig-a016-20220105
i386                 randconfig-a012-20220105
i386                 randconfig-a016-20220105
i386                 randconfig-a015-20220105
i386                 randconfig-a014-20220105
i386                 randconfig-a011-20220105
i386                 randconfig-a013-20220105
hexagon              randconfig-r041-20220105
hexagon              randconfig-r045-20220105
riscv                randconfig-r042-20220105

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
