From: kbuild test robot <lkp@intel.com>
Date: Tue, 05 Feb 2019 02:45:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 b7bb2eb8ba3d6e1463ba371ecf61700220f70815
Message-ID: <5c58883c.mcWuRItael1ubyRZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: b7bb2eb8ba3d6e1463ba371ecf61700220f70815  Documentation: PCI/MSI: Document dynamic MSI-X infrastructure

Regressions in current branch:

include/linux/pci.h:1430:20: error: expected ';' before '}' token
include/linux/pci.h:1430:21: error: expected ';' before '}' token
include/linux/pci.h:1430:24: error: expected ';' before '}' token

Error ids grouped by kconfigs:

recent_errors
??? alpha-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a2-02040849
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a3-02040849
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-i1-02040506
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-i3-02040506
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-l1-02032043
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-l2-02032043
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-s1-02041749
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
??? mips-malta_kvm_guest_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-maltasmvp_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-b180_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-c3000_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? powerpc-mpc837x_mds_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-sh7785lcr_32bit_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-titan_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sparc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l2-02032043
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

elapsed time: 99m

configs tested: 126

i386                   randconfig-x010-201905
i386                   randconfig-x011-201905
i386                   randconfig-x012-201905
i386                   randconfig-x013-201905
i386                   randconfig-x014-201905
i386                   randconfig-x015-201905
i386                   randconfig-x016-201905
i386                   randconfig-x017-201905
i386                   randconfig-x018-201905
i386                   randconfig-x019-201905
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
i386                   randconfig-i0-02040506
i386                   randconfig-i1-02040506
i386                   randconfig-i2-02040506
i386                   randconfig-i3-02040506
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
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-a1-02040849
i386                   randconfig-a0-02040849
i386                   randconfig-a3-02040849
i386                   randconfig-a2-02040849
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-02041749
i386                   randconfig-s3-02041749
i386                   randconfig-s2-02041749
i386                   randconfig-s1-02041749
csky                                defconfig
mips                malta_kvm_guest_defconfig
c6x                        evmc6472_defconfig
mips                      maltasmvp_defconfig
mips                             allyesconfig
x86_64                 randconfig-u0-02042128
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                         rhel-7.2-clear
x86_64                 randconfig-l3-02032043
i386                   randconfig-l3-02032043
x86_64                 randconfig-l2-02032043
x86_64                 randconfig-l0-02032043
i386                   randconfig-l0-02032043
i386                   randconfig-l2-02032043
i386                   randconfig-l1-02032043
x86_64                 randconfig-l1-02032043
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
i386                   randconfig-h0-02020943
i386                   randconfig-h1-02020943
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
powerpc                 mpc837x_mds_defconfig
sh                        sh7763rdp_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
