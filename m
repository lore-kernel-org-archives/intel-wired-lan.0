From: kbuild test robot <lkp@intel.com>
Date: Fri, 05 Apr 2019 04:24:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 24f3427c98150bead00f17f2957b188087285c9d
Message-ID: <5ca66807.l3vf6TZVHSV1Gv/a%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 24f3427c98150bead00f17f2957b188087285c9d  ixgbe: fix AF_XDP tx packet count

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14842:2-8: ERROR: missing iounmap; ioremap on line 14700 and execution via conditional on line 14841

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line

elapsed time: 219m

configs tested: 142

i386                   randconfig-x010-201913
i386                   randconfig-x018-201913
i386                   randconfig-x017-201913
i386                   randconfig-x013-201913
i386                   randconfig-x014-201913
i386                   randconfig-x011-201913
i386                   randconfig-x015-201913
i386                   randconfig-x019-201913
i386                   randconfig-x012-201913
i386                   randconfig-x016-201913
i386                   randconfig-n3-04010147
i386                   randconfig-n2-04010147
i386                   randconfig-n1-04010147
i386                   randconfig-n0-04010147
riscv                             allnoconfig
riscv                               defconfig
i386                   randconfig-x002-201913
i386                   randconfig-x005-201913
i386                   randconfig-x001-201913
i386                   randconfig-x007-201913
i386                   randconfig-x000-201913
i386                   randconfig-x008-201913
i386                   randconfig-x004-201913
i386                   randconfig-x009-201913
i386                   randconfig-x003-201913
i386                   randconfig-x006-201913
x86_64                 randconfig-x015-201913
x86_64                 randconfig-x016-201913
x86_64                 randconfig-x013-201913
x86_64                 randconfig-x017-201913
x86_64                 randconfig-x012-201913
x86_64                 randconfig-x018-201913
x86_64                 randconfig-x010-201913
x86_64                 randconfig-x014-201913
x86_64                 randconfig-x019-201913
x86_64                 randconfig-x011-201913
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-a1-201913
i386                     randconfig-a2-201913
i386                     randconfig-a0-201913
i386                     randconfig-a3-201913
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                           allyesconfig
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
i386                             alldefconfig
x86_64                                    lkp
x86_64                                   rhel
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
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
nds32                             allnoconfig
nds32                               defconfig
x86_64                   randconfig-m2-201913
i386                     randconfig-m0-201913
i386                     randconfig-m3-201913
i386                     randconfig-m2-201913
x86_64                   randconfig-m1-201913
x86_64                   randconfig-m0-201913
i386                     randconfig-m1-201913
x86_64                   randconfig-m3-201913
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
parisc                        c3000_defconfig
um                                  defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
x86_64                                  kexec
x86_64                               rhel-7.2
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                 randconfig-x000-201913
x86_64                 randconfig-x004-201913
x86_64                 randconfig-x001-201913
x86_64                 randconfig-x003-201913
x86_64                 randconfig-x007-201913
x86_64                 randconfig-x008-201913
x86_64                 randconfig-x002-201913
x86_64                 randconfig-x006-201913
x86_64                 randconfig-x005-201913
x86_64                 randconfig-x009-201913
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                   randconfig-x077-201913
i386                   randconfig-x070-201913
i386                   randconfig-x074-201913
i386                   randconfig-x072-201913
i386                   randconfig-x075-201913
i386                   randconfig-x071-201913
i386                   randconfig-x078-201913
i386                   randconfig-x079-201913
i386                   randconfig-x076-201913
i386                   randconfig-x073-201913
i386                              allnoconfig
i386                                defconfig
riscv                              tinyconfig
i386                               tinyconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
