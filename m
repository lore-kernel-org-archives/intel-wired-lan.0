From: kernel test robot <lkp@intel.com>
Date: Sat, 08 May 2021 13:21:58 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 8085a36db71f54d2592426eb76bdf71b82479140
Message-ID: <60961ff6.JFJFcCepbk0FiMlr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: 8085a36db71f54d2592426eb76bdf71b82479140  i40e: Remove LLDP frame filters

elapsed time: 723m

configs tested: 120
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
riscv                            allyesconfig
i386                             allyesconfig
arc                          axs101_defconfig
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
m68k                        m5272c3_defconfig
sh                          lboxre2_defconfig
arm                           stm32_defconfig
mips                    maltaup_xpa_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ip22_defconfig
m68k                                defconfig
arc                          axs103_defconfig
um                               allmodconfig
powerpc                      pcm030_defconfig
sh                ecovec24-romimage_defconfig
arc                           tb10x_defconfig
arm                    vt8500_v6_v7_defconfig
xtensa                generic_kc705_defconfig
mips                      pic32mzda_defconfig
sh                             shx3_defconfig
arm                          collie_defconfig
arm                         nhk8815_defconfig
arm                         shannon_defconfig
parisc                           alldefconfig
m68k                        m5307c3_defconfig
xtensa                    smp_lx200_defconfig
sh                           se7619_defconfig
arm                           sunxi_defconfig
arc                              allyesconfig
m68k                       m5475evb_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         bigsur_defconfig
arm                       netwinder_defconfig
m68k                           sun3_defconfig
m68k                         amcore_defconfig
powerpc                       holly_defconfig
powerpc                      ppc6xx_defconfig
arm                         palmz72_defconfig
arm                          badge4_defconfig
powerpc                      pasemi_defconfig
arm                        spear6xx_defconfig
mips                           mtx1_defconfig
um                             i386_defconfig
mips                         mpc30x_defconfig
sh                     magicpanelr2_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210507
x86_64               randconfig-a003-20210507
x86_64               randconfig-a005-20210507
x86_64               randconfig-a002-20210507
x86_64               randconfig-a006-20210507
x86_64               randconfig-a004-20210507
i386                 randconfig-a003-20210507
i386                 randconfig-a006-20210507
i386                 randconfig-a001-20210507
i386                 randconfig-a005-20210507
i386                 randconfig-a004-20210507
i386                 randconfig-a002-20210507
i386                 randconfig-a015-20210507
i386                 randconfig-a013-20210507
i386                 randconfig-a016-20210507
i386                 randconfig-a014-20210507
i386                 randconfig-a012-20210507
i386                 randconfig-a011-20210507
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210507
x86_64               randconfig-a015-20210507
x86_64               randconfig-a012-20210507
x86_64               randconfig-a013-20210507
x86_64               randconfig-a011-20210507
x86_64               randconfig-a016-20210507

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
