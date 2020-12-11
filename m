From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Dec 2020 20:09:45 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 48d91eba0c7d674de08e9c66fcd67a2b742f8b7a
Message-ID: <5fd36189.DEMmGgxmmPp0r/2x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  dev-queue
branch HEAD: 48d91eba0c7d674de08e9c66fcd67a2b742f8b7a  ixgbe: aggregate all receive errors through netdev's rx_errors

elapsed time: 720m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
arm                        shmobile_defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         bigsur_defconfig
powerpc                 canyonlands_defconfig
mips                           ci20_defconfig
m68k                                defconfig
xtensa                  nommu_kc705_defconfig
arc                        vdk_hs38_defconfig
sh                           sh2007_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
arm                          collie_defconfig
sh                 kfr2r09-romimage_defconfig
um                             i386_defconfig
arc                            hsdk_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
arm                            zeus_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
xtensa                    xip_kc705_defconfig
sh                          kfr2r09_defconfig
sparc                            alldefconfig
mips                        bcm47xx_defconfig
microblaze                      mmu_defconfig
arc                          axs103_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                             shx3_defconfig
arm                          imote2_defconfig
mips                           gcw0_defconfig
sparc                            allyesconfig
powerpc                     asp8347_defconfig
arm                          simpad_defconfig
powerpc                         ps3_defconfig
sh                           se7705_defconfig
sh                        sh7763rdp_defconfig
sparc64                          alldefconfig
h8300                               defconfig
sh                          rsk7201_defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
c6x                                 defconfig
mips                          rb532_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         shannon_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
arm                       versatile_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc834x_itx_defconfig
sh                               alldefconfig
m68k                          amiga_defconfig
powerpc                      ppc40x_defconfig
mips                           ip27_defconfig
arm                          gemini_defconfig
arm                      pxa255-idp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
i386                 randconfig-a014-20201210
i386                 randconfig-a013-20201210
i386                 randconfig-a012-20201210
i386                 randconfig-a011-20201210
i386                 randconfig-a016-20201210
i386                 randconfig-a015-20201210
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
