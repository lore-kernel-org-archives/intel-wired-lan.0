From: kbuild test robot <lkp@intel.com>
Date: Fri, 06 Sep 2019 12:26:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 3ba12aa598a6b30df8da54d89de35163d40f09fc
Message-ID: <5d71dffe.xgqexWS8b+ODPDgy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 3ba12aa598a6b30df8da54d89de35163d40f09fc  ixgbe: use skb_get_queue_mapping in Tx path

elapsed time: 547m

configs tested: 143

The following configs have been built successfully.
More configs may be tested in the coming days.

i386                   randconfig-d002-201935
i386                   randconfig-d004-201935
x86_64                 randconfig-d004-201935
x86_64                 randconfig-d002-201935
x86_64                 randconfig-d001-201935
x86_64                 randconfig-d003-201935
i386                   randconfig-d001-201935
i386                   randconfig-d003-201935
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                 randconfig-c003-201935
x86_64                 randconfig-c002-201935
i386                   randconfig-c004-201935
x86_64                 randconfig-c004-201935
i386                   randconfig-c003-201935
x86_64                 randconfig-c001-201935
i386                   randconfig-c002-201935
i386                   randconfig-c001-201935
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             alldefconfig
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
x86_64                 randconfig-g003-201935
i386                   randconfig-g004-201935
x86_64                 randconfig-g002-201935
x86_64                 randconfig-g001-201935
i386                   randconfig-g001-201935
x86_64                 randconfig-g004-201935
i386                   randconfig-g002-201935
i386                   randconfig-g003-201935
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
x86_64                 randconfig-b002-201935
i386                   randconfig-b003-201935
i386                   randconfig-b004-201935
i386                   randconfig-b001-201935
x86_64                 randconfig-b001-201935
i386                   randconfig-b002-201935
x86_64                 randconfig-b004-201935
x86_64                 randconfig-b003-201935
s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                 randconfig-e004-201935
i386                   randconfig-e004-201935
x86_64                 randconfig-e002-201935
x86_64                 randconfig-e003-201935
i386                   randconfig-e003-201935
x86_64                 randconfig-e001-201935
i386                   randconfig-e001-201935
i386                   randconfig-e002-201935
powerpc                             defconfig
ia64                                defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
x86_64                           allmodconfig
arm                              allmodconfig
arm64                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
i386                   randconfig-f004-201935
x86_64                 randconfig-f004-201935
x86_64                 randconfig-f002-201935
i386                   randconfig-f001-201935
i386                   randconfig-f003-201935
i386                   randconfig-f002-201935
x86_64                 randconfig-f001-201935
x86_64                 randconfig-f003-201935
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
x86_64                 randconfig-h002-201935
x86_64                 randconfig-h003-201935
i386                   randconfig-h002-201935
i386                   randconfig-h001-201935
i386                   randconfig-h004-201935
x86_64                 randconfig-h004-201935
x86_64                 randconfig-h001-201935
i386                   randconfig-h003-201935
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-a004-201935
i386                   randconfig-a003-201935
x86_64                 randconfig-a002-201935
i386                   randconfig-a004-201935
i386                   randconfig-a002-201935
i386                   randconfig-a001-201935
x86_64                 randconfig-a001-201935
x86_64                 randconfig-a003-201935
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
