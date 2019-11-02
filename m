From: kbuild test robot <lkp@intel.com>
Date: Sun, 03 Nov 2019 06:08:51 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:master] BUILD INCOMPLETE
 c8c2cd8102a7b399873b3d001193a5abef42ffb8
Message-ID: <5dbdfe73.EDhp0hAoyALgEBcx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  master
branch HEAD: c8c2cd8102a7b399873b3d001193a5abef42ffb8  Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue

TIMEOUT after 1453m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 1

x86_64                           allmodconfig

configs tested: 120

x86_64                 randconfig-a004-201943
x86_64                 randconfig-a001-201943
i386                   randconfig-a002-201943
x86_64                 randconfig-a002-201943
i386                   randconfig-a001-201943
i386                   randconfig-a003-201943
i386                   randconfig-a004-201943
x86_64                 randconfig-a003-201943
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
i386                   randconfig-f002-201943
i386                   randconfig-f001-201943
i386                   randconfig-f003-201943
i386                   randconfig-f004-201943
x86_64                           allyesconfig
i386                             allmodconfig
m68k                             allmodconfig
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
x86_64                 randconfig-e004-201943
i386                   randconfig-e003-201943
i386                   randconfig-e001-201943
i386                   randconfig-e002-201943
x86_64                 randconfig-d001-201943
x86_64                 randconfig-d002-201943
x86_64                 randconfig-d003-201943
x86_64                 randconfig-d004-201943
i386                   randconfig-d001-201943
i386                   randconfig-d002-201943
i386                   randconfig-d003-201943
i386                   randconfig-d004-201943
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-g004-201943
i386                   randconfig-g003-201943
x86_64                 randconfig-b001-201943
x86_64                 randconfig-b002-201943
x86_64                 randconfig-b003-201943
x86_64                 randconfig-b004-201943
i386                   randconfig-b001-201943
i386                   randconfig-b002-201943
i386                   randconfig-b003-201943
i386                   randconfig-b004-201943
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-c004-201943
i386                   randconfig-c003-201943
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-e001-201943
x86_64                 randconfig-e002-201943
x86_64                 randconfig-e003-201943
i386                   randconfig-e004-201943

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
