From: kernel test robot <lkp@intel.com>
Date: Wed, 04 Aug 2021 19:21:29 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 6d06d73548dcaae8b9f1228e863c6a2aaa215823
Message-ID: <610a7839.Cn+njEUOVqErzitp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 6d06d73548dcaae8b9f1228e863c6a2aaa215823  ice: don't remove netdev->dev_addr from uc sync list

elapsed time: 837m

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
i386                 randconfig-c001-20210804
arm                          pxa3xx_defconfig
mips                         tb0219_defconfig
arm                            qcom_defconfig
mips                     decstation_defconfig
powerpc                  iss476-smp_defconfig
mips                      maltaaprp_defconfig
m68k                             alldefconfig
arm                         socfpga_defconfig
powerpc                 linkstation_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8540_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         s3c6400_defconfig
arm                            xcep_defconfig
arm                         vf610m4_defconfig
ia64                             alldefconfig
sh                   sh7724_generic_defconfig
sh                          sdk7780_defconfig
powerpc                        warp_defconfig
powerpc                        icon_defconfig
arm                         hackkit_defconfig
mips                             allyesconfig
sh                            titan_defconfig
powerpc                 canyonlands_defconfig
powerpc                     ksi8560_defconfig
arm                          imote2_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                        edosk7760_defconfig
mips                     cu1000-neo_defconfig
mips                          ath79_defconfig
mips                     loongson2k_defconfig
arm                        keystone_defconfig
mips                           ip22_defconfig
arm                          gemini_defconfig
powerpc                      pasemi_defconfig
mips                          rm200_defconfig
sparc                            alldefconfig
mips                         mpc30x_defconfig
sh                        dreamcast_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a012-20210803
i386                 randconfig-a011-20210803
i386                 randconfig-a015-20210803
i386                 randconfig-a013-20210803
i386                 randconfig-a014-20210803
i386                 randconfig-a016-20210803
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
x86_64               randconfig-a002-20210803
x86_64               randconfig-a004-20210803
x86_64               randconfig-a006-20210803
x86_64               randconfig-a003-20210803
x86_64               randconfig-a001-20210803
x86_64               randconfig-a005-20210803
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-a012-20210803
x86_64               randconfig-a016-20210803
x86_64               randconfig-a013-20210803
x86_64               randconfig-a011-20210803
x86_64               randconfig-a014-20210803
x86_64               randconfig-a015-20210803

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
