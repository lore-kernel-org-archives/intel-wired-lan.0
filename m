From: kernel test robot <lkp@intel.com>
Date: Tue, 23 Feb 2021 21:08:34 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 c0593e1d6e66c973b4d67a33d094a2f77cfbfd64
Message-ID: <6034fe52.6NCsJ+BwPReDjgza%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: c0593e1d6e66c973b4d67a33d094a2f77cfbfd64  igb: Fix duplicate include guard

elapsed time: 726m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   bluestone_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
powerpc                        cell_defconfig
mips                           ip22_defconfig
sh                             sh03_defconfig
powerpc                        warp_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
powerpc                   lite5200b_defconfig
mips                  decstation_64_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
xtensa                  cadence_csp_defconfig
arm                            lart_defconfig
powerpc                      arches_defconfig
arc                        nsim_700_defconfig
arm                        multi_v7_defconfig
arm                        clps711x_defconfig
openrisc                  or1klitex_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8315_rdb_defconfig
um                           x86_64_defconfig
m68k                        m5407c3_defconfig
powerpc                      ppc6xx_defconfig
sh                            migor_defconfig
um                            kunit_defconfig
sh                   sh7724_generic_defconfig
arc                      axs103_smp_defconfig
arm                       netwinder_defconfig
m68k                       bvme6000_defconfig
m68k                            mac_defconfig
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
s390                             allmodconfig
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
i386                 randconfig-a005-20210222
i386                 randconfig-a006-20210222
i386                 randconfig-a004-20210222
i386                 randconfig-a003-20210222
i386                 randconfig-a001-20210222
i386                 randconfig-a002-20210222
i386                 randconfig-a013-20210222
i386                 randconfig-a012-20210222
i386                 randconfig-a011-20210222
i386                 randconfig-a014-20210222
i386                 randconfig-a015-20210222
x86_64               randconfig-a001-20210222
x86_64               randconfig-a002-20210222
x86_64               randconfig-a003-20210222
x86_64               randconfig-a005-20210222
x86_64               randconfig-a006-20210222
x86_64               randconfig-a004-20210222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210222
x86_64               randconfig-a011-20210222
x86_64               randconfig-a012-20210222
x86_64               randconfig-a016-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
