From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 10 Sep 2015 14:00:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 bbe2b476bf368aec750e95a780004ec8e390ac63 BUILD DONE
Message-ID: <55f11c85.77aZchwoX4lieIWR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
bbe2b476bf368aec750e95a780004ec8e390ac63  igb: add 88E1543 initialization code

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8352:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-x011-09091713
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-x016-09091713
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check

elapsed time: 37m

configs tested: 112

i386                     randconfig-a0-201536
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                            allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
x86_64               randconfig-x013-09091713
x86_64               randconfig-x010-09091713
x86_64               randconfig-x019-09091713
x86_64               randconfig-x018-09091713
x86_64               randconfig-x012-09091713
x86_64               randconfig-x014-09091713
x86_64               randconfig-x011-09091713
x86_64               randconfig-x017-09091713
x86_64               randconfig-x016-09091713
x86_64               randconfig-x015-09091713
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
i386                     randconfig-s1-201536
i386                     randconfig-s0-201536
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201536
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201536
i386                     randconfig-i1-201536
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
i386                     randconfig-n0-201536
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                   rhel
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                 randconfig-x000-201536
x86_64                 randconfig-x001-201536
x86_64                 randconfig-x002-201536
x86_64                 randconfig-x003-201536
x86_64                 randconfig-x004-201536
x86_64                 randconfig-x005-201536
x86_64                 randconfig-x006-201536
x86_64                 randconfig-x007-201536
x86_64                 randconfig-x008-201536
x86_64                 randconfig-x009-201536
i386                     randconfig-r0-201536
i386                   randconfig-x000-201536
i386                   randconfig-x008-201536
i386                   randconfig-x001-201536
i386                   randconfig-x004-201536
i386                   randconfig-x007-201536
i386                   randconfig-x003-201536
i386                   randconfig-x005-201536
i386                   randconfig-x002-201536
i386                   randconfig-x009-201536
i386                   randconfig-x006-201536
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

Thanks,
Fengguang
