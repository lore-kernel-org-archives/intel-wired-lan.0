From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 01 Oct 2015 06:05:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 1250e6170acb727010f3b6f3f9592518992ecc78 BUILD INCOMPLETE
Message-ID: <560c5cb1.pxK9m8FMAsYGpAdX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
1250e6170acb727010f3b6f3f9592518992ecc78  ixgbe: Add KR mode support for CS4227 chip

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_main.c:1959:7-17: ERROR: function i40e_sync_vsi_filters called on line 9038 inside lock on line 9034 but uses GFP_KERNEL
drivers/net/ethernet/intel/i40e/i40e_main.c:8998:5: sparse: context imbalance in 'i40e_vsi_release' - different lock contexts for basic block
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2294:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2294:17: warning: 'oudph' may be used uninitialized in this function [-Wuninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2294:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2294:37: warning: 'oiph' may be used uninitialized in this function [-Wuninitialized]
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:131:12: warning: 'ixgbe_get_cs4227_status' defined but not used [-Wunused-function]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:function-i40e_sync_vsi_filters-called-on-line-inside-lock-on-line-but-uses-GFP_KERNEL
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? i386-randconfig-i0-201539
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? i386-randconfig-i1-201539
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:sparse:context-imbalance-in-i40e_vsi_release-different-lock-contexts-for-basic-block
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:warning:ixgbe_get_cs4227_status-defined-but-not-used

TIMEOUT after 608m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 23

alpha                            allyesconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
blackfin                         allyesconfig
cris                             allyesconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allyesconfig
parisc                         b180_defconfig
powerpc                          allyesconfig
s390                             allyesconfig
sh                               allyesconfig
sparc64                          allyesconfig
sparc                            allyesconfig
tile                             allyesconfig
x86_64                           allyesconfig
x86_64                                    lkp
xtensa                           allyesconfig

configs tested: 105

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201539
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                 randconfig-x014-201539
x86_64                 randconfig-x019-201539
x86_64                 randconfig-x016-201539
x86_64                 randconfig-x011-201539
x86_64                 randconfig-x018-201539
x86_64                 randconfig-x012-201539
x86_64                 randconfig-x017-201539
x86_64                 randconfig-x013-201539
x86_64                 randconfig-x015-201539
x86_64                 randconfig-x010-201539
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                     randconfig-s1-201539
i386                     randconfig-s0-201539
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
x86_64                   randconfig-i0-201539
i386                     randconfig-i1-201539
i386                     randconfig-i0-201539
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201539
x86_64                                   rhel
x86_64                           allmodconfig
x86_64                 randconfig-x001-201539
x86_64                 randconfig-x004-201539
x86_64                 randconfig-x000-201539
x86_64                 randconfig-x006-201539
x86_64                 randconfig-x003-201539
x86_64                 randconfig-x008-201539
x86_64                 randconfig-x007-201539
x86_64                 randconfig-x009-201539
x86_64                 randconfig-x005-201539
x86_64                 randconfig-x002-201539
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201539
i386                   randconfig-x000-201539
i386                   randconfig-x005-201539
i386                   randconfig-x003-201539
i386                   randconfig-x007-201539
i386                   randconfig-x004-201539
i386                   randconfig-x001-201539
i386                   randconfig-x008-201539
i386                   randconfig-x006-201539
i386                   randconfig-x009-201539
i386                   randconfig-x002-201539
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
