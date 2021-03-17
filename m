From: kernel test robot <lkp@intel.com>
Date: Wed, 17 Mar 2021 22:16:27 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 1d6c0c9c33e8a72d75b254af8247cdc1cd203345
Message-ID: <60520f3b.z7wqAwWWwDua/lNL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 1d6c0c9c33e8a72d75b254af8247cdc1cd203345  e1000e: Fix prototype warning

elapsed time: 722m

configs tested: 103
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
i386                             allyesconfig
powerpc                     akebono_defconfig
powerpc                          g5_defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
arm                          pxa910_defconfig
s390                          debug_defconfig
sh                         apsh4a3a_defconfig
m68k                        mvme16x_defconfig
m68k                       bvme6000_defconfig
arm                        neponset_defconfig
sh                          sdk7786_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc836x_mds_defconfig
openrisc                  or1klitex_defconfig
powerpc                     redwood_defconfig
powerpc                      katmai_defconfig
powerpc                      acadia_defconfig
powerpc                    adder875_defconfig
powerpc                      cm5200_defconfig
powerpc                  storcenter_defconfig
sh                   sh7770_generic_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      tqm8xx_defconfig
mips                         tb0287_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          pcm027_defconfig
arm                        spear3xx_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
