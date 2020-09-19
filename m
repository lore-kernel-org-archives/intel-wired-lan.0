From: kernel test robot <lkp@intel.com>
Date: Sat, 19 Sep 2020 17:56:35 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:100GbE] BUILD SUCCESS
 405f4084b5b2e314d479c69f27536cda7889bd44
Message-ID: <5f65d5d3.B0Szd2rRvP1gOv56%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  100GbE
branch HEAD: 405f4084b5b2e314d479c69f27536cda7889bd44  ice: fix memory leak in ice_vsi_setup

elapsed time: 723m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      acadia_defconfig
arm                        neponset_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          pxa910_defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             alldefconfig
riscv                          rv32_defconfig
arm                       imx_v6_v7_defconfig
arm                             rpc_defconfig
c6x                              allyesconfig
arm                            u300_defconfig
arm                       omap2plus_defconfig
m68k                             alldefconfig
mips                          malta_defconfig
mips                        vocore2_defconfig
mips                           ip28_defconfig
m68k                       m5208evb_defconfig
s390                             allyesconfig
powerpc                      arches_defconfig
xtensa                              defconfig
arm                        spear3xx_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
sh                        sh7763rdp_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         mv78xx0_defconfig
arm                          badge4_defconfig
mips                      loongson3_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
powerpc                     tqm5200_defconfig
powerpc                    klondike_defconfig
arc                         haps_hs_defconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
mips                           ci20_defconfig
arm                          moxart_defconfig
parisc                           alldefconfig
powerpc                 linkstation_defconfig
mips                     decstation_defconfig
sh                        edosk7760_defconfig
powerpc                        cell_defconfig
mips                        omega2p_defconfig
arm                       versatile_defconfig
arm                            mps2_defconfig
powerpc                        icon_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200918
i386                 randconfig-a011-20200918
i386                 randconfig-a014-20200918
i386                 randconfig-a013-20200918
i386                 randconfig-a012-20200918
i386                 randconfig-a016-20200918
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
