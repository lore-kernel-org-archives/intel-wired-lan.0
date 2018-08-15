From: kbuild test robot <lkp@intel.com>
Date: Thu, 16 Aug 2018 03:04:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 1724e32b2b299a1148f9f6cfaad5b09079d89f60
Message-ID: <5b747953.bpjTPDUx4/Qm9UFG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 1724e32b2b299a1148f9f6cfaad5b09079d89f60  igc: Add watchdog

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

elapsed time: 140m

configs tested: 153

x86_64                 randconfig-a0-08160130
mips                          malta_defconfig
powerpc                       maple_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-08152056
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-n0-08152108
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
i386                   randconfig-i0-08152108
i386                   randconfig-i1-08152108
ia64                                defconfig
mips                                defconfig
x86_64                 randconfig-g0-08152104
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
ia64                             alldefconfig
ia64                              allnoconfig
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
i386                   randconfig-a0-08152117
i386                   randconfig-a1-08152117
x86_64                 randconfig-s0-08160115
x86_64                 randconfig-s1-08160115
x86_64                 randconfig-s2-08160115
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                            mmp2_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7763rdp_defconfig
x86_64               randconfig-x016-08152109
x86_64               randconfig-x017-08152109
x86_64               randconfig-x015-08152109
x86_64               randconfig-x013-08152109
x86_64               randconfig-x014-08152109
x86_64               randconfig-x012-08152109
x86_64               randconfig-x011-08152109
x86_64               randconfig-x010-08152109
x86_64               randconfig-x019-08152109
x86_64               randconfig-x018-08152109
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s1-08152109
i386                   randconfig-s0-08152109
x86_64                 randconfig-s3-08160039
x86_64                 randconfig-s4-08160039
x86_64                 randconfig-s5-08160039
i386                             allmodconfig
x86_64                 randconfig-i0-08152057
i386                   randconfig-b0-08152348
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
mips                        bcm63xx_defconfig
powerpc64                        allyesconfig
x86_64                 randconfig-u0-08160112
i386                               tinyconfig
i386                 randconfig-x019-08152058
i386                 randconfig-x018-08152058
i386                 randconfig-x011-08152058
i386                 randconfig-x012-08152058
i386                 randconfig-x010-08152058
i386                 randconfig-x016-08152058
i386                 randconfig-x013-08152058
i386                 randconfig-x017-08152058
i386                 randconfig-x015-08152058
i386                 randconfig-x014-08152058
i386                 randconfig-x006-08152301
i386                 randconfig-x000-08152301
i386                 randconfig-x002-08152301
i386                 randconfig-x001-08152301
i386                 randconfig-x009-08152301
i386                 randconfig-x007-08152301
i386                 randconfig-x004-08152301
i386                 randconfig-x008-08152301
i386                 randconfig-x003-08152301
i386                 randconfig-x005-08152301
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                            allnoconfig
sh                           se7751_defconfig
x86_64                randconfig-ws0-08152100
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
i386                 randconfig-x077-08152104
i386                 randconfig-x071-08152104
i386                 randconfig-x070-08152104
i386                 randconfig-x079-08152104
i386                 randconfig-x073-08152104
i386                 randconfig-x072-08152104
i386                 randconfig-x075-08152104
i386                 randconfig-x074-08152104
i386                 randconfig-x076-08152104
i386                 randconfig-x078-08152104
x86_64                 randconfig-r0-08160002
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-x0-08152056

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
