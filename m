From: kbuild test robot <lkp@intel.com>
Date: Thu, 04 Jul 2019 22:22:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD INCOMPLETE
 033542b038c6ce7f51e6631e5fee735e14e53009
Message-ID: <5d1e0bb0.X1fC6RTWO9cboXY1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: 033542b038c6ce7f51e6631e5fee735e14e53009  i40e: Register RDMA client devices to the virtual platform bus

TIMEOUT after 721m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 28

alpha                            allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
arc                                 defconfig
c6x                              allyesconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
nds32                            allmodconfig
nds32                            allyesconfig
nios2                         3c120_defconfig
openrisc                 simple_smp_defconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
s390                             allyesconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
x86_64                           allmodconfig
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 143

s390                             allmodconfig
s390                          debug_defconfig
sh                               allmodconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
nds32                             allnoconfig
nds32                               defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-x010-201926
i386                   randconfig-x011-201926
i386                   randconfig-x012-201926
i386                   randconfig-x013-201926
i386                   randconfig-x014-201926
i386                   randconfig-x015-201926
i386                   randconfig-x016-201926
i386                   randconfig-x017-201926
i386                   randconfig-x018-201926
i386                   randconfig-x019-201926
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                           allyesconfig
i386                             allmodconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
riscv                             allnoconfig
riscv                               defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                 randconfig-n001-201926
x86_64                 randconfig-n002-201926
x86_64                 randconfig-n003-201926
x86_64                 randconfig-n004-201926
x86_64                 randconfig-n005-201926
x86_64                 randconfig-n006-201926
x86_64                 randconfig-n007-201926
x86_64                 randconfig-n008-201926
x86_64                 randconfig-n009-201926
x86_64                 randconfig-n010-201926
x86_64                 randconfig-n011-201926
x86_64                 randconfig-n012-201926
x86_64                 randconfig-n013-201926
x86_64                 randconfig-n014-201926
x86_64                 randconfig-n015-201926
x86_64                 randconfig-n016-201926
x86_64                 randconfig-n017-201926
x86_64                 randconfig-n018-201926
x86_64                 randconfig-n019-201926
x86_64                 randconfig-n020-201926
x86_64                 randconfig-n021-201926
x86_64                 randconfig-n022-201926
x86_64                 randconfig-n023-201926
x86_64                 randconfig-n024-201926
x86_64                 randconfig-n025-201926
x86_64                 randconfig-n026-201926
x86_64                 randconfig-n027-201926
x86_64                 randconfig-n028-201926
x86_64                 randconfig-n029-201926
x86_64                 randconfig-n030-201926
x86_64                 randconfig-n031-201926
x86_64                 randconfig-n032-201926
i386                   randconfig-n001-201926
i386                   randconfig-n002-201926
i386                   randconfig-n003-201926
i386                   randconfig-n004-201926
i386                   randconfig-n005-201926
i386                   randconfig-n006-201926
i386                   randconfig-n007-201926
i386                   randconfig-n008-201926
i386                   randconfig-n009-201926
i386                   randconfig-n010-201926
i386                   randconfig-n011-201926
i386                   randconfig-n012-201926
i386                   randconfig-n013-201926
i386                   randconfig-n014-201926
i386                   randconfig-n015-201926
i386                   randconfig-n016-201926
i386                   randconfig-n017-201926
i386                   randconfig-n018-201926
i386                   randconfig-n019-201926
i386                   randconfig-n020-201926
i386                   randconfig-n021-201926
i386                   randconfig-n022-201926
i386                   randconfig-n023-201926
i386                   randconfig-n024-201926
i386                   randconfig-n025-201926
i386                   randconfig-n026-201926
i386                   randconfig-n027-201926
i386                   randconfig-n028-201926
i386                   randconfig-n029-201926
i386                   randconfig-n030-201926
i386                   randconfig-n031-201926
i386                   randconfig-n032-201926
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
um                                  defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
