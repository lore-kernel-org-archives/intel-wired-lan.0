From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Nov 2021 17:05:19 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 3f24bdd5e0d7bf9772ccb9dbed39ec790ae16486
Message-ID: <61a5e94f.OOad/D2LgfITEEbj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 3f24bdd5e0d7bf9772ccb9dbed39ec790ae16486  i40e: Fix queues reservation for XDP

elapsed time: 728m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211128
i386                 randconfig-c001-20211130
powerpc                      pasemi_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                    smp_lx200_defconfig
arm                          iop32x_defconfig
mips                        vocore2_defconfig
mips                       capcella_defconfig
powerpc                     tqm8555_defconfig
i386                                defconfig
arm                         mv78xx0_defconfig
arm                     davinci_all_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      cm5200_defconfig
mips                        qi_lb60_defconfig
mips                         cobalt_defconfig
powerpc                     akebono_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                          rm200_defconfig
arm                          lpd270_defconfig
arm                            xcep_defconfig
mips                      loongson3_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          exynos_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
mips                         tb0219_defconfig
arm                            qcom_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
powerpc                      makalu_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5208evb_defconfig
powerpc                 linkstation_defconfig
mips                           ci20_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
arm                         palmz72_defconfig
powerpc                         wii_defconfig
mips                       rbtx49xx_defconfig
sh                          rsk7201_defconfig
arm                        mvebu_v7_defconfig
arm                       versatile_defconfig
microblaze                      mmu_defconfig
arm                         orion5x_defconfig
mips                           ip22_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
riscv             nommu_k210_sdcard_defconfig
sparc                       sparc32_defconfig
mips                           ip28_defconfig
mips                  maltasmvp_eva_defconfig
m68k                        m5407c3_defconfig
arc                        nsim_700_defconfig
arm                         lubbock_defconfig
sh                     magicpanelr2_defconfig
arm                         bcm2835_defconfig
sh                               j2_defconfig
powerpc                     tqm8548_defconfig
mips                           gcw0_defconfig
arm                       imx_v6_v7_defconfig
mips                        omega2p_defconfig
mips                           rs90_defconfig
arm                           h5000_defconfig
m68k                             allyesconfig
nds32                               defconfig
openrisc                            defconfig
arm                          pcm027_defconfig
powerpc                        warp_defconfig
mips                 decstation_r4k_defconfig
arm                       imx_v4_v5_defconfig
arm                          simpad_defconfig
m68k                       m5249evb_defconfig
mips                      bmips_stb_defconfig
sh                   sh7770_generic_defconfig
arm                          ep93xx_defconfig
arm                        neponset_defconfig
powerpc                      ep88xc_defconfig
powerpc                     redwood_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         shannon_defconfig
sh                          rsk7203_defconfig
arm                           u8500_defconfig
arm                        cerfcube_defconfig
m68k                        m5272c3_defconfig
arm                  randconfig-c002-20211128
arm                  randconfig-c002-20211129
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a011-20211128
x86_64               randconfig-a014-20211128
x86_64               randconfig-a012-20211128
x86_64               randconfig-a016-20211128
x86_64               randconfig-a013-20211128
x86_64               randconfig-a015-20211128
i386                 randconfig-a015-20211128
i386                 randconfig-a016-20211128
i386                 randconfig-a013-20211128
i386                 randconfig-a012-20211128
i386                 randconfig-a014-20211128
i386                 randconfig-a011-20211128
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211128
i386                 randconfig-c001-20211128
riscv                randconfig-c006-20211128
arm                  randconfig-c002-20211128
powerpc              randconfig-c003-20211128
x86_64               randconfig-c007-20211128
mips                 randconfig-c004-20211128
x86_64               randconfig-a001-20211128
x86_64               randconfig-a006-20211128
x86_64               randconfig-a003-20211128
x86_64               randconfig-a005-20211128
x86_64               randconfig-a004-20211128
x86_64               randconfig-a002-20211128
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
i386                 randconfig-a015-20211129
i386                 randconfig-a016-20211129
i386                 randconfig-a013-20211129
i386                 randconfig-a012-20211129
i386                 randconfig-a014-20211129
i386                 randconfig-a011-20211129
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
