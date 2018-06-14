From: kbuild test robot <lkp@intel.com>
Date: Fri, 15 Jun 2018 00:04:27 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 222a6fd6ce30319c3ce5d0c733089dc6daba8948
Message-ID: <5b22920b.p/pXQAq3YxDl22JU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 222a6fd6ce30319c3ce5d0c733089dc6daba8948  net: Add generic ndo_select_queue functions

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:496:56: sparse: restricted __be32 degrades to integer

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer

elapsed time: 90m

configs tested: 125

sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                               tinyconfig
i386                   randconfig-x012-201823
i386                   randconfig-x016-201823
i386                   randconfig-x017-201823
i386                   randconfig-x014-201823
i386                   randconfig-x018-201823
i386                   randconfig-x013-201823
i386                   randconfig-x011-201823
i386                   randconfig-x015-201823
i386                   randconfig-x019-201823
i386                   randconfig-x010-201823
x86_64                 randconfig-x003-201823
x86_64                 randconfig-x007-201823
x86_64                 randconfig-x000-201823
x86_64                 randconfig-x004-201823
x86_64                 randconfig-x005-201823
x86_64                 randconfig-x001-201823
x86_64                 randconfig-x008-201823
x86_64                 randconfig-x002-201823
x86_64                 randconfig-x006-201823
x86_64                 randconfig-x009-201823
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-x011-201823
x86_64                 randconfig-x015-201823
x86_64                 randconfig-x018-201823
x86_64                 randconfig-x010-201823
x86_64                 randconfig-x014-201823
x86_64                 randconfig-x019-201823
x86_64                 randconfig-x013-201823
x86_64                 randconfig-x017-201823
x86_64                 randconfig-x016-201823
x86_64                 randconfig-x012-201823
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                           allmodconfig
i386                             allmodconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201823
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                              fedora-25
x86_64                                   rhel
x86_64                               rhel-7.2
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                   randconfig-x009-201823
i386                   randconfig-x008-201823
i386                   randconfig-x005-201823
i386                   randconfig-x001-201823
i386                   randconfig-x000-201823
i386                   randconfig-x003-201823
i386                   randconfig-x004-201823
i386                   randconfig-x006-201823
i386                   randconfig-x002-201823
i386                   randconfig-x007-201823
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x078-201823
i386                   randconfig-x079-201823
i386                   randconfig-x070-201823
i386                   randconfig-x074-201823
i386                   randconfig-x075-201823
i386                   randconfig-x076-201823
i386                   randconfig-x071-201823
i386                   randconfig-x073-201823
i386                   randconfig-x077-201823
i386                   randconfig-x072-201823
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
