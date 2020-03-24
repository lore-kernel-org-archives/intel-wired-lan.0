From: kbuild test robot <lkp@intel.com>
Date: Wed, 25 Mar 2020 00:48:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 8e79af6b684844272589bdf63257503e7d0fe722
Message-ID: <5e7a39ef.wCQj/ju3JkxEiHiT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 8e79af6b684844272589bdf63257503e7d0fe722  igc: add support to interrupt, eeprom, registers and link self-tests

elapsed time: 484m

configs tested: 146
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200324
x86_64               randconfig-a002-20200324
i386                 randconfig-a001-20200324
x86_64               randconfig-a001-20200324
i386                 randconfig-a003-20200324
x86_64               randconfig-a003-20200324
mips                 randconfig-a001-20200324
nds32                randconfig-a001-20200324
m68k                 randconfig-a001-20200324
parisc               randconfig-a001-20200324
alpha                randconfig-a001-20200324
riscv                randconfig-a001-20200324
h8300                randconfig-a001-20200324
nios2                randconfig-a001-20200324
c6x                  randconfig-a001-20200324
sparc64              randconfig-a001-20200324
s390                 randconfig-a001-20200324
csky                 randconfig-a001-20200324
xtensa               randconfig-a001-20200324
openrisc             randconfig-a001-20200324
sh                   randconfig-a001-20200324
i386                 randconfig-b003-20200324
i386                 randconfig-b001-20200324
i386                 randconfig-b002-20200324
x86_64               randconfig-b001-20200324
x86_64               randconfig-c003-20200324
i386                 randconfig-c002-20200324
x86_64               randconfig-c001-20200324
x86_64               randconfig-c002-20200324
i386                 randconfig-c003-20200324
i386                 randconfig-c001-20200324
i386                 randconfig-d003-20200324
i386                 randconfig-d001-20200324
x86_64               randconfig-d002-20200324
x86_64               randconfig-d001-20200324
i386                 randconfig-d002-20200324
x86_64               randconfig-d003-20200324
x86_64               randconfig-e001-20200324
i386                 randconfig-e002-20200324
i386                 randconfig-e003-20200324
x86_64               randconfig-e002-20200324
i386                 randconfig-e001-20200324
i386                 randconfig-f001-20200324
i386                 randconfig-f003-20200324
i386                 randconfig-f002-20200324
x86_64               randconfig-f002-20200324
x86_64               randconfig-f003-20200324
x86_64               randconfig-f001-20200324
i386                 randconfig-g003-20200324
x86_64               randconfig-g002-20200324
i386                 randconfig-g001-20200324
i386                 randconfig-g002-20200324
x86_64               randconfig-g001-20200324
x86_64               randconfig-g003-20200324
x86_64               randconfig-h002-20200324
x86_64               randconfig-h003-20200324
i386                 randconfig-h003-20200324
i386                 randconfig-h001-20200324
x86_64               randconfig-h001-20200324
i386                 randconfig-h002-20200324
arm                  randconfig-a001-20200324
arm64                randconfig-a001-20200324
ia64                 randconfig-a001-20200324
arc                  randconfig-a001-20200324
sparc                randconfig-a001-20200324
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
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
