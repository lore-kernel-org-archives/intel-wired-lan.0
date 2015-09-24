From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 24 Sep 2015 08:48:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 b036bfb5b16db26f64bac3e014ae02ea921cc402 BUILD DONE
Message-ID: <5603484c.z1xI6Uo7foNe107s%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
b036bfb5b16db26f64bac3e014ae02ea921cc402  igb: add more checks for disconnected adapter

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8539:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:1985:5: error: redefinition of 'ixgbe_write_i2c_byte_generic'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:2001:5: error: redefinition of 'ixgbe_write_i2c_byte_generic_unlocked'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:2003:5: error: redefinition of 'ixgbe_write_i2c_byte_generic'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:2019:5: error: redefinition of 'ixgbe_write_i2c_byte_generic_unlocked'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:312:5: error: redefinition of 'ixgbe_write_i2c_combined_generic'
drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c:327:5: error: redefinition of 'ixgbe_write_i2c_combined_generic_unlocked'

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-x000-09220931
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-x001-09220931
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic_unlocked
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic_unlocked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic_unlocked
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic_unlocked
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic_unlocked
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic_unlocked
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic_unlocked
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic_unlocked
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic_unlocked
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic_unlocked
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_byte_generic_unlocked
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_phy.c:error:redefinition-of-ixgbe_write_i2c_combined_generic_unlocked

elapsed time: 43m

configs tested: 103

i386                     randconfig-a0-201538
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64               randconfig-x010-09232308
x86_64               randconfig-x014-09232308
x86_64               randconfig-x018-09232308
x86_64               randconfig-x017-09232308
x86_64               randconfig-x012-09232308
x86_64               randconfig-x016-09232308
x86_64               randconfig-x013-09232308
x86_64               randconfig-x011-09232308
x86_64               randconfig-x015-09232308
x86_64               randconfig-x019-09232308
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s1-201538
i386                     randconfig-s0-201538
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                            allnoconfig
i386                             allmodconfig
mips                                   jz4740
mips                              allnoconfig
mips                                     txx9
powerpc                           allnoconfig
x86_64                   randconfig-i0-201538
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i1-201538
i386                     randconfig-i0-201538
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201538
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                   rhel
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
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
