From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 23 Sep 2015 07:09:50 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 bce484e5c99ef4e8c36fae60948058ccf991f3d0 BUILD DONE
Message-ID: <5601dfbe.xfGjFwdvhGIyKQzN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
bce484e5c99ef4e8c36fae60948058ccf991f3d0  igb: add more checks for disconnected adapter

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000e/netdev.c:6788:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8539:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8539:9: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-c0-09230625
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-x000-09220931
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-s0-09230558
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check

elapsed time: 82m

configs tested: 128

i386                     randconfig-a0-201538
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                            allnoconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-09230625
x86_64                           allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
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
mips                                   jz4740
mips                              allnoconfig
mips                                     txx9
powerpc                           allnoconfig
i386                     randconfig-s1-201538
i386                     randconfig-s0-201538
x86_64                 randconfig-s0-09230558
x86_64                 randconfig-s1-09230558
x86_64                 randconfig-s2-09230558
x86_64                 randconfig-s3-09230558
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
blackfin                   CM-BF561_defconfig
m68k                       m5275evb_defconfig
m68k                          multi_defconfig
x86_64                   randconfig-i0-201538
i386                   randconfig-b0-09230635
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         lubbock_defconfig
blackfin                BF538-EZKIT_defconfig
blackfin                  CM-BF537U_defconfig
powerpc                  gef_sbc310_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201538
i386                     randconfig-i0-201538
x86_64                 randconfig-b0-09230534
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
arm                         shannon_defconfig
blackfin                BF527-EZKIT_defconfig
mips                           mtx1_defconfig
powerpc                 mpc832x_mds_defconfig
i386                     randconfig-n0-201538
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
x86_64                 randconfig-n0-09230610
m68k                           sun3_defconfig
m68k                       m5475evb_defconfig
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
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-r0-201538
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
