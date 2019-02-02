From: kbuild test robot <lkp@intel.com>
Date: Sat, 02 Feb 2019 15:07:49 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 e28dbaae40bb2490a64d53ad205b4813ada4fbcd
Message-ID: <5c5541c5.Khr3dRmq32svW6Lv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e28dbaae40bb2490a64d53ad205b4813ada4fbcd  Documentation: PCI/MSI: Document dynamic MSI-X infrastructure

Regressions in current branch:

include/linux/pci.h:1430:24: error: expected ';' before '}' token
include/linux/pci.h:1433:20: error: expected ';' before '}' token
include/linux/pci.h:1433:21: error: expected ';' before '}' token
include/linux/pci.h:1433:24: error: expected ';' before '}' token

Error ids grouped by kconfigs:

recent_errors
??? alpha-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? arm-multi_v5_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a1-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-b0-02011955
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-c0-01290401
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-l0-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-l2-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-m0-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-m2-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-s2-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-s3-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x0-02021047
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x006-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x010-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x011-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x012-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x013-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x014-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x015-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x016-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x018-02021212
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x070-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x072-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x074-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x075-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x076-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x077-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x078-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x079-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? m68k-m5475evb_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? microblaze-mmu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? microblaze-nommu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-fuloong2e_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-lemote2f_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-malta_kvm_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-mips_paravirt_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-xway_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-b180_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-c3000_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? powerpc-mpc832x_mds_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-sh7785lcr_32bit_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-titan_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sparc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-a0-02021031
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-b0-02012238
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l2-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l3-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-m1-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-m2-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-m3-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s0-02021134
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s1-02021134
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s3-01290430
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s4-01290430
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s4-02021013
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s5-01290430
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x000-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x001-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x002-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x003-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x004-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x005-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x006-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x008-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-x009-201904
??? ??? include-linux-pci.h:error:expected-before-token
??? xtensa-common_defconfig
    ??? include-linux-pci.h:error:expected-before-token

elapsed time: 186m

configs tested: 190

x86_64                 randconfig-a0-02021031
i386                   randconfig-c0-01290401
riscv                              tinyconfig
i386                               tinyconfig
powerpc                      pasemi_defconfig
sparc                             allnoconfig
i386                 randconfig-x011-02021212
i386                 randconfig-x014-02021212
i386                 randconfig-x017-02021212
i386                 randconfig-x012-02021212
i386                 randconfig-x010-02021212
i386                 randconfig-x013-02021212
i386                 randconfig-x015-02021212
i386                 randconfig-x019-02021212
i386                 randconfig-x018-02021212
i386                 randconfig-x016-02021212
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
nds32                             allnoconfig
nds32                               defconfig
riscv                             allnoconfig
riscv                               defconfig
i386                             allmodconfig
i386                   randconfig-x007-201904
i386                   randconfig-x006-201904
i386                   randconfig-x000-201904
i386                   randconfig-x002-201904
i386                   randconfig-x001-201904
i386                   randconfig-x009-201904
i386                   randconfig-x003-201904
i386                   randconfig-x008-201904
i386                   randconfig-x005-201904
i386                   randconfig-x004-201904
x86_64                 randconfig-x013-201904
x86_64                 randconfig-x017-201904
x86_64                 randconfig-x016-201904
x86_64                 randconfig-x019-201904
x86_64                 randconfig-x012-201904
x86_64                 randconfig-x018-201904
x86_64                 randconfig-x011-201904
x86_64                 randconfig-x010-201904
x86_64                 randconfig-x015-201904
x86_64                 randconfig-x014-201904
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-a0-201904
i386                     randconfig-a1-201904
i386                     randconfig-a2-201904
i386                     randconfig-a3-201904
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-s0-02021134
x86_64                 randconfig-s1-02021134
x86_64                 randconfig-s2-02021134
arm                          nuc960_defconfig
mips                  mips_paravirt_defconfig
mips                           xway_defconfig
nios2                               defconfig
arm                         em_x270_defconfig
h8300                             allnoconfig
powerpc                          allmodconfig
sh                         microdev_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201904
i386                     randconfig-s1-201904
i386                     randconfig-s2-201904
i386                     randconfig-s3-201904
x86_64                 randconfig-s3-01290430
x86_64                 randconfig-s4-01290430
x86_64                 randconfig-s5-01290430
i386                   randconfig-b0-02011955
x86_64                 randconfig-b0-02012238
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                          allyesconfig
powerpc                 mpc832x_mds_defconfig
x86_64                 randconfig-u0-02021005
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.2
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-m0-201904
x86_64                   randconfig-m1-201904
x86_64                   randconfig-m2-201904
x86_64                   randconfig-m3-201904
i386                     randconfig-m0-201904
i386                     randconfig-m1-201904
i386                     randconfig-m2-201904
i386                     randconfig-m3-201904
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
arm64                            allyesconfig
arm64                               defconfig
x86_64                   randconfig-l0-201904
x86_64                   randconfig-l1-201904
x86_64                   randconfig-l2-201904
x86_64                   randconfig-l3-201904
i386                     randconfig-l0-201904
i386                     randconfig-l1-201904
i386                     randconfig-l2-201904
i386                     randconfig-l3-201904
x86_64                 randconfig-s3-02021013
x86_64                 randconfig-s4-02021013
x86_64                 randconfig-s5-02021013
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
i386                   randconfig-x010-201904
i386                   randconfig-x011-201904
i386                   randconfig-x012-201904
i386                   randconfig-x013-201904
i386                   randconfig-x014-201904
i386                   randconfig-x015-201904
i386                   randconfig-x016-201904
i386                   randconfig-x017-201904
i386                   randconfig-x018-201904
i386                   randconfig-x019-201904
i386                   randconfig-h0-02020943
i386                   randconfig-h1-02020943
i386                   randconfig-x072-201904
i386                   randconfig-x079-201904
i386                   randconfig-x073-201904
i386                   randconfig-x075-201904
i386                   randconfig-x077-201904
i386                   randconfig-x078-201904
i386                   randconfig-x074-201904
i386                   randconfig-x076-201904
i386                   randconfig-x070-201904
i386                   randconfig-x071-201904
mips                       lemote2f_defconfig
um                               allyesconfig
i386                  randconfig-sb0-02011012
x86_64                 randconfig-x005-201904
x86_64                 randconfig-x008-201904
x86_64                 randconfig-x009-201904
x86_64                 randconfig-x001-201904
x86_64                 randconfig-x002-201904
x86_64                 randconfig-x003-201904
x86_64                 randconfig-x006-201904
x86_64                 randconfig-x007-201904
x86_64                 randconfig-x000-201904
x86_64                 randconfig-x004-201904
i386                   randconfig-x0-02021047

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
