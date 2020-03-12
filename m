From: kbuild test robot <lkp@intel.com>
Date: Thu, 12 Mar 2020 10:04:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 cef452094a939462e60584356dc73cf7ed8eb863
Message-ID: <5e6998b6.eMFTrqW4wygAHbSd%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: cef452094a939462e60584356dc73cf7ed8eb863  igc: Fix default MAC address filter override

Regressions in current branch:

drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:83:2-9: line 83 is redundant because platform_get_irq() already prints an error
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:336:6-24: duplicated argument to && or ||

Error ids grouped by kconfigs:

recent_errors
|-- m68k-allyesconfig
|   |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:line-is-redundant-because-platform_get_irq()-already-prints-an-error
|   `-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:duplicated-argument-to-or
|-- sparc-allyesconfig
|   |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:line-is-redundant-because-platform_get_irq()-already-prints-an-error
|   `-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:duplicated-argument-to-or
`-- x86_64-allyesconfig
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:line-is-redundant-because-platform_get_irq()-already-prints-an-error
    `-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:duplicated-argument-to-or

elapsed time: 1606m

configs tested: 163
configs skipped: 0

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
microblaze                    nommu_defconfig
nios2                         10m50_defconfig
powerpc                             defconfig
riscv                             allnoconfig
sparc64                          allyesconfig
riscv                               defconfig
m68k                          multi_defconfig
openrisc                 simple_smp_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
powerpc                           allnoconfig
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
i386                 randconfig-a003-20200311
i386                 randconfig-a001-20200311
x86_64               randconfig-a001-20200311
i386                 randconfig-a002-20200311
x86_64               randconfig-a003-20200311
x86_64               randconfig-a002-20200311
riscv                randconfig-a001-20200309
m68k                 randconfig-a001-20200309
alpha                randconfig-a001-20200309
mips                 randconfig-a001-20200309
nds32                randconfig-a001-20200309
parisc               randconfig-a001-20200309
alpha                randconfig-a001-20200311
m68k                 randconfig-a001-20200311
mips                 randconfig-a001-20200311
nds32                randconfig-a001-20200311
parisc               randconfig-a001-20200311
riscv                randconfig-a001-20200311
h8300                randconfig-a001-20200311
sparc64              randconfig-a001-20200311
c6x                  randconfig-a001-20200311
nios2                randconfig-a001-20200311
microblaze           randconfig-a001-20200311
csky                 randconfig-a001-20200312
openrisc             randconfig-a001-20200312
s390                 randconfig-a001-20200312
sh                   randconfig-a001-20200312
xtensa               randconfig-a001-20200312
xtensa               randconfig-a001-20200311
openrisc             randconfig-a001-20200311
csky                 randconfig-a001-20200311
sh                   randconfig-a001-20200311
s390                 randconfig-a001-20200311
x86_64               randconfig-b001-20200311
x86_64               randconfig-b002-20200311
x86_64               randconfig-b003-20200311
i386                 randconfig-b001-20200311
i386                 randconfig-b002-20200311
i386                 randconfig-b003-20200311
x86_64               randconfig-c001-20200311
i386                 randconfig-c001-20200311
x86_64               randconfig-c002-20200311
i386                 randconfig-c002-20200311
i386                 randconfig-c003-20200311
x86_64               randconfig-c003-20200311
i386                 randconfig-e003-20200311
i386                 randconfig-f002-20200311
x86_64               randconfig-f001-20200311
i386                 randconfig-f003-20200311
i386                 randconfig-f001-20200311
x86_64               randconfig-f002-20200311
x86_64               randconfig-f003-20200311
i386                 randconfig-g003-20200311
i386                 randconfig-g001-20200311
x86_64               randconfig-g003-20200311
x86_64               randconfig-g002-20200311
x86_64               randconfig-g001-20200311
i386                 randconfig-g002-20200311
x86_64               randconfig-h001-20200311
i386                 randconfig-h001-20200311
x86_64               randconfig-h002-20200311
x86_64               randconfig-h003-20200311
i386                 randconfig-h002-20200311
i386                 randconfig-h003-20200311
arc                  randconfig-a001-20200311
ia64                 randconfig-a001-20200311
arm                  randconfig-a001-20200311
arm64                randconfig-a001-20200311
sparc                randconfig-a001-20200311
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
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
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
