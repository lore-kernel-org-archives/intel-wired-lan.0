From: kernel test robot <lkp@intel.com>
Date: Sun, 14 Mar 2021 14:09:29 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 9f096678c93bdde938d8293f111033657d61b8e8
Message-ID: <604da899.MgSnFjFqq7dp5v48%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 9f096678c93bdde938d8293f111033657d61b8e8  ixgbe: Fix NULL pointer dereference in ethtool loopback test

elapsed time: 723m

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
powerpc                       maple_defconfig
powerpc                    socrates_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
mips                     loongson1c_defconfig
powerpc                        cell_defconfig
powerpc                     akebono_defconfig
sh                            migor_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                          axs101_defconfig
openrisc                         alldefconfig
sh                        edosk7760_defconfig
powerpc                         wii_defconfig
mips                         tb0226_defconfig
mips                           ip32_defconfig
arc                              allyesconfig
riscv                    nommu_virt_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
powerpc                     kmeter1_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      acadia_defconfig
arm                         assabet_defconfig
arm                  colibri_pxa300_defconfig
parisc                           alldefconfig
m68k                          atari_defconfig
powerpc                     ppa8548_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210314
i386                 randconfig-a005-20210314
i386                 randconfig-a003-20210314
i386                 randconfig-a002-20210314
i386                 randconfig-a004-20210314
i386                 randconfig-a006-20210314
x86_64               randconfig-a011-20210314
x86_64               randconfig-a016-20210314
x86_64               randconfig-a013-20210314
x86_64               randconfig-a015-20210314
x86_64               randconfig-a014-20210314
x86_64               randconfig-a012-20210314
i386                 randconfig-a013-20210314
i386                 randconfig-a016-20210314
i386                 randconfig-a011-20210314
i386                 randconfig-a012-20210314
i386                 randconfig-a014-20210314
i386                 randconfig-a015-20210314
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a006-20210314
x86_64               randconfig-a001-20210314
x86_64               randconfig-a005-20210314
x86_64               randconfig-a004-20210314
x86_64               randconfig-a002-20210314
x86_64               randconfig-a003-20210314

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
