From: kernel test robot <lkp@intel.com>
Date: Fri, 20 Nov 2020 14:06:46 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 657bc1d10bfc23ac06d5d687ce45826c760744f9
Message-ID: <5fb75cf6.uhdAseX9OAojlJrl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  master
branch HEAD: 657bc1d10bfc23ac06d5d687ce45826c760744f9  r8153_ecm: avoid to be prior to r8152 driver

elapsed time: 776m

configs tested: 133
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
c6x                        evmc6678_defconfig
m68k                          amiga_defconfig
arm                        keystone_defconfig
powerpc                     mpc5200_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
arm                     davinci_all_defconfig
arm                         lpc18xx_defconfig
xtensa                  audio_kc705_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           sh2007_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
arm                       multi_v4t_defconfig
mips                         tb0287_defconfig
m68k                            q40_defconfig
powerpc                     ppa8548_defconfig
arc                        nsimosci_defconfig
powerpc                     akebono_defconfig
arm                          moxart_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
powerpc                     tqm8548_defconfig
mips                     cu1830-neo_defconfig
arm                         bcm2835_defconfig
mips                          rm200_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8540_defconfig
arm                        trizeps4_defconfig
powerpc                     powernv_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                        nlm_xlp_defconfig
powerpc                        fsp2_defconfig
arm                         s5pv210_defconfig
arm                          tango4_defconfig
arm                          badge4_defconfig
arm                              alldefconfig
arm                            zeus_defconfig
parisc                              defconfig
mips                     cu1000-neo_defconfig
arm                          pcm027_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
mips                      bmips_stb_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                                defconfig
powerpc                    sam440ep_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc                     tqm8555_defconfig
mips                         tb0226_defconfig
powerpc                  mpc866_ads_defconfig
mips                        omega2p_defconfig
sh                           se7712_defconfig
s390                                defconfig
arc                         haps_hs_defconfig
powerpc                       eiger_defconfig
powerpc                           allnoconfig
ia64                             allmodconfig
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
xtensa                           allyesconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a015-20201119
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
