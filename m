From: kbuild test robot <lkp@intel.com>
Date: Thu, 07 Feb 2019 15:04:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 4865244a28dc88acf7c09611ae14ebbd71b887d7
Message-ID: <5c5bd874.L/1myZFBQkvlt0Tq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 4865244a28dc88acf7c09611ae14ebbd71b887d7  igc: Add multiple receive queues control supporting

Regressions in current branch:

include/linux/pci.h:1429:20: error: expected ';' before '}' token
include/linux/pci.h:1429:24: error: expected ';' before '}' token
include/linux/pci.h:1432:20: error: expected ';' before '}' token
include/linux/pci.h:1432:21: error: expected ';' before '}' token
include/linux/pci.h:1432:24: error: expected ';' before '}' token

Error ids grouped by kconfigs:

recent_errors
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
??? i386-randconfig-l0-201905
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
??? microblaze-mmu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? microblaze-nommu_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-fuloong2e_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-jmr3927_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-malta_kvm_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? mips-rbtx49xx_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-b180_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-c3000_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? parisc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? powerpc-mgcoge_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-sh7785lcr_32bit_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sh-titan_defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? sparc-defconfig
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-a0-02071216
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-b0-02071312
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l0-02062115
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l1-02062115
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l3-02062115
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-l3-201905
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s0-02071208
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s1-02071208
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s1-02071330
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s2-02071208
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s3-02041749
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s4-02071209
??? ??? include-linux-pci.h:error:expected-before-token
??? x86_64-randconfig-s5-02071209
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

elapsed time: 373m

configs tested: 182

x86_64                 randconfig-a0-02071216
i386                   randconfig-c0-02041452
mips                       rbtx49xx_defconfig
powerpc                 mpc832x_rdb_defconfig
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
nds32                             allnoconfig
nds32                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
i386                     randconfig-a2-201905
i386                     randconfig-a3-201905
i386                     randconfig-a0-201905
i386                     randconfig-a1-201905
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-s0-02071208
x86_64                 randconfig-s1-02071208
x86_64                 randconfig-s2-02071208
x86_64                 randconfig-s0-02071330
x86_64                 randconfig-s1-02071330
x86_64                 randconfig-s2-02071330
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
arm                        keystone_defconfig
mips                      fuloong2e_defconfig
mips                        jmr3927_defconfig
parisc                           allyesconfig
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
x86_64                 randconfig-s3-02041749
x86_64                 randconfig-s4-02041749
x86_64                 randconfig-s5-02041749
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-b0-02071212
ia64                                defconfig
mips                                defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-02071312
arm                         s3c6400_defconfig
powerpc64                        allmodconfig
x86_64                 randconfig-u0-02071308
x86_64                 randconfig-u0-02071325
riscv                              tinyconfig
i386                               tinyconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             alldefconfig
x86_64                 randconfig-l1-02062115
i386                   randconfig-l1-02062115
x86_64                 randconfig-l0-02062115
i386                   randconfig-l0-02062115
i386                   randconfig-l3-02062115
i386                   randconfig-l2-02062115
x86_64                 randconfig-l3-02062115
x86_64                 randconfig-l2-02062115
x86_64                   randconfig-l0-201905
x86_64                   randconfig-l1-201905
x86_64                   randconfig-l2-201905
x86_64                   randconfig-l3-201905
i386                     randconfig-l0-201905
i386                     randconfig-l1-201905
i386                     randconfig-l2-201905
i386                     randconfig-l3-201905
x86_64                 randconfig-s3-02071209
x86_64                 randconfig-s4-02071209
x86_64                 randconfig-s5-02071209
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
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
i386                   randconfig-h0-02020943
i386                   randconfig-h1-02020943
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
powerpc                      mgcoge_defconfig
i386                  randconfig-sb0-02032014
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
x86_64                           allmodconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
