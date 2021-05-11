From: kernel test robot <lkp@intel.com>
Date: Tue, 11 May 2021 19:44:12 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 9f568aa35a82ad697207fdf8872f5b00f86a77f7
Message-ID: <609a6e0c.FnIWJTLjKEAJDUPx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 9f568aa35a82ad697207fdf8872f5b00f86a77f7  igc: add correct exception tracing for XDP

elapsed time: 722m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                    amigaone_defconfig
nios2                            allyesconfig
mips                      malta_kvm_defconfig
arm                           u8500_defconfig
sh                            hp6xx_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                                defconfig
ia64                      gensparse_defconfig
arm                        neponset_defconfig
sh                         ap325rxa_defconfig
sh                          rsk7264_defconfig
arm                       aspeed_g5_defconfig
sh                        sh7763rdp_defconfig
arm                            pleb_defconfig
sh                   sh7770_generic_defconfig
sh                           se7751_defconfig
powerpc                     tqm5200_defconfig
powerpc                      walnut_defconfig
sh                           se7712_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
sh                          sdk7780_defconfig
mips                     loongson1c_defconfig
arm                      footbridge_defconfig
powerpc                      ppc40x_defconfig
h8300                            alldefconfig
arm                        mvebu_v5_defconfig
arm                         lubbock_defconfig
powerpc                     ksi8560_defconfig
sh                           se7721_defconfig
sh                          lboxre2_defconfig
arm                         cm_x300_defconfig
arm                         socfpga_defconfig
sh                   sh7724_generic_defconfig
arc                        nsim_700_defconfig
arm                         nhk8815_defconfig
arc                        vdk_hs38_defconfig
mips                          rm200_defconfig
powerpc                     pseries_defconfig
arm                          iop32x_defconfig
sh                           se7750_defconfig
powerpc                    mvme5100_defconfig
ia64                          tiger_defconfig
arm                   milbeaut_m10v_defconfig
arm                       versatile_defconfig
ia64                             allyesconfig
sh                          polaris_defconfig
xtensa                    xip_kc705_defconfig
mips                        maltaup_defconfig
mips                         mpc30x_defconfig
arm                         vf610m4_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210511
i386                 randconfig-a001-20210511
i386                 randconfig-a005-20210511
i386                 randconfig-a004-20210511
i386                 randconfig-a002-20210511
i386                 randconfig-a006-20210511
x86_64               randconfig-a012-20210511
x86_64               randconfig-a015-20210511
x86_64               randconfig-a011-20210511
x86_64               randconfig-a013-20210511
x86_64               randconfig-a016-20210511
x86_64               randconfig-a014-20210511
i386                 randconfig-a016-20210511
i386                 randconfig-a014-20210511
i386                 randconfig-a011-20210511
i386                 randconfig-a015-20210511
i386                 randconfig-a012-20210511
i386                 randconfig-a013-20210511
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210511
x86_64               randconfig-a004-20210511
x86_64               randconfig-a001-20210511
x86_64               randconfig-a005-20210511
x86_64               randconfig-a002-20210511
x86_64               randconfig-a006-20210511

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
