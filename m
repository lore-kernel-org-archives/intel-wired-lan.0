From: kbuild test robot <lkp@intel.com>
Date: Fri, 06 Dec 2019 07:43:26 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 ca8e48eb5f3baa989219ee984366404a8859f45a
Message-ID: <5de9961e.+2eXdMEAYe1AK9yh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ca8e48eb5f3baa989219ee984366404a8859f45a  igc: Use Start of Packet signal from PHY for timestamping

TIMEOUT after 2888m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 19

i386                             allyesconfig
ia64                             alldefconfig
ia64                                defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig

configs tested: 105

x86_64               randconfig-b001-20191204
i386                 randconfig-b001-20191204
i386                 randconfig-b002-20191204
x86_64               randconfig-b003-20191204
x86_64               randconfig-b002-20191204
i386                 randconfig-b003-20191204
x86_64               randconfig-c001-20191204
i386                 randconfig-c003-20191204
i386                 randconfig-c002-20191204
x86_64               randconfig-c002-20191204
i386                 randconfig-c001-20191204
x86_64               randconfig-c003-20191204
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64               randconfig-e003-20191204
i386                 randconfig-e003-20191204
x86_64               randconfig-e001-20191204
i386                 randconfig-e001-20191204
i386                 randconfig-e002-20191204
x86_64               randconfig-e002-20191204
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
mips                             allmodconfig
mips                           32r2_defconfig
mips                              allnoconfig
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
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64               randconfig-h001-20191204
i386                 randconfig-h001-20191204
i386                 randconfig-h003-20191204
x86_64               randconfig-h003-20191204
x86_64               randconfig-h002-20191204
i386                 randconfig-h002-20191204
i386                 randconfig-g003-20191204
x86_64               randconfig-g003-20191204
i386                 randconfig-g002-20191204
i386                 randconfig-g001-20191204
x86_64               randconfig-g001-20191204
x86_64               randconfig-g002-20191204
arc                              allyesconfig
microblaze                    nommu_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
ia64                 randconfig-a001-20191204
arm64                randconfig-a001-20191204
powerpc              randconfig-a001-20191204
sparc                randconfig-a001-20191204
arm                  randconfig-a001-20191204
arc                 randconfig-a0031-20191204
x86_64               randconfig-f001-20191204
x86_64               randconfig-f003-20191204
i386                 randconfig-f003-20191204
i386                 randconfig-f001-20191204
i386                 randconfig-f002-20191204
x86_64               randconfig-f002-20191204
i386                 randconfig-a001-20191204
ia64                             allmodconfig
ia64                              allnoconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
