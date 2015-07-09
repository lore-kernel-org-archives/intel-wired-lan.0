From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 09 Jul 2015 15:41:33 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 40742350c8337701d968b75deaec747e9da2b58e BUILD DONE
Message-ID: <559e25ad.osjiwSQS0/Sjpx9V%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
40742350c8337701d968b75deaec747e9da2b58e  ixgbe: Avoid needless PHY access on copper phys

drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'

Error ids grouped by kconfigs:

recent_errors
??? i386-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size

elapsed time: 52m

configs tested: 95

i386                     randconfig-a0-201527
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-c0-07091338
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-v0-07091334
x86_64                            allnoconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201527
i386                   randconfig-b0-07091329
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201527
i386                             allyesconfig
x86_64                 randconfig-b0-07091325
i386                     randconfig-n0-201527
i386                     randconfig-n1-201527
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                                       mmp
arm                           tegra_defconfig
arm                                      arm5
arm                                     arm67
x86_64                                   rhel
x86_64                 randconfig-h0-07091309
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-07091347
x86_64               randconfig-x008-07081512
x86_64               randconfig-x001-07081512
x86_64               randconfig-x000-07081512
x86_64               randconfig-x003-07081512
x86_64               randconfig-x005-07081512
x86_64               randconfig-x009-07081512
x86_64               randconfig-x006-07081512
x86_64               randconfig-x002-07081512
x86_64               randconfig-x007-07081512
x86_64               randconfig-x004-07081512
x86_64                                    lkp
i386                     randconfig-r0-201527
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
x86_64                 randconfig-s0-07091324
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                 randconfig-x005-07090952
i386                 randconfig-x008-07090952
i386                 randconfig-x004-07090952
i386                 randconfig-x000-07090952
i386                 randconfig-x007-07090952
i386                 randconfig-x003-07090952
i386                 randconfig-x006-07090952
i386                 randconfig-x009-07090952
i386                 randconfig-x002-07090952
i386                 randconfig-x001-07090952
i386                   randconfig-x0-07091319

Thanks,
Fengguang
