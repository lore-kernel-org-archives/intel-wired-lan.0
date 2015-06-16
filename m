From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 16 Jun 2015 19:25:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 6eca5840cdba9a6f8f710dc611eb29ee1bbab16e BUILD DONE
Message-ID: <558007ac.jmWDr5Op9+G19IKa%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6eca5840cdba9a6f8f710dc611eb29ee1bbab16e  ixgbe: Add support for VXLAN RX offloads

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4279:6: sparse: symbol 'ixgbe_clear_vxlan_port' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1467:5: sparse: symbol 'ixgbe_get_lcd_t_x550em' was not declared. Should it be static?
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:1504:5: sparse: symbol 'ixgbe_enter_lplu_t_x550em' was not declared. Should it be static?
net/core/rtnetlink.c:835:49: error: expected ';' before ')' token
net/core/rtnetlink.c:835:49: error: expected statement before ')' token
net/core/rtnetlink.c:835: error: expected ';' before ')' token
net/core/rtnetlink.c:835: error: expected statement before ')' token

error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? alpha-defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-arm5
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-arm67
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-at91_dt_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-at_hdmac
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-ep93xx
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-iop-adma
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-mmp
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-omap2plus_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-s3c2410_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-sa1100
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-samsung
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-sh
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? arm-tegra_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? avr32-atngw100_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? avr32-atstk1006_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? blackfin-BF526-EZBRD_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? blackfin-BF533-EZKIT_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? blackfin-BF561-EZKIT-SMP_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? blackfin-TCM-BF537_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? cris-etrax-100lx_v2_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? frv-defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-a0-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-i0-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-n0-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-n1-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-r0-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x000-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x001-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x002-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x003-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x004-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x005-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x006-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x007-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x008-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? i386-randconfig-x009-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? ia64-defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? m68k-amiga_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? m68k-multi_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? microblaze-mmu_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? microblaze-nommu_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? mn10300-asb2364_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? openrisc-or1ksim_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? parisc-c3000_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? parisc-defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? powerpc-defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? powerpc-ppc64_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? sh-rsk7269_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? sh-sh7785lcr_32bit_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? sh-titan_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? sparc-defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? tile-tilegx_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? um-i386_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? um-x86_64_defconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-acpi-redef
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:sparse:symbol-ixgbe_clear_vxlan_port-was-not-declared.-Should-it-be-static
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:sparse:symbol-ixgbe_enter_lplu_t_x550em-was-not-declared.-Should-it-be-static
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:sparse:symbol-ixgbe_get_lcd_t_x550em-was-not-declared.-Should-it-be-static
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-allyesconfig
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-allyesdebian
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-nfsroot
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-i0-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x000-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x001-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x002-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x003-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x004-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x005-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x006-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x007-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x008-201524
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-randconfig-x009-201524
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? x86_64-rhel
??? ??? net-core-rtnetlink.c:error:expected-before-)-token
??? ??? net-core-rtnetlink.c:error:expected-statement-before-)-token
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size

80 directories, 188 files

elapsed time: 64m

configs tested: 91

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201524
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
x86_64                            allnoconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201524
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i0-201524
i386                             allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201524
i386                     randconfig-n1-201524
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                                       mmp
arm                           tegra_defconfig
arm                                      arm5
arm                                     arm67
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                                    lkp
x86_64                                   rhel
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                 randconfig-x005-201524
x86_64                 randconfig-x006-201524
x86_64                 randconfig-x009-201524
x86_64                 randconfig-x000-201524
x86_64                 randconfig-x003-201524
x86_64                 randconfig-x007-201524
x86_64                 randconfig-x001-201524
x86_64                 randconfig-x002-201524
x86_64                 randconfig-x008-201524
x86_64                 randconfig-x004-201524
i386                     randconfig-r0-201524
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                           allmodconfig
i386                   randconfig-x006-201524
i386                   randconfig-x007-201524
i386                   randconfig-x002-201524
i386                   randconfig-x001-201524
i386                   randconfig-x000-201524
i386                   randconfig-x003-201524
i386                   randconfig-x005-201524
i386                   randconfig-x009-201524
i386                   randconfig-x008-201524
i386                   randconfig-x004-201524

Thanks,
Fengguang
