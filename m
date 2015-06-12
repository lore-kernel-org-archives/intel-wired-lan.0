From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 12 Jun 2015 12:51:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 3b9a14f8368be49d9a07dbdcfcf6ff1cc92f9c85 BUILD DONE
Message-ID: <557a6540.Ia5081z/83EhWgvw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
3b9a14f8368be49d9a07dbdcfcf6ff1cc92f9c85  ixgbe: Add support for VXLAN RX offloads

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

elapsed time: 128m

configs tested: 236

i386                     randconfig-a0-201523
x86_64                            allnoconfig
i386                   randconfig-c0-06121118
i386                   randconfig-c0-06121145
i386                   randconfig-c0-06121211
i386                   randconfig-c0-06121239
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
mips                       markeins_defconfig
mips                          sead3_defconfig
arm                      footbridge_defconfig
arm                           kzm9g_defconfig
ia64                                defconfig
arm                      acs5k_tiny_defconfig
microblaze                    nommu_defconfig
powerpc               corenet32_smp_defconfig
frv                              alldefconfig
m32r                   m32700ut.smp_defconfig
sh                          r7780mp_defconfig
arm                          moxart_defconfig
m68k                       m5208evb_defconfig
powerpc                  mpc885_ads_defconfig
arm                           corgi_defconfig
arm                         shannon_defconfig
sh                           se7343_defconfig
arm                          ixp4xx_defconfig
arm                       mainstone_defconfig
mips                      malta_kvm_defconfig
arm                         orion5x_defconfig
arm64                             allnoconfig
powerpc                     redwood_defconfig
i386                              allnoconfig
mn10300                          allmodconfig
powerpc                 mpc8540_ads_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-06121121
x86_64                 randconfig-v0-06121136
x86_64                 randconfig-v0-06121153
x86_64                 randconfig-v0-06121210
x86_64                 randconfig-v0-06121219
x86_64                 randconfig-v0-06121225
x86_64                 randconfig-v0-06121231
x86_64                 randconfig-v0-06121238
x86_64                 randconfig-v0-06121243
arm                           u8500_defconfig
blackfin              BF561-ACVILON_defconfig
m68k                          hp300_defconfig
arm                           omap1_defconfig
avr32            atngw100_evklcd100_defconfig
mips                        maltaup_defconfig
sh                          lboxre2_defconfig
arm                       imx_v4_v5_defconfig
parisc                      default_defconfig
powerpc                     ep8248e_defconfig
sparc64                             defconfig
x86_64                   randconfig-i0-201523
i386                   randconfig-b0-06121128
i386                   randconfig-b0-06121150
i386                   randconfig-b0-06121200
arm                       cns3420vb_defconfig
arm                         em_x270_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      tqm8xx_defconfig
arm                         lpc18xx_defconfig
powerpc                     mpc86xx_defconfig
sh                        sh7763rdp_defconfig
sh                          urquell_defconfig
mips                  mips_paravirt_defconfig
powerpc                       eiger_defconfig
tile                             alldefconfig
xtensa                generic_kc705_defconfig
m68k                           sun3_defconfig
mips                           ip27_defconfig
microblaze                      mmu_defconfig
i386                     randconfig-i0-201523
i386                             allyesconfig
x86_64                 randconfig-b0-06121119
x86_64                 randconfig-b0-06121158
x86_64                 randconfig-b0-06121221
x86_64                 randconfig-b0-06121231
x86_64                 randconfig-b0-06121236
x86_64                 randconfig-b0-06121242
sparc                               defconfig
sparc64                           allnoconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201523
i386                     randconfig-n1-201523
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                                       mmp
arm                           tegra_defconfig
arm                                      arm5
arm                                     arm67
i386                   randconfig-h0-06121120
i386                   randconfig-h1-06121120
i386                   randconfig-h0-06121141
i386                   randconfig-h1-06121141
i386                   randconfig-h0-06121156
i386                   randconfig-h1-06121156
i386                   randconfig-h0-06121242
i386                   randconfig-h1-06121242
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
arm                     davinci_all_defconfig
powerpc64                         allnoconfig
mn10300                           allnoconfig
avr32        atngw100mkii_evklcd100_defconfig
powerpc                      acadia_defconfig
powerpc                     ksi8560_defconfig
arm                        spear3xx_defconfig
avr32                       favr-32_defconfig
sh                            hp6xx_defconfig
arm64                            alldefconfig
m68k                        m5307c3_defconfig
microblaze                        allnoconfig
arm                      integrator_defconfig
openrisc                         allmodconfig
x86_64                 randconfig-h0-06121118
x86_64                 randconfig-h0-06121135
x86_64                 randconfig-h0-06121150
x86_64                 randconfig-h0-06121203
x86_64                 randconfig-h0-06121216
x86_64                 randconfig-n0-06121123
x86_64                 randconfig-n0-06121138
x86_64                 randconfig-n0-06121145
x86_64                 randconfig-n0-06121153
x86_64                 randconfig-n0-06121210
x86_64                 randconfig-n0-06121222
x86_64                 randconfig-n0-06121246
mips                         tb0226_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     tqm8540_defconfig
arm                           h5000_defconfig
powerpc                     kmeter1_defconfig
powerpc                      ppc64e_defconfig
blackfin                      H8606_defconfig
mips                     sead3micro_defconfig
um                               alldefconfig
alpha                               defconfig
arm                          ep93xx_defconfig
s390                    performance_defconfig
powerpc                 linkstation_defconfig
arm                       spear13xx_defconfig
mips                           ls1b_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-06121120
i386                  randconfig-sb0-06121130
i386                  randconfig-sb0-06121152
i386                  randconfig-sb0-06121158
i386                  randconfig-sb0-06121220
i386                  randconfig-sb0-06121226
i386                  randconfig-sb0-06121232
i386                  randconfig-sb0-06121240
powerpc                  gef_sbc610_defconfig
sh                   sh7770_generic_defconfig
arm                         cm_x2xx_defconfig
arm                        magician_defconfig
arm64                               defconfig
parisc                         b180_defconfig
powerpc64                           defconfig
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
ia64                              allnoconfig
ia64                             alldefconfig
i386                     randconfig-r0-201523
x86_64                 randconfig-r0-06121123
x86_64                 randconfig-r0-06121139
x86_64                 randconfig-r0-06121157
x86_64                 randconfig-r0-06121244
parisc                        c3000_defconfig
parisc                              defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
powerpc                mpc8610_hpcd_defconfig
arm                          marzen_defconfig
arm                            netx_defconfig
m32r                        oaks32r_defconfig
powerpc                     mpc5200_defconfig
sh                             sh03_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
x86_64                 randconfig-s0-06121117
x86_64                 randconfig-s0-06121146
x86_64                 randconfig-s0-06121226
x86_64                           allmodconfig
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
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
