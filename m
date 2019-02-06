From: kbuild test robot <lkp@intel.com>
Date: Wed, 06 Feb 2019 21:12:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 6756a14bb957cece7bad10d3514e6e58832b4ce9
Message-ID: <5c5add4b.TFiN2hk4169v66UT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 6756a14bb957cece7bad10d3514e6e58832b4ce9  e1000e: Disable runtime PM on CNP+

Regressions in current branch:

include/linux/pci.h:1429:20: error: expected ';' before '}' token
include/linux/pci.h:1429:24: error: expected ';' before '}' token
include/linux/pci.h:1432:20: error: expected ';' before '}' token
include/linux/pci.h:1432:24: error: expected ';' before '}' token

Error ids grouped by kconfigs:

recent_errors
??? alpha-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? arm-cm_x2xx_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? arm-multi_v5_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a0-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a1-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a2-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-c0-02041452
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-l2-02060944
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x002-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x004-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x006-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x011-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x012-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x014-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x019-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x071-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x072-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x073-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x074-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x075-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x076-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x077-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x078-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? m68k-m5475evb_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? microblaze-mmu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? microblaze-nommu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-fuloong2e_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-malta_kvm_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sparc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-h0-02061158
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l0-02060944
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l2-02060944
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s4-02061156
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x000-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x002-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x003-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x005-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x006-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x009-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x012-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x018-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x019-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? xtensa-common_defconfig
    ??? include-linux-pci.h:error:expected-before-token

elapsed time: 518m

configs tested: 166

i386                   randconfig-c0-02041452
parisc                        c3000_defconfig
sparc                            allyesconfig
i386                   randconfig-x019-201905
i386                   randconfig-x015-201905
i386                   randconfig-x016-201905
i386                   randconfig-x014-201905
i386                   randconfig-x012-201905
i386                   randconfig-x013-201905
i386                   randconfig-x010-201905
i386                   randconfig-x011-201905
i386                   randconfig-x018-201905
i386                   randconfig-x017-201905
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-x005-201905
x86_64                 randconfig-x008-201905
x86_64                 randconfig-x009-201905
x86_64                 randconfig-x001-201905
x86_64                 randconfig-x002-201905
x86_64                 randconfig-x003-201905
x86_64                 randconfig-x006-201905
x86_64                 randconfig-x007-201905
x86_64                 randconfig-x000-201905
x86_64                 randconfig-x004-201905
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
i386                             allmodconfig
x86_64                 randconfig-x013-201905
x86_64                 randconfig-x017-201905
x86_64                 randconfig-x016-201905
x86_64                 randconfig-x019-201905
x86_64                 randconfig-x012-201905
x86_64                 randconfig-x018-201905
x86_64                 randconfig-x011-201905
x86_64                 randconfig-x010-201905
x86_64                 randconfig-x015-201905
x86_64                 randconfig-x014-201905
i386                     randconfig-a2-201905
i386                     randconfig-a3-201905
i386                     randconfig-a0-201905
i386                     randconfig-a1-201905
i386                   randconfig-a0-02061325
i386                   randconfig-a1-02061325
i386                   randconfig-a2-02061325
i386                   randconfig-a3-02061325
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                      pxa255-idp_defconfig
arm64                            allyesconfig
mips                     loongson1c_defconfig
sh                           se7751_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-02041749
i386                   randconfig-s1-02041749
i386                   randconfig-s2-02041749
i386                   randconfig-s3-02041749
x86_64                 randconfig-s3-02041749
x86_64                 randconfig-s4-02041749
x86_64                 randconfig-s5-02041749
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
i386                   randconfig-b0-02061058
x86_64                 randconfig-b0-02061121
arm                         cm_x2xx_defconfig
x86_64                 randconfig-u0-02061140
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                         rhel-7.2-clear
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-l3-02060944
x86_64                 randconfig-l0-02060944
i386                   randconfig-l1-02060944
i386                   randconfig-l3-02060944
x86_64                 randconfig-l1-02060944
i386                   randconfig-l0-02060944
i386                   randconfig-l2-02060944
x86_64                 randconfig-l2-02060944
x86_64                 randconfig-s3-02061156
x86_64                 randconfig-s4-02061156
x86_64                 randconfig-s5-02061156
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
arm64                               defconfig
x86_64                 randconfig-h0-02061158
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                              defconfig
um                                  defconfig
i386                   randconfig-x072-201905
i386                   randconfig-x079-201905
i386                   randconfig-x073-201905
i386                   randconfig-x075-201905
i386                   randconfig-x077-201905
i386                   randconfig-x078-201905
i386                   randconfig-x074-201905
i386                   randconfig-x076-201905
i386                   randconfig-x070-201905
i386                   randconfig-x071-201905
powerpc                           allnoconfig
sh                           se7206_defconfig
i386                  randconfig-sb0-02032014
i386                   randconfig-x007-201905
i386                   randconfig-x006-201905
i386                   randconfig-x000-201905
i386                   randconfig-x002-201905
i386                   randconfig-x001-201905
i386                   randconfig-x009-201905
i386                   randconfig-x003-201905
i386                   randconfig-x008-201905
i386                   randconfig-x005-201905
i386                   randconfig-x004-201905
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                randconfig-ws0-02041245
x86_64                 randconfig-r0-02060941
riscv                              tinyconfig
i386                               tinyconfig
powerpc                     skiroot_defconfig
i386                   randconfig-x0-02061256

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
