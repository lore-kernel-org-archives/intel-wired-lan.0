From: kernel test robot <lkp@intel.com>
Date: Sat, 10 Jul 2021 20:00:28 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 c76f20222c17011e295baee71dbaf7124984636c
Message-ID: <60e98bdc.sm1GOeFqNT2S2P+P%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: c76f20222c17011e295baee71dbaf7124984636c  ice: fix build issue if CONFIG_1588_PTP_CLOCk=m

elapsed time: 721m

configs tested: 122
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                     edosk2674_defconfig
arm                        spear6xx_defconfig
sh                        edosk7760_defconfig
m68k                       m5249evb_defconfig
sh                            migor_defconfig
mips                      malta_kvm_defconfig
arm                          pcm027_defconfig
mips                       lemote2f_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7705_defconfig
powerpc                      mgcoge_defconfig
powerpc64                           defconfig
h8300                    h8300h-sim_defconfig
arm                         s3c2410_defconfig
arm                       spear13xx_defconfig
powerpc                       maple_defconfig
m68k                        m5307c3_defconfig
powerpc                    gamecube_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
xtensa                generic_kc705_defconfig
sh                              ul2_defconfig
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
arm                       aspeed_g5_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      obs600_defconfig
sh                           se7343_defconfig
sh                          rsk7201_defconfig
sh                           se7751_defconfig
mips                        vocore2_defconfig
sh                             sh03_defconfig
powerpc                      cm5200_defconfig
arm                         s5pv210_defconfig
riscv                             allnoconfig
sh                           sh2007_defconfig
arm                        mvebu_v5_defconfig
mips                       capcella_defconfig
mips                      pistachio_defconfig
s390                             allyesconfig
powerpc                     rainier_defconfig
arm                      footbridge_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc834x_mds_defconfig
x86_64                            allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210709
x86_64               randconfig-a005-20210709
x86_64               randconfig-a002-20210709
x86_64               randconfig-a006-20210709
x86_64               randconfig-a003-20210709
x86_64               randconfig-a001-20210709
i386                 randconfig-a006-20210709
i386                 randconfig-a004-20210709
i386                 randconfig-a001-20210709
i386                 randconfig-a003-20210709
i386                 randconfig-a005-20210709
i386                 randconfig-a002-20210709
i386                 randconfig-a015-20210709
i386                 randconfig-a016-20210709
i386                 randconfig-a011-20210709
i386                 randconfig-a012-20210709
i386                 randconfig-a013-20210709
i386                 randconfig-a014-20210709
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210709
x86_64               randconfig-a015-20210709
x86_64               randconfig-a011-20210709
x86_64               randconfig-a012-20210709
x86_64               randconfig-a014-20210709
x86_64               randconfig-a016-20210709
x86_64               randconfig-a013-20210709

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
