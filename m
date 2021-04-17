From: kernel test robot <lkp@intel.com>
Date: Sat, 17 Apr 2021 20:55:45 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 c12132158f1b93af7365c6cc0357e8784c604c38
Message-ID: <607adad1.faGPJBquCGXhDV4p%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: c12132158f1b93af7365c6cc0357e8784c604c38  ixgbe: Fix out-bounds warning in ixgbe_host_interface_command()

elapsed time: 722m

configs tested: 113
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
arm                    vt8500_v6_v7_defconfig
arm                        clps711x_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
powerpc                         ps3_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
powerpc                      pcm030_defconfig
arm                       aspeed_g5_defconfig
powerpc                       eiger_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                       holly_defconfig
arm                        magician_defconfig
um                               alldefconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
arm                         socfpga_defconfig
sh                ecovec24-romimage_defconfig
mips                           gcw0_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     sbc8548_defconfig
powerpc                      ppc44x_defconfig
m68k                            q40_defconfig
arc                         haps_hs_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
