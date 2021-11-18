From: kernel test robot <lkp@intel.com>
Date: Thu, 18 Nov 2021 23:14:47 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 75082e7f46809432131749f4ecea66864d0f7438
Message-ID: <61966de7.w4eY//Xc8HLrrm9Z%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 75082e7f46809432131749f4ecea66864d0f7438  net: add missing include in include/net/gro.h

elapsed time: 1347m

configs tested: 192
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211118
powerpc                     redwood_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     kilauea_defconfig
i386                             allyesconfig
m68k                        mvme16x_defconfig
mips                        vocore2_defconfig
mips                         cobalt_defconfig
mips                           ip27_defconfig
powerpc                    klondike_defconfig
arm                       versatile_defconfig
ia64                            zx1_defconfig
microblaze                      mmu_defconfig
xtensa                    xip_kc705_defconfig
m68k                          atari_defconfig
mips                       rbtx49xx_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
powerpc                     mpc512x_defconfig
s390                       zfcpdump_defconfig
powerpc                     akebono_defconfig
arm                  colibri_pxa300_defconfig
xtensa                              defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     rainier_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
sh                     sh7710voipgw_defconfig
mips                           gcw0_defconfig
arm                         axm55xx_defconfig
powerpc                      obs600_defconfig
powerpc                     tqm8555_defconfig
mips                      maltaaprp_defconfig
arm                       mainstone_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
mips                           mtx1_defconfig
openrisc                 simple_smp_defconfig
h8300                     edosk2674_defconfig
arm                         bcm2835_defconfig
alpha                            alldefconfig
arm                          pxa168_defconfig
sh                                  defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        bcm47xx_defconfig
powerpc                     tqm8548_defconfig
arm                           sunxi_defconfig
xtensa                  nommu_kc705_defconfig
arm                           corgi_defconfig
m68k                       m5208evb_defconfig
mips                     cu1000-neo_defconfig
arm                           tegra_defconfig
sh                            migor_defconfig
powerpc                     mpc5200_defconfig
arc                              allyesconfig
m68k                            q40_defconfig
arm                          ixp4xx_defconfig
openrisc                    or1ksim_defconfig
arc                          axs103_defconfig
arm                         shannon_defconfig
arm                          gemini_defconfig
sh                          rsk7264_defconfig
powerpc                    socrates_defconfig
arm                     eseries_pxa_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
mips                  cavium_octeon_defconfig
powerpc                    amigaone_defconfig
m68k                        mvme147_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 canyonlands_defconfig
powerpc                       holly_defconfig
arm                            mps2_defconfig
arm                          collie_defconfig
sh                        edosk7705_defconfig
arm                  randconfig-c002-20211118
arm                  randconfig-c002-20211117
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a005-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a004-20211117
i386                 randconfig-a002-20211117
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
x86_64               randconfig-a005-20211117
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
arc                  randconfig-r043-20211118
riscv                randconfig-r042-20211118
s390                 randconfig-r044-20211118
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
x86_64               randconfig-a015-20211117
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a016-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
