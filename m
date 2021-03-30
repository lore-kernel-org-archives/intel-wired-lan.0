From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Mar 2021 14:25:11 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 b7eeb52721fe417730fc5adc5cbeeb5fe349ab26
Message-ID: <6062c447.AsNei0iroZFNxN8D%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: b7eeb52721fe417730fc5adc5cbeeb5fe349ab26  ice: Cleanup fltr list in case of allocation issues

elapsed time: 732m

configs tested: 179
configs skipped: 3

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
arm64                            alldefconfig
xtensa                              defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      pcm030_defconfig
powerpc                    socrates_defconfig
mips                       lemote2f_defconfig
powerpc                      ppc44x_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                            hsdk_defconfig
sh                            hp6xx_defconfig
powerpc                      makalu_defconfig
m68k                            q40_defconfig
mips                     loongson1c_defconfig
sh                   sh7770_generic_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                            migor_defconfig
mips                         cobalt_defconfig
powerpc                      pasemi_defconfig
xtensa                  audio_kc705_defconfig
arm                         vf610m4_defconfig
arm                        magician_defconfig
arm                       spear13xx_defconfig
powerpc                           allnoconfig
powerpc                    sam440ep_defconfig
powerpc                  storcenter_defconfig
parisc                           allyesconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                       ebony_defconfig
sh                            titan_defconfig
sparc64                             defconfig
arc                        vdk_hs38_defconfig
mips                       capcella_defconfig
arm                         lubbock_defconfig
powerpc                       ppc64_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
mips                      loongson3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         tb0219_defconfig
mips                            ar7_defconfig
arm                     am200epdkit_defconfig
arm                          pxa910_defconfig
arm                          collie_defconfig
xtensa                generic_kc705_defconfig
arm                         lpc18xx_defconfig
powerpc                     rainier_defconfig
um                                  defconfig
powerpc                   motionpro_defconfig
mips                           gcw0_defconfig
arm                          gemini_defconfig
powerpc                     ppa8548_defconfig
s390                       zfcpdump_defconfig
arm                       omap2plus_defconfig
m68k                          sun3x_defconfig
mips                        jmr3927_defconfig
sh                           se7724_defconfig
m68k                        m5407c3_defconfig
arm                          pcm027_defconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                    vt8500_v6_v7_defconfig
sh                          r7785rp_defconfig
arm                            hisi_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          exynos_defconfig
sh                            shmin_defconfig
sh                        edosk7705_defconfig
powerpc                     mpc5200_defconfig
powerpc                  mpc885_ads_defconfig
mips                     loongson1b_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
arm                         assabet_defconfig
arm                      tct_hammer_defconfig
x86_64                           alldefconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
powerpc                      ppc64e_defconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
arc                        nsimosci_defconfig
mips                      pic32mzda_defconfig
m68k                       m5275evb_defconfig
mips                        nlm_xlp_defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
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
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
