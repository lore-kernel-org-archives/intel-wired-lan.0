From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 23 Dec 2015 16:28:55 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 c779eb447c4dd939e2cb7adc5d29eb5e18ca29ba BUILD DONE
Message-ID: <567a5b47.V5mglgOQjQ6kgPlE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
c779eb447c4dd939e2cb7adc5d29eb5e18ca29ba  i40e/i40evf: Fix for UDP/TCP RSS for X722

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 61m

configs tested: 122

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-12222034
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                          ath79_defconfig
um                               alldefconfig
parisc                         b180_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
arm                          nuc910_defconfig
arm                           viper_defconfig
ia64                                defconfig
powerpc64                           defconfig
sparc                            alldefconfig
x86_64                 randconfig-x015-201551
x86_64                 randconfig-x019-201551
x86_64                 randconfig-x010-201551
x86_64                 randconfig-x016-201551
x86_64                 randconfig-x012-201551
x86_64                 randconfig-x011-201551
x86_64                 randconfig-x013-201551
x86_64                 randconfig-x017-201551
x86_64                 randconfig-x014-201551
x86_64                 randconfig-x018-201551
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201551
i386                     randconfig-s1-201551
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201551
arm                         nhk8815_defconfig
mips                      pistachio_defconfig
mn10300                          alldefconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201551
i386                     randconfig-i1-201551
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201551
mips                            gpr_defconfig
powerpc                 canyonlands_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
arm                       netwinder_defconfig
mips                           xway_defconfig
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
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-x006-201551
x86_64                 randconfig-x009-201551
x86_64                 randconfig-x003-201551
x86_64                 randconfig-x008-201551
x86_64                 randconfig-x005-201551
x86_64                 randconfig-x001-201551
x86_64                 randconfig-x002-201551
x86_64                 randconfig-x000-201551
x86_64                 randconfig-x004-201551
x86_64                 randconfig-x007-201551
i386                     randconfig-r0-201551
arm                             bcm_defconfig
xtensa                            allnoconfig
i386                 randconfig-x005-12222106
i386                 randconfig-x004-12222106
i386                 randconfig-x002-12222106
i386                 randconfig-x006-12222106
i386                 randconfig-x007-12222106
i386                 randconfig-x003-12222106
i386                 randconfig-x009-12222106
i386                 randconfig-x008-12222106
i386                 randconfig-x001-12222106
i386                 randconfig-x000-12222106
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

Thanks,
Fengguang
