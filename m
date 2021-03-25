From: kernel test robot <lkp@intel.com>
Date: Thu, 25 Mar 2021 13:45:28 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 ca4303103f33952646218db4e0869e6f6aa1c840
Message-ID: <605c2378.NBa5S6MBO6HpO+QI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: ca4303103f33952646218db4e0869e6f6aa1c840  ixgbe: fix unbalanced device enable/disable in suspend/resume

elapsed time: 734m

configs tested: 172
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                      obs600_defconfig
arm                           h3600_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                      pmac32_defconfig
sh                        sh7785lcr_defconfig
arm                         hackkit_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8555_defconfig
h8300                    h8300h-sim_defconfig
sh                          lboxre2_defconfig
arm                      tct_hammer_defconfig
arm                             mxs_defconfig
sh                            titan_defconfig
mips                 decstation_r4k_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
sh                             sh03_defconfig
sh                           se7343_defconfig
m68k                          hp300_defconfig
s390                             allmodconfig
arc                           tb10x_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        workpad_defconfig
powerpc64                           defconfig
arm                          pcm027_defconfig
xtensa                    smp_lx200_defconfig
arm                        keystone_defconfig
mips                           ip27_defconfig
arm                       netwinder_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                      ppc44x_defconfig
m68k                            q40_defconfig
mips                     loongson1b_defconfig
m68k                        m5407c3_defconfig
arm                      footbridge_defconfig
arm                          simpad_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
arm                     am200epdkit_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
sh                           se7705_defconfig
arm                          moxart_defconfig
powerpc                     sequoia_defconfig
xtensa                         virt_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          sdk7786_defconfig
arm                           stm32_defconfig
sh                           se7721_defconfig
powerpc                 mpc85xx_cds_defconfig
nds32                               defconfig
mips                     cu1000-neo_defconfig
powerpc                     pseries_defconfig
arm                          pxa168_defconfig
sh                          urquell_defconfig
powerpc                          g5_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
riscv                             allnoconfig
arm                         axm55xx_defconfig
arm64                            alldefconfig
mips                     loongson1c_defconfig
powerpc                  storcenter_defconfig
sh                            hp6xx_defconfig
powerpc                      makalu_defconfig
sh                      rts7751r2d1_defconfig
powerpc                       ebony_defconfig
powerpc                  iss476-smp_defconfig
mips                      maltaaprp_defconfig
mips                  maltasmvp_eva_defconfig
ia64                             alldefconfig
riscv                          rv32_defconfig
powerpc                 mpc8272_ads_defconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a004-20210324
i386                 randconfig-a003-20210324
i386                 randconfig-a001-20210324
i386                 randconfig-a002-20210324
i386                 randconfig-a006-20210324
i386                 randconfig-a005-20210324
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
x86_64               randconfig-a012-20210324
x86_64               randconfig-a015-20210324
x86_64               randconfig-a014-20210324
x86_64               randconfig-a013-20210324
x86_64               randconfig-a016-20210324
x86_64               randconfig-a011-20210324
i386                 randconfig-a014-20210324
i386                 randconfig-a011-20210324
i386                 randconfig-a015-20210324
i386                 randconfig-a016-20210324
i386                 randconfig-a013-20210324
i386                 randconfig-a012-20210324
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a002-20210324
x86_64               randconfig-a003-20210324
x86_64               randconfig-a001-20210324
x86_64               randconfig-a006-20210324
x86_64               randconfig-a005-20210324
x86_64               randconfig-a004-20210324
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325
x86_64               randconfig-a014-20210325
x86_64               randconfig-a013-20210325
x86_64               randconfig-a011-20210325
x86_64               randconfig-a016-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
