From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 23 Sep 2015 02:45:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 5b57a3147c27d51fe91b5c00972b37e73a1d4052 BUILD DONE
Message-ID: <5601a1bd.Kxnhrfdc6zvco3wS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
5b57a3147c27d51fe91b5c00972b37e73a1d4052  igb: add more checks for disconnected adapter

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8539:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-h1-09230030
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-x000-09220931
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check

elapsed time: 76m

configs tested: 153

arm                           omap1_defconfig
sh                               alldefconfig
sh                           sh2007_defconfig
i386                     randconfig-a0-201538
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
mips                           jazz_defconfig
parisc                           allmodconfig
powerpc                       ep405_defconfig
i386                   randconfig-c0-09230201
m68k                          atari_defconfig
parisc                        c3000_defconfig
powerpc                      cm5200_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
powerpc                          allmodconfig
powerpc                         ps3_defconfig
powerpc                     redwood_defconfig
sh                     sh7710voipgw_defconfig
x86_64               randconfig-x014-09211934
x86_64               randconfig-x011-09211934
x86_64               randconfig-x012-09211934
x86_64               randconfig-x010-09211934
x86_64               randconfig-x015-09211934
x86_64               randconfig-x016-09211934
x86_64               randconfig-x018-09211934
x86_64               randconfig-x017-09211934
x86_64               randconfig-x019-09211934
x86_64               randconfig-x013-09211934
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                                     txx9
mips                      fuloong2e_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
i386                     randconfig-s1-201538
i386                     randconfig-s0-201538
x86_64                 randconfig-s0-09230149
x86_64                 randconfig-s1-09230149
x86_64                 randconfig-s2-09230149
x86_64                 randconfig-s3-09230149
x86_64                           allmodconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
arm                        trizeps4_defconfig
mips                           ip27_defconfig
powerpc               corenet_basic_defconfig
sh                            hp6xx_defconfig
x86_64                   randconfig-i0-201538
i386                   randconfig-b0-09230152
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                           bockw_defconfig
arm                        spear6xx_defconfig
blackfin             BF527-EZKIT-V2_defconfig
i386                     randconfig-i1-201538
i386                     randconfig-i0-201538
x86_64                 randconfig-b0-09230152
alpha                            allmodconfig
arm                           stm32_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                    mvme5100_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201538
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                                       mmp
arm                           tegra_defconfig
arm                                      arm5
arm                                     arm67
i386                   randconfig-h0-09230030
i386                   randconfig-h1-09230030
mips                            ar7_defconfig
powerpc                     kilauea_defconfig
s390                    performance_defconfig
x86_64                                   rhel
x86_64                 randconfig-n0-09230158
arm                                    sa1100
arm                          prima2_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-09230151
x86_64               randconfig-x001-09220935
x86_64               randconfig-x004-09220935
x86_64               randconfig-x006-09220935
x86_64               randconfig-x007-09220935
x86_64               randconfig-x000-09220935
x86_64               randconfig-x009-09220935
x86_64               randconfig-x002-09220935
x86_64               randconfig-x003-09220935
x86_64               randconfig-x005-09220935
x86_64               randconfig-x008-09220935
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201538
x86_64                 randconfig-r0-09230047
i386                             allmodconfig
arm                            mmp2_defconfig
powerpc                      pmac32_defconfig
xtensa                              defconfig
i386                 randconfig-x007-09220931
i386                 randconfig-x001-09220931
i386                 randconfig-x002-09220931
i386                 randconfig-x005-09220931
i386                 randconfig-x008-09220931
i386                 randconfig-x003-09220931
i386                 randconfig-x006-09220931
i386                 randconfig-x000-09220931
i386                 randconfig-x004-09220931
i386                 randconfig-x009-09220931

Thanks,
Fengguang
