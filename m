From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 26 Oct 2015 22:18:02 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 16eb854021a0d4f01088612b3791143b252895d2 BUILD DONE
Message-ID: <562e361a.HokvNOjhtScYV9GP%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
16eb854021a0d4f01088612b3791143b252895d2  bridge: Notify port device of encap header length

drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:12: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:2: error: implicit declaration of function 'CLOCKSOURCE_MASK'
drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:2: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-s0-10262138
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-s1-10262138
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-s4-10262128
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x008-10252017
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x013-201543
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x018-201543
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x019-201543
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK

elapsed time: 54m

configs tested: 129

powerpc                      tqm8xx_defconfig
sh                             sh03_defconfig
sparc64                             defconfig
i386                   randconfig-a0-10252128
x86_64                 randconfig-a0-10262059
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                            allnoconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
arm                         bcm2835_defconfig
arm                         lpc18xx_defconfig
powerpc                        warp_defconfig
sh                           se7721_defconfig
sh                   secureedge5410_defconfig
x86_64                 randconfig-x015-201543
x86_64                 randconfig-x019-201543
x86_64                 randconfig-x014-201543
x86_64                 randconfig-x016-201543
x86_64                 randconfig-x018-201543
x86_64                 randconfig-x011-201543
x86_64                 randconfig-x013-201543
x86_64                 randconfig-x010-201543
x86_64                 randconfig-x017-201543
x86_64                 randconfig-x012-201543
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201543
i386                     randconfig-s1-201543
x86_64                 randconfig-s0-10262138
x86_64                 randconfig-s1-10262138
x86_64                 randconfig-s2-10262138
x86_64                           allmodconfig
x86_64                 randconfig-s3-10262128
x86_64                 randconfig-s4-10262128
x86_64                 randconfig-s5-10262128
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201543
sparc                               defconfig
sparc64                           allnoconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201543
i386                     randconfig-i1-201543
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
ia64                            zx1_defconfig
powerpc                   lite5200b_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                   randconfig-n0-10260618
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                        neponset_defconfig
mips                          lasat_defconfig
x86_64                 randconfig-n0-10262132
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
i386                  randconfig-sb0-10262055
x86_64               randconfig-x008-10252017
x86_64               randconfig-x007-10252017
x86_64               randconfig-x001-10252017
x86_64               randconfig-x005-10252017
x86_64               randconfig-x004-10252017
x86_64               randconfig-x000-10252017
x86_64               randconfig-x002-10252017
x86_64               randconfig-x006-10252017
x86_64               randconfig-x009-10252017
x86_64               randconfig-x003-10252017
i386                   randconfig-r0-10252017
i386                   randconfig-x004-201543
i386                   randconfig-x003-201543
i386                   randconfig-x009-201543
i386                   randconfig-x007-201543
i386                   randconfig-x008-201543
i386                   randconfig-x005-201543
i386                   randconfig-x006-201543
i386                   randconfig-x001-201543
i386                   randconfig-x002-201543
i386                   randconfig-x000-201543

Thanks,
Fengguang
