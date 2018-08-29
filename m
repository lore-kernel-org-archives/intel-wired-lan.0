From: kbuild test robot <lkp@intel.com>
Date: Thu, 30 Aug 2018 06:03:06 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 e745e28371300bc14c5d145251ed390e13093f5e
Message-ID: <5b87181a.dXnkGpAE8GEJovcK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e745e28371300bc14c5d145251ed390e13093f5e  Subject: [v2] Documentation: ixgbe: Update kernel documentation X-Patchwork-Submitter: Jeff Kirsher <jeffrey.t.kirsher@intel.com> List-Id: Intel Wired Ethernet Linux Kernel Driver Development  <intel-wired-lan.osuosl.org>

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_xsk.c:709:32: warning: 'tx_desc' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_xsk.c:warning:tx_desc-may-be-used-uninitialized-in-this-function

elapsed time: 102m

configs tested: 142

arm                              zx_defconfig
sparc64                          allyesconfig
x86_64                 randconfig-a0-08300439
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x018-201834
i386                   randconfig-x017-201834
i386                   randconfig-x010-201834
i386                   randconfig-x013-201834
i386                   randconfig-x016-201834
i386                   randconfig-x011-201834
i386                   randconfig-x019-201834
i386                   randconfig-x015-201834
i386                   randconfig-x012-201834
i386                   randconfig-x014-201834
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201834
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201834
i386                     randconfig-i1-201834
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
x86_64                 randconfig-g0-08300022
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-x019-201834
x86_64                 randconfig-x013-201834
x86_64                 randconfig-x018-201834
x86_64                 randconfig-x012-201834
x86_64                 randconfig-x017-201834
x86_64                 randconfig-x010-201834
x86_64                 randconfig-x014-201834
x86_64                 randconfig-x015-201834
x86_64                 randconfig-x016-201834
x86_64                 randconfig-x011-201834
i386                   randconfig-a0-08280857
i386                   randconfig-a1-08280857
x86_64                 randconfig-s0-08300418
x86_64                 randconfig-s1-08300418
x86_64                 randconfig-s2-08300418
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                           allyesconfig
arm                          pxa3xx_defconfig
mips                       bmips_be_defconfig
um                                allnoconfig
powerpc                    klondike_defconfig
xtensa                           allyesconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-s1-08280925
i386                   randconfig-s0-08280925
x86_64                 randconfig-s3-08300443
x86_64                 randconfig-s4-08300443
x86_64                 randconfig-s5-08300443
i386                               tinyconfig
x86_64                 randconfig-i0-08280848
i386                   randconfig-b0-08291651
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-u0-08300046
x86_64                 randconfig-u0-08300531
mips                              allnoconfig
i386                   randconfig-x077-201834
i386                   randconfig-x070-201834
i386                   randconfig-x076-201834
i386                   randconfig-x075-201834
i386                   randconfig-x072-201834
i386                   randconfig-x078-201834
i386                   randconfig-x071-201834
i386                   randconfig-x074-201834
i386                   randconfig-x073-201834
i386                   randconfig-x079-201834
i386                   randconfig-x002-201834
i386                   randconfig-x005-201834
i386                   randconfig-x003-201834
i386                   randconfig-x008-201834
i386                   randconfig-x000-201834
i386                   randconfig-x007-201834
i386                   randconfig-x004-201834
i386                   randconfig-x001-201834
i386                   randconfig-x006-201834
i386                   randconfig-x009-201834
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-x000-201834
x86_64                 randconfig-x009-201834
x86_64                 randconfig-x001-201834
x86_64                 randconfig-x004-201834
x86_64                 randconfig-x003-201834
x86_64                 randconfig-x008-201834
x86_64                 randconfig-x007-201834
x86_64                 randconfig-x006-201834
x86_64                 randconfig-x005-201834
x86_64                 randconfig-x002-201834
i386                             allmodconfig
x86_64                 randconfig-r0-08291101
x86_64                              defconfig
powerpc                     kilauea_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-x0-08291447

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
