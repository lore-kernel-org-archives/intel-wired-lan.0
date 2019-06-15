From: kbuild test robot <lkp@intel.com>
Date: Sat, 15 Jun 2019 14:25:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD INCOMPLETE
 514af5f0995219da7f18d73ecece6e7d1fec8c4e
Message-ID: <5d048f40.s+LenqEzQDow5Tcw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
branch HEAD: 514af5f0995219da7f18d73ecece6e7d1fec8c4e  i40e: mark expected switch fall-through

TIMEOUT after 609m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 41

alpha                            allmodconfig
alpha                            allyesconfig
i386                          randconfig-x000
i386                          randconfig-x001
i386                          randconfig-x002
i386                          randconfig-x003
i386                          randconfig-x004
i386                          randconfig-x005
i386                          randconfig-x006
i386                          randconfig-x007
i386                          randconfig-x008
i386                          randconfig-x009
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                             allyesconfig
nds32                            allmodconfig
nds32                            allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 172

arm                              allmodconfig
arm64                            allmodconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                 randconfig-n001-201923
x86_64                 randconfig-n002-201923
x86_64                 randconfig-n003-201923
x86_64                 randconfig-n004-201923
x86_64                 randconfig-n005-201923
x86_64                 randconfig-n006-201923
x86_64                 randconfig-n007-201923
x86_64                 randconfig-n008-201923
x86_64                 randconfig-n009-201923
x86_64                 randconfig-n010-201923
x86_64                 randconfig-n011-201923
x86_64                 randconfig-n012-201923
x86_64                 randconfig-n013-201923
x86_64                 randconfig-n014-201923
x86_64                 randconfig-n015-201923
x86_64                 randconfig-n016-201923
x86_64                 randconfig-n017-201923
x86_64                 randconfig-n018-201923
x86_64                 randconfig-n019-201923
x86_64                 randconfig-n020-201923
x86_64                 randconfig-n021-201923
x86_64                 randconfig-n022-201923
x86_64                 randconfig-n023-201923
x86_64                 randconfig-n024-201923
x86_64                 randconfig-n025-201923
x86_64                 randconfig-n026-201923
x86_64                 randconfig-n027-201923
x86_64                 randconfig-n028-201923
x86_64                 randconfig-n029-201923
x86_64                 randconfig-n030-201923
x86_64                 randconfig-n031-201923
x86_64                 randconfig-n032-201923
i386                   randconfig-n001-201923
i386                   randconfig-n002-201923
i386                   randconfig-n003-201923
i386                   randconfig-n004-201923
i386                   randconfig-n005-201923
i386                   randconfig-n006-201923
i386                   randconfig-n007-201923
i386                   randconfig-n008-201923
i386                   randconfig-n009-201923
i386                   randconfig-n010-201923
i386                   randconfig-n011-201923
i386                   randconfig-n012-201923
i386                   randconfig-n013-201923
i386                   randconfig-n014-201923
i386                   randconfig-n015-201923
i386                   randconfig-n016-201923
i386                   randconfig-n017-201923
i386                   randconfig-n018-201923
i386                   randconfig-n019-201923
i386                   randconfig-n020-201923
i386                   randconfig-n021-201923
i386                   randconfig-n022-201923
i386                   randconfig-n023-201923
i386                   randconfig-n024-201923
i386                   randconfig-n025-201923
i386                   randconfig-n026-201923
i386                   randconfig-n027-201923
i386                   randconfig-n028-201923
i386                   randconfig-n029-201923
i386                   randconfig-n030-201923
i386                   randconfig-n031-201923
i386                   randconfig-n032-201923
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                          debug_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
i386                             alldefconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
ia64                             alldefconfig
i386                             allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                              allnoconfig
i386                                defconfig
sh                               allyesconfig
m68k                             allyesconfig
x86_64                 randconfig-x010-201923
x86_64                 randconfig-x011-201923
x86_64                 randconfig-x012-201923
x86_64                 randconfig-x013-201923
x86_64                 randconfig-x014-201923
x86_64                 randconfig-x015-201923
x86_64                 randconfig-x016-201923
x86_64                 randconfig-x017-201923
x86_64                 randconfig-x018-201923
x86_64                 randconfig-x019-201923
i386                   randconfig-x073-201923
i386                   randconfig-x070-201923
i386                   randconfig-x071-201923
i386                   randconfig-x074-201923
i386                   randconfig-x078-201923
i386                   randconfig-x075-201923
i386                   randconfig-x072-201923
i386                   randconfig-x076-201923
i386                   randconfig-x077-201923
i386                   randconfig-x079-201923
i386                   randconfig-x010-201923
i386                   randconfig-x011-201923
i386                   randconfig-x012-201923
i386                   randconfig-x013-201923
i386                   randconfig-x014-201923
i386                   randconfig-x015-201923
i386                   randconfig-x016-201923
i386                   randconfig-x017-201923
i386                   randconfig-x018-201923
i386                   randconfig-x019-201923
x86_64                 randconfig-x000-201923
x86_64                 randconfig-x001-201923
x86_64                 randconfig-x002-201923
x86_64                 randconfig-x003-201923
x86_64                 randconfig-x004-201923
x86_64                 randconfig-x005-201923
x86_64                 randconfig-x006-201923
x86_64                 randconfig-x007-201923
x86_64                 randconfig-x008-201923
x86_64                 randconfig-x009-201923
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                                   jz4740
mips                                     txx9
riscv                              tinyconfig
i386                               tinyconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
