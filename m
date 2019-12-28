From: kbuild test robot <lkp@intel.com>
Date: Sat, 28 Dec 2019 10:40:42 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD REGRESSION
 7e5a53fc0c524519c2941cfd719ee598800a5572
Message-ID: <5e06c0aa.P0k0p3xKw1cinu07%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 7e5a53fc0c524519c2941cfd719ee598800a5572  e1000e: Revert "e1000e: Make watchdog use delayed work"

Regressions in current branch:

drivers/net/ethernet/intel/e1000e/netdev.c:7604:6: warning: the address of 'down' will always evaluate as 'true' [-Waddress]

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- i386-randconfig-f001-20191228
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- parisc-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- powerpc-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- sparc64-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
|-- x86_64-randconfig-f001-20191228
|   `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-e1000e-netdev.c:warning:the-address-of-down-will-always-evaluate-as-true

elapsed time: 256m

configs tested: 181

arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-a001-20191227
x86_64               randconfig-a002-20191227
x86_64               randconfig-a003-20191227
i386                 randconfig-a001-20191227
i386                 randconfig-a002-20191227
i386                 randconfig-a003-20191227
i386                 randconfig-h002-20191227
x86_64               randconfig-h001-20191227
i386                 randconfig-h003-20191227
x86_64               randconfig-h003-20191227
i386                 randconfig-h001-20191227
x86_64               randconfig-h002-20191227
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                  randconfig-a001-20191228
h8300                randconfig-a001-20191228
microblaze           randconfig-a001-20191228
nios2                randconfig-a001-20191228
sparc64              randconfig-a001-20191228
m68k                             allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
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
x86_64               randconfig-e001-20191227
x86_64               randconfig-e002-20191227
x86_64               randconfig-e003-20191227
i386                 randconfig-e001-20191227
i386                 randconfig-e002-20191227
i386                 randconfig-e003-20191227
x86_64               randconfig-f001-20191227
x86_64               randconfig-f002-20191227
x86_64               randconfig-f003-20191227
i386                 randconfig-f001-20191227
i386                 randconfig-f002-20191227
i386                 randconfig-f003-20191227
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64               randconfig-b001-20191227
x86_64               randconfig-b002-20191227
x86_64               randconfig-b003-20191227
i386                 randconfig-b001-20191227
i386                 randconfig-b002-20191227
i386                 randconfig-b003-20191227
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
csky                 randconfig-a001-20191228
openrisc             randconfig-a001-20191228
s390                 randconfig-a001-20191228
sh                   randconfig-a001-20191228
xtensa               randconfig-a001-20191228
csky                 randconfig-a001-20191227
openrisc             randconfig-a001-20191227
s390                 randconfig-a001-20191227
sh                   randconfig-a001-20191227
xtensa               randconfig-a001-20191227
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-c003-20191227
i386                 randconfig-c001-20191227
i386                 randconfig-c002-20191227
i386                 randconfig-c003-20191227
x86_64               randconfig-c002-20191227
x86_64               randconfig-c001-20191227
x86_64               randconfig-d001-20191227
x86_64               randconfig-d002-20191227
x86_64               randconfig-d003-20191227
i386                 randconfig-d001-20191227
i386                 randconfig-d002-20191227
i386                 randconfig-d003-20191227
alpha                randconfig-a001-20191228
m68k                 randconfig-a001-20191228
mips                 randconfig-a001-20191228
nds32                randconfig-a001-20191228
parisc               randconfig-a001-20191228
riscv                randconfig-a001-20191228
i386                 randconfig-f001-20191228
x86_64               randconfig-f003-20191228
i386                 randconfig-f003-20191228
x86_64               randconfig-f001-20191228
i386                 randconfig-f002-20191228
x86_64               randconfig-f002-20191228
x86_64               randconfig-e001-20191228
x86_64               randconfig-e002-20191228
x86_64               randconfig-e003-20191228
i386                 randconfig-e001-20191228
i386                 randconfig-e002-20191228
i386                 randconfig-e003-20191228
arc                  randconfig-a001-20191227
arm                  randconfig-a001-20191227
arm64                randconfig-a001-20191227
ia64                 randconfig-a001-20191227
powerpc              randconfig-a001-20191227
sparc                randconfig-a001-20191227
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
alpha                randconfig-a001-20191227
m68k                 randconfig-a001-20191227
mips                 randconfig-a001-20191227
nds32                randconfig-a001-20191227
parisc               randconfig-a001-20191227
riscv                randconfig-a001-20191227

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
