From: kbuild test robot <lkp@intel.com>
Date: Tue, 13 Aug 2019 23:07:30 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 6275557e41357a49c6521e05449d4bf36ef6217a
Message-ID: <5d52d232.0cwod2iaoqKCQDm3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 6275557e41357a49c6521e05449d4bf36ef6217a  checkpatch.pl: seed camelcase from the provided kernel tree root

TIMEOUT after 1441m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 40

alpha                            allmodconfig
alpha                            allyesconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
i386                             allmodconfig
i386                               tinyconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allyesconfig
mips                                   jz4740
mips                                     txx9
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
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 131

x86_64                           allmodconfig
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
ia64                                defconfig
x86_64                 randconfig-e004-201932
i386                   randconfig-e004-201932
x86_64                 randconfig-e002-201932
i386                   randconfig-e003-201932
x86_64                 randconfig-e003-201932
x86_64                 randconfig-e001-201932
i386                   randconfig-e002-201932
i386                   randconfig-e001-201932
x86_64                 randconfig-b002-201932
i386                   randconfig-b003-201932
i386                   randconfig-b004-201932
i386                   randconfig-b002-201932
x86_64                 randconfig-b001-201932
i386                   randconfig-b001-201932
x86_64                 randconfig-b004-201932
x86_64                 randconfig-b003-201932
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
x86_64                 randconfig-g003-201932
i386                   randconfig-g004-201932
x86_64                 randconfig-g001-201932
x86_64                 randconfig-g002-201932
i386                   randconfig-g001-201932
x86_64                 randconfig-g004-201932
i386                   randconfig-g002-201932
i386                   randconfig-g003-201932
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
i386                   randconfig-d002-201932
i386                   randconfig-d004-201932
x86_64                 randconfig-d004-201932
x86_64                 randconfig-d001-201932
x86_64                 randconfig-d002-201932
x86_64                 randconfig-d003-201932
i386                   randconfig-d001-201932
i386                   randconfig-d003-201932
x86_64                 randconfig-a004-201932
i386                   randconfig-a003-201932
x86_64                 randconfig-a002-201932
i386                   randconfig-a004-201932
i386                   randconfig-a002-201932
x86_64                 randconfig-a001-201932
i386                   randconfig-a001-201932
x86_64                 randconfig-a003-201932
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
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
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
x86_64                 randconfig-c003-201932
x86_64                 randconfig-c002-201932
i386                   randconfig-c004-201932
x86_64                 randconfig-c004-201932
i386                   randconfig-c003-201932
i386                   randconfig-c001-201932
i386                   randconfig-c002-201932
x86_64                 randconfig-c001-201932
i386                   randconfig-f004-201932
x86_64                 randconfig-f004-201932
i386                   randconfig-f001-201932
x86_64                 randconfig-f002-201932
i386                   randconfig-f002-201932
i386                   randconfig-f003-201932
x86_64                 randconfig-f003-201932
x86_64                 randconfig-f001-201932
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
x86_64                 randconfig-h002-201932
x86_64                 randconfig-h003-201932
i386                   randconfig-h001-201932
i386                   randconfig-h002-201932
x86_64                 randconfig-h004-201932
i386                   randconfig-h004-201932
i386                   randconfig-h003-201932
x86_64                 randconfig-h001-201932
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
