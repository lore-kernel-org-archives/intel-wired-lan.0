From: kernel test robot <lkp@intel.com>
Date: Wed, 12 Jan 2022 23:19:40 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 61a0b1ca2485ddfe549cde9eccd93b06b53188e8
Message-ID: <61def18c.+igfjUUHr1jkeBdH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 61a0b1ca2485ddfe549cde9eccd93b06b53188e8  iavf: Add support for 50G/100G in AIM algorithm

elapsed time: 805m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220111
mips                 randconfig-c004-20220112
arc                                 defconfig
s390                             allmodconfig
arm                         cm_x300_defconfig
csky                             alldefconfig
powerpc                      ppc6xx_defconfig
powerpc                         wii_defconfig
arm                           u8500_defconfig
h8300                     edosk2674_defconfig
sh                           se7724_defconfig
m68k                           sun3_defconfig
arc                     haps_hs_smp_defconfig
sh                         microdev_defconfig
powerpc                     rainier_defconfig
sparc                            alldefconfig
sh                          rsk7203_defconfig
m68k                       m5275evb_defconfig
sh                        edosk7705_defconfig
arm                        realview_defconfig
powerpc                       holly_defconfig
powerpc                  storcenter_defconfig
arm                         assabet_defconfig
arm                            pleb_defconfig
sh                            hp6xx_defconfig
sh                            shmin_defconfig
h8300                       h8s-sim_defconfig
sh                           se7751_defconfig
microblaze                          defconfig
powerpc                    adder875_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc834x_itx_defconfig
microblaze                      mmu_defconfig
sh                           se7721_defconfig
sh                          polaris_defconfig
arm                        mini2440_defconfig
m68k                            q40_defconfig
sh                          sdk7780_defconfig
sh                        edosk7760_defconfig
mips                        jmr3927_defconfig
xtensa                           alldefconfig
h8300                            alldefconfig
arm                  randconfig-c002-20220111
arm                  randconfig-c002-20220112
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220111
arc                  randconfig-r043-20220112
arc                  randconfig-r043-20220111
s390                 randconfig-r044-20220111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220111
x86_64                        randconfig-c007
riscv                randconfig-c006-20220111
powerpc              randconfig-c003-20220111
i386                          randconfig-c001
mips                 randconfig-c004-20220111
arm                  randconfig-c002-20220112
riscv                randconfig-c006-20220112
powerpc              randconfig-c003-20220112
mips                 randconfig-c004-20220112
arm                      tct_hammer_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       cns3420vb_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc836x_mds_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220112
riscv                randconfig-r042-20220112
s390                 randconfig-r044-20220112
hexagon              randconfig-r041-20220112
hexagon              randconfig-r045-20220111
hexagon              randconfig-r041-20220111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
