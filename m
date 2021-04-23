From: kernel test robot <lkp@intel.com>
Date: Fri, 23 Apr 2021 19:59:07 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 ac4c6bf9c93c7da373f24e37976878c157d55b8f
Message-ID: <6082b68b.pRMBL+NIRp+t5Qz4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: ac4c6bf9c93c7da373f24e37976878c157d55b8f  igb: Check if num of q_vectors is smaller than max before array access

elapsed time: 723m

configs tested: 122
configs skipped: 3

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
powerpc                 xes_mpc85xx_defconfig
mips                           mtx1_defconfig
sh                               allmodconfig
ia64                            zx1_defconfig
arm                          lpd270_defconfig
arm                     eseries_pxa_defconfig
arm                         lpc32xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                           tegra_defconfig
powerpc                     skiroot_defconfig
nios2                            alldefconfig
mips                         bigsur_defconfig
arm                           h3600_defconfig
xtensa                  audio_kc705_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ep88xc_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
mips                        omega2p_defconfig
arm                          exynos_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      chrp32_defconfig
sh                          sdk7786_defconfig
arm                       cns3420vb_defconfig
um                               alldefconfig
sh                         microdev_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
xtensa                         virt_defconfig
openrisc                         alldefconfig
sh                          rsk7269_defconfig
powerpc                     powernv_defconfig
powerpc                   currituck_defconfig
ia64                      gensparse_defconfig
openrisc                  or1klitex_defconfig
mips                      pic32mzda_defconfig
nios2                            allyesconfig
mips                        maltaup_defconfig
mips                        vocore2_defconfig
sh                           se7750_defconfig
powerpc                      arches_defconfig
sh                          lboxre2_defconfig
um                            kunit_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allyesconfig
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
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
