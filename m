From: kernel test robot <lkp@intel.com>
Date: Tue, 23 Nov 2021 15:54:38 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 fa7382148d4840e7bbded84896be9e9be81119d6
Message-ID: <619c9e3e.BKVNc+R0BhvhbU8v%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: fa7382148d4840e7bbded84896be9e9be81119d6  ice: fix adding different tunnels

elapsed time: 726m

configs tested: 151
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211122
i386                 randconfig-c001-20211123
sh                      rts7751r2d1_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
arm                          exynos_defconfig
powerpc                      pmac32_defconfig
um                                  defconfig
nios2                         3c120_defconfig
xtensa                    smp_lx200_defconfig
mips                       capcella_defconfig
h8300                            alldefconfig
s390                             alldefconfig
powerpc                 canyonlands_defconfig
ia64                      gensparse_defconfig
sh                         ecovec24_defconfig
powerpc                     akebono_defconfig
powerpc                          allyesconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          lboxre2_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      cm5200_defconfig
arm                           sama7_defconfig
arm                       spear13xx_defconfig
mips                        vocore2_defconfig
mips                         cobalt_defconfig
sh                        edosk7705_defconfig
arc                          axs103_defconfig
arm                    vt8500_v6_v7_defconfig
mips                             allyesconfig
mips                       rbtx49xx_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                          sdk7780_defconfig
arm                           stm32_defconfig
h8300                    h8300h-sim_defconfig
arm                            dove_defconfig
powerpc                          allmodconfig
powerpc                         ps3_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                    maltaup_xpa_defconfig
sh                        dreamcast_defconfig
sh                              ul2_defconfig
arm                          gemini_defconfig
sh                        edosk7760_defconfig
m68k                       m5249evb_defconfig
sh                   secureedge5410_defconfig
m68k                         amcore_defconfig
powerpc                      ppc64e_defconfig
m68k                             alldefconfig
m68k                       m5208evb_defconfig
arm                        trizeps4_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
sh                           se7343_defconfig
arm                          pxa168_defconfig
ia64                        generic_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20211122
arm                  randconfig-c002-20211123
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211123
i386                 randconfig-a002-20211123
i386                 randconfig-a005-20211123
i386                 randconfig-a006-20211123
i386                 randconfig-a004-20211123
i386                 randconfig-a003-20211123
x86_64               randconfig-a014-20211122
x86_64               randconfig-a011-20211122
x86_64               randconfig-a012-20211122
x86_64               randconfig-a016-20211122
x86_64               randconfig-a013-20211122
x86_64               randconfig-a015-20211122
i386                 randconfig-a016-20211122
i386                 randconfig-a015-20211122
i386                 randconfig-a012-20211122
i386                 randconfig-a013-20211122
i386                 randconfig-a014-20211122
i386                 randconfig-a011-20211122
arc                  randconfig-r043-20211122
s390                 randconfig-r044-20211122
riscv                randconfig-r042-20211122
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20211123
i386                 randconfig-c001-20211123
powerpc              randconfig-c003-20211123
arm                  randconfig-c002-20211123
riscv                randconfig-c006-20211123
x86_64               randconfig-c007-20211123
mips                 randconfig-c004-20211123
x86_64               randconfig-a001-20211122
x86_64               randconfig-a003-20211122
x86_64               randconfig-a006-20211122
x86_64               randconfig-a004-20211122
x86_64               randconfig-a005-20211122
x86_64               randconfig-a002-20211122
i386                 randconfig-a001-20211122
i386                 randconfig-a002-20211122
i386                 randconfig-a005-20211122
i386                 randconfig-a006-20211122
i386                 randconfig-a004-20211122
i386                 randconfig-a003-20211122

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
