From: kernel test robot <lkp@intel.com>
Date: Sat, 04 Dec 2021 09:03:07 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 2765e7c0a88cdb8b7bfaf0b5cbae8cb7dc1cebcc
Message-ID: <61aabe4b.fFJylyXMUAiCyQSE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 2765e7c0a88cdb8b7bfaf0b5cbae8cb7dc1cebcc  i40e: Fix for failed to init adminq while VF reset

elapsed time: 1861m

configs tested: 159
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211202
arm                            hisi_defconfig
powerpc                     kmeter1_defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
s390                             allyesconfig
powerpc                      arches_defconfig
arc                          axs101_defconfig
m68k                        m5407c3_defconfig
mips                        maltaup_defconfig
sparc                       sparc64_defconfig
mips                        vocore2_defconfig
arm                        shmobile_defconfig
arm                       imx_v6_v7_defconfig
um                             i386_defconfig
powerpc                     sequoia_defconfig
arm                          ep93xx_defconfig
arm                          pxa3xx_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                         hackkit_defconfig
powerpc                     pseries_defconfig
h8300                    h8300h-sim_defconfig
powerpc                  mpc866_ads_defconfig
sh                          kfr2r09_defconfig
powerpc                     tqm8555_defconfig
m68k                            q40_defconfig
mips                         cobalt_defconfig
arm                      jornada720_defconfig
sh                          landisk_defconfig
um                                  defconfig
arm                       omap2plus_defconfig
powerpc                   bluestone_defconfig
arm                           omap1_defconfig
powerpc                        cell_defconfig
arm                         bcm2835_defconfig
arc                      axs103_smp_defconfig
arm                         palmz72_defconfig
xtensa                       common_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      pcm030_defconfig
powerpc                     powernv_defconfig
arm                        spear6xx_defconfig
parisc                generic-32bit_defconfig
sh                   sh7770_generic_defconfig
arm                             rpc_defconfig
powerpc                    gamecube_defconfig
sh                            shmin_defconfig
arm                       aspeed_g4_defconfig
sparc                            alldefconfig
powerpc                        warp_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20211203
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
x86_64               randconfig-a006-20211203
x86_64               randconfig-a005-20211203
x86_64               randconfig-a001-20211203
x86_64               randconfig-a002-20211203
x86_64               randconfig-a004-20211203
x86_64               randconfig-a003-20211203
i386                 randconfig-a001-20211203
i386                 randconfig-a005-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
x86_64               randconfig-a016-20211202
x86_64               randconfig-a011-20211202
x86_64               randconfig-a013-20211202
x86_64               randconfig-a014-20211202
x86_64               randconfig-a012-20211202
x86_64               randconfig-a015-20211202
i386                 randconfig-a013-20211204
i386                 randconfig-a016-20211204
i386                 randconfig-a011-20211204
i386                 randconfig-a014-20211204
i386                 randconfig-a012-20211204
i386                 randconfig-a015-20211204
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a006-20211202
x86_64               randconfig-a005-20211202
x86_64               randconfig-a001-20211202
x86_64               randconfig-a002-20211202
x86_64               randconfig-a004-20211202
x86_64               randconfig-a003-20211202
i386                 randconfig-a001-20211202
i386                 randconfig-a005-20211202
i386                 randconfig-a002-20211202
i386                 randconfig-a003-20211202
i386                 randconfig-a006-20211202
i386                 randconfig-a004-20211202
x86_64               randconfig-a016-20211203
x86_64               randconfig-a011-20211203
x86_64               randconfig-a013-20211203
x86_64               randconfig-a014-20211203
x86_64               randconfig-a015-20211203
x86_64               randconfig-a012-20211203
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a015-20211203
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
