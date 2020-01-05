From: kbuild test robot <lkp@intel.com>
Date: Mon, 06 Jan 2020 01:10:24 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 77be7962ad5b5f8a0e63b4fe7327f73e14fbabfc
Message-ID: <5e121880.yifjN6Pjd79JLuM2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 77be7962ad5b5f8a0e63b4fe7327f73e14fbabfc  i40e: Fix receive buffer starvation for AF_XDP

Regressions in current branch:

drivers/net/ethernet/intel/igc/igc_ptp.c:425:17: sparse: sparse: incorrect type in argument 1 (different base types)

Error ids grouped by kconfigs:

recent_errors
|-- x86_64-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_ptp.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)
`-- x86_64-allyesconfig
    `-- drivers-net-ethernet-intel-igc-igc_ptp.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)

elapsed time: 497m

configs tested: 146

sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
arm64                randconfig-a001-20200105
sparc                randconfig-a001-20200105
arm                  randconfig-a001-20200105
ia64                 randconfig-a001-20200105
powerpc              randconfig-a001-20200105
arc                  randconfig-a001-20200105
x86_64               randconfig-d003-20200105
x86_64               randconfig-d002-20200105
x86_64               randconfig-d001-20200105
i386                 randconfig-d002-20200105
i386                 randconfig-d001-20200105
i386                 randconfig-d003-20200105
x86_64               randconfig-a002-20200105
i386                 randconfig-a001-20200105
x86_64               randconfig-a001-20200105
i386                 randconfig-a002-20200105
x86_64               randconfig-a003-20200105
i386                 randconfig-a003-20200105
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
csky                 randconfig-a001-20200105
s390                 randconfig-a001-20200105
sh                   randconfig-a001-20200105
xtensa               randconfig-a001-20200105
openrisc             randconfig-a001-20200105
sparc                            allyesconfig
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
x86_64               randconfig-g002-20200105
i386                 randconfig-g003-20200105
i386                 randconfig-g002-20200105
x86_64               randconfig-g003-20200105
x86_64               randconfig-g001-20200105
i386                 randconfig-g001-20200105
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
i386                 randconfig-b003-20200105
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
sparc64              randconfig-a001-20200105
nios2                randconfig-a001-20200105
h8300                randconfig-a001-20200105
c6x                  randconfig-a001-20200105
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                 randconfig-e002-20200105
x86_64               randconfig-e001-20200105
x86_64               randconfig-e002-20200105
i386                 randconfig-e003-20200105
x86_64               randconfig-e003-20200105
i386                 randconfig-e001-20200105
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
