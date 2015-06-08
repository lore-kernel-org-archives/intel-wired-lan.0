From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 09 Jun 2015 03:50:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 dae07df8ad03f5ba72833f34496de0d3ecba626c BUILD DONE
Message-ID: <5575f1f8.W6K8W72CMBaiUma5%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
dae07df8ad03f5ba72833f34496de0d3ecba626c  ixgbe: Remember to write ixfi changes after modifying

drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1233:5: sparse: symbol 'ixgbe_handle_lasi_ext_t_x550em' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1381:5: sparse: symbol 'ixgbe_setup_internal_phy_t_x550em' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:891:5: sparse: symbol 'ixgbe_setup_mac_link_t_X550em' was not declared. Should it be static?

elapsed time: 108m

configs tested: 101

i386                     randconfig-a0-201523
i386                             allyesconfig
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
mips                        msp71xx_defconfig
powerpc                          alldefconfig
xtensa                           allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-06090241
x86_64                 randconfig-v0-06090304
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i1-201523
x86_64                   randconfig-i0-201523
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201523
i386                     randconfig-i1-201523
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                            allnoconfig
i386                     randconfig-n0-201523
i386                     randconfig-n1-201523
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                                   rhel
x86_64                 randconfig-h0-06090226
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                       spear13xx_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
x86_64               randconfig-x002-06031659
x86_64               randconfig-x004-06031659
x86_64               randconfig-x006-06031659
x86_64               randconfig-x005-06031659
x86_64               randconfig-x007-06031659
x86_64               randconfig-x009-06031659
x86_64               randconfig-x003-06031659
x86_64               randconfig-x008-06031659
x86_64               randconfig-x001-06031659
x86_64               randconfig-x000-06031659
i386                     randconfig-r0-201523
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                           h3600_defconfig
m68k                             allmodconfig
sh                        apsh4ad0a_defconfig
x86_64                 randconfig-s0-06081828
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                 randconfig-x009-06031736
i386                 randconfig-x008-06031736
i386                 randconfig-x003-06031736
i386                 randconfig-x005-06031736
i386                 randconfig-x007-06031736
i386                 randconfig-x002-06031736
i386                 randconfig-x004-06031736
i386                 randconfig-x006-06031736
i386                 randconfig-x001-06031736
i386                 randconfig-x000-06031736

Thanks,
Fengguang
