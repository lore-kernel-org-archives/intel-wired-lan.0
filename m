From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 23 Dec 2015 18:09:49 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 ac1d0eaf0e33fa2f35fda28774eac3036031c986 BUILD DONE
Message-ID: <567a72ed.zuCyz1WBq6OyNw+i%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
ac1d0eaf0e33fa2f35fda28774eac3036031c986  i40e: allow zero MAC address for VFs

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 81m

configs tested: 107

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-12222034
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
i386                             allyesconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201551
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201551
i386                     randconfig-i1-201551
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-n0-201551
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
x86_64                                    lkp
i386                     randconfig-r0-201551
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
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
