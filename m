From: kbuild test robot <lkp@intel.com>
Date: Wed, 15 Aug 2018 01:07:46 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 99c96371a9c7f8ea5dd0516084d138327860d5f0
Message-ID: <5b730c62.ePVsllmexV8rU9Fk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 99c96371a9c7f8ea5dd0516084d138327860d5f0  ixgbevf: enable VF ipsec offload operations

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:13741:34-36: ERROR: reference preceded by free on line 13740
drivers/net/ethernet/intel/i40e/i40e_main.c:13949:2-8: ERROR: missing iounmap; ioremap on line 13820 and execution via conditional on line 13948
drivers/net/ethernet/intel/igc/igc_i225.c:471:5-12: Unneeded variable: "ret_val". Return "0" on line 490
drivers/net/ethernet/intel/igc/igc_mac.c:275:5-12: Unneeded variable: "ret_val". Return "0" on line 297

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:reference-preceded-by-free-on-line
    ??? drivers-net-ethernet-intel-igc-igc_i225.c:Unneeded-variable:ret_val-Return-on-line
    ??? drivers-net-ethernet-intel-igc-igc_mac.c:Unneeded-variable:ret_val-Return-on-line

elapsed time: 108m

configs tested: 166

arm                              allmodconfig
arm                            mps2_defconfig
x86_64                 randconfig-a0-08150011
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-08142356
x86_64                           allmodconfig
i386                     randconfig-n0-201832
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i1-201832
i386                     randconfig-i0-201832
c6x                        evmc6678_defconfig
m68k                        m5272c3_defconfig
x86_64                 randconfig-g0-08150007
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
i386                     randconfig-a1-201832
i386                     randconfig-a0-201832
x86_64                 randconfig-s0-08150007
x86_64                 randconfig-s1-08150007
x86_64                 randconfig-s2-08150007
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                          pxa910_defconfig
mips                      loongson3_defconfig
mips                      pistachio_defconfig
i386                     randconfig-s0-201832
i386                     randconfig-s1-201832
x86_64                 randconfig-s3-08142351
x86_64                 randconfig-s4-08142351
x86_64                 randconfig-s5-08142351
i386                               tinyconfig
arm                         em_x270_defconfig
powerpc                      obs600_defconfig
x86_64                   randconfig-i0-201832
i386                   randconfig-b0-08150015
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         cm_x300_defconfig
powerpc64                        alldefconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                          pxa168_defconfig
powerpc                      pmac32_defconfig
x86_64                 randconfig-u0-08142027
arm                         axm55xx_defconfig
arm                        mini2440_defconfig
mips                           jazz_defconfig
x86_64                randconfig-ne0-08132022
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
i386                  randconfig-sb0-08141950
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
powerpc                       ep405_defconfig
powerpc               mpc85xx_basic_defconfig
x86_64                randconfig-ws0-08150010
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
arm                     am200epdkit_defconfig
arm                         shannon_defconfig
x86_64                randconfig-ws0-08142344
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
powerpc                      makalu_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-r0-08142357
i386                   randconfig-x0-08150018

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
