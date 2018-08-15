From: kbuild test robot <lkp@intel.com>
Date: Wed, 15 Aug 2018 08:01:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 4b0aef0cd5ef255a97ee45215c72f2af4220b038
Message-ID: <5b736d49./OMYh3IIJ4pt3npS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 4b0aef0cd5ef255a97ee45215c72f2af4220b038  ixgbevf: enable VF ipsec offload operations

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:13949:2-8: ERROR: missing iounmap; ioremap on line 13820 and execution via conditional on line 13948
drivers/net/ethernet/intel/igc/igc_i225.c:471:5-12: Unneeded variable: "ret_val". Return "0" on line 490
drivers/net/ethernet/intel/igc/igc_mac.c:275:5-12: Unneeded variable: "ret_val". Return "0" on line 297

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
    ??? drivers-net-ethernet-intel-igc-igc_i225.c:Unneeded-variable:ret_val-Return-on-line
    ??? drivers-net-ethernet-intel-igc-igc_mac.c:Unneeded-variable:ret_val-Return-on-line

elapsed time: 180m

configs tested: 121

i386                               tinyconfig
i386                     randconfig-n0-201832
x86_64                 randconfig-x009-201832
x86_64                 randconfig-x000-201832
x86_64                 randconfig-x004-201832
x86_64                 randconfig-x001-201832
x86_64                 randconfig-x003-201832
x86_64                 randconfig-x007-201832
x86_64                 randconfig-x008-201832
x86_64                 randconfig-x005-201832
x86_64                 randconfig-x002-201832
x86_64                 randconfig-x006-201832
i386                     randconfig-i1-201832
i386                     randconfig-i0-201832
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
x86_64                 randconfig-x019-201832
x86_64                 randconfig-x013-201832
x86_64                 randconfig-x017-201832
x86_64                 randconfig-x012-201832
x86_64                 randconfig-x018-201832
x86_64                 randconfig-x010-201832
x86_64                 randconfig-x014-201832
x86_64                 randconfig-x016-201832
x86_64                 randconfig-x011-201832
x86_64                 randconfig-x015-201832
arm                       omap2plus_defconfig
arm                              allmodconfig
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm64                            alldefconfig
i386                     randconfig-a1-201832
i386                     randconfig-a0-201832
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                     randconfig-s0-201832
i386                     randconfig-s1-201832
x86_64                           allmodconfig
x86_64                   randconfig-i0-201832
i386                   randconfig-x018-201832
i386                   randconfig-x017-201832
i386                   randconfig-x010-201832
i386                   randconfig-x016-201832
i386                   randconfig-x013-201832
i386                   randconfig-x011-201832
i386                   randconfig-x015-201832
i386                   randconfig-x019-201832
i386                   randconfig-x014-201832
i386                   randconfig-x012-201832
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x002-201832
i386                   randconfig-x003-201832
i386                   randconfig-x005-201832
i386                   randconfig-x008-201832
i386                   randconfig-x000-201832
i386                   randconfig-x007-201832
i386                   randconfig-x001-201832
i386                   randconfig-x004-201832
i386                   randconfig-x009-201832
i386                   randconfig-x006-201832
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
i386                   randconfig-x077-201832
i386                   randconfig-x076-201832
i386                   randconfig-x070-201832
i386                   randconfig-x075-201832
i386                   randconfig-x072-201832
i386                   randconfig-x074-201832
i386                   randconfig-x071-201832
i386                   randconfig-x078-201832
i386                   randconfig-x079-201832
i386                   randconfig-x073-201832
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
