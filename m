From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 14 Jan 2016 07:08:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 036449ede7908385fa38698b419c0b72a1839431 BUILD DONE
Message-ID: <5696d8e6.3So61TNXhZcRthoz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
036449ede7908385fa38698b419c0b72a1839431  igbvf: Add support for generic Tx checksums

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 79m

configs tested: 103

m68k                            mac_defconfig
powerpc                         ps3_defconfig
sh                     sh7710voipgw_defconfig
i386                     randconfig-a0-201602
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
x86_64               randconfig-x013-01110856
x86_64               randconfig-x011-01110856
x86_64               randconfig-x012-01110856
x86_64               randconfig-x010-01110856
x86_64               randconfig-x017-01110856
x86_64               randconfig-x015-01110856
x86_64               randconfig-x019-01110856
x86_64               randconfig-x018-01110856
x86_64               randconfig-x016-01110856
x86_64               randconfig-x014-01110856
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201602
i386                     randconfig-s1-201602
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201602
i386                     randconfig-i0-201602
i386                     randconfig-i1-201602
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-n0-01140546
ia64                                defconfig
mips                                defconfig
x86_64                 randconfig-n0-01140517
blackfin                            defconfig
ia64                             alldefconfig
ia64                              allnoconfig
x86_64                                    lkp
x86_64                                   rhel
i386                   randconfig-r0-01140537
i386                   randconfig-x007-201602
i386                   randconfig-x001-201602
i386                   randconfig-x004-201602
i386                   randconfig-x008-201602
i386                   randconfig-x002-201602
i386                   randconfig-x006-201602
i386                   randconfig-x003-201602
i386                   randconfig-x005-201602
i386                   randconfig-x000-201602
i386                   randconfig-x009-201602
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
