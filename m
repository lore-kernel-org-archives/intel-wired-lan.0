From: kbuild test robot <lkp@intel.com>
Date: Sun, 06 Oct 2019 01:41:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 af5c436931c6ef1789949d6b510c5ca0429a5823
Message-ID: <5d98d5e6.2GM0s0xvLEdwabQQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: af5c436931c6ef1789949d6b510c5ca0429a5823  ixgbe: Remove duplicate clear_bit() call

elapsed time: 1286m

configs tested: 161

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                 randconfig-a004-201939
x86_64                 randconfig-a002-201939
i386                   randconfig-a003-201939
i386                   randconfig-a004-201939
i386                   randconfig-a002-201939
x86_64                 randconfig-a003-201939
x86_64                 randconfig-a001-201939
i386                   randconfig-a001-201939
x86_64                           allyesconfig
x86_64                           allmodconfig
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                             allmodconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-c003-201939
i386                   randconfig-c004-201939
x86_64                 randconfig-c002-201939
x86_64                 randconfig-c004-201939
i386                   randconfig-c003-201939
i386                   randconfig-c001-201939
x86_64                 randconfig-c001-201939
i386                   randconfig-c002-201939
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                   randconfig-g004-201939
x86_64                 randconfig-g003-201939
x86_64                 randconfig-g002-201939
x86_64                 randconfig-g001-201939
x86_64                 randconfig-g004-201939
i386                   randconfig-g001-201939
i386                   randconfig-g002-201939
i386                   randconfig-g003-201939
i386                   randconfig-d002-201939
i386                   randconfig-d004-201939
x86_64                 randconfig-d004-201939
x86_64                 randconfig-d001-201939
x86_64                 randconfig-d002-201939
x86_64                 randconfig-d003-201939
i386                   randconfig-d001-201939
i386                   randconfig-d003-201939
x86_64                 randconfig-h003-201939
x86_64                 randconfig-h002-201939
i386                   randconfig-h002-201939
i386                   randconfig-h001-201939
x86_64                 randconfig-h004-201939
i386                   randconfig-h004-201939
x86_64                 randconfig-h001-201939
i386                   randconfig-h003-201939
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-f001-201940
x86_64                 randconfig-f002-201940
x86_64                 randconfig-f003-201940
x86_64                 randconfig-f004-201940
i386                   randconfig-f001-201940
i386                   randconfig-f002-201940
i386                   randconfig-f003-201940
i386                   randconfig-f004-201940
x86_64                 randconfig-g001-201940
x86_64                 randconfig-g002-201940
x86_64                 randconfig-g003-201940
x86_64                 randconfig-g004-201940
i386                   randconfig-g001-201940
i386                   randconfig-g002-201940
i386                   randconfig-g003-201940
i386                   randconfig-g004-201940
x86_64                 randconfig-f004-201939
i386                   randconfig-f004-201939
i386                   randconfig-f003-201939
i386                   randconfig-f002-201939
i386                   randconfig-f001-201939
x86_64                 randconfig-f002-201939
x86_64                 randconfig-f001-201939
x86_64                 randconfig-f003-201939
i386                   randconfig-e004-201939
x86_64                 randconfig-e004-201939
x86_64                 randconfig-e002-201939
x86_64                 randconfig-e003-201939
i386                   randconfig-e003-201939
x86_64                 randconfig-e001-201939
i386                   randconfig-e001-201939
i386                   randconfig-e002-201939
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-b002-201939
i386                   randconfig-b003-201939
i386                   randconfig-b004-201939
x86_64                 randconfig-b001-201939
i386                   randconfig-b002-201939
i386                   randconfig-b001-201939
x86_64                 randconfig-b004-201939
x86_64                 randconfig-b003-201939

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
