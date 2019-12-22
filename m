From: kbuild test robot <lkp@intel.com>
Date: Sun, 22 Dec 2019 09:58:15 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 4d0f025125a229960630ffa17861df8133108e29
Message-ID: <5dfecdb7.GNeNWXdQrrBjlHLO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 4d0f025125a229960630ffa17861df8133108e29  ice: remove redundant assignment to variable xmit_done

TIMEOUT after 2881m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 26

arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
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
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig

configs tested: 149

um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-e002-20191220
x86_64               randconfig-e002-20191220
x86_64               randconfig-e001-20191220
i386                 randconfig-e003-20191220
x86_64               randconfig-e003-20191220
i386                 randconfig-e001-20191220
x86_64               randconfig-g002-20191220
i386                 randconfig-g003-20191220
i386                 randconfig-g001-20191220
x86_64               randconfig-g001-20191220
i386                 randconfig-g002-20191220
x86_64               randconfig-g003-20191220
x86_64               randconfig-d001-20191222
x86_64               randconfig-d002-20191222
x86_64               randconfig-d003-20191222
i386                 randconfig-d001-20191222
i386                 randconfig-d002-20191222
i386                 randconfig-d003-20191222
arm64                randconfig-a001-20191220
arm                  randconfig-a001-20191220
powerpc              randconfig-a001-20191220
arc                  randconfig-a001-20191220
ia64                 randconfig-a001-20191220
sparc                randconfig-a001-20191220
i386                 randconfig-d003-20191220
x86_64               randconfig-d001-20191220
x86_64               randconfig-d002-20191220
i386                 randconfig-d002-20191220
x86_64               randconfig-d003-20191220
i386                 randconfig-d001-20191220
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
sparc64                          allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                             allyesconfig
i386                 randconfig-h003-20191220
x86_64               randconfig-a002-20191222
x86_64               randconfig-a001-20191222
x86_64               randconfig-a003-20191222
i386                 randconfig-a001-20191222
i386                 randconfig-a002-20191222
i386                 randconfig-a003-20191222
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
arm                           sunxi_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
c6x                  randconfig-a001-20191222
h8300                randconfig-a001-20191222
microblaze           randconfig-a001-20191222
nios2                randconfig-a001-20191222
sparc64              randconfig-a001-20191222
i386                 randconfig-f001-20191220
x86_64               randconfig-f003-20191220
i386                 randconfig-f003-20191220
i386                 randconfig-f002-20191220
x86_64               randconfig-f001-20191220
x86_64               randconfig-f002-20191220
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64               randconfig-b001-20191222
x86_64               randconfig-b002-20191222
x86_64               randconfig-b003-20191222
i386                 randconfig-b001-20191222
i386                 randconfig-b002-20191222
i386                 randconfig-b003-20191222
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                 randconfig-a001-20191220
m68k                 randconfig-a001-20191220
riscv                randconfig-a001-20191220
nds32                randconfig-a001-20191220
parisc               randconfig-a001-20191220
alpha                randconfig-a001-20191220
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
csky                 randconfig-a001-20191222
openrisc             randconfig-a001-20191222
s390                 randconfig-a001-20191222
sh                   randconfig-a001-20191222
xtensa               randconfig-a001-20191222
x86_64               randconfig-b003-20191220
x86_64               randconfig-b001-20191220
x86_64               randconfig-b002-20191220
i386                 randconfig-b001-20191220
i386                 randconfig-b003-20191220
i386                 randconfig-b002-20191220
s390                 randconfig-a001-20191220
sh                   randconfig-a001-20191220
xtensa               randconfig-a001-20191220
openrisc             randconfig-a001-20191220
csky                 randconfig-a001-20191220
x86_64               randconfig-c003-20191222
i386                 randconfig-c001-20191222
i386                 randconfig-c003-20191222
i386                 randconfig-c002-20191222
x86_64               randconfig-c002-20191222
x86_64               randconfig-c001-20191222

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
