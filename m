From: kernel test robot <lkp@intel.com>
Date: Thu, 08 Jul 2021 19:04:31 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 44e4ab6e20ae04ed8e42f178831aaf69f5af5219
Message-ID: <60e6dbbf.ea5yA3/mUEES++90%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 44e4ab6e20ae04ed8e42f178831aaf69f5af5219  ice: introduce XDP_TX fallback path

elapsed time: 726m

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
sh                          rsk7269_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
mips                        bcm63xx_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7206_defconfig
arc                           tb10x_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
sh                           se7751_defconfig
arm                       versatile_defconfig
sh                         ecovec24_defconfig
m68k                        stmark2_defconfig
sh                             shx3_defconfig
powerpc                     ksi8560_defconfig
arm                            mps2_defconfig
arm                         cm_x300_defconfig
m68k                         apollo_defconfig
m68k                         amcore_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
powerpc                     akebono_defconfig
arm                       cns3420vb_defconfig
m68k                           sun3_defconfig
parisc                           allyesconfig
arm                           sunxi_defconfig
x86_64                            allnoconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210707
i386                 randconfig-a006-20210707
i386                 randconfig-a001-20210707
i386                 randconfig-a003-20210707
i386                 randconfig-a005-20210707
i386                 randconfig-a002-20210707
x86_64               randconfig-a004-20210707
x86_64               randconfig-a002-20210707
x86_64               randconfig-a005-20210707
x86_64               randconfig-a006-20210707
x86_64               randconfig-a003-20210707
x86_64               randconfig-a001-20210707
x86_64               randconfig-a015-20210708
x86_64               randconfig-a011-20210708
x86_64               randconfig-a012-20210708
x86_64               randconfig-a014-20210708
x86_64               randconfig-a016-20210708
x86_64               randconfig-a013-20210708
i386                 randconfig-a015-20210707
i386                 randconfig-a016-20210707
i386                 randconfig-a012-20210707
i386                 randconfig-a011-20210707
i386                 randconfig-a014-20210707
i386                 randconfig-a013-20210707
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210707
x86_64               randconfig-a015-20210707
x86_64               randconfig-a014-20210707
x86_64               randconfig-a012-20210707
x86_64               randconfig-a011-20210707
x86_64               randconfig-a016-20210707
x86_64               randconfig-a013-20210707

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
