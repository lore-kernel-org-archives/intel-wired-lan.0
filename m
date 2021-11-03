From: kernel test robot <lkp@intel.com>
Date: Wed, 03 Nov 2021 19:43:59 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 5ebd29a6da84ef62e265a9bb421d67b7cd23d439
Message-ID: <618275ff.2a5hq+ykfIKPZCDu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 5ebd29a6da84ef62e265a9bb421d67b7cd23d439  i40e: avoid spin loop in i40e_asq_send_command()

elapsed time: 722m

configs tested: 72
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20211103
powerpc                         ps3_defconfig
nds32                               defconfig
arm                         socfpga_defconfig
arm                       aspeed_g5_defconfig
arm                         assabet_defconfig
um                                  defconfig
mips                         tb0219_defconfig
h8300                               defconfig
sh                           se7619_defconfig
arm                            mps2_defconfig
arm                  randconfig-c002-20211103
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20211103
x86_64               randconfig-a015-20211103
x86_64               randconfig-a016-20211103
x86_64               randconfig-a011-20211103
x86_64               randconfig-a013-20211103
x86_64               randconfig-a014-20211103
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
hexagon              randconfig-r041-20211103
hexagon              randconfig-r045-20211103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
