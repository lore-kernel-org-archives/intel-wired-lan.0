From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 18:01:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 bf499ec2d437ccc20d093e29b5502b0434d2b67e BUILD DONE
Message-ID: <557aadf9.4qROrV/IkIESRAPJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
bf499ec2d437ccc20d093e29b5502b0434d2b67e  e1000e: synchronization of MAC-PHY interface only on non- ME systems

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4279:6: sparse: symbol 'ixgbe_clear_vxlan_port' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1467:5: sparse: symbol 'ixgbe_get_lcd_t_x550em' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1504:5: sparse: symbol 'ixgbe_enter_lplu_t_x550em' was not declared. Should it be static?

elapsed time: 81m

configs tested: 148

m68k                       m5275evb_defconfig
m68k                       m5475evb_defconfig
powerpc                      acadia_defconfig
i386                     randconfig-a0-201523
x86_64                 randconfig-a0-06121626
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
i386                             allyesconfig
i386                   randconfig-c0-06121626
arm                          moxart_defconfig
powerpc                         c2k_defconfig
s390                             alldefconfig
blackfin                BF609-EZKIT_defconfig
m32r                     mappi3.smp_defconfig
s390                    performance_defconfig
arm                          prima2_defconfig
blackfin                  CM-BF537E_defconfig
openrisc                         alldefconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-06121656
x86_64                 randconfig-v0-06121725
x86_64                 randconfig-v0-06121736
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
arm                        neponset_defconfig
blackfin                          allnoconfig
powerpc                     asp8347_defconfig
sh                                allnoconfig
arm                          collie_defconfig
mn10300                             defconfig
sh                          sdk7786_defconfig
um                                allnoconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201523
i386                   randconfig-b0-06121642
i386                   randconfig-b0-06121721
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
mips                malta_kvm_guest_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      bamboo_defconfig
sh                      rts7751r2d1_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201523
x86_64                 randconfig-b0-06121652
x86_64                           allmodconfig
arm                            lart_defconfig
arm                       spear13xx_defconfig
i386                     randconfig-n0-201523
i386                     randconfig-n1-201523
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-06121656
i386                   randconfig-h1-06121656
arm                        spear3xx_defconfig
powerpc                     ep8248e_defconfig
powerpc                     redwood_defconfig
arm                        trizeps4_defconfig
avr32            atngw100_evklcd101_defconfig
blackfin                    DNP5370_defconfig
frv                                 defconfig
parisc                         b180_defconfig
x86_64                 randconfig-h0-06121659
x86_64                 randconfig-h0-06121728
x86_64                 randconfig-h0-06121742
x86_64                                    lkp
x86_64                                   rhel
x86_64                 randconfig-n0-06121659
x86_64                 randconfig-n0-06121738
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
blackfin                  TCM-BF518_defconfig
ia64                            zx1_defconfig
mn10300                           allnoconfig
m68k                          amiga_defconfig
m68k                          multi_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                  randconfig-sb0-06121654
i386                  randconfig-sb0-06121729
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
x86_64                 randconfig-r0-06121624
alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                 randconfig-s0-06121642
x86_64                 randconfig-s0-06121721
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
i386                   randconfig-x0-06121643

Thanks,
Fengguang
