From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 16 Oct 2015 22:43:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 81f5fea549d54c306e31dd5fcf9218409b7c8c0d BUILD DONE
Message-ID: <56210d1b.NvUKThYjhKd+HZ96%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
81f5fea549d54c306e31dd5fcf9218409b7c8c0d  e1000e: Increase timeout of polling bit RSPCIPHY

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 203m

configs tested: 119

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201541
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
x86_64               randconfig-x010-10130227
x86_64               randconfig-x015-10130227
x86_64               randconfig-x017-10130227
x86_64               randconfig-x019-10130227
x86_64               randconfig-x012-10130227
x86_64               randconfig-x018-10130227
x86_64               randconfig-x011-10130227
x86_64               randconfig-x016-10130227
x86_64               randconfig-x014-10130227
x86_64               randconfig-x013-10130227
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201541
i386                     randconfig-s0-201541
x86_64                 randconfig-s3-10161935
x86_64                 randconfig-s4-10161935
x86_64                 randconfig-s5-10161935
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201541
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201541
i386                     randconfig-i0-201541
i386         randconfig-i1-201541+CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-b0-10161938
x86_64                           allmodconfig
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                                       mmp
arm                           tegra_defconfig
arm                                      arm5
arm                                     arm67
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201541
i386                             allyesconfig
x86_64                 randconfig-x002-201541
x86_64                 randconfig-x009-201541
x86_64                 randconfig-x000-201541
x86_64                 randconfig-x003-201541
x86_64                 randconfig-x004-201541
x86_64                 randconfig-x001-201541
x86_64                 randconfig-x006-201541
x86_64                 randconfig-x007-201541
x86_64                 randconfig-x008-201541
x86_64                 randconfig-x005-201541
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201541
i386                 randconfig-x008-10121721
i386                 randconfig-x009-10121721
i386                 randconfig-x001-10121721
i386                 randconfig-x002-10121721
i386                 randconfig-x003-10121721
i386                 randconfig-x007-10121721
i386                 randconfig-x006-10121721
i386                 randconfig-x000-10121721
i386                 randconfig-x004-10121721
i386                 randconfig-x005-10121721

Thanks,
Fengguang
