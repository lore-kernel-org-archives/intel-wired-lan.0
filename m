From: kernel test robot <lkp@intel.com>
Date: Tue, 08 Jun 2021 14:32:45 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 de0220d2b16609f468f5bc484569eb85b2099495
Message-ID: <60bf0f0d.ifAPykw2aM/jTKsJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: de0220d2b16609f468f5bc484569eb85b2099495  iavf: Fix for setting queues to 0

elapsed time: 726m

configs tested: 170
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     davinci_all_defconfig
powerpc64                           defconfig
powerpc                     sbc8548_defconfig
arm                       versatile_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     akebono_defconfig
openrisc                  or1klitex_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v7_defconfig
mips                         tb0219_defconfig
sh                ecovec24-romimage_defconfig
arm                            mmp2_defconfig
arm                           tegra_defconfig
xtensa                           alldefconfig
powerpc                      makalu_defconfig
mips                     loongson2k_defconfig
mips                          rm200_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           omap1_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                             sh03_defconfig
arm                           sama5_defconfig
mips                        omega2p_defconfig
s390                             alldefconfig
sh                            migor_defconfig
m68k                            q40_defconfig
powerpc                 mpc8272_ads_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7343_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
sh                   sh7724_generic_defconfig
mips                       capcella_defconfig
mips                           ip32_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                            lart_defconfig
riscv                          rv32_defconfig
powerpc                   motionpro_defconfig
ia64                             allmodconfig
arm                      jornada720_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    adder875_defconfig
x86_64                           alldefconfig
arm                            hisi_defconfig
arm                             pxa_defconfig
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
m68k                                defconfig
xtensa                           allyesconfig
arc                            hsdk_defconfig
s390                                defconfig
arc                          axs103_defconfig
mips                       bmips_be_defconfig
powerpc                      pasemi_defconfig
sh                          r7780mp_defconfig
arm                        realview_defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
mips                         db1xxx_defconfig
arm                      footbridge_defconfig
powerpc                 mpc832x_mds_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
powerpc                         ps3_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5208evb_defconfig
sparc                       sparc64_defconfig
powerpc                 canyonlands_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           ip28_defconfig
powerpc                      ep88xc_defconfig
mips                        maltaup_defconfig
arm                        vexpress_defconfig
arm                            qcom_defconfig
mips                           mtx1_defconfig
arm                         s5pv210_defconfig
nios2                               defconfig
arc                        vdk_hs38_defconfig
nios2                         10m50_defconfig
parisc                              defconfig
sh                         microdev_defconfig
sh                     magicpanelr2_defconfig
sh                      rts7751r2d1_defconfig
sh                                  defconfig
powerpc                        warp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                        fsp2_defconfig
x86_64                              defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
csky                                defconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210607
i386                 randconfig-a006-20210607
i386                 randconfig-a004-20210607
i386                 randconfig-a001-20210607
i386                 randconfig-a002-20210607
i386                 randconfig-a005-20210607
x86_64               randconfig-a015-20210607
x86_64               randconfig-a011-20210607
x86_64               randconfig-a014-20210607
x86_64               randconfig-a012-20210607
x86_64               randconfig-a016-20210607
x86_64               randconfig-a013-20210607
i386                 randconfig-a015-20210607
i386                 randconfig-a011-20210607
i386                 randconfig-a012-20210607
i386                 randconfig-a013-20210607
i386                 randconfig-a016-20210607
i386                 randconfig-a014-20210607
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210607
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
