From: kernel test robot <lkp@intel.com>
Date: Thu, 18 Nov 2021 21:43:12 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 339f28964147db9cb5c45d84a9b9d86a8ceb9260
Message-ID: <61965870.jtxm+8mjUH9O+u6H%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: 339f28964147db9cb5c45d84a9b9d86a8ceb9260  ixgbevf: Add support for new mailbox communication between PF and VF

elapsed time: 723m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211118
i386                             allyesconfig
m68k                        mvme16x_defconfig
mips                        vocore2_defconfig
mips                         cobalt_defconfig
xtensa                    xip_kc705_defconfig
m68k                          atari_defconfig
mips                       rbtx49xx_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
powerpc                     mpc512x_defconfig
riscv                    nommu_k210_defconfig
arm                           sama7_defconfig
arm                        mvebu_v7_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
arm                      jornada720_defconfig
i386                             alldefconfig
arm                         lpc18xx_defconfig
arm                         socfpga_defconfig
sh                             espt_defconfig
sh                            hp6xx_defconfig
mips                           ip22_defconfig
mips                           gcw0_defconfig
arm                         axm55xx_defconfig
powerpc                      obs600_defconfig
powerpc                     tqm8555_defconfig
mips                      maltaaprp_defconfig
h8300                     edosk2674_defconfig
arm                         bcm2835_defconfig
alpha                            alldefconfig
mips                      fuloong2e_defconfig
arm                          pxa168_defconfig
sh                                  defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
mips                  cavium_octeon_defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                        mvme147_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 canyonlands_defconfig
m68k                          hp300_defconfig
arm                       imx_v6_v7_defconfig
arm                             mxs_defconfig
ia64                          tiger_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
powerpc                    klondike_defconfig
xtensa                          iss_defconfig
xtensa                              defconfig
arm                  randconfig-c002-20211118
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
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
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
