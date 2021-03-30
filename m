From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Mar 2021 23:57:35 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 291cae45e184510a2dba7e8e1900a3a7d734b59a
Message-ID: <60634a6f.BFm3dNDrUNdKrsXl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 291cae45e184510a2dba7e8e1900a3a7d734b59a  i40e: Fix sparse warning: missing error code 'err'

elapsed time: 915m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm64                               defconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
m68k                            q40_defconfig
mips                     loongson1c_defconfig
sh                   sh7770_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
m68k                       m5208evb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         vf610m4_defconfig
arm                        cerfcube_defconfig
arm                          lpd270_defconfig
m68k                        stmark2_defconfig
powerpc                      pasemi_defconfig
xtensa                  audio_kc705_defconfig
arm                        magician_defconfig
arm                       spear13xx_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
sh                           sh2007_defconfig
arc                        nsimosci_defconfig
nios2                         3c120_defconfig
sh                          polaris_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        maltaup_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
powerpc                         ps3_defconfig
ia64                             allmodconfig
mips                          ath25_defconfig
m68k                        m5272c3_defconfig
arc                        vdk_hs38_defconfig
mips                       capcella_defconfig
arm                         lubbock_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
powerpc                    klondike_defconfig
mips                             allyesconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         shannon_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc8540_ads_defconfig
arm                          badge4_defconfig
openrisc                    or1ksim_defconfig
arm                       omap2plus_defconfig
powerpc                     tqm8541_defconfig
sparc64                             defconfig
mips                        jmr3927_defconfig
powerpc                     akebono_defconfig
arm                         socfpga_defconfig
m68k                          atari_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                         virt_defconfig
powerpc                          allmodconfig
arm                          simpad_defconfig
powerpc                   motionpro_defconfig
mips                malta_qemu_32r6_defconfig
arm                        keystone_defconfig
arm                          gemini_defconfig
arm                          exynos_defconfig
sh                            shmin_defconfig
sh                        edosk7705_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
mips                          malta_defconfig
s390                       zfcpdump_defconfig
arm                      tct_hammer_defconfig
x86_64                           alldefconfig
m68k                        mvme147_defconfig
powerpc                      ppc64e_defconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         cm_x300_defconfig
arm                             pxa_defconfig
nios2                            alldefconfig
arm                          collie_defconfig
arm                       mainstone_defconfig
sh                         ap325rxa_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
arm                         lpc32xx_defconfig
sh                     magicpanelr2_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
s390                          debug_defconfig
m68k                       m5249evb_defconfig
arm                       versatile_defconfig
sparc64                          alldefconfig
openrisc                 simple_smp_defconfig
mips                        nlm_xlp_defconfig
sparc                       sparc64_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
