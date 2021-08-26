From: kernel test robot <lkp@intel.com>
Date: Thu, 26 Aug 2021 12:34:16 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 a90ec84837325df4b9a6798c2cc0df202b5680bd
Message-ID: <612719c8.LeAo/f3YGd109eMB%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: a90ec84837325df4b9a6798c2cc0df202b5680bd  igc: Add support for PTP getcrosststamp()

elapsed time: 1865m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
i386                 randconfig-c001-20210825
powerpc                     ep8248e_defconfig
powerpc                      katmai_defconfig
xtensa                  audio_kc705_defconfig
powerpc                    gamecube_defconfig
mips                      maltasmvp_defconfig
powerpc                   microwatt_defconfig
sh                           se7343_defconfig
powerpc                 canyonlands_defconfig
arm                         assabet_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ep88xc_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
powerpc                     tqm5200_defconfig
arm                           tegra_defconfig
arm                         axm55xx_defconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
mips                     decstation_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            migor_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc8540_ads_defconfig
arm                             mxs_defconfig
arm                            pleb_defconfig
sh                            shmin_defconfig
sh                               j2_defconfig
powerpc                      arches_defconfig
arc                            hsdk_defconfig
mips                         tb0226_defconfig
arm                        neponset_defconfig
xtensa                    xip_kc705_defconfig
sparc                            alldefconfig
mips                    maltaup_xpa_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        multi_v7_defconfig
powerpc                      pcm030_defconfig
mips                           rs90_defconfig
powerpc                      ppc40x_defconfig
arm                          ixp4xx_defconfig
arm                       spear13xx_defconfig
powerpc                     ksi8560_defconfig
riscv                          rv32_defconfig
arm                       aspeed_g4_defconfig
sh                            titan_defconfig
arm                             rpc_defconfig
sparc                       sparc64_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arm                             pxa_defconfig
powerpc                     tqm8540_defconfig
microblaze                      mmu_defconfig
powerpc                       ebony_defconfig
arm                       netwinder_defconfig
arm                          imote2_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     tqm8541_defconfig
sh                   sh7770_generic_defconfig
arm                       imx_v4_v5_defconfig
sh                          sdk7786_defconfig
powerpc                        icon_defconfig
sh                          urquell_defconfig
mips                        qi_lb60_defconfig
arm                        magician_defconfig
arm                      jornada720_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210825
x86_64               randconfig-a015-20210825
x86_64               randconfig-a016-20210825
x86_64               randconfig-a013-20210825
x86_64               randconfig-a012-20210825
x86_64               randconfig-a011-20210825
i386                 randconfig-a011-20210825
i386                 randconfig-a016-20210825
i386                 randconfig-a012-20210825
i386                 randconfig-a014-20210825
i386                 randconfig-a013-20210825
i386                 randconfig-a015-20210825
arc                  randconfig-r043-20210825
riscv                randconfig-r042-20210825
s390                 randconfig-r044-20210825
x86_64               randconfig-a005-20210824
x86_64               randconfig-a006-20210824
x86_64               randconfig-a001-20210824
x86_64               randconfig-a003-20210824
x86_64               randconfig-a004-20210824
x86_64               randconfig-a002-20210824
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20210825
x86_64               randconfig-a001-20210825
x86_64               randconfig-a006-20210825
x86_64               randconfig-a003-20210825
x86_64               randconfig-a004-20210825
x86_64               randconfig-a002-20210825
i386                 randconfig-a006-20210825
i386                 randconfig-a001-20210825
i386                 randconfig-a002-20210825
i386                 randconfig-a005-20210825
i386                 randconfig-a004-20210825
i386                 randconfig-a003-20210825
hexagon              randconfig-r041-20210825
hexagon              randconfig-r045-20210825

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
