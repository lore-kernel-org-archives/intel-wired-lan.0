From: kbuild test robot <lkp@intel.com>
Date: Wed, 10 Apr 2019 04:49:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 852e0989274ce350d78b0df1fae5502a8511ed54
Message-ID: <5cad0560.pGDynbWp3W2ppVNk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 852e0989274ce350d78b0df1fae5502a8511ed54  ixgbe: fix PTP SDP pin setup on X540 hardware

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14842:2-8: ERROR: missing iounmap; ioremap on line 14700 and execution via conditional on line 14841

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line

elapsed time: 160m

configs tested: 140

riscv                              tinyconfig
i386                               tinyconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                           allyesconfig
i386                             allmodconfig
i386                   randconfig-x002-201914
i386                   randconfig-x001-201914
i386                   randconfig-x005-201914
i386                   randconfig-x007-201914
i386                   randconfig-x000-201914
i386                   randconfig-x004-201914
i386                   randconfig-x008-201914
i386                   randconfig-x009-201914
i386                   randconfig-x006-201914
i386                   randconfig-x003-201914
x86_64                 randconfig-x015-201914
x86_64                 randconfig-x016-201914
x86_64                 randconfig-x012-201914
x86_64                 randconfig-x017-201914
x86_64                 randconfig-x013-201914
x86_64                 randconfig-x018-201914
x86_64                 randconfig-x010-201914
x86_64                 randconfig-x014-201914
x86_64                 randconfig-x019-201914
x86_64                 randconfig-x011-201914
i386                     randconfig-a0-201914
i386                     randconfig-a1-201914
i386                     randconfig-a2-201914
i386                     randconfig-a3-201914
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                   randconfig-m0-201914
x86_64                   randconfig-m1-201914
x86_64                   randconfig-m2-201914
x86_64                   randconfig-m3-201914
i386                     randconfig-m0-201914
i386                     randconfig-m1-201914
i386                     randconfig-m2-201914
i386                     randconfig-m3-201914
riscv                             allnoconfig
riscv                               defconfig
i386                   randconfig-x010-201914
i386                   randconfig-x018-201914
i386                   randconfig-x017-201914
i386                   randconfig-x013-201914
i386                   randconfig-x011-201914
i386                   randconfig-x014-201914
i386                   randconfig-x019-201914
i386                   randconfig-x015-201914
i386                   randconfig-x016-201914
i386                   randconfig-x012-201914
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
i386                   randconfig-x077-201914
i386                   randconfig-x074-201914
i386                   randconfig-x070-201914
i386                   randconfig-x072-201914
i386                   randconfig-x075-201914
i386                   randconfig-x071-201914
i386                   randconfig-x079-201914
i386                   randconfig-x078-201914
i386                   randconfig-x073-201914
i386                   randconfig-x076-201914
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                           allmodconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
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
x86_64                 randconfig-x001-201914
x86_64                 randconfig-x004-201914
x86_64                 randconfig-x000-201914
x86_64                 randconfig-x003-201914
x86_64                 randconfig-x008-201914
x86_64                 randconfig-x007-201914
x86_64                 randconfig-x002-201914
x86_64                 randconfig-x006-201914
x86_64                 randconfig-x009-201914
x86_64                 randconfig-x005-201914

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
