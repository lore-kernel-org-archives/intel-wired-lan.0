From: kbuild test robot <lkp@intel.com>
Date: Fri, 27 Jul 2018 13:25:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:10GbE] BUILD SUCCESS
 1918e937ca3b4270181e6f05734d5240306bd2cf
Message-ID: <5b5aacb0.yyoO+5QmHZ/aGbui%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  10GbE
branch HEAD: 1918e937ca3b4270181e6f05734d5240306bd2cf  ixgbe: Refactor queue disable logic to take completion time into account

elapsed time: 250m

configs tested: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
i386                   randconfig-x012-201829
i386                   randconfig-x017-201829
i386                   randconfig-x014-201829
i386                   randconfig-x016-201829
i386                   randconfig-x013-201829
i386                   randconfig-x011-201829
i386                   randconfig-x018-201829
i386                   randconfig-x010-201829
i386                   randconfig-x015-201829
i386                   randconfig-x019-201829
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201829
x86_64                 randconfig-x007-201829
x86_64                 randconfig-x003-201829
x86_64                 randconfig-x000-201829
x86_64                 randconfig-x005-201829
x86_64                 randconfig-x004-201829
x86_64                 randconfig-x008-201829
x86_64                 randconfig-x001-201829
x86_64                 randconfig-x009-201829
x86_64                 randconfig-x002-201829
x86_64                 randconfig-x006-201829
i386                     randconfig-i0-201829
i386                     randconfig-i1-201829
x86_64                 randconfig-x018-201829
x86_64                 randconfig-x011-201829
x86_64                 randconfig-x015-201829
x86_64                 randconfig-x019-201829
x86_64                 randconfig-x014-201829
x86_64                 randconfig-x010-201829
x86_64                 randconfig-x013-201829
x86_64                 randconfig-x016-201829
x86_64                 randconfig-x017-201829
x86_64                 randconfig-x012-201829
arm                       omap2plus_defconfig
arm                              allmodconfig
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm64                            alldefconfig
i386                     randconfig-a0-201829
i386                     randconfig-a1-201829
i386                     randconfig-s1-201829
i386                     randconfig-s0-201829
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                               tinyconfig
x86_64                   randconfig-i0-201829
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                   randconfig-x078-201829
i386                   randconfig-x070-201829
i386                   randconfig-x075-201829
i386                   randconfig-x076-201829
i386                   randconfig-x074-201829
i386                   randconfig-x079-201829
i386                   randconfig-x071-201829
i386                   randconfig-x073-201829
i386                   randconfig-x072-201829
i386                   randconfig-x077-201829
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                             allmodconfig
i386                   randconfig-x008-201829
i386                   randconfig-x009-201829
i386                   randconfig-x005-201829
i386                   randconfig-x000-201829
i386                   randconfig-x003-201829
i386                   randconfig-x001-201829
i386                   randconfig-x004-201829
i386                   randconfig-x006-201829
i386                   randconfig-x007-201829
i386                   randconfig-x002-201829

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
