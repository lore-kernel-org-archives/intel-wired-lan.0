From: kbuild test robot <lkp@intel.com>
Date: Mon, 09 Dec 2019 13:12:46 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 c0046220b8ba1d67ff13837ad5a53c5f70d9e9f9
Message-ID: <5dedd7ce.SYbyLhMMoL8NAW12%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: c0046220b8ba1d67ff13837ad5a53c5f70d9e9f9  igb: Fix SGMII SFP module discovery for 100FX/LX

TIMEOUT after 2887m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 6

i386                             allyesconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6

configs tested: 111

i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-g001-20191208
x86_64               randconfig-g002-20191208
x86_64               randconfig-g003-20191208
i386                 randconfig-g001-20191208
i386                 randconfig-g002-20191208
i386                 randconfig-g003-20191208
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-e001-20191208
x86_64               randconfig-e002-20191208
x86_64               randconfig-e003-20191208
i386                 randconfig-e001-20191208
i386                 randconfig-e002-20191208
i386                 randconfig-e003-20191208
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64               randconfig-d001-20191208
x86_64               randconfig-d002-20191208
x86_64               randconfig-d003-20191208
i386                 randconfig-d001-20191208
i386                 randconfig-d002-20191208
i386                 randconfig-d003-20191208
x86_64               randconfig-b001-20191206
i386                 randconfig-b001-20191206
i386                 randconfig-b002-20191206
x86_64               randconfig-b003-20191206
x86_64               randconfig-b002-20191206
i386                 randconfig-b003-20191206
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64               randconfig-a001-20191208
x86_64               randconfig-a002-20191208
x86_64               randconfig-a003-20191208
i386                 randconfig-a001-20191208
i386                 randconfig-a002-20191208
i386                 randconfig-a003-20191208
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
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
x86_64               randconfig-b001-20191208
x86_64               randconfig-b002-20191208
x86_64               randconfig-b003-20191208
i386                 randconfig-b001-20191208
i386                 randconfig-b002-20191208
i386                 randconfig-b003-20191208

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
