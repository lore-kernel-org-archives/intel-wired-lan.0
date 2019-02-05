From: kbuild test robot <lkp@intel.com>
Date: Tue, 05 Feb 2019 09:06:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 0691de312573b90f5470ff1310cd970e9fe662de
Message-ID: <5c58e18e.eZOvdPSdoREs094x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 0691de312573b90f5470ff1310cd970e9fe662de  e1000e: Disable runtime PM on CNP+

Regressions in current branch:

include/linux/pci.h:1429:20: error: expected ';' before '}' token
include/linux/pci.h:1429:24: error: expected ';' before '}' token
include/linux/pci.h:1432:20: error: expected ';' before '}' token
include/linux/pci.h:1432:24: error: expected ';' before '}' token

Error ids grouped by kconfigs:

recent_errors
??? alpha-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? arm-multi_v5_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a2-02040849
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-a3-02040849
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-c0-02041452
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-l1-02032043
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-l2-02032043
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-s1-02041749
??? ??? include-linux-pci.h:error:expected-before-token
??? i386-randconfig-x0-02050619
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
??? ia64-zx1_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? m68k-m5475evb_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? microblaze-mmu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? microblaze-nommu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-fuloong2e_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-malta_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-malta_kvm_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-mtx1_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-b180_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-c3000_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? powerpc-socrates_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? powerpc-walnut_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-sh7785lcr_32bit_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-titan_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sparc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-a0-02040623
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-b0-02040624
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-h0-02040444
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l2-02032043
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-ne0-02040213
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-r0-02041238
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s1-02040849
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s3-02041749
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s3-02050621
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s4-02050621
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s5-02050621
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-u0-02050658
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

elapsed time: 176m

configs tested: 185

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
openrisc                            defconfig
powerpc                          allyesconfig
x86_64                 randconfig-a0-02040623
m68k                            mac_defconfig
mips                          malta_defconfig
i386                   randconfig-c0-02041452
powerpc                         ps3_defconfig
powerpc                     virtex5_defconfig
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
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
nds32                             allnoconfig
nds32                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
riscv                             allnoconfig
riscv                               defconfig
i386                             allmodconfig
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
i386                   randconfig-a1-02040849
i386                   randconfig-a0-02040849
i386                   randconfig-a3-02040849
i386                   randconfig-a2-02040849
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-s0-02040849
x86_64                 randconfig-s1-02040849
x86_64                 randconfig-s2-02040849
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                              allmodconfig
arm                          badge4_defconfig
ia64                            zx1_defconfig
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
mips                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-b0-02041055
i386                             allyesconfig
x86_64                 randconfig-b0-02040624
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                        keystone_defconfig
powerpc                    socrates_defconfig
arm                          tango4_defconfig
openrisc                         alldefconfig
powerpc                      walnut_defconfig
x86_64                 randconfig-u0-02050624
x86_64                 randconfig-u0-02050658
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                         rhel-7.2-clear
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
x86_64                 randconfig-l0-02032043
x86_64                 randconfig-l1-02032043
x86_64                 randconfig-l2-02032043
x86_64                 randconfig-l3-02032043
i386                   randconfig-l0-02032043
i386                   randconfig-l1-02032043
i386                   randconfig-l2-02032043
i386                   randconfig-l3-02032043
x86_64                 randconfig-s3-02050621
x86_64                 randconfig-s4-02050621
x86_64                 randconfig-s5-02050621
i386                   randconfig-h0-02020943
i386                   randconfig-h1-02020943
x86_64                randconfig-ne0-02040213
x86_64                 randconfig-h0-02040444
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
mips                             allyesconfig
mips                           mtx1_defconfig
i386                  randconfig-sb0-02032014
x86_64                                  kexec
x86_64                              fedora-25
x86_64                 randconfig-r0-02041238
riscv                              tinyconfig
i386                               tinyconfig
powerpc                     tqm5200_defconfig
powerpc                         wii_defconfig
i386                   randconfig-x0-02050619

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
