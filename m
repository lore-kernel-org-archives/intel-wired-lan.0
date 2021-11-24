From: kernel test robot <lkp@intel.com>
Date: Wed, 24 Nov 2021 14:25:58 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 d6899bcb119fc81ae6fe5608110c59eff820b5a3
Message-ID: <619ddaf6.5MgcFeTcaK/yKsvQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: d6899bcb119fc81ae6fe5608110c59eff820b5a3  ice: fix adding different tunnels

elapsed time: 725m

configs tested: 195
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211124
i386                 randconfig-c001-20211123
powerpc              randconfig-c003-20211124
sh                      rts7751r2d1_defconfig
sh                        apsh4ad0a_defconfig
arm                         vf610m4_defconfig
powerpc                     mpc83xx_defconfig
powerpc                    socrates_defconfig
arc                            hsdk_defconfig
m68k                           sun3_defconfig
arc                     nsimosci_hs_defconfig
mips                   sb1250_swarm_defconfig
sh                          polaris_defconfig
arm                         bcm2835_defconfig
arm                       aspeed_g5_defconfig
arm                        cerfcube_defconfig
arm                           stm32_defconfig
xtensa                       common_defconfig
sh                         ecovec24_defconfig
m68k                        stmark2_defconfig
mips                           ip27_defconfig
arm                          gemini_defconfig
powerpc64                           defconfig
arm                        magician_defconfig
mips                       rbtx49xx_defconfig
h8300                     edosk2674_defconfig
arm                         hackkit_defconfig
m68k                            q40_defconfig
mips                       capcella_defconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
m68k                       m5249evb_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     tqm8555_defconfig
arm                          badge4_defconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                       netwinder_defconfig
arm                           h5000_defconfig
mips                           ip22_defconfig
sh                           se7780_defconfig
powerpc                       ebony_defconfig
openrisc                            defconfig
arc                        nsim_700_defconfig
powerpc                      acadia_defconfig
arm                         orion5x_defconfig
powerpc                    ge_imp3a_defconfig
mips                     decstation_defconfig
arm64                            alldefconfig
sh                   secureedge5410_defconfig
powerpc                     pseries_defconfig
powerpc                  iss476-smp_defconfig
arm                  colibri_pxa300_defconfig
sh                          rsk7264_defconfig
sh                            shmin_defconfig
arm                          lpd270_defconfig
arm                          collie_defconfig
powerpc                  mpc885_ads_defconfig
arm                        keystone_defconfig
arm                       versatile_defconfig
arc                     haps_hs_smp_defconfig
sh                          kfr2r09_defconfig
powerpc                     tqm8548_defconfig
arm                              alldefconfig
arm                         cm_x300_defconfig
powerpc                     pq2fads_defconfig
powerpc                     tqm5200_defconfig
h8300                               defconfig
powerpc                 mpc834x_mds_defconfig
ia64                          tiger_defconfig
arm                  colibri_pxa270_defconfig
sh                              ul2_defconfig
riscv                    nommu_k210_defconfig
arm                     eseries_pxa_defconfig
arm                        realview_defconfig
powerpc                        icon_defconfig
sh                           se7722_defconfig
riscv                            allmodconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
mips                          rm200_defconfig
powerpc                 mpc832x_mds_defconfig
mips                      maltaaprp_defconfig
s390                       zfcpdump_defconfig
mips                         rt305x_defconfig
powerpc                    adder875_defconfig
sh                           se7343_defconfig
ia64                      gensparse_defconfig
arm                       spear13xx_defconfig
sh                           se7206_defconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
sh                          r7785rp_defconfig
mips                    maltaup_xpa_defconfig
arm                        mvebu_v7_defconfig
arm                  randconfig-c002-20211123
arm                  randconfig-c002-20211124
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211123
x86_64               randconfig-a003-20211123
x86_64               randconfig-a006-20211123
x86_64               randconfig-a004-20211123
x86_64               randconfig-a005-20211123
x86_64               randconfig-a002-20211123
i386                 randconfig-a001-20211123
i386                 randconfig-a002-20211123
i386                 randconfig-a005-20211123
i386                 randconfig-a006-20211123
i386                 randconfig-a004-20211123
i386                 randconfig-a003-20211123
x86_64               randconfig-a011-20211124
x86_64               randconfig-a014-20211124
x86_64               randconfig-a012-20211124
x86_64               randconfig-a016-20211124
x86_64               randconfig-a013-20211124
x86_64               randconfig-a015-20211124
i386                 randconfig-a016-20211124
i386                 randconfig-a015-20211124
i386                 randconfig-a012-20211124
i386                 randconfig-a013-20211124
i386                 randconfig-a014-20211124
i386                 randconfig-a011-20211124
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211123
i386                 randconfig-c001-20211123
powerpc              randconfig-c003-20211123
arm                  randconfig-c002-20211123
riscv                randconfig-c006-20211123
x86_64               randconfig-c007-20211123
mips                 randconfig-c004-20211123
x86_64               randconfig-a014-20211123
x86_64               randconfig-a011-20211123
x86_64               randconfig-a012-20211123
x86_64               randconfig-a016-20211123
x86_64               randconfig-a013-20211123
x86_64               randconfig-a015-20211123
i386                 randconfig-a016-20211123
i386                 randconfig-a015-20211123
i386                 randconfig-a012-20211123
i386                 randconfig-a013-20211123
i386                 randconfig-a014-20211123
i386                 randconfig-a011-20211123
hexagon              randconfig-r045-20211123
s390                 randconfig-r044-20211123
hexagon              randconfig-r041-20211123
riscv                randconfig-r042-20211123
hexagon              randconfig-r045-20211124
hexagon              randconfig-r041-20211124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
