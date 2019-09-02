From: kbuild test robot <lkp@intel.com>
Date: Mon, 02 Sep 2019 19:15:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 ed1634c77b53aabc0cb384d1df6daf59470e716c
Message-ID: <5d6cf9c1.trgHydjoU1sWy8Rt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ed1634c77b53aabc0cb384d1df6daf59470e716c  ice: Rework around device/function capabilities

TIMEOUT after 1440m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 18

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
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig

configs tested: 132

s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-c001-201935
x86_64                 randconfig-c002-201935
x86_64                 randconfig-c003-201935
x86_64                 randconfig-c004-201935
i386                   randconfig-c001-201935
i386                   randconfig-c002-201935
i386                   randconfig-c003-201935
i386                   randconfig-c004-201935
x86_64                 randconfig-f001-201935
x86_64                 randconfig-f002-201935
x86_64                 randconfig-f003-201935
x86_64                 randconfig-f004-201935
i386                   randconfig-f001-201935
i386                   randconfig-f002-201935
i386                   randconfig-f003-201935
i386                   randconfig-f004-201935
x86_64                           allmodconfig
x86_64                           allyesconfig
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                 randconfig-g001-201935
x86_64                 randconfig-g002-201935
x86_64                 randconfig-g003-201935
x86_64                 randconfig-g004-201935
i386                   randconfig-g001-201935
i386                   randconfig-g002-201935
i386                   randconfig-g003-201935
i386                   randconfig-g004-201935
i386                             allmodconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h002-201935
x86_64                 randconfig-h003-201935
i386                   randconfig-h002-201935
i386                   randconfig-h001-201935
i386                   randconfig-h004-201935
x86_64                 randconfig-h004-201935
x86_64                 randconfig-h001-201935
i386                   randconfig-h003-201935
x86_64                 randconfig-a001-201935
x86_64                 randconfig-a002-201935
x86_64                 randconfig-a003-201935
x86_64                 randconfig-a004-201935
i386                   randconfig-a001-201935
i386                   randconfig-a002-201935
i386                   randconfig-a003-201935
i386                   randconfig-a004-201935
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                 randconfig-e001-201935
x86_64                 randconfig-e002-201935
x86_64                 randconfig-e003-201935
x86_64                 randconfig-e004-201935
i386                   randconfig-e001-201935
i386                   randconfig-e002-201935
i386                   randconfig-e003-201935
i386                   randconfig-e004-201935
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
powerpc                             defconfig
x86_64                 randconfig-b001-201935
x86_64                 randconfig-b002-201935
x86_64                 randconfig-b003-201935
x86_64                 randconfig-b004-201935
i386                   randconfig-b001-201935
i386                   randconfig-b002-201935
i386                   randconfig-b003-201935
i386                   randconfig-b004-201935
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-d001-201935
x86_64                 randconfig-d002-201935
x86_64                 randconfig-d003-201935
x86_64                 randconfig-d004-201935
i386                   randconfig-d001-201935
i386                   randconfig-d002-201935
i386                   randconfig-d003-201935
i386                   randconfig-d004-201935
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
