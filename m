From: kernel test robot <lkp@intel.com>
Date: Fri, 07 May 2021 12:36:10 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 cf8e8d9814605e8cf62ebb8e79f2b72175a6551b
Message-ID: <6094c3ba.9sXyjLHKbZmxlqDk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: cf8e8d9814605e8cf62ebb8e79f2b72175a6551b  ice: fix FDIR init missing when reset VF

elapsed time: 725m

configs tested: 138
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
arm                       imx_v4_v5_defconfig
parisc                           alldefconfig
m68k                         amcore_defconfig
microblaze                          defconfig
mips                          rb532_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
powerpc                      ep88xc_defconfig
powerpc                    amigaone_defconfig
m68k                            q40_defconfig
powerpc                      acadia_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         bigsur_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
arm                      integrator_defconfig
sh                      rts7751r2d1_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
sh                   sh7724_generic_defconfig
mips                           jazz_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
arm                         nhk8815_defconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                             allyesconfig
sh                                  defconfig
arc                        vdk_hs38_defconfig
arm                          moxart_defconfig
powerpc                      obs600_defconfig
arm                       imx_v6_v7_defconfig
sh                          sdk7780_defconfig
powerpc                     rainier_defconfig
powerpc                      katmai_defconfig
powerpc                        warp_defconfig
microblaze                      mmu_defconfig
ia64                        generic_defconfig
mips                        bcm47xx_defconfig
arm                          exynos_defconfig
mips                     cu1830-neo_defconfig
arc                            hsdk_defconfig
arm                        realview_defconfig
m68k                       m5275evb_defconfig
arm                       multi_v4t_defconfig
powerpc                     akebono_defconfig
arm                       aspeed_g5_defconfig
arm                        keystone_defconfig
arm                        mvebu_v7_defconfig
arm                          simpad_defconfig
arm                      jornada720_defconfig
riscv                    nommu_k210_defconfig
sh                           se7751_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8315_rdb_defconfig
xtensa                generic_kc705_defconfig
powerpc                   currituck_defconfig
powerpc                     stx_gp3_defconfig
um                            kunit_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
x86_64               randconfig-a014-20210506
x86_64               randconfig-a015-20210506
x86_64               randconfig-a012-20210506
x86_64               randconfig-a013-20210506
x86_64               randconfig-a011-20210506
x86_64               randconfig-a016-20210506
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
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
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
