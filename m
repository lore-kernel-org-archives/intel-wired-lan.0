From: kernel test robot <lkp@intel.com>
Date: Thu, 20 Jan 2022 17:01:06 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD REGRESSION
 91191ec316c30812ab1d0adc51fe28091c9470d6
Message-ID: <61e924d2.gHaWP0fSuR+BZTGA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 91191ec316c30812ab1d0adc51fe28091c9470d6  ice: Fix KASAN error in LAG NETDEV_UNREGISTER handler

possible Error/Warning in current branch (please contact us if interested):

aarch64-linux-ld: Unexpected GOT/PLT entries detected!
aarch64-linux-ld: Unexpected run-time procedure linkages detected!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-randconfig-r022-20220117
|   |-- aarch64-linux-ld:Unexpected-GOT-PLT-entries-detected
|   `-- aarch64-linux-ld:Unexpected-run-time-procedure-linkages-detected
|-- arm64-randconfig-r033-20220120
|   |-- aarch64-linux-ld:Unexpected-GOT-PLT-entries-detected
|   `-- aarch64-linux-ld:Unexpected-run-time-procedure-linkages-detected
`-- arm64-randconfig-r035-20220118
    |-- aarch64-linux-ld:Unexpected-GOT-PLT-entries-detected
    `-- aarch64-linux-ld:Unexpected-run-time-procedure-linkages-detected

elapsed time: 725m

configs tested: 122
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
arc                         haps_hs_defconfig
arm                           sunxi_defconfig
powerpc                        warp_defconfig
powerpc                 linkstation_defconfig
powerpc                     tqm8548_defconfig
um                               alldefconfig
sh                          sdk7780_defconfig
powerpc                     sequoia_defconfig
xtensa                  nommu_kc705_defconfig
arm                            lart_defconfig
arc                        vdk_hs38_defconfig
powerpc                    klondike_defconfig
csky                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
xtensa                           allyesconfig
mips                           ip32_defconfig
arm                      integrator_defconfig
openrisc                 simple_smp_defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
sh                         microdev_defconfig
x86_64                           alldefconfig
mips                       capcella_defconfig
s390                                defconfig
arc                     haps_hs_smp_defconfig
arc                        nsimosci_defconfig
arm                  randconfig-c002-20220116
arm                  randconfig-c002-20220117
arm                  randconfig-c002-20220118
arm                  randconfig-c002-20220119
arm                  randconfig-c002-20220120
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20220117
x86_64               randconfig-a012-20220117
x86_64               randconfig-a013-20220117
x86_64               randconfig-a011-20220117
x86_64               randconfig-a014-20220117
x86_64               randconfig-a015-20220117
i386                 randconfig-a012-20220117
i386                 randconfig-a016-20220117
i386                 randconfig-a014-20220117
i386                 randconfig-a015-20220117
i386                 randconfig-a011-20220117
i386                 randconfig-a013-20220117
arc                  randconfig-r043-20220120
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                     powernv_defconfig
mips                     cu1000-neo_defconfig
powerpc                     ksi8560_defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip22_defconfig
mips                malta_qemu_32r6_defconfig
x86_64               randconfig-a005-20220117
x86_64               randconfig-a004-20220117
x86_64               randconfig-a001-20220117
x86_64               randconfig-a006-20220117
x86_64               randconfig-a002-20220117
x86_64               randconfig-a003-20220117
i386                 randconfig-a005-20220117
i386                 randconfig-a001-20220117
i386                 randconfig-a006-20220117
i386                 randconfig-a004-20220117
i386                 randconfig-a002-20220117
i386                 randconfig-a003-20220117
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20220120
hexagon              randconfig-r045-20220120
hexagon              randconfig-r041-20220120
s390                 randconfig-r044-20220120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
