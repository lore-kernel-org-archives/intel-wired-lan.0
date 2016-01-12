From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 12 Jan 2016 20:28:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 59919de1f9819229f4878870739e2f41dfed7f71 BUILD DONE
Message-ID: <5694f177.2CnCf/mhreXm0TYM%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
59919de1f9819229f4878870739e2f41dfed7f71  i40e: move sync_vsi_filters up in service_task

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 53m

configs tested: 123

i386                   randconfig-a0-01120106
x86_64                 randconfig-a0-01121753
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
arm                         em_x270_defconfig
sh                         microdev_defconfig
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
parisc                        c8000_defconfig
powerpc                     akebono_defconfig
powerpc                          alldefconfig
sh                           se7619_defconfig
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
x86_64                 randconfig-s0-01121924
x86_64                 randconfig-s1-01121924
x86_64                 randconfig-s2-01121924
x86_64                           allmodconfig
x86_64                 randconfig-s3-01121927
x86_64                 randconfig-s4-01121927
x86_64                 randconfig-s5-01121927
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
x86_64                   randconfig-i0-201602
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         lpc18xx_defconfig
arm                         vf610m4_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201602
i386                     randconfig-i1-201602
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201602
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
