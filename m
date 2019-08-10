From: kbuild test robot <lkp@intel.com>
Date: Sat, 10 Aug 2019 23:38:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 e958247192c6f27e0170745ecd2b3444c98ebe30
Message-ID: <5d4ee500.h0kfr4sgwv9JQiTM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e958247192c6f27e0170745ecd2b3444c98ebe30  igc: Add tx_csum offload functionality

TIMEOUT after 1448m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 24

alpha                            allmodconfig
alpha                            allyesconfig
i386                               tinyconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
nds32                            allmodconfig
nds32                            allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                              tinyconfig
s390                             allyesconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc64                          allyesconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 147

x86_64                           allmodconfig
x86_64                           allyesconfig
i386                             alldefconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                   randconfig-d002-201931
i386                   randconfig-d004-201931
x86_64                 randconfig-d004-201931
x86_64                 randconfig-d001-201931
x86_64                 randconfig-d002-201931
x86_64                 randconfig-d003-201931
i386                   randconfig-d001-201931
i386                   randconfig-d003-201931
x86_64                 randconfig-a001-201931
x86_64                 randconfig-a002-201931
x86_64                 randconfig-a003-201931
x86_64                 randconfig-a004-201931
i386                   randconfig-a001-201931
i386                   randconfig-a002-201931
i386                   randconfig-a003-201931
i386                   randconfig-a004-201931
ia64                                defconfig
powerpc                             defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
i386                             allmodconfig
x86_64                 randconfig-g003-201931
i386                   randconfig-g004-201931
x86_64                 randconfig-g002-201931
x86_64                 randconfig-g001-201931
i386                   randconfig-g001-201931
x86_64                 randconfig-g004-201931
i386                   randconfig-g002-201931
i386                   randconfig-g003-201931
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                              allmodconfig
arm64                            allmodconfig
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
x86_64                 randconfig-b001-201931
x86_64                 randconfig-b002-201931
x86_64                 randconfig-b003-201931
x86_64                 randconfig-b004-201931
i386                   randconfig-b001-201931
i386                   randconfig-b002-201931
i386                   randconfig-b003-201931
i386                   randconfig-b004-201931
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
x86_64                 randconfig-f001-201931
x86_64                 randconfig-f002-201931
x86_64                 randconfig-f003-201931
x86_64                 randconfig-f004-201931
i386                   randconfig-f001-201931
i386                   randconfig-f002-201931
i386                   randconfig-f003-201931
i386                   randconfig-f004-201931
i386                              allnoconfig
i386                                defconfig
x86_64                 randconfig-c001-201931
x86_64                 randconfig-c002-201931
x86_64                 randconfig-c003-201931
x86_64                 randconfig-c004-201931
i386                   randconfig-c001-201931
i386                   randconfig-c002-201931
i386                   randconfig-c003-201931
i386                   randconfig-c004-201931
x86_64                 randconfig-h002-201931
x86_64                 randconfig-h003-201931
i386                   randconfig-h002-201931
i386                   randconfig-h001-201931
x86_64                 randconfig-h004-201931
i386                   randconfig-h004-201931
x86_64                 randconfig-h001-201931
i386                   randconfig-h003-201931
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
x86_64                 randconfig-e001-201931
x86_64                 randconfig-e002-201931
x86_64                 randconfig-e003-201931
x86_64                 randconfig-e004-201931
i386                   randconfig-e001-201931
i386                   randconfig-e002-201931
i386                   randconfig-e003-201931
i386                   randconfig-e004-201931
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
