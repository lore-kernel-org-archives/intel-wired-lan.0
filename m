From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 13 Jun 2015 08:47:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 06e361dadb1d39bfcee0398fb0f5b1749b97f12a BUILD DONE
Message-ID: <557b7da1.XdmOBrPkrX/+8los%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
06e361dadb1d39bfcee0398fb0f5b1749b97f12a  ixgbe: Add support for VXLAN RX offloads

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/e1000e/netdev.c:6454:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4279:6: sparse: symbol 'ixgbe_clear_vxlan_port' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1467:5: sparse: symbol 'ixgbe_get_lcd_t_x550em' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1504:5: sparse: symbol 'ixgbe_enter_lplu_t_x550em' was not declared. Should it be static?

elapsed time: 101m

configs tested: 106

i386                     randconfig-a0-201523
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
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
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-06130830
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
arm                         bcm2835_defconfig
mips                          ath79_defconfig
powerpc                     pseries_defconfig
sh                        sh7763rdp_defconfig
arm                      footbridge_defconfig
avr32                            alldefconfig
sh                         microdev_defconfig
sparc64                             defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201523
i386                   randconfig-b0-06130817
i386                   randconfig-b0-06130828
i386                   randconfig-b0-06130838
sparc                               defconfig
sparc64                           allnoconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-06130823
x86_64                           allmodconfig
x86_64                            allnoconfig
x86_64                                    lkp
i386                     randconfig-n0-201523
i386                     randconfig-n1-201523
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                             allyesconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                                   rhel
x86_64                 randconfig-h0-06130822
x86_64                 randconfig-n0-06130823
x86_64                 randconfig-n0-06130832
m68k                          amiga_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
x86_64               randconfig-x009-06112155
x86_64               randconfig-x000-06112155
x86_64               randconfig-x004-06112155
x86_64               randconfig-x005-06112155
x86_64               randconfig-x003-06112155
x86_64               randconfig-x001-06112155
x86_64               randconfig-x006-06112155
x86_64               randconfig-x002-06112155
x86_64               randconfig-x007-06112155
x86_64               randconfig-x008-06112155
i386                     randconfig-r0-201523
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
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                 randconfig-x001-06110847
i386                 randconfig-x003-06110847
i386                 randconfig-x000-06110847
i386                 randconfig-x008-06110847
i386                 randconfig-x006-06110847
i386                 randconfig-x007-06110847
i386                 randconfig-x005-06110847
i386                 randconfig-x009-06110847
i386                 randconfig-x004-06110847
i386                 randconfig-x002-06110847

Thanks,
Fengguang
