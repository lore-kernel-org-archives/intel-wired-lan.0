From: kbuild test robot <lkp@intel.com>
Date: Sun, 05 Jan 2020 20:28:11 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:1GbE] BUILD SUCCESS
 63c92c9d2e536c91ace17dec7534883f40421753
Message-ID: <5e11d65b.TdI9cd5OGQkkkwGW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  1GbE
branch HEAD: 63c92c9d2e536c91ace17dec7534883f40421753  igc: Remove no need declaration of the igc_sw_init

elapsed time: 316m

configs tested: 152

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
csky                 randconfig-a001-20200105
s390                 randconfig-a001-20200105
sh                   randconfig-a001-20200105
xtensa               randconfig-a001-20200105
openrisc             randconfig-a001-20200105
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                 randconfig-f001-20200105
x86_64               randconfig-f003-20200105
x86_64               randconfig-f001-20200105
i386                 randconfig-f003-20200105
i386                 randconfig-f002-20200105
x86_64               randconfig-f002-20200105
x86_64               randconfig-c001-20200105
x86_64               randconfig-c002-20200105
x86_64               randconfig-c003-20200105
i386                 randconfig-c001-20200105
i386                 randconfig-c002-20200105
i386                 randconfig-c003-20200105
x86_64               randconfig-d001-20200105
x86_64               randconfig-d002-20200105
x86_64               randconfig-d003-20200105
i386                 randconfig-d001-20200105
i386                 randconfig-d002-20200105
i386                 randconfig-d003-20200105
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
nds32                               defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
arm                              allmodconfig
arm64                            allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
x86_64               randconfig-g002-20200105
i386                 randconfig-g003-20200105
i386                 randconfig-g002-20200105
x86_64               randconfig-g003-20200105
x86_64               randconfig-g001-20200105
i386                 randconfig-g001-20200105
c6x                  randconfig-a001-20200105
h8300                randconfig-a001-20200105
microblaze           randconfig-a001-20200105
nios2                randconfig-a001-20200105
sparc64              randconfig-a001-20200105
x86_64               randconfig-a002-20200105
i386                 randconfig-a001-20200105
x86_64               randconfig-a001-20200105
i386                 randconfig-a002-20200105
x86_64               randconfig-a003-20200105
i386                 randconfig-a003-20200105
x86_64               randconfig-e001-20200105
x86_64               randconfig-e002-20200105
x86_64               randconfig-e003-20200105
i386                 randconfig-e001-20200105
i386                 randconfig-e002-20200105
i386                 randconfig-e003-20200105
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
mips                 randconfig-a001-20200105
parisc               randconfig-a001-20200105
riscv                randconfig-a001-20200105
alpha                randconfig-a001-20200105
m68k                 randconfig-a001-20200105
nds32                randconfig-a001-20200105
x86_64               randconfig-b001-20200105
x86_64               randconfig-b002-20200105
x86_64               randconfig-b003-20200105
i386                 randconfig-b001-20200105
i386                 randconfig-b002-20200105
i386                 randconfig-b003-20200105
arm                               allnoconfig
arm                              allyesconfig
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
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
