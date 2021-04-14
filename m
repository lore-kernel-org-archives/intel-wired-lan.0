From: kernel test robot <lkp@intel.com>
Date: Wed, 14 Apr 2021 22:31:37 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:10GbE] BUILD SUCCESS
 ce2cb12dccab57179fc97d2c89f872333ff369f0
Message-ID: <6076fcc9.zsgcWVaEBc/vnLS5%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 10GbE
branch HEAD: ce2cb12dccab57179fc97d2c89f872333ff369f0  net: ethernet: intel: Fix a typo in the file ixgbe_dcb_nl.c

elapsed time: 723m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
sh                          rsk7269_defconfig
sh                             sh03_defconfig
openrisc                 simple_smp_defconfig
arc                          axs101_defconfig
mips                  cavium_octeon_defconfig
mips                        jmr3927_defconfig
xtensa                           alldefconfig
xtensa                  cadence_csp_defconfig
arm                       imx_v4_v5_defconfig
openrisc                         alldefconfig
m68k                          atari_defconfig
mips                malta_qemu_32r6_defconfig
arm                          iop32x_defconfig
arm                           sunxi_defconfig
powerpc                      cm5200_defconfig
sh                   secureedge5410_defconfig
s390                             alldefconfig
mips                        bcm47xx_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
powerpc                       ebony_defconfig
powerpc                      ppc6xx_defconfig
mips                          rb532_defconfig
sh                        sh7785lcr_defconfig
mips                         tb0219_defconfig
arm                          gemini_defconfig
ia64                            zx1_defconfig
sh                           se7619_defconfig
arm                          simpad_defconfig
m68k                          multi_defconfig
i386                             alldefconfig
mips                          rm200_defconfig
arm                            mmp2_defconfig
arm                          pcm027_defconfig
arm                        cerfcube_defconfig
microblaze                          defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7203_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
sh                             espt_defconfig
m68k                       bvme6000_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc8540_ads_defconfig
mips                        qi_lb60_defconfig
arm                            dove_defconfig
powerpc                     tqm8540_defconfig
mips                           xway_defconfig
alpha                               defconfig
arm                       aspeed_g4_defconfig
arm                           sama5_defconfig
s390                             allmodconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc512x_defconfig
arm                        trizeps4_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a006-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a003-20210414
i386                 randconfig-a006-20210414
i386                 randconfig-a001-20210414
i386                 randconfig-a005-20210414
i386                 randconfig-a004-20210414
i386                 randconfig-a002-20210414
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
x86_64               randconfig-a014-20210414
x86_64               randconfig-a015-20210414
x86_64               randconfig-a011-20210414
x86_64               randconfig-a013-20210414
x86_64               randconfig-a012-20210414
x86_64               randconfig-a016-20210414
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a011-20210413
i386                 randconfig-a015-20210414
i386                 randconfig-a014-20210414
i386                 randconfig-a013-20210414
i386                 randconfig-a012-20210414
i386                 randconfig-a016-20210414
i386                 randconfig-a011-20210414
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210414
x86_64               randconfig-a002-20210414
x86_64               randconfig-a005-20210414
x86_64               randconfig-a001-20210414
x86_64               randconfig-a006-20210414
x86_64               randconfig-a004-20210414
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
