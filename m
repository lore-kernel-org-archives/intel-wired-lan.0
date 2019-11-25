From: kbuild test robot <lkp@intel.com>
Date: Mon, 25 Nov 2019 14:56:57 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD INCOMPLETE
 ed960c1d36f5db38a8038fcca83e1f6495f468fb
Message-ID: <5ddb7b39.9yhs58BnPVEVDJqD%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: ed960c1d36f5db38a8038fcca83e1f6495f468fb  ice: Update FW API minor version

TIMEOUT after 2888m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 1

i386                             allyesconfig

configs tested: 121

c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64               randconfig-e001-20191123
x86_64               randconfig-e002-20191123
x86_64               randconfig-e003-20191123
i386                 randconfig-e001-20191123
i386                 randconfig-e002-20191123
i386                 randconfig-e003-20191123
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
alpha                               defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64               randconfig-d001-20191123
x86_64               randconfig-d002-20191123
x86_64               randconfig-d003-20191123
i386                 randconfig-d001-20191123
i386                 randconfig-d002-20191123
i386                 randconfig-d003-20191123
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
x86_64               randconfig-c001-20191123
x86_64               randconfig-c002-20191123
x86_64               randconfig-c003-20191123
i386                 randconfig-c001-20191123
i386                 randconfig-c002-20191123
i386                 randconfig-c003-20191123
x86_64               randconfig-h001-20191123
x86_64               randconfig-h002-20191123
x86_64               randconfig-h003-20191123
i386                 randconfig-h001-20191123
i386                 randconfig-h002-20191123
i386                 randconfig-h003-20191123
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64               randconfig-b001-20191123
x86_64               randconfig-b002-20191123
x86_64               randconfig-b003-20191123
i386                 randconfig-b001-20191123
i386                 randconfig-b002-20191123
i386                 randconfig-b003-20191123
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-g001-20191123
x86_64               randconfig-g002-20191123
x86_64               randconfig-g003-20191123
i386                 randconfig-g001-20191123
i386                 randconfig-g002-20191123
i386                 randconfig-g003-20191123
arc                 randconfig-a0031-20191123
arm                  randconfig-a001-20191123
arm64                randconfig-a001-20191123
ia64                 randconfig-a001-20191123
powerpc              randconfig-a001-20191123
sparc                randconfig-a001-20191123

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
