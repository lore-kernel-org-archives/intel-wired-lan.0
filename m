From: kernel test robot <lkp@intel.com>
Date: Sat, 24 Apr 2021 13:03:49 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:40GbE] BUILD SUCCESS
 1f70dfc542e88492a3bba3017e5e286dab7d3be6
Message-ID: <6083a6b5.OAHF4KmkSvsc2LIk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 40GbE
branch HEAD: 1f70dfc542e88492a3bba3017e5e286dab7d3be6  iavf: redefine the magic number for FDIR GTP-U header fields

elapsed time: 723m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                  mpc885_ads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         bcm2835_defconfig
powerpc                      walnut_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
mips                         tb0219_defconfig
powerpc                      obs600_defconfig
arm                       imx_v6_v7_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
arc                        vdk_hs38_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5208evb_defconfig
arm                           stm32_defconfig
mips                           ci20_defconfig
mips                        bcm63xx_defconfig
m68k                             alldefconfig
sh                          kfr2r09_defconfig
mips                      pistachio_defconfig
mips                          ath25_defconfig
microblaze                          defconfig
openrisc                    or1ksim_defconfig
nios2                            alldefconfig
arm                           h3600_defconfig
mips                          rm200_defconfig
powerpc                     skiroot_defconfig
sh                           se7780_defconfig
arm                           sama5_defconfig
arc                 nsimosci_hs_smp_defconfig
i386                                defconfig
arm                          exynos_defconfig
ia64                             alldefconfig
m68k                                defconfig
s390                          debug_defconfig
i386                             alldefconfig
powerpc                 xes_mpc85xx_defconfig
arm                             mxs_defconfig
microblaze                      mmu_defconfig
arc                     nsimosci_hs_defconfig
mips                     cu1830-neo_defconfig
parisc                generic-64bit_defconfig
arm                         lubbock_defconfig
powerpc                  storcenter_defconfig
arm                       spear13xx_defconfig
sh                        edosk7760_defconfig
mips                      bmips_stb_defconfig
powerpc                      ppc64e_defconfig
arm                        mvebu_v7_defconfig
mips                            e55_defconfig
sh                          polaris_defconfig
mips                           jazz_defconfig
arm                           viper_defconfig
arm                            mps2_defconfig
arm                       imx_v4_v5_defconfig
sh                               j2_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                         wii_defconfig
mips                           ip28_defconfig
arm                         hackkit_defconfig
sh                             sh03_defconfig
powerpc                   lite5200b_defconfig
um                             i386_defconfig
sh                            migor_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5272c3_defconfig
sh                           se7705_defconfig
xtensa                generic_kc705_defconfig
sh                         microdev_defconfig
arm                       multi_v4t_defconfig
arm                         lpc18xx_defconfig
powerpc                          g5_defconfig
arc                        nsim_700_defconfig
um                               allmodconfig
powerpc                      tqm8xx_defconfig
arm                            qcom_defconfig
arm                        magician_defconfig
sh                           sh2007_defconfig
mips                        vocore2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210423
x86_64               randconfig-a004-20210423
x86_64               randconfig-a001-20210423
x86_64               randconfig-a005-20210423
x86_64               randconfig-a006-20210423
x86_64               randconfig-a003-20210423
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
i386                 randconfig-a012-20210424
i386                 randconfig-a014-20210424
i386                 randconfig-a011-20210424
i386                 randconfig-a013-20210424
i386                 randconfig-a016-20210424
i386                 randconfig-a015-20210424
i386                 randconfig-a012-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a014-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a016-20210423
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
