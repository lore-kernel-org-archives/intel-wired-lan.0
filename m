From: kbuild test robot <lkp@intel.com>
Date: Sat, 22 Dec 2018 14:17:21 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 124d68113d94e426a23e8d96d3a2834c3468bfa1
Message-ID: <5c1dd6f1.SGS3HPQ7HIkrQOLy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 124d68113d94e426a23e8d96d3a2834c3468bfa1  igc: Clean up code

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 102

alpha                            allmodconfig
alpha                            allyesconfig
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
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-a2
i386                            randconfig-a3
i386                            randconfig-f0
i386                            randconfig-f1
i386                            randconfig-f2
i386                            randconfig-f3
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-i2
i386                            randconfig-i3
i386                            randconfig-j0
i386                            randconfig-j1
i386                            randconfig-j2
i386                            randconfig-j3
i386                            randconfig-k0
i386                            randconfig-k1
i386                            randconfig-k2
i386                            randconfig-k3
i386                            randconfig-n0
i386                            randconfig-n1
i386                            randconfig-n2
i386                            randconfig-n3
i386                            randconfig-s0
i386                            randconfig-s1
i386                            randconfig-s2
i386                            randconfig-s3
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
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
s390                             allmodconfig
s390                             allyesconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                          randconfig-e0
x86_64                          randconfig-e1
x86_64                          randconfig-e2
x86_64                          randconfig-e3
x86_64                          randconfig-f0
x86_64                          randconfig-f1
x86_64                          randconfig-f2
x86_64                          randconfig-f3
x86_64                          randconfig-g0
x86_64                          randconfig-g1
x86_64                          randconfig-g2
x86_64                          randconfig-g3
x86_64                          randconfig-h0
x86_64                          randconfig-h1
x86_64                          randconfig-h2
x86_64                          randconfig-h3
x86_64                          randconfig-i0
x86_64                          randconfig-i1
x86_64                          randconfig-i2
x86_64                          randconfig-i3
x86_64                          randconfig-j0
x86_64                          randconfig-j1
x86_64                          randconfig-j2
x86_64                          randconfig-j3
x86_64                          randconfig-k0
x86_64                          randconfig-k1
x86_64                          randconfig-k2
x86_64                          randconfig-k3
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 107

x86_64                           allmodconfig
i386                   randconfig-x015-201850
i386                   randconfig-x011-201850
i386                   randconfig-x016-201850
i386                   randconfig-x017-201850
i386                   randconfig-x013-201850
i386                   randconfig-x018-201850
i386                   randconfig-x014-201850
i386                   randconfig-x012-201850
i386                   randconfig-x010-201850
i386                   randconfig-x019-201850
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-x006-201850
x86_64                 randconfig-x008-201850
x86_64                 randconfig-x003-201850
x86_64                 randconfig-x005-201850
x86_64                 randconfig-x001-201850
x86_64                 randconfig-x007-201850
x86_64                 randconfig-x009-201850
x86_64                 randconfig-x004-201850
x86_64                 randconfig-x000-201850
x86_64                 randconfig-x002-201850
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
nds32                             allnoconfig
nds32                               defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
riscv                             allnoconfig
riscv                               defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                 randconfig-x013-201850
x86_64                 randconfig-x011-201850
x86_64                 randconfig-x015-201850
x86_64                 randconfig-x019-201850
x86_64                 randconfig-x010-201850
x86_64                 randconfig-x016-201850
x86_64                 randconfig-x012-201850
x86_64                 randconfig-x018-201850
x86_64                 randconfig-x014-201850
x86_64                 randconfig-x017-201850
sh                               allmodconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-s3-12221349
x86_64                 randconfig-s4-12221349
x86_64                 randconfig-s5-12221349
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
riscv                              tinyconfig
i386                               tinyconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                         rhel-7.2-clear
i386                             allmodconfig
i386                   randconfig-x008-201850
i386                   randconfig-x002-201850
i386                   randconfig-x006-201850
i386                   randconfig-x001-201850
i386                   randconfig-x000-201850
i386                   randconfig-x004-201850
i386                   randconfig-x009-201850
i386                   randconfig-x003-201850
i386                   randconfig-x005-201850
i386                   randconfig-x007-201850
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
i386                   randconfig-x079-201850
i386                   randconfig-x077-201850
i386                   randconfig-x073-201850
i386                   randconfig-x074-201850
i386                   randconfig-x075-201850
i386                   randconfig-x071-201850
i386                   randconfig-x078-201850
i386                   randconfig-x076-201850
i386                   randconfig-x070-201850
i386                   randconfig-x072-201850

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
