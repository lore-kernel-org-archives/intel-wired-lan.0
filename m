From: kbuild test robot <lkp@intel.com>
Date: Fri, 30 Aug 2019 13:22:07 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 5d8ea5d1b25a85f357b037d03a59dc98d521c486
Message-ID: <5d68b27f.PLaOWVBEREpRFLYk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5d8ea5d1b25a85f357b037d03a59dc98d521c486  ice: Rework around device/function capabilities

TIMEOUT after 1444m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 27

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
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.6

configs tested: 123

s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-a004-201934
i386                   randconfig-a003-201934
x86_64                 randconfig-a002-201934
i386                   randconfig-a004-201934
i386                   randconfig-a002-201934
i386                   randconfig-a001-201934
x86_64                 randconfig-a001-201934
x86_64                 randconfig-a003-201934
i386                   randconfig-f004-201934
x86_64                 randconfig-f004-201934
x86_64                 randconfig-f002-201934
i386                   randconfig-f001-201934
i386                   randconfig-f003-201934
i386                   randconfig-f002-201934
x86_64                 randconfig-f001-201934
x86_64                 randconfig-f003-201934
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
x86_64                 randconfig-c003-201934
x86_64                 randconfig-c002-201934
i386                   randconfig-c004-201934
x86_64                 randconfig-c004-201934
i386                   randconfig-c003-201934
x86_64                 randconfig-c001-201934
i386                   randconfig-c002-201934
i386                   randconfig-c001-201934
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
x86_64                 randconfig-e004-201934
i386                   randconfig-e004-201934
x86_64                 randconfig-e002-201934
x86_64                 randconfig-e003-201934
i386                   randconfig-e003-201934
x86_64                 randconfig-e001-201934
i386                   randconfig-e002-201934
i386                   randconfig-e001-201934
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                   randconfig-d002-201934
i386                   randconfig-d004-201934
x86_64                 randconfig-d004-201934
x86_64                 randconfig-d002-201934
x86_64                 randconfig-d001-201934
x86_64                 randconfig-d003-201934
i386                   randconfig-d001-201934
i386                   randconfig-d003-201934
x86_64                 randconfig-h002-201934
x86_64                 randconfig-h003-201934
i386                   randconfig-h001-201934
i386                   randconfig-h002-201934
i386                   randconfig-h004-201934
x86_64                 randconfig-h004-201934
i386                   randconfig-h003-201934
x86_64                 randconfig-h001-201934
x86_64                 randconfig-b002-201934
i386                   randconfig-b003-201934
i386                   randconfig-b004-201934
i386                   randconfig-b001-201934
x86_64                 randconfig-b001-201934
i386                   randconfig-b002-201934
x86_64                 randconfig-b004-201934
x86_64                 randconfig-b003-201934
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
x86_64                 randconfig-g003-201934
i386                   randconfig-g004-201934
x86_64                 randconfig-g001-201934
x86_64                 randconfig-g002-201934
i386                   randconfig-g001-201934
x86_64                 randconfig-g004-201934
i386                   randconfig-g002-201934
i386                   randconfig-g003-201934
x86_64                           allyesconfig
x86_64                           allmodconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
