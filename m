From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 20:19:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 92e1c6333beee2ca6fbb8c4e461a94d33255701e BUILD DONE
Message-ID: <557ace4d.yWLZMCHqYhpceqql%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
92e1c6333beee2ca6fbb8c4e461a94d33255701e  e1000e: i219 - Increase minimum FIFO read/write min gap

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/e1000e/netdev.c:6454:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
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

elapsed time: 77m

configs tested: 162

arm                          ks8695_defconfig
arm                            lart_defconfig
sparc                       sparc64_defconfig
i386                     randconfig-a0-201523
x86_64                 randconfig-a0-06121839
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-c0-06121858
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
mips                      maltasmvp_defconfig
powerpc                   currituck_defconfig
sparc                             allnoconfig
parisc                generic-32bit_defconfig
um                                  defconfig
um                           x86_64_defconfig
avr32            atngw100_evklcd101_defconfig
blackfin                    DNP5370_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           sunxi_defconfig
m32r                       m32104ut_defconfig
powerpc                     tqm8548_defconfig
blackfin                BF533-STAMP_defconfig
mips                       bmips_be_defconfig
powerpc                      pmac32_defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-v0-06121908
x86_64                 randconfig-v0-06121930
x86_64                 randconfig-v0-06121942
x86_64                 randconfig-v0-06121958
x86_64                            allnoconfig
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
m32r                       mappi.up_defconfig
microblaze                       allmodconfig
parisc                      default_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201523
i386                   randconfig-b0-06121853
i386                   randconfig-b0-06121939
i386                   randconfig-b0-06121954
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
blackfin          BF527-AD7160-EVAL_defconfig
blackfin                BF548-EZKIT_defconfig
mips                       markeins_defconfig
parisc                           allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201523
i386                             allyesconfig
x86_64                 randconfig-b0-06121907
x86_64                 randconfig-b0-06121941
x86_64                 randconfig-b0-06122002
blackfin                BF533-EZKIT_defconfig
ia64                            sim_defconfig
microblaze                          defconfig
powerpc                     mpc512x_defconfig
arm                            zeus_defconfig
m32r                    m32700ut.up_defconfig
powerpc                     ep8248e_defconfig
sh                          lboxre2_defconfig
i386                     randconfig-n0-201523
i386                     randconfig-n1-201523
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-06121847
i386                   randconfig-h1-06121847
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
arm                             mxs_defconfig
parisc                         b180_defconfig
sh                          sdk7786_defconfig
x86_64                 randconfig-h0-06121901
x86_64                 randconfig-h0-06121951
x86_64                                   rhel
x86_64                 randconfig-n0-06121852
x86_64                 randconfig-n0-06121917
x86_64                 randconfig-n0-06121927
x86_64                 randconfig-n0-06121946
x86_64                 randconfig-n0-06122005
arm                          nuc960_defconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_mds_defconfig
sh                          rsk7264_defconfig
powerpc64                         allnoconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-06121905
i386                  randconfig-sb0-06121932
i386                  randconfig-sb0-06121958
x86_64                           allmodconfig
arm                          iop33x_defconfig
arm                           omap1_defconfig
powerpc                 mpc8540_ads_defconfig
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
x86_64                                    lkp
i386                     randconfig-r0-201523
x86_64                 randconfig-r0-06121843
x86_64                 randconfig-r0-06121950
alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
m68k                          amiga_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
x86_64                 randconfig-s0-06121854
x86_64                 randconfig-s0-06121933
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
i386                   randconfig-x0-06121842

Thanks,
Fengguang
