From: kbuild test robot <lkp@intel.com>
Date: Sat, 14 Sep 2019 02:44:43 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 6420ec48d8d70f56462584e89b3c959d33e26f70
Message-ID: <5d7be39b.sCGXaKhBuPB7yIsv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 6420ec48d8d70f56462584e89b3c959d33e26f70  igb: Fix constant media auto sense switching when no cable is connected

elapsed time: 198m

configs tested: 127

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-c003-201936
x86_64                 randconfig-c002-201936
i386                   randconfig-c004-201936
x86_64                 randconfig-c004-201936
i386                   randconfig-c003-201936
i386                   randconfig-c002-201936
x86_64                 randconfig-c001-201936
i386                   randconfig-c001-201936
x86_64                           allmodconfig
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
x86_64                 randconfig-b002-201936
i386                   randconfig-b003-201936
i386                   randconfig-b004-201936
i386                   randconfig-b001-201936
i386                   randconfig-b002-201936
x86_64                 randconfig-b001-201936
x86_64                 randconfig-b004-201936
x86_64                 randconfig-b003-201936
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
arm                              allmodconfig
i386                   randconfig-f004-201936
x86_64                 randconfig-f004-201936
x86_64                 randconfig-f002-201936
i386                   randconfig-f001-201936
i386                   randconfig-f002-201936
i386                   randconfig-f003-201936
x86_64                 randconfig-f003-201936
x86_64                 randconfig-f001-201936
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
x86_64                 randconfig-h002-201936
x86_64                 randconfig-h003-201936
i386                   randconfig-h001-201936
i386                   randconfig-h002-201936
i386                   randconfig-h004-201936
x86_64                 randconfig-h004-201936
i386                   randconfig-h003-201936
x86_64                 randconfig-h001-201936
x86_64                 randconfig-e004-201936
i386                   randconfig-e004-201936
x86_64                 randconfig-e002-201936
i386                   randconfig-e003-201936
x86_64                 randconfig-e003-201936
x86_64                 randconfig-e001-201936
i386                   randconfig-e002-201936
i386                   randconfig-e001-201936
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
x86_64                 randconfig-g003-201936
i386                   randconfig-g004-201936
x86_64                 randconfig-g001-201936
x86_64                 randconfig-g002-201936
i386                   randconfig-g001-201936
x86_64                 randconfig-g004-201936
i386                   randconfig-g002-201936
i386                   randconfig-g003-201936
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
