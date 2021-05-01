From: kernel test robot <lkp@intel.com>
Date: Sat, 01 May 2021 18:28:55 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 074ff847e12bf2ff765f0036971532032bf8d612
Message-ID: <608d2d67.LM+GSl4/eC9KH212%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 074ff847e12bf2ff765f0036971532032bf8d612  i40e: Fix logic of disabling queues

elapsed time: 724m

configs tested: 110
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
sh                 kfr2r09-romimage_defconfig
arm                            lart_defconfig
microblaze                      mmu_defconfig
arm                       spear13xx_defconfig
m68k                          hp300_defconfig
powerpc                   bluestone_defconfig
nios2                         3c120_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        omega2p_defconfig
h8300                            allyesconfig
mips                         rt305x_defconfig
powerpc                      katmai_defconfig
m68k                       m5275evb_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
ia64                         bigsur_defconfig
mips                        vocore2_defconfig
parisc                              defconfig
s390                             alldefconfig
mips                          ath79_defconfig
m68k                        stmark2_defconfig
h8300                       h8s-sim_defconfig
mips                           ip27_defconfig
m68k                        m5407c3_defconfig
sh                        edosk7760_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
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
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
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
i386                 randconfig-a004-20210430
i386                 randconfig-a001-20210430
i386                 randconfig-a003-20210430
i386                 randconfig-a002-20210430
i386                 randconfig-a005-20210430
i386                 randconfig-a006-20210430
x86_64               randconfig-a003-20210430
x86_64               randconfig-a004-20210430
x86_64               randconfig-a002-20210430
x86_64               randconfig-a006-20210430
x86_64               randconfig-a001-20210430
x86_64               randconfig-a005-20210430
i386                 randconfig-a013-20210430
i386                 randconfig-a011-20210430
i386                 randconfig-a016-20210430
i386                 randconfig-a015-20210430
i386                 randconfig-a012-20210430
i386                 randconfig-a014-20210430
i386                 randconfig-a013-20210501
i386                 randconfig-a015-20210501
i386                 randconfig-a016-20210501
i386                 randconfig-a014-20210501
i386                 randconfig-a011-20210501
i386                 randconfig-a012-20210501
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
x86_64               randconfig-a011-20210430
x86_64               randconfig-a016-20210430
x86_64               randconfig-a013-20210430
x86_64               randconfig-a014-20210430
x86_64               randconfig-a012-20210430
x86_64               randconfig-a015-20210430

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
