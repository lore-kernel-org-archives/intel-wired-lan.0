From: kbuild test robot <lkp@intel.com>
Date: Tue, 23 Jul 2019 08:54:30 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 8d5722addcca4f58f9f68cffbda473ea2cde673a
Message-ID: <5d365ac6.WDlJxFRssGoY+k+V%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 8d5722addcca4f58f9f68cffbda473ea2cde673a  checkpatch.pl: seed camelcase from the provided kernel tree root

elapsed time: 381m

configs tested: 147

The following configs have been built successfully.
More configs may be tested in the coming days.

mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
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
riscv                              tinyconfig
i386                               tinyconfig
x86_64                 randconfig-a001-201929
x86_64                 randconfig-a002-201929
x86_64                 randconfig-a003-201929
x86_64                 randconfig-a004-201929
i386                   randconfig-a001-201929
i386                   randconfig-a002-201929
i386                   randconfig-a003-201929
i386                   randconfig-a004-201929
x86_64                 randconfig-g001-201929
x86_64                 randconfig-g002-201929
x86_64                 randconfig-g003-201929
x86_64                 randconfig-g004-201929
i386                   randconfig-g001-201929
i386                   randconfig-g002-201929
i386                   randconfig-g003-201929
i386                   randconfig-g004-201929
x86_64                 randconfig-d001-201929
x86_64                 randconfig-d002-201929
x86_64                 randconfig-d003-201929
x86_64                 randconfig-d004-201929
i386                   randconfig-d001-201929
i386                   randconfig-d002-201929
i386                   randconfig-d003-201929
i386                   randconfig-d004-201929
x86_64                           allmodconfig
x86_64                           allyesconfig
i386                             alldefconfig
x86_64                 randconfig-h001-201929
x86_64                 randconfig-h002-201929
x86_64                 randconfig-h003-201929
x86_64                 randconfig-h004-201929
i386                   randconfig-h001-201929
i386                   randconfig-h002-201929
i386                   randconfig-h003-201929
i386                   randconfig-h004-201929
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-f001-201929
x86_64                 randconfig-f002-201929
x86_64                 randconfig-f003-201929
x86_64                 randconfig-f004-201929
i386                   randconfig-f001-201929
i386                   randconfig-f002-201929
i386                   randconfig-f003-201929
i386                   randconfig-f004-201929
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-e001-201929
x86_64                 randconfig-e002-201929
x86_64                 randconfig-e003-201929
x86_64                 randconfig-e004-201929
i386                   randconfig-e001-201929
i386                   randconfig-e002-201929
i386                   randconfig-e003-201929
i386                   randconfig-e004-201929
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-b001-201929
x86_64                 randconfig-b002-201929
x86_64                 randconfig-b003-201929
x86_64                 randconfig-b004-201929
i386                   randconfig-b001-201929
i386                   randconfig-b002-201929
i386                   randconfig-b003-201929
i386                   randconfig-b004-201929
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-c001-201929
x86_64                 randconfig-c002-201929
x86_64                 randconfig-c003-201929
x86_64                 randconfig-c004-201929
i386                   randconfig-c001-201929
i386                   randconfig-c002-201929
i386                   randconfig-c003-201929
i386                   randconfig-c004-201929
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
