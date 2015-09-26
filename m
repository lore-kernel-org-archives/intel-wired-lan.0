From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 26 Sep 2015 11:11:07 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 851348a35fa19d622e56a6b4e087fdcff4d44f90 BUILD DONE
Message-ID: <56060ccb.rjZXH2nNTTv/rHmk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
851348a35fa19d622e56a6b4e087fdcff4d44f90  i40e: Fix RS bit update in Tx path and disable force WB workaround

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2293:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2293:17: warning: 'oudph' may be used uninitialized in this function [-Wuninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2293:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2293:37: warning: 'oiph' may be used uninitialized in this function [-Wuninitialized]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 60m

configs tested: 70

i386                     randconfig-a0-201538
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
sh                                  defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                   randconfig-s1-09261031
i386                   randconfig-s0-09261031
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                             allmodconfig
x86_64                   randconfig-i0-201538
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201538
i386                     randconfig-i0-201538
x86_64                 randconfig-b0-09260814
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
i386                     randconfig-n0-201538
i386                   randconfig-h0-09260819
i386                   randconfig-h1-09260819
ia64                              allnoconfig
ia64                             alldefconfig
x86_64                                   rhel
x86_64                 randconfig-h0-09260813
i386                  randconfig-sb0-09260745
x86_64               randconfig-x007-09251258
x86_64               randconfig-x001-09251258
x86_64               randconfig-x008-09251258
x86_64               randconfig-x009-09251258
x86_64               randconfig-x002-09251258
x86_64               randconfig-x004-09251258
x86_64               randconfig-x003-09251258
x86_64               randconfig-x000-09251258
x86_64               randconfig-x006-09251258
x86_64               randconfig-x005-09251258
i386                     randconfig-r0-201538

Thanks,
Fengguang
