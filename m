From: kbuild test robot <lkp@intel.com>
Date: Wed, 03 Jul 2019 03:23:56 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD INCOMPLETE
 fae6cad17ce39b4c03e5c9f2315d2e511a1c8cb4
Message-ID: <5d1baf4c.+85xe4UFag80ILUR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
branch HEAD: fae6cad17ce39b4c03e5c9f2315d2e511a1c8cb4  i40e/i40e_virtchnl_pf: Use struct_size() in kzalloc()

TIMEOUT after 722m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 40

alpha                            allmodconfig
alpha                            allyesconfig
alpha                               defconfig
c6x                              allyesconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
i386                             alldefconfig
i386                               tinyconfig
ia64                             allyesconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                             allyesconfig
nds32                            allmodconfig
nds32                            allyesconfig
nios2                         3c120_defconfig
parisc                           allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                              tinyconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc64                          allyesconfig
um                                  defconfig
x86_64                           allmodconfig
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 137

c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arm                              allmodconfig
arm64                            allmodconfig
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                           allyesconfig
i386                             allmodconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
arc                              allyesconfig
arc                                 defconfig
openrisc                 simple_smp_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
