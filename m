From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 16 Dec 2015 22:10:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 1b199aae065ea037744367add7a9613916e41fbd BUILD DONE
Message-ID: <567170e3.bF6+ncZcwZtuCs+B%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
1b199aae065ea037744367add7a9613916e41fbd  igb: fix compare_const_fl.cocci warnings

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 21m

configs tested: 104

i386                     randconfig-a0-201550
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
x86_64               randconfig-x011-12141150
x86_64               randconfig-x016-12141150
x86_64               randconfig-x013-12141150
x86_64               randconfig-x019-12141150
x86_64               randconfig-x017-12141150
x86_64               randconfig-x012-12141150
x86_64               randconfig-x014-12141150
x86_64               randconfig-x010-12141150
x86_64               randconfig-x018-12141150
x86_64               randconfig-x015-12141150
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201550
i386                     randconfig-s1-201550
x86_64                           allmodconfig
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
x86_64                   randconfig-i0-201550
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201550
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
x86_64               randconfig-x005-12141102
x86_64               randconfig-x003-12141102
x86_64               randconfig-x000-12141102
x86_64               randconfig-x001-12141102
x86_64               randconfig-x007-12141102
x86_64               randconfig-x004-12141102
x86_64               randconfig-x009-12141102
x86_64               randconfig-x006-12141102
x86_64               randconfig-x002-12141102
x86_64               randconfig-x008-12141102
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                 randconfig-x000-12141102
i386                 randconfig-x007-12141102
i386                 randconfig-x009-12141102
i386                 randconfig-x004-12141102
i386                 randconfig-x003-12141102
i386                 randconfig-x006-12141102
i386                 randconfig-x005-12141102
i386                 randconfig-x002-12141102
i386                 randconfig-x008-12141102
i386                 randconfig-x001-12141102

Thanks,
Fengguang
