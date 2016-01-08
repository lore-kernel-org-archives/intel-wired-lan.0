From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 08 Jan 2016 21:56:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 37ac0b2240aed49d6ce9cb3bdf8d28ff11260ba9 BUILD DONE
Message-ID: <568fbff4.yZgozxI+9qpuPSeg%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
37ac0b2240aed49d6ce9cb3bdf8d28ff11260ba9  igb: When GbE link up, wait for Remote receiver status condition.

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 43m

configs tested: 107

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
x86_64               randconfig-x017-01041832
x86_64               randconfig-x011-01041832
x86_64               randconfig-x015-01041832
x86_64               randconfig-x010-01041832
x86_64               randconfig-x016-01041832
x86_64               randconfig-x013-01041832
x86_64               randconfig-x018-01041832
x86_64               randconfig-x019-01041832
x86_64               randconfig-x012-01041832
x86_64               randconfig-x014-01041832
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201601
i386                     randconfig-s1-201601
x86_64                           allmodconfig
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
x86_64                   randconfig-i0-201601
i386                   randconfig-b0-01082041
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201601
i386                     randconfig-i1-201601
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                               tinyconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201601
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
x86_64               randconfig-x006-01060743
x86_64               randconfig-x001-01060743
x86_64               randconfig-x009-01060743
x86_64               randconfig-x002-01060743
x86_64               randconfig-x007-01060743
x86_64               randconfig-x000-01060743
x86_64               randconfig-x005-01060743
x86_64               randconfig-x008-01060743
x86_64               randconfig-x003-01060743
x86_64               randconfig-x004-01060743
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201601
i386                 randconfig-x005-01040616
i386                 randconfig-x003-01040616
i386                 randconfig-x002-01040616
i386                 randconfig-x001-01040616
i386                 randconfig-x008-01040616
i386                 randconfig-x000-01040616
i386                 randconfig-x009-01040616
i386                 randconfig-x006-01040616
i386                 randconfig-x004-01040616
i386                 randconfig-x007-01040616

Thanks,
Fengguang
