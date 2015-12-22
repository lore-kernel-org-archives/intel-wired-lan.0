From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 23 Dec 2015 05:46:46 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 549017961178c82c69a7f157b88a7a26d9a7783e BUILD INCOMPLETE
Message-ID: <5679c4c6.s2wZLtDaCkN2rw3q%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
549017961178c82c69a7f157b88a7a26d9a7783e  ixgbevf: use bit operations for setting and checking resets

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? s390-allyesconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 14

alpha                            allyesconfig
blackfin                         allyesconfig
cris                             allyesconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allyesconfig
powerpc                          allyesconfig
sh                               allyesconfig
sparc64                          allyesconfig
sparc                            allyesconfig
tile                             allyesconfig
x86_64                           allyesconfig
xtensa                           allyesconfig

configs tested: 210

blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
m68k                             allmodconfig
mips                        qi_lb60_defconfig
i386                   randconfig-a0-12222034
x86_64                 randconfig-a0-12222338
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-12222229
i386                   randconfig-c0-12230005
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
blackfin                BF548-EZKIT_defconfig
mn10300                     asb2303_defconfig
um                             i386_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
i386                             allyesconfig
x86_64                 randconfig-v0-12222338
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
i386                             allmodconfig
microblaze                      mmu_defconfig
powerpc                   gef_ppc9a_defconfig
powerpc                         wii_defconfig
sh                             shx3_defconfig
alpha                            allmodconfig
arm                         mv78xx0_defconfig
ia64                         bigsur_defconfig
mips                          lasat_defconfig
sh                            shmin_defconfig
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
x86_64                 randconfig-s0-12222020
x86_64                 randconfig-s1-12222020
x86_64                 randconfig-s2-12222020
x86_64                 randconfig-s0-12222211
x86_64                 randconfig-s1-12222211
x86_64                 randconfig-s2-12222211
x86_64                 randconfig-s0-12222255
x86_64                 randconfig-s1-12222255
x86_64                 randconfig-s2-12222255
x86_64                 randconfig-s0-12222332
x86_64                 randconfig-s1-12222332
x86_64                 randconfig-s2-12222332
x86_64                 randconfig-s0-12230007
x86_64                 randconfig-s1-12230007
x86_64                 randconfig-s2-12230007
x86_64                 randconfig-s3-12222018
x86_64                 randconfig-s4-12222018
x86_64                 randconfig-s5-12222018
x86_64                 randconfig-s3-12222212
x86_64                 randconfig-s4-12222212
x86_64                 randconfig-s5-12222212
x86_64                 randconfig-s3-12222306
x86_64                 randconfig-s4-12222306
x86_64                 randconfig-s5-12222306
x86_64                 randconfig-s3-12222351
x86_64                 randconfig-s4-12222351
x86_64                 randconfig-s5-12222351
x86_64                 randconfig-s3-12230020
x86_64                 randconfig-s4-12230020
x86_64                 randconfig-s5-12230020
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201551
i386                   randconfig-b0-12222226
i386                   randconfig-b0-12222333
i386                   randconfig-b0-12230005
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         cm_x300_defconfig
arm                       cns3420vb_defconfig
m32r                    mappi.nommu_defconfig
openrisc                          allnoconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201551
i386                     randconfig-i1-201551
i386                   randconfig-i0-12222055
i386                   randconfig-i1-12222055
x86_64                 randconfig-b0-12222301
x86_64                 randconfig-b0-12222333
x86_64                 randconfig-b0-12230002
arm                         hackkit_defconfig
arm                      integrator_defconfig
ia64                             allmodconfig
x86_64                                    lkp
x86_64                                   rhel
i386                   randconfig-n0-12222029
i386                   randconfig-h0-12222318
i386                   randconfig-h1-12222318
i386                   randconfig-h0-12230003
i386                   randconfig-h1-12230003
arm                      jornada720_defconfig
mips                      pic32mzda_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
x86_64                 randconfig-h0-12222352
m68k                         apollo_defconfig
x86_64                 randconfig-n0-12222230
x86_64                 randconfig-n0-12222330
x86_64                 randconfig-n0-12230017
powerpc                     tqm8560_defconfig
tile                              allnoconfig
i386                  randconfig-sb0-12222229
i386                  randconfig-sb0-12222333
i386                  randconfig-sb0-12230018
arm                  colibri_pxa300_defconfig
powerpc                         ps3_defconfig
s390                             allyesconfig
x86_64                 randconfig-x000-201551
x86_64                 randconfig-x001-201551
x86_64                 randconfig-x002-201551
x86_64                 randconfig-x003-201551
x86_64                 randconfig-x004-201551
x86_64                 randconfig-x005-201551
x86_64                 randconfig-x006-201551
x86_64                 randconfig-x007-201551
x86_64                 randconfig-x008-201551
x86_64                 randconfig-x009-201551
i386                     randconfig-r0-201551
x86_64                 randconfig-r0-12222037
x86_64                 randconfig-r0-12222210
x86_64                 randconfig-r0-12222312
x86_64                 randconfig-r0-12222346
arm                      acs5k_tiny_defconfig
powerpc                       maple_defconfig
sh                          sdk7780_defconfig
i386                   randconfig-x008-201551
i386                   randconfig-x009-201551
i386                   randconfig-x003-201551
i386                   randconfig-x006-201551
i386                   randconfig-x001-201551
i386                   randconfig-x002-201551
i386                   randconfig-x000-201551
i386                   randconfig-x004-201551
i386                   randconfig-x007-201551
i386                   randconfig-x005-201551
i386                 randconfig-x000-12222106
i386                 randconfig-x001-12222106
i386                 randconfig-x002-12222106
i386                 randconfig-x003-12222106
i386                 randconfig-x004-12222106
i386                 randconfig-x005-12222106
i386                 randconfig-x006-12222106
i386                 randconfig-x007-12222106
i386                 randconfig-x008-12222106
i386                 randconfig-x009-12222106
i386                   randconfig-x0-12222158
i386                   randconfig-x0-12222338
i386                   randconfig-x0-12230013

Thanks,
Fengguang
