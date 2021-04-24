From: kernel test robot <lkp@intel.com>
Date: Sat, 24 Apr 2021 19:03:35 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 bbda55931462adc69d422fd0cb0a2d51f91d3646
Message-ID: <6083fb07.WgDoncKA2r4xIEZO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: bbda55931462adc69d422fd0cb0a2d51f91d3646  ice: Re-organizes reqstd/avail {R, T}XQ check/code for efficiency

elapsed time: 724m

configs tested: 112
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
i386                             allyesconfig
riscv                            allyesconfig
mips                         tb0219_defconfig
powerpc                      obs600_defconfig
arm                       imx_v6_v7_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
nios2                            alldefconfig
arm                           h3600_defconfig
mips                          rm200_defconfig
mips                       capcella_defconfig
powerpc                     skiroot_defconfig
sh                           se7780_defconfig
arm                           sama5_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          exynos_defconfig
ia64                             alldefconfig
mips                     cu1830-neo_defconfig
parisc                generic-64bit_defconfig
arm                         lubbock_defconfig
powerpc                  storcenter_defconfig
arm                       spear13xx_defconfig
s390                          debug_defconfig
mips                      bmips_stb_defconfig
powerpc                      ppc64e_defconfig
arm                        mvebu_v7_defconfig
mips                            e55_defconfig
sh                           se7705_defconfig
xtensa                generic_kc705_defconfig
sh                        edosk7760_defconfig
sh                         microdev_defconfig
arm                       multi_v4t_defconfig
mips                  cavium_octeon_defconfig
sh                                  defconfig
powerpc                    adder875_defconfig
h8300                            alldefconfig
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
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
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
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210424
x86_64               randconfig-a002-20210424
x86_64               randconfig-a001-20210424
x86_64               randconfig-a006-20210424
x86_64               randconfig-a005-20210424
x86_64               randconfig-a003-20210424
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
