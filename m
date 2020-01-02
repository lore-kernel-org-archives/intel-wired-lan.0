From: kbuild test robot <lkp@intel.com>
Date: Thu, 02 Jan 2020 17:12:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 74c2ae1254468e2c3db1ff410175525a465488a3
Message-ID: <5e0db3f0.U09tyiHQkGsTX1ST%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 74c2ae1254468e2c3db1ff410175525a465488a3  igc: Fix typo in a comment

Regressions in current branch:

drivers/net/ethernet/intel/igc/igc_main.c:129:13: error: redefinition of 'igc_power_down_link'
drivers/net/ethernet/intel/igc/igc_main.c:143:13: error: redefinition of 'igc_power_down_link'
drivers/net/ethernet/intel/igc/igc_ptp.c:425:17: sparse: sparse: incorrect type in argument 1 (different base types)

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- arm-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- arm64-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- arm64-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- i386-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- ia64-randconfig-a001-20200102
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- parisc-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- riscv-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- s390-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- sparc-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- sparc64-allmodconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- sparc64-allyesconfig
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|-- x86_64-allmodconfig
|   |-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|   `-- drivers-net-ethernet-intel-igc-igc_ptp.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)
|-- x86_64-allyesconfig
|   |-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
|   `-- drivers-net-ethernet-intel-igc-igc_ptp.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)
|-- x86_64-randconfig-h003-20200102
|   `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link
`-- xtensa-allmodconfig
    `-- drivers-net-ethernet-intel-igc-igc_main.c:error:redefinition-of-igc_power_down_link

elapsed time: 308m

configs tested: 158

x86_64               randconfig-a002-20200102
x86_64               randconfig-a001-20200102
i386                 randconfig-a001-20200102
i386                 randconfig-a002-20200102
x86_64               randconfig-a003-20200102
i386                 randconfig-a003-20200102
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
x86_64               randconfig-b001-20200102
x86_64               randconfig-b002-20200102
x86_64               randconfig-b003-20200102
i386                 randconfig-b001-20200102
i386                 randconfig-b002-20200102
i386                 randconfig-b003-20200102
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                              allmodconfig
arm64                            allmodconfig
x86_64               randconfig-h001-20200102
x86_64               randconfig-h002-20200102
x86_64               randconfig-h003-20200102
i386                 randconfig-h001-20200102
i386                 randconfig-h002-20200102
i386                 randconfig-h003-20200102
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
x86_64               randconfig-c001-20200102
x86_64               randconfig-c002-20200102
x86_64               randconfig-c003-20200102
i386                 randconfig-c001-20200102
i386                 randconfig-c002-20200102
i386                 randconfig-c003-20200102
x86_64               randconfig-e001-20200102
x86_64               randconfig-e002-20200102
x86_64               randconfig-e003-20200102
i386                 randconfig-e001-20200102
i386                 randconfig-e002-20200102
i386                 randconfig-e003-20200102
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
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
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
csky                 randconfig-a001-20200102
s390                 randconfig-a001-20200102
sh                   randconfig-a001-20200102
xtensa               randconfig-a001-20200102
openrisc             randconfig-a001-20200102
c6x                  randconfig-a001-20200102
h8300                randconfig-a001-20200102
microblaze           randconfig-a001-20200102
nios2                randconfig-a001-20200102
sparc64              randconfig-a001-20200102
arc                  randconfig-a001-20200102
arm                  randconfig-a001-20200102
arm64                randconfig-a001-20200102
ia64                 randconfig-a001-20200102
powerpc              randconfig-a001-20200102
sparc                randconfig-a001-20200102
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64               randconfig-d001-20200102
x86_64               randconfig-d002-20200102
x86_64               randconfig-d003-20200102
i386                 randconfig-d001-20200102
i386                 randconfig-d002-20200102
i386                 randconfig-d003-20200102
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
alpha                randconfig-a001-20200102
m68k                 randconfig-a001-20200102
mips                 randconfig-a001-20200102
nds32                randconfig-a001-20200102
parisc               randconfig-a001-20200102
riscv                randconfig-a001-20200102
x86_64               randconfig-g001-20200102
x86_64               randconfig-g002-20200102
x86_64               randconfig-g003-20200102
i386                 randconfig-g001-20200102
i386                 randconfig-g002-20200102
i386                 randconfig-g003-20200102
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
