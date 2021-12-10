From: kernel test robot <lkp@intel.com>
Date: Fri, 10 Dec 2021 13:41:48 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 19961780f115769c8f998fa6b05b48ce499b21fc
Message-ID: <61b2e89c.7qXFyy/9WIq+3mO0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 19961780f115769c8f998fa6b05b48ce499b21fc  Merge branch 'net-wwan-iosm-bug-fixes'

elapsed time: 804m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211209
i386                 randconfig-c001-20211210
powerpc                    socrates_defconfig
sh                          r7780mp_defconfig
m68k                       m5208evb_defconfig
sh                          sdk7780_defconfig
mips                        qi_lb60_defconfig
powerpc                    sam440ep_defconfig
m68k                        m5307c3_defconfig
arm                           sunxi_defconfig
xtensa                  cadence_csp_defconfig
m68k                          amiga_defconfig
powerpc                           allnoconfig
mips                           ip28_defconfig
sh                          polaris_defconfig
nios2                         10m50_defconfig
powerpc                     asp8347_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
arm                             mxs_defconfig
sh                        apsh4ad0a_defconfig
alpha                            allyesconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     kilauea_defconfig
powerpc                      makalu_defconfig
sh                          lboxre2_defconfig
mips                     loongson1b_defconfig
arm                       aspeed_g5_defconfig
sh                          sdk7786_defconfig
ia64                          tiger_defconfig
powerpc                     tqm8540_defconfig
arm                        oxnas_v6_defconfig
nios2                            alldefconfig
sh                          landisk_defconfig
powerpc                         wii_defconfig
arm                           tegra_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
sh                           se7712_defconfig
arm                             rpc_defconfig
sparc                       sparc32_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 xes_mpc85xx_defconfig
nds32                             allnoconfig
sh                           se7705_defconfig
powerpc                      mgcoge_defconfig
arm                           sama7_defconfig
sh                          rsk7201_defconfig
mips                         cobalt_defconfig
arm                        multi_v5_defconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
powerpc                     rainier_defconfig
arm                            dove_defconfig
nds32                               defconfig
m68k                         apollo_defconfig
arm                     am200epdkit_defconfig
mips                         mpc30x_defconfig
powerpc                 canyonlands_defconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
xtensa                              defconfig
powerpc                     ppa8548_defconfig
m68k                             alldefconfig
arm                      jornada720_defconfig
mips                         db1xxx_defconfig
um                             i386_defconfig
arm                             pxa_defconfig
m68k                        m5407c3_defconfig
powerpc                        warp_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                 mpc836x_mds_defconfig
sh                             sh03_defconfig
arm                      integrator_defconfig
powerpc                      chrp32_defconfig
um                           x86_64_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
openrisc                 simple_smp_defconfig
powerpc                      ppc44x_defconfig
arm                      footbridge_defconfig
powerpc                      katmai_defconfig
m68k                       m5275evb_defconfig
arm                         orion5x_defconfig
arm                  randconfig-c002-20211210
arm                  randconfig-c002-20211209
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
i386                 randconfig-a001-20211210
i386                 randconfig-a002-20211210
i386                 randconfig-a005-20211210
i386                 randconfig-a003-20211210
i386                 randconfig-a006-20211210
i386                 randconfig-a004-20211210
i386                 randconfig-a001-20211209
i386                 randconfig-a005-20211209
i386                 randconfig-a003-20211209
i386                 randconfig-a002-20211209
i386                 randconfig-a006-20211209
i386                 randconfig-a004-20211209
x86_64               randconfig-a006-20211209
x86_64               randconfig-a005-20211209
x86_64               randconfig-a001-20211209
x86_64               randconfig-a002-20211209
x86_64               randconfig-a004-20211209
x86_64               randconfig-a003-20211209
x86_64               randconfig-a006-20211210
x86_64               randconfig-a005-20211210
x86_64               randconfig-a001-20211210
x86_64               randconfig-a002-20211210
x86_64               randconfig-a003-20211210
x86_64               randconfig-a004-20211210
arc                  randconfig-r043-20211210
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211210
x86_64               randconfig-c007-20211210
riscv                randconfig-c006-20211210
mips                 randconfig-c004-20211210
i386                 randconfig-c001-20211210
s390                 randconfig-c005-20211210
powerpc              randconfig-c003-20211210
x86_64               randconfig-a011-20211210
x86_64               randconfig-a012-20211210
x86_64               randconfig-a014-20211210
x86_64               randconfig-a013-20211210
x86_64               randconfig-a015-20211210
x86_64               randconfig-a016-20211210
i386                 randconfig-a013-20211210
i386                 randconfig-a011-20211210
i386                 randconfig-a014-20211210
i386                 randconfig-a012-20211210
i386                 randconfig-a016-20211210
i386                 randconfig-a015-20211210
hexagon              randconfig-r045-20211209
s390                 randconfig-r044-20211209
hexagon              randconfig-r041-20211209
riscv                randconfig-r042-20211209
s390                 randconfig-r044-20211210
hexagon              randconfig-r041-20211210
hexagon              randconfig-r045-20211210
riscv                randconfig-r042-20211210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
