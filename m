From: kbuild test robot <lkp@intel.com>
Date: Tue, 18 Jun 2019 17:22:02 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD INCOMPLETE
 efa14c3985828da3163f5372137cb64d992b0f79
Message-ID: <5d08ad3a.lhOnPfJyBxCeSwvs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
branch HEAD: efa14c3985828da3163f5372137cb64d992b0f79  iavf: allow null RX descriptors

TIMEOUT after 606m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 106

alpha                            allmodconfig
alpha                            allyesconfig
alpha                               defconfig
i386                             allmodconfig
i386                          randconfig-n001
i386                          randconfig-n002
i386                          randconfig-n003
i386                          randconfig-n004
i386                          randconfig-n005
i386                          randconfig-n006
i386                          randconfig-n007
i386                          randconfig-n008
i386                          randconfig-n009
i386                          randconfig-n010
i386                          randconfig-n011
i386                          randconfig-n012
i386                          randconfig-n013
i386                          randconfig-n014
i386                          randconfig-n015
i386                          randconfig-n016
i386                          randconfig-n017
i386                          randconfig-n018
i386                          randconfig-n019
i386                          randconfig-n020
i386                          randconfig-n021
i386                          randconfig-n022
i386                          randconfig-n023
i386                          randconfig-n024
i386                          randconfig-n025
i386                          randconfig-n026
i386                          randconfig-n027
i386                          randconfig-n028
i386                          randconfig-n029
i386                          randconfig-n030
i386                          randconfig-n031
i386                          randconfig-n032
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
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
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
um                                  defconfig
x86_64                        randconfig-n001
x86_64                        randconfig-n002
x86_64                        randconfig-n003
x86_64                        randconfig-n004
x86_64                        randconfig-n005
x86_64                        randconfig-n006
x86_64                        randconfig-n007
x86_64                        randconfig-n008
x86_64                        randconfig-n009
x86_64                        randconfig-n010
x86_64                        randconfig-n011
x86_64                        randconfig-n012
x86_64                        randconfig-n013
x86_64                        randconfig-n014
x86_64                        randconfig-n015
x86_64                        randconfig-n016
x86_64                        randconfig-n017
x86_64                        randconfig-n018
x86_64                        randconfig-n019
x86_64                        randconfig-n020
x86_64                        randconfig-n021
x86_64                        randconfig-n022
x86_64                        randconfig-n023
x86_64                        randconfig-n024
x86_64                        randconfig-n025
x86_64                        randconfig-n026
x86_64                        randconfig-n027
x86_64                        randconfig-n028
x86_64                        randconfig-n029
x86_64                        randconfig-n030
x86_64                        randconfig-n031
x86_64                        randconfig-n032
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 107

x86_64                                  kexec
x86_64                              fedora-25
arm                              allmodconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
riscv                              tinyconfig
i386                               tinyconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                 randconfig-x019-201924
x86_64                 randconfig-x012-201924
x86_64                 randconfig-x014-201924
x86_64                 randconfig-x015-201924
x86_64                 randconfig-x010-201924
x86_64                 randconfig-x017-201924
x86_64                 randconfig-x011-201924
x86_64                 randconfig-x016-201924
x86_64                 randconfig-x018-201924
x86_64                 randconfig-x013-201924
i386                   randconfig-x013-201924
i386                   randconfig-x018-201924
i386                   randconfig-x012-201924
i386                   randconfig-x011-201924
i386                   randconfig-x016-201924
i386                   randconfig-x010-201924
i386                   randconfig-x017-201924
i386                   randconfig-x015-201924
i386                   randconfig-x014-201924
i386                   randconfig-x019-201924
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-x001-201924
x86_64                 randconfig-x007-201924
x86_64                 randconfig-x006-201924
x86_64                 randconfig-x003-201924
x86_64                 randconfig-x004-201924
x86_64                 randconfig-x009-201924
x86_64                 randconfig-x002-201924
x86_64                 randconfig-x008-201924
x86_64                 randconfig-x005-201924
x86_64                 randconfig-x000-201924
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
s390                          debug_defconfig
i386                   randconfig-x009-201924
i386                   randconfig-x004-201924
i386                   randconfig-x005-201924
i386                   randconfig-x008-201924
i386                   randconfig-x006-201924
i386                   randconfig-x001-201924
i386                   randconfig-x007-201924
i386                   randconfig-x000-201924
i386                   randconfig-x002-201924
i386                   randconfig-x003-201924
i386                   randconfig-x071-201924
i386                   randconfig-x070-201924
i386                   randconfig-x073-201924
i386                   randconfig-x078-201924
i386                   randconfig-x074-201924
i386                   randconfig-x072-201924
i386                   randconfig-x075-201924
i386                   randconfig-x077-201924
i386                   randconfig-x076-201924
i386                   randconfig-x079-201924
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
