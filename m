From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 16 Sep 2015 07:31:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 e0a17cc52b07f14cbd4c278f52dcd458345de713 BUILD DONE
Message-ID: <55f8aa44.T9GW36rbyngUlOh7%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
e0a17cc52b07f14cbd4c278f52dcd458345de713  i40e: Store off PHY capabilities

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8539:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-x009-09141005
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check

elapsed time: 15m

configs tested: 106

i386                     randconfig-a0-201537
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
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
i386                             allmodconfig
x86_64               randconfig-x015-09141022
x86_64               randconfig-x016-09141022
x86_64               randconfig-x014-09141022
x86_64               randconfig-x010-09141022
x86_64               randconfig-x017-09141022
x86_64               randconfig-x019-09141022
x86_64               randconfig-x011-09141022
x86_64               randconfig-x018-09141022
x86_64               randconfig-x013-09141022
x86_64               randconfig-x012-09141022
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                     randconfig-s1-201537
i386                     randconfig-s0-201537
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                            allnoconfig
x86_64                   randconfig-i0-201537
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201537
i386                     randconfig-i0-201537
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
i386                     randconfig-n0-201537
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
x86_64                           allmodconfig
x86_64               randconfig-x000-09141005
x86_64               randconfig-x001-09141005
x86_64               randconfig-x004-09141005
x86_64               randconfig-x003-09141005
x86_64               randconfig-x008-09141005
x86_64               randconfig-x006-09141005
x86_64               randconfig-x007-09141005
x86_64               randconfig-x005-09141005
x86_64               randconfig-x002-09141005
x86_64               randconfig-x009-09141005
i386                     randconfig-r0-201537
i386                 randconfig-x003-09141004
i386                 randconfig-x005-09141004
i386                 randconfig-x001-09141004
i386                 randconfig-x008-09141004
i386                 randconfig-x007-09141004
i386                 randconfig-x004-09141004
i386                 randconfig-x002-09141004
i386                 randconfig-x000-09141004
i386                 randconfig-x009-09141004
i386                 randconfig-x006-09141004

Thanks,
Fengguang
