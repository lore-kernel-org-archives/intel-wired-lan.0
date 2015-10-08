From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 09 Oct 2015 06:15:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 cbb2e5d35cd7c39f32cb704fa1253d9e63ab488b BUILD DONE
Message-ID: <5616eb1a.57/c0BThOiDHHKzo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
cbb2e5d35cd7c39f32cb704fa1253d9e63ab488b  i40e: re-use %*ph specifier to hexdump a data

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:17: warning: 'oudph' may be used uninitialized in this function [-Wuninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:37: warning: 'oiph' may be used uninitialized in this function [-Wuninitialized]

Error ids grouped by kconfigs:

recent_errors
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 40m

configs tested: 131

i386                     randconfig-a0-201540
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
powerpc                      pcm030_defconfig
powerpc                     tqm8541_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                                allnoconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201540
x86_64                 randconfig-x019-201540
x86_64                 randconfig-x014-201540
x86_64                 randconfig-x018-201540
x86_64                 randconfig-x016-201540
x86_64                 randconfig-x011-201540
x86_64                 randconfig-x010-201540
x86_64                 randconfig-x013-201540
x86_64                 randconfig-x017-201540
x86_64                 randconfig-x012-201540
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s1-201540
i386                     randconfig-s0-201540
x86_64                 randconfig-s3-10090522
x86_64                 randconfig-s4-10090522
x86_64                 randconfig-s5-10090522
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201540
i386                   randconfig-b0-10090530
arm                           corgi_defconfig
powerpc                        icon_defconfig
sh                     sh7710voipgw_defconfig
sparc                             allnoconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201540
i386                     randconfig-i0-201540
x86_64                 randconfig-b0-10090528
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
microblaze                       allmodconfig
sh                           se7721_defconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201540
i386                   randconfig-h0-10090336
i386                   randconfig-h1-10090336
x86_64                 randconfig-h0-10090439
arm                                    sa1100
arm                          prima2_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
x86_64                 randconfig-x002-201540
x86_64                 randconfig-x009-201540
x86_64                 randconfig-x003-201540
x86_64                 randconfig-x000-201540
x86_64                 randconfig-x004-201540
x86_64                 randconfig-x001-201540
x86_64                 randconfig-x006-201540
x86_64                 randconfig-x007-201540
x86_64                 randconfig-x008-201540
x86_64                 randconfig-x005-201540
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201540
x86_64                 randconfig-r0-10090345
i386                   randconfig-x004-201540
i386                   randconfig-x009-201540
i386                   randconfig-x003-201540
i386                   randconfig-x007-201540
i386                   randconfig-x006-201540
i386                   randconfig-x005-201540
i386                   randconfig-x008-201540
i386                   randconfig-x002-201540
i386                   randconfig-x001-201540
i386                   randconfig-x000-201540
i386                   randconfig-x0-10090449

Thanks,
Fengguang
