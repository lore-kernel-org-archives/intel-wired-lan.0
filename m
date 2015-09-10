From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 10 Sep 2015 16:32:59 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 a9ec56ae62ccc5e098219d695af52b9743805da4 BUILD DONE
Message-ID: <55f1403b.Ej3UG8ZHJFyEZGW9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
a9ec56ae62ccc5e098219d695af52b9743805da4  i40e: Change some messages from info to debug only

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:8353:2: error: implicit declaration of function 'vxlan_features_check' [-Werror=implicit-function-declaration]

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
??? x86_64-randconfig-x011-09091713
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-x016-09091713
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:implicit-declaration-of-function-vxlan_features_check

elapsed time: 38m

configs tested: 107

i386                     randconfig-a0-201536
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                     randconfig-s1-201536
i386                     randconfig-s0-201536
x86_64                           allmodconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                            allnoconfig
x86_64                   randconfig-i0-201536
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201536
i386                     randconfig-i0-201536
i386                     randconfig-n0-201536
i386                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                    lkp
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
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                 randconfig-x004-201536
x86_64                 randconfig-x001-201536
x86_64                 randconfig-x006-201536
x86_64                 randconfig-x000-201536
x86_64                 randconfig-x003-201536
x86_64                 randconfig-x002-201536
x86_64                 randconfig-x005-201536
x86_64                 randconfig-x009-201536
x86_64                 randconfig-x007-201536
x86_64                 randconfig-x008-201536
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

Thanks,
Fengguang
