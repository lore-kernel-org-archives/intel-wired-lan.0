From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 25 Dec 2015 06:49:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 bf52a98fdd64ab7189549dacca6f047076f9cea8 BUILD DONE
Message-ID: <567c768f.WiS+/vkMZN2qXVzl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
bf52a98fdd64ab7189549dacca6f047076f9cea8  i40e/i40evf: Bump i40e to 1.4.11 and i40evf to 1.4.7

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? arm-multi_v7_defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 64m

configs tested: 120

i386                     randconfig-a0-201551
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
frv                                 defconfig
parisc                            allnoconfig
xtensa                          iss_defconfig
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
alpha                               defconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                          ep93xx_defconfig
arm64                             allnoconfig
sh                   rts7751r2dplus_defconfig
sh                          sdk7780_defconfig
sh                              ul2_defconfig
arm                          imote2_defconfig
arm                    realview-smp_defconfig
mips                             allyesconfig
powerpc                     mpc86xx_defconfig
powerpc                     taishan_defconfig
x86_64               randconfig-x019-12250254
x86_64               randconfig-x017-12250254
x86_64               randconfig-x015-12250254
x86_64               randconfig-x013-12250254
x86_64               randconfig-x010-12250254
x86_64               randconfig-x016-12250254
x86_64               randconfig-x011-12250254
x86_64               randconfig-x012-12250254
x86_64               randconfig-x018-12250254
x86_64               randconfig-x014-12250254
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201551
i386                     randconfig-s1-201551
x86_64                 randconfig-s0-12250600
x86_64                 randconfig-s1-12250600
x86_64                 randconfig-s2-12250600
x86_64                 randconfig-s3-12250608
x86_64                 randconfig-s4-12250608
x86_64                 randconfig-s5-12250608
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
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
x86_64                 randconfig-i0-12250240
i386                     randconfig-i0-201551
i386                     randconfig-i1-201551
i386                             allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
microblaze                        allnoconfig
powerpc                     mpc5200_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201551
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                        multi_v7_defconfig
arm                           stm32_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      acadia_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                             allmodconfig
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
i386                   randconfig-x0-12250609

Thanks,
Fengguang
