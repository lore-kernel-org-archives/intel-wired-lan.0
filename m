From: kbuild test robot <lkp@intel.com>
Date: Wed, 04 Jul 2018 11:56:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 a9ea4ab1fbbfa6b0fe3368ca620006f5b1d3502d
Message-ID: <5b3c457c.5nSUqSIqtGffSzm7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: a9ea4ab1fbbfa6b0fe3368ca620006f5b1d3502d  ixgbe: add ipsec security registers into ethtool register dump

TIMEOUT after 601m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 63

alpha                            allmodconfig
alpha                            allyesconfig
alpha                               defconfig
i386                            randconfig-i0
i386                            randconfig-i1
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
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                                allnoconfig
sh                               allyesconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                                    lkp
x86_64                        randconfig-x000
x86_64                        randconfig-x001
x86_64                        randconfig-x002
x86_64                        randconfig-x003
x86_64                        randconfig-x004
x86_64                        randconfig-x005
x86_64                        randconfig-x006
x86_64                        randconfig-x007
x86_64                        randconfig-x008
x86_64                        randconfig-x009
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 80

i386                   randconfig-n0-07031211
i386                   randconfig-a1-07040208
i386                   randconfig-a0-07040208
x86_64                 randconfig-x015-201826
x86_64                 randconfig-x011-201826
x86_64                 randconfig-x018-201826
x86_64                 randconfig-x010-201826
x86_64                 randconfig-x014-201826
x86_64                 randconfig-x019-201826
x86_64                 randconfig-x017-201826
x86_64                 randconfig-x016-201826
x86_64                 randconfig-x013-201826
x86_64                 randconfig-x012-201826
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s0-201826
i386                     randconfig-s1-201826
i386                             allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-i0-07031126
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                               tinyconfig
i386                   randconfig-x016-201826
i386                   randconfig-x014-201826
i386                   randconfig-x017-201826
i386                   randconfig-x012-201826
i386                   randconfig-x018-201826
i386                   randconfig-x011-201826
i386                   randconfig-x013-201826
i386                   randconfig-x019-201826
i386                   randconfig-x015-201826
i386                   randconfig-x010-201826
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                   randconfig-x078-201826
i386                   randconfig-x079-201826
i386                   randconfig-x074-201826
i386                   randconfig-x076-201826
i386                   randconfig-x075-201826
i386                   randconfig-x070-201826
i386                   randconfig-x073-201826
i386                   randconfig-x071-201826
i386                   randconfig-x077-201826
i386                   randconfig-x072-201826
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                              fedora-25
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
