From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 21 Oct 2015 09:28:14 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 b4ad5997d4a1e8456cda59dac1e9c9fd8983ec97 BUILD DONE
Message-ID: <5626ea2e.TQg04hWI9yzK+Ghk%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
b4ad5997d4a1e8456cda59dac1e9c9fd8983ec97  fm10k: Add support for ITR scaling based on PCIe link speed

drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1753:2: error: too many arguments to function 'fm10k_dcbnl_set_ops'
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? i386-randconfig-a0-201542
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_pci.c:error:too-many-arguments-to-function-fm10k_dcbnl_set_ops
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 47m

configs tested: 107

i386                     randconfig-a0-201542
x86_64                            allnoconfig
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
x86_64                 randconfig-x015-201542
x86_64                 randconfig-x019-201542
x86_64                 randconfig-x014-201542
x86_64                 randconfig-x016-201542
x86_64                 randconfig-x018-201542
x86_64                 randconfig-x011-201542
x86_64                 randconfig-x010-201542
x86_64                 randconfig-x013-201542
x86_64                 randconfig-x017-201542
x86_64                 randconfig-x012-201542
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201542
i386                     randconfig-s1-201542
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
x86_64                   randconfig-i0-201542
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201542
i386                     randconfig-i1-201542
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                     randconfig-n0-201542
x86_64                                    lkp
x86_64                                   rhel
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-x002-201542
x86_64                 randconfig-x009-201542
x86_64                 randconfig-x003-201542
x86_64                 randconfig-x000-201542
x86_64                 randconfig-x004-201542
x86_64                 randconfig-x001-201542
x86_64                 randconfig-x006-201542
x86_64                 randconfig-x007-201542
x86_64                 randconfig-x005-201542
x86_64                 randconfig-x008-201542
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201542
i386                 randconfig-x007-10191220
i386                 randconfig-x004-10191220
i386                 randconfig-x000-10191220
i386                 randconfig-x006-10191220
i386                 randconfig-x003-10191220
i386                 randconfig-x009-10191220
i386                 randconfig-x008-10191220
i386                 randconfig-x005-10191220
i386                 randconfig-x002-10191220
i386                 randconfig-x001-10191220

Thanks,
Fengguang
