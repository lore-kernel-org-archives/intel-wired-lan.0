From: kernel test robot <lkp@intel.com>
Date: Sun, 24 Jan 2021 13:11:50 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 29cc273a0cace224d83f846750e2bd01372ffdd9
Message-ID: <600d0196.zTrCQcubZDfuk6Jy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 29cc273a0cace224d83f846750e2bd01372ffdd9  i40e: Fix correct max_pkt_size on VF RX queue

elapsed time: 3213m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
sh                           se7206_defconfig
arm                              zx_defconfig
m68k                       bvme6000_defconfig
m68k                            mac_defconfig
arm64                            alldefconfig
arm                         palmz72_defconfig
arm                         assabet_defconfig
powerpc                   currituck_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                   sh7724_generic_defconfig
sh                         ap325rxa_defconfig
arc                            hsdk_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
i386                 randconfig-a001-20210122
i386                 randconfig-a002-20210122
i386                 randconfig-a004-20210122
i386                 randconfig-a006-20210122
i386                 randconfig-a003-20210122
i386                 randconfig-a005-20210122
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
i386                 randconfig-a013-20210122
i386                 randconfig-a011-20210122
i386                 randconfig-a012-20210122
i386                 randconfig-a014-20210122
i386                 randconfig-a015-20210122
i386                 randconfig-a016-20210122
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210122
x86_64               randconfig-a003-20210122
x86_64               randconfig-a001-20210122
x86_64               randconfig-a005-20210122
x86_64               randconfig-a006-20210122
x86_64               randconfig-a004-20210122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
