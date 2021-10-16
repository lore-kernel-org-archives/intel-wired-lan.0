From: kernel test robot <lkp@intel.com>
Date: Sat, 16 Oct 2021 23:26:30 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 dc0234f4504c270d77b5097a65b163e8fa959e13
Message-ID: <616aef26.8RDsbyxe2B53AgEZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: dc0234f4504c270d77b5097a65b163e8fa959e13  igb: support EXTTS on 82580/i354/i350

elapsed time: 940m

configs tested: 108
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211016
arm                          moxart_defconfig
sh                          rsk7264_defconfig
arm                           spitz_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pasemi_defconfig
powerpc                     sequoia_defconfig
xtensa                          iss_defconfig
mips                            gpr_defconfig
arm                       omap2plus_defconfig
mips                       lemote2f_defconfig
riscv                          rv32_defconfig
sh                        edosk7705_defconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
powerpc                      walnut_defconfig
arm                        keystone_defconfig
powerpc                   microwatt_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20211016
x86_64               randconfig-c001-20211016
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
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
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20211016
i386                 randconfig-a001-20211016
i386                 randconfig-a005-20211016
i386                 randconfig-a004-20211016
i386                 randconfig-a002-20211016
i386                 randconfig-a006-20211016
i386                 randconfig-a016-20211015
i386                 randconfig-a014-20211015
i386                 randconfig-a011-20211015
i386                 randconfig-a015-20211015
i386                 randconfig-a012-20211015
i386                 randconfig-a013-20211015
x86_64               randconfig-a006-20211016
x86_64               randconfig-a004-20211016
x86_64               randconfig-a001-20211016
x86_64               randconfig-a005-20211016
x86_64               randconfig-a002-20211016
x86_64               randconfig-a003-20211016
arc                  randconfig-r043-20211015
s390                 randconfig-r044-20211015
riscv                randconfig-r042-20211015
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20211016
x86_64               randconfig-a015-20211016
x86_64               randconfig-a016-20211016
x86_64               randconfig-a014-20211016
x86_64               randconfig-a011-20211016
x86_64               randconfig-a013-20211016
i386                 randconfig-a016-20211016
i386                 randconfig-a014-20211016
i386                 randconfig-a011-20211016
i386                 randconfig-a015-20211016
i386                 randconfig-a012-20211016
i386                 randconfig-a013-20211016
hexagon              randconfig-r041-20211015
hexagon              randconfig-r045-20211015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
