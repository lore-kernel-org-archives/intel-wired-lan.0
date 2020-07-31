From: kernel test robot <lkp@intel.com>
Date: Sat, 01 Aug 2020 01:13:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:1GbE] BUILD SUCCESS
 8698fb64cc77bf103ab582970965ae851f5f4d72
Message-ID: <5f24514f.yiIihJYP4p2leibe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  1GbE
branch HEAD: 8698fb64cc77bf103ab582970965ae851f5f4d72  igb: use eth_zero_addr() to clear mac address

elapsed time: 1266m

configs tested: 66
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a005-20200731
i386                 randconfig-a004-20200731
i386                 randconfig-a006-20200731
i386                 randconfig-a002-20200731
i386                 randconfig-a001-20200731
i386                 randconfig-a003-20200731
x86_64               randconfig-a015-20200731
x86_64               randconfig-a014-20200731
x86_64               randconfig-a016-20200731
x86_64               randconfig-a012-20200731
x86_64               randconfig-a013-20200731
x86_64               randconfig-a011-20200731
i386                 randconfig-a016-20200731
i386                 randconfig-a012-20200731
i386                 randconfig-a014-20200731
i386                 randconfig-a015-20200731
i386                 randconfig-a011-20200731
i386                 randconfig-a013-20200731
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
