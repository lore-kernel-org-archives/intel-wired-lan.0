From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 12 Jan 2016 19:12:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 a87f7a60f94049fbcd0c6f19206f2f163e04d476 BUILD DONE
Message-ID: <5694dfb0.FTqIepnQYiGi4Ddb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
a87f7a60f94049fbcd0c6f19206f2f163e04d476  igbvf: Add support for generic Tx checksums

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc'
drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb'
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? tile-allyesconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 57m

configs tested: 121

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-01120106
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
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
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
avr32        atngw100mkii_evklcd100_defconfig
mips                      pistachio_defconfig
powerpc                      katmai_defconfig
s390                           gcov_defconfig
tile                             allyesconfig
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
x86_64                 randconfig-s0-01121803
x86_64                 randconfig-s1-01121803
x86_64                 randconfig-s2-01121803
x86_64                           allmodconfig
x86_64                 randconfig-s3-01121754
x86_64                 randconfig-s4-01121754
x86_64                 randconfig-s5-01121754
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
x86_64                   randconfig-i0-201602
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201602
i386                     randconfig-i1-201602
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201602
sh                   rts7751r2dplus_defconfig
arm                         iop13xx_defconfig
powerpc64                           defconfig
x86_64                 randconfig-x002-201602
x86_64                 randconfig-x004-201602
x86_64                 randconfig-x000-201602
x86_64                 randconfig-x009-201602
x86_64                 randconfig-x003-201602
x86_64                 randconfig-x005-201602
x86_64                 randconfig-x006-201602
x86_64                 randconfig-x001-201602
x86_64                 randconfig-x008-201602
x86_64                 randconfig-x007-201602
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201602
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

Thanks,
Fengguang
