From: kernel test robot <lkp@intel.com>
Date: Wed, 14 Apr 2021 22:31:40 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 WARNING be38a3b022aeb57094b1906d3d4b84ef94ebf0d4
Message-ID: <6076fccc.XR99FoRHhuYTu1Ds%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: be38a3b022aeb57094b1906d3d4b84ef94ebf0d4  igc: Update driver to use ethtool_sprintf

Warning in current branch:

drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c:654:14: warning: variable 'reg_c1' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm64-defconfig
    `-- drivers-net-ethernet-mellanox-mlx5-core-en-rep-tc.c:warning:variable-reg_c1-set-but-not-used

elapsed time: 723m

configs tested: 135
configs skipped: 2

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
arm                       imx_v4_v5_defconfig
openrisc                         alldefconfig
m68k                          atari_defconfig
mips                malta_qemu_32r6_defconfig
arm                          iop32x_defconfig
arm                           sunxi_defconfig
arc                         haps_hs_defconfig
powerpc                     taishan_defconfig
powerpc64                        alldefconfig
powerpc                     ksi8560_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      cm5200_defconfig
sh                   secureedge5410_defconfig
s390                             alldefconfig
mips                        bcm47xx_defconfig
mips                  decstation_64_defconfig
mips                         tb0287_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8548_defconfig
powerpc                      ppc44x_defconfig
arc                     haps_hs_smp_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7203_defconfig
powerpc                   currituck_defconfig
sh                            hp6xx_defconfig
openrisc                  or1klitex_defconfig
powerpc                      arches_defconfig
powerpc                      ppc64e_defconfig
arm                          badge4_defconfig
sh                           se7705_defconfig
sh                   sh7724_generic_defconfig
mips                      pic32mzda_defconfig
powerpc                    gamecube_defconfig
sh                        sh7785lcr_defconfig
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
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
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
