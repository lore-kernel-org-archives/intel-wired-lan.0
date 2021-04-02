From: kernel test robot <lkp@intel.com>
Date: Fri, 02 Apr 2021 14:52:21 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 c3214de929dbf1b7374add8bbed30ce82b197bbb
Message-ID: <6066bf25.jJCVI7dlQ/iDy4jt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: c3214de929dbf1b7374add8bbed30ce82b197bbb  i40e: Fix display statistics for veb_tc

elapsed time: 726m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
xtensa                generic_kc705_defconfig
sh                            titan_defconfig
arm                      footbridge_defconfig
arm                             ezx_defconfig
arm                        trizeps4_defconfig
alpha                            alldefconfig
arm                           sama5_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
mips                     cu1830-neo_defconfig
mips                     cu1000-neo_defconfig
mips                             allmodconfig
mips                      pistachio_defconfig
riscv                          rv32_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
mips                            gpr_defconfig
powerpc                     tqm8540_defconfig
sh                     magicpanelr2_defconfig
powerpc                  mpc866_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          atari_defconfig
x86_64                           alldefconfig
arm                          exynos_defconfig
mips                        nlm_xlp_defconfig
arm                         shannon_defconfig
arm                       omap2plus_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      acadia_defconfig
powerpc                     mpc512x_defconfig
sh                   rts7751r2dplus_defconfig
m68k                          hp300_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        mvme16x_defconfig
arc                        nsim_700_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8560_defconfig
powerpc                      tqm8xx_defconfig
mips                           ip27_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
m68k                           sun3_defconfig
arm                            pleb_defconfig
mips                          malta_defconfig
arm                        magician_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
h8300                       h8s-sim_defconfig
um                                allnoconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
arc                     nsimosci_hs_defconfig
mips                        qi_lb60_defconfig
mips                       rbtx49xx_defconfig
arm                           tegra_defconfig
powerpc                       maple_defconfig
arm                             pxa_defconfig
powerpc                     rainier_defconfig
sh                        dreamcast_defconfig
mips                            e55_defconfig
riscv                               defconfig
mips                        vocore2_defconfig
s390                                defconfig
powerpc                 mpc8315_rdb_defconfig
sh                        edosk7760_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                         ecovec24_defconfig
mips                      maltaaprp_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
xtensa                       common_defconfig
arm                          ixp4xx_defconfig
arm                     am200epdkit_defconfig
mips                           ci20_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7750_defconfig
riscv                    nommu_k210_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
s390                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
i386                 randconfig-a006-20210402
i386                 randconfig-a003-20210402
i386                 randconfig-a001-20210402
i386                 randconfig-a004-20210402
i386                 randconfig-a005-20210402
i386                 randconfig-a002-20210402
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
