From: kbuild test robot <lkp@intel.com>
Date: Wed, 28 Aug 2019 19:29:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:10GbE] BUILD SUCCESS
 23f98dcc83b046962a05dd82b831d3e59883a993
Message-ID: <5d6665ab.oqQJqUlndbGODhmt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  10GbE
branch HEAD: 23f98dcc83b046962a05dd82b831d3e59883a993  i40e: Add support for X710 device

elapsed time: 298m

configs tested: 147

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                           allmodconfig
x86_64                           allyesconfig
i386                             alldefconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-c003-201934
x86_64                 randconfig-c002-201934
i386                   randconfig-c004-201934
x86_64                 randconfig-c004-201934
i386                   randconfig-c003-201934
x86_64                 randconfig-c001-201934
i386                   randconfig-c002-201934
i386                   randconfig-c001-201934
x86_64                 randconfig-e004-201934
i386                   randconfig-e004-201934
x86_64                 randconfig-e002-201934
x86_64                 randconfig-e003-201934
i386                   randconfig-e003-201934
x86_64                 randconfig-e001-201934
i386                   randconfig-e002-201934
i386                   randconfig-e001-201934
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-f001-201934
x86_64                 randconfig-f002-201934
x86_64                 randconfig-f003-201934
x86_64                 randconfig-f004-201934
i386                   randconfig-f001-201934
i386                   randconfig-f002-201934
i386                   randconfig-f003-201934
i386                   randconfig-f004-201934
x86_64                 randconfig-b001-201934
x86_64                 randconfig-b002-201934
x86_64                 randconfig-b003-201934
x86_64                 randconfig-b004-201934
i386                   randconfig-b001-201934
i386                   randconfig-b002-201934
i386                   randconfig-b003-201934
i386                   randconfig-b004-201934
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
i386                             allmodconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
arm                              allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                             defconfig
ia64                                defconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
x86_64                 randconfig-a004-201934
i386                   randconfig-a003-201934
x86_64                 randconfig-a002-201934
i386                   randconfig-a004-201934
i386                   randconfig-a002-201934
i386                   randconfig-a001-201934
x86_64                 randconfig-a001-201934
x86_64                 randconfig-a003-201934
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-h002-201934
x86_64                 randconfig-h003-201934
i386                   randconfig-h001-201934
i386                   randconfig-h002-201934
i386                   randconfig-h004-201934
x86_64                 randconfig-h004-201934
i386                   randconfig-h003-201934
x86_64                 randconfig-h001-201934
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
i386                   randconfig-d002-201934
i386                   randconfig-d004-201934
x86_64                 randconfig-d004-201934
x86_64                 randconfig-d002-201934
x86_64                 randconfig-d001-201934
x86_64                 randconfig-d003-201934
i386                   randconfig-d001-201934
i386                   randconfig-d003-201934
x86_64                 randconfig-g001-201934
x86_64                 randconfig-g002-201934
x86_64                 randconfig-g003-201934
x86_64                 randconfig-g004-201934
i386                   randconfig-g001-201934
i386                   randconfig-g002-201934
i386                   randconfig-g003-201934
i386                   randconfig-g004-201934
s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
i386                              allnoconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             alldefconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
