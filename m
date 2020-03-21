From: kbuild test robot <lkp@intel.com>
Date: Sun, 22 Mar 2020 00:28:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD SUCCESS
 e961b679fb0b25004f5a57db0ccb34256391646b
Message-ID: <5e7640bf.p7C3OIomYCKQ2mp2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: e961b679fb0b25004f5a57db0ccb34256391646b  ice: add board identifier info to devlink .info_get

elapsed time: 503m

configs tested: 164
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
c6x                        evmc6678_defconfig
sparc64                             defconfig
csky                                defconfig
m68k                          multi_defconfig
s390                          debug_defconfig
alpha                               defconfig
ia64                             allmodconfig
s390                             alldefconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200321
x86_64               randconfig-a002-20200321
x86_64               randconfig-a003-20200321
i386                 randconfig-a001-20200321
i386                 randconfig-a002-20200321
i386                 randconfig-a003-20200321
alpha                randconfig-a001-20200321
m68k                 randconfig-a001-20200321
mips                 randconfig-a001-20200321
nds32                randconfig-a001-20200321
parisc               randconfig-a001-20200321
riscv                randconfig-a001-20200321
h8300                randconfig-a001-20200321
microblaze           randconfig-a001-20200321
nios2                randconfig-a001-20200321
c6x                  randconfig-a001-20200321
sparc64              randconfig-a001-20200321
s390                 randconfig-a001-20200321
xtensa               randconfig-a001-20200321
csky                 randconfig-a001-20200321
openrisc             randconfig-a001-20200321
sh                   randconfig-a001-20200321
x86_64               randconfig-b001-20200321
x86_64               randconfig-b002-20200321
x86_64               randconfig-b003-20200321
i386                 randconfig-b001-20200321
i386                 randconfig-b002-20200321
i386                 randconfig-b003-20200321
x86_64               randconfig-c001-20200321
x86_64               randconfig-c002-20200321
x86_64               randconfig-c003-20200321
i386                 randconfig-c001-20200321
i386                 randconfig-c002-20200321
i386                 randconfig-c003-20200321
i386                 randconfig-d003-20200321
i386                 randconfig-d001-20200321
x86_64               randconfig-d002-20200321
i386                 randconfig-d002-20200321
x86_64               randconfig-d001-20200321
x86_64               randconfig-d003-20200321
x86_64               randconfig-e001-20200321
x86_64               randconfig-e002-20200321
x86_64               randconfig-e003-20200321
i386                 randconfig-e001-20200321
i386                 randconfig-e002-20200321
i386                 randconfig-e003-20200321
x86_64               randconfig-f001-20200321
x86_64               randconfig-f002-20200321
x86_64               randconfig-f003-20200321
i386                 randconfig-f001-20200321
i386                 randconfig-f002-20200321
i386                 randconfig-f003-20200321
x86_64               randconfig-g001-20200321
x86_64               randconfig-g002-20200321
x86_64               randconfig-g003-20200321
i386                 randconfig-g001-20200321
i386                 randconfig-g002-20200321
i386                 randconfig-g003-20200321
x86_64               randconfig-h001-20200321
x86_64               randconfig-h002-20200321
x86_64               randconfig-h003-20200321
i386                 randconfig-h001-20200321
i386                 randconfig-h002-20200321
i386                 randconfig-h003-20200321
arm                  randconfig-a001-20200321
arm64                randconfig-a001-20200321
ia64                 randconfig-a001-20200321
powerpc              randconfig-a001-20200321
sparc                randconfig-a001-20200321
arc                  randconfig-a001-20200321
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
