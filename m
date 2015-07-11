From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 12 Jul 2015 04:55:11 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 98da077ad23d488ddd9868e055043bd31f144e13 BUILD DONE
Message-ID: <55a182af.e3HGFZa9qWQUupR6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
98da077ad23d488ddd9868e055043bd31f144e13  ixgbe: Avoid needless PHY access on copper phys

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/e1000e/netdev.c:6454:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? frv-allmodconfig
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-c0-07112102
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? i386-randconfig-c0-07112122
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-c0-07120105
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-c0-07120350
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-h1-07112108
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? i386-randconfig-sb0-07112100
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-sb0-07112127
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? i386-randconfig-sb0-07120211
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-sb0-07120410
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? i386-randconfig-x003-07111123
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? i386-randconfig-x004-07111123
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-x0-07112236
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? i386-randconfig-x0-07112359
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? microblaze-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? microblaze-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? powerpc-corenet32_smp_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? powerpc-corenet64_smp_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? powerpc-currituck_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? sparc-sparc64_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-h0-07120255
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-r0-07120416
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-v0-07120405
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-x002-07111123
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-x003-07111123
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-x004-07111123
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size

elapsed time: 582m

configs tested: 706

m68k                          sun3x_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                    socrates_defconfig
m32r                         opsput_defconfig
powerpc                             defconfig
sh                          polaris_defconfig
avr32                  atngw100mkii_defconfig
blackfin                BF526-EZBRD_defconfig
sparc64                          alldefconfig
arm                          iop33x_defconfig
m32r                       m32104ut_defconfig
mips                        workpad_defconfig
avr32                    hammerhead_defconfig
ia64                         bigsur_defconfig
sh                          rsk7201_defconfig
m68k                       bvme6000_defconfig
mips                        jmr3927_defconfig
powerpc                    klondike_defconfig
arm                         mv78xx0_defconfig
sh                            shmin_defconfig
alpha                            alldefconfig
arm                           acs5k_defconfig
powerpc                 mpc8272_ads_defconfig
arm                                 defconfig
arm                           u8500_defconfig
avr32                        merisc_defconfig
blackfin              BF561-ACVILON_defconfig
mips                malta_kvm_guest_defconfig
ia64                            zx1_defconfig
powerpc                      makalu_defconfig
sh                           se7712_defconfig
arm                               allnoconfig
m68k                       m5208evb_defconfig
mips                       rbtx49xx_defconfig
openrisc                            defconfig
sh                          landisk_defconfig
sh                   rts7751r2dplus_defconfig
avr32                               defconfig
m32r                   m32700ut.smp_defconfig
mips                     decstation_defconfig
x86_64                           alldefconfig
arm                          pxa168_defconfig
powerpc                mpc8641_hpcn_defconfig
arm                              allmodconfig
ia64                              allnoconfig
powerpc                      cm5200_defconfig
i386                     randconfig-a0-201527
x86_64                 randconfig-a0-07112012
x86_64                 randconfig-a0-07112052
x86_64                 randconfig-a0-07112111
x86_64                 randconfig-a0-07112123
x86_64                 randconfig-a0-07112135
x86_64                 randconfig-a0-07112146
x86_64                 randconfig-a0-07112203
x86_64                 randconfig-a0-07112236
x86_64                 randconfig-a0-07112247
x86_64                 randconfig-a0-07112258
x86_64                 randconfig-a0-07112319
x86_64                 randconfig-a0-07120019
x86_64                 randconfig-a0-07120207
x86_64                 randconfig-a0-07120309
x86_64                 randconfig-a0-07120333
x86_64                 randconfig-a0-07120410
x86_64                 randconfig-a0-07120434
x86_64                            allnoconfig
arm                             mxs_defconfig
arm                         s3c2410_defconfig
mips                          malta_defconfig
arm                      tct_hammer_defconfig
parisc                      default_defconfig
xtensa                  audio_kc705_defconfig
arm                            qcom_defconfig
powerpc               corenet64_smp_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          r7780mp_defconfig
sparc                       sparc64_defconfig
arm                          moxart_defconfig
blackfin                BF537-STAMP_defconfig
arm                        cerfcube_defconfig
powerpc                     akebono_defconfig
powerpc                      ppc44x_defconfig
arm                       omap2plus_defconfig
m68k                          hp300_defconfig
parisc                            allnoconfig
alpha                            allyesconfig
openrisc                    or1ksim_defconfig
arm                          pxa910_defconfig
powerpc                   lite5200b_defconfig
powerpc                      ppc6xx_defconfig
openrisc                         allyesconfig
powerpc                    sbc8641d_defconfig
arm                         vf610m4_defconfig
ia64                                defconfig
powerpc                     mpc85xx_defconfig
arm                       imx_v6_v7_defconfig
blackfin                          allnoconfig
sh                           se7724_defconfig
xtensa                            allnoconfig
mn10300                          allmodconfig
powerpc                       eiger_defconfig
arm                        spear3xx_defconfig
blackfin                  TCM-BF518_defconfig
powerpc64                         allnoconfig
openrisc                          allnoconfig
s390                           gcov_defconfig
tile                         tilegx_defconfig
blackfin                BF609-EZKIT_defconfig
mips                           ls1b_defconfig
openrisc                         allmodconfig
parisc                generic-32bit_defconfig
sh                               alldefconfig
arm                            u300_defconfig
mips                         bigsur_defconfig
sh                   sh7724_generic_defconfig
arm                      pxa255-idp_defconfig
m68k                             alldefconfig
sh                           se7721_defconfig
sh                             sh03_defconfig
mips                                defconfig
powerpc                     virtex5_defconfig
s390                             allmodconfig
arm                        mvebu_v7_defconfig
avr32                     atstk1006_defconfig
sh                     sh7710voipgw_defconfig
arm64                            allmodconfig
blackfin                   CM-BF548_defconfig
mips                          rm200_defconfig
i386                             allyesconfig
i386                   randconfig-c0-07112030
i386                   randconfig-c0-07112041
i386                   randconfig-c0-07112049
i386                   randconfig-c0-07112102
i386                   randconfig-c0-07112122
i386                   randconfig-c0-07112137
i386                   randconfig-c0-07112151
i386                   randconfig-c0-07112205
i386                   randconfig-c0-07112236
i386                   randconfig-c0-07112255
i386                   randconfig-c0-07112308
i386                   randconfig-c0-07112324
i386                   randconfig-c0-07112339
i386                   randconfig-c0-07112352
i386                   randconfig-c0-07120010
i386                   randconfig-c0-07120030
i386                   randconfig-c0-07120046
i386                   randconfig-c0-07120105
i386                   randconfig-c0-07120127
i386                   randconfig-c0-07120142
i386                   randconfig-c0-07120155
i386                   randconfig-c0-07120218
i386                   randconfig-c0-07120234
i386                   randconfig-c0-07120254
i386                   randconfig-c0-07120306
i386                   randconfig-c0-07120317
i386                   randconfig-c0-07120329
i386                   randconfig-c0-07120350
i386                   randconfig-c0-07120413
i386                   randconfig-c0-07120431
arm                                    sa1100
arm                         at91_dt_defconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
avr32                     atstk1004_defconfig
powerpc                          allmodconfig
sh                           se7722_defconfig
m32r                    mappi.nommu_defconfig
powerpc                       ebony_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip27_defconfig
powerpc                      tqm8xx_defconfig
arm                      footbridge_defconfig
mips                          lasat_defconfig
powerpc               corenet32_smp_defconfig
sh                        dreamcast_defconfig
arm                        multi_v7_defconfig
arm                         shannon_defconfig
mips                          ath79_defconfig
arm                            mmp2_defconfig
ia64                             alldefconfig
powerpc                       maple_defconfig
arm64                             allnoconfig
m68k                       m5475evb_defconfig
mips                  maltasmvp_eva_defconfig
arm                            lart_defconfig
avr32            atngw100_evklcd100_defconfig
ia64                      gensparse_defconfig
arm                           sunxi_defconfig
arm64                            allyesconfig
sh                               allyesconfig
arm                         lubbock_defconfig
arm                          nuc910_defconfig
m68k                          atari_defconfig
powerpc                  mpc885_ads_defconfig
arm                          badge4_defconfig
arm                             rpc_defconfig
powerpc                   gef_ppc9a_defconfig
mips                         tb0219_defconfig
s390                    performance_defconfig
blackfin               BF518F-EZBRD_defconfig
powerpc                     tqm8560_defconfig
powerpc64                           defconfig
powerpc                   currituck_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-07112014
x86_64                 randconfig-v0-07112032
x86_64                 randconfig-v0-07112052
x86_64                 randconfig-v0-07112111
x86_64                 randconfig-v0-07112124
x86_64                 randconfig-v0-07112132
x86_64                 randconfig-v0-07112145
x86_64                 randconfig-v0-07112157
x86_64                 randconfig-v0-07112208
x86_64                 randconfig-v0-07112237
x86_64                 randconfig-v0-07112250
x86_64                 randconfig-v0-07112307
x86_64                 randconfig-v0-07112317
x86_64                 randconfig-v0-07112337
x86_64                 randconfig-v0-07120015
x86_64                 randconfig-v0-07120126
x86_64                 randconfig-v0-07120135
x86_64                 randconfig-v0-07120201
x86_64                 randconfig-v0-07120226
x86_64                 randconfig-v0-07120245
x86_64                 randconfig-v0-07120305
x86_64                 randconfig-v0-07120314
x86_64                 randconfig-v0-07120331
x86_64                 randconfig-v0-07120405
x86_64                 randconfig-v0-07120416
x86_64                 randconfig-v0-07120429
x86_64                 randconfig-v0-07120442
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
powerpc                    sam440ep_defconfig
blackfin                BF527-EZKIT_defconfig
blackfin                  TCM-BF537_defconfig
mips                             alldefconfig
arm                        mini2440_defconfig
arm                         palmz72_defconfig
powerpc                     mpc512x_defconfig
sh                          lboxre2_defconfig
arm                           stm32_defconfig
powerpc                     tqm8555_defconfig
sh                 kfr2r09-romimage_defconfig
arm                      integrator_defconfig
powerpc                 mpc8560_ads_defconfig
m32r                       mappi.up_defconfig
parisc                         b180_defconfig
sh                   secureedge5410_defconfig
arm                       netwinder_defconfig
mips                        bcm47xx_defconfig
powerpc                     mpc83xx_defconfig
sh                         microdev_defconfig
blackfin                       SRV1_defconfig
arm                  colibri_pxa270_defconfig
parisc                              defconfig
avr32        atngw100mkii_evklcd100_defconfig
parisc                           allmodconfig
powerpc                          alldefconfig
powerpc                       ep405_defconfig
blackfin                  CM-BF537U_defconfig
mips                            e55_defconfig
blackfin                         alldefconfig
s390                        default_defconfig
blackfin                   CM-BF533_defconfig
m68k                       m5249evb_defconfig
ia64                        generic_defconfig
parisc                         a500_defconfig
ia64                          tiger_defconfig
m68k                        mvme16x_defconfig
microblaze                       allmodconfig
powerpc                 mpc837x_rdb_defconfig
arm                           bockw_defconfig
arm                        vexpress_defconfig
blackfin                BF538-EZKIT_defconfig
mips                        maltaup_defconfig
mips                        qi_lb60_defconfig
powerpc                     sbc834x_defconfig
powerpc                         wii_defconfig
um                               alldefconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201527
i386                   randconfig-b0-07112027
i386                   randconfig-b0-07112040
i386                   randconfig-b0-07112054
i386                   randconfig-b0-07112112
i386                   randconfig-b0-07112126
i386                   randconfig-b0-07112139
i386                   randconfig-b0-07112200
i386                   randconfig-b0-07112213
i386                   randconfig-b0-07112235
i386                   randconfig-b0-07112248
i386                   randconfig-b0-07112258
i386                   randconfig-b0-07112308
i386                   randconfig-b0-07112328
i386                   randconfig-b0-07112349
i386                   randconfig-b0-07120014
i386                   randconfig-b0-07120111
i386                   randconfig-b0-07120146
i386                   randconfig-b0-07120220
i386                   randconfig-b0-07120232
i386                   randconfig-b0-07120247
i386                   randconfig-b0-07120303
i386                   randconfig-b0-07120317
i386                   randconfig-b0-07120325
i386                   randconfig-b0-07120350
i386                   randconfig-b0-07120406
i386                   randconfig-b0-07120420
i386                   randconfig-b0-07120433
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         lpc18xx_defconfig
powerpc                      pmac32_defconfig
x86_64                           allmodconfig
blackfin                BF561-EZKIT_defconfig
tile                             allyesconfig
arm                    realview-smp_defconfig
arm64                               defconfig
avr32        atngw100mkii_evklcd101_defconfig
powerpc                     tqm5200_defconfig
mips                       bmips_be_defconfig
mips                         tb0226_defconfig
arm                            zeus_defconfig
mips                     sead3micro_defconfig
sh                           cayman_defconfig
arm                  colibri_pxa300_defconfig
mn10300                           allnoconfig
blackfin                BF548-EZKIT_defconfig
powerpc                      chrp32_defconfig
sh                            migor_defconfig
arm64                            alldefconfig
blackfin          BF527-AD7160-EVAL_defconfig
mips                       capcella_defconfig
mips                         cobalt_defconfig
powerpc                    mvme5100_defconfig
arm                           omap1_defconfig
mips                          rb532_defconfig
arm                            netx_defconfig
blackfin                   CM-BF527_defconfig
sh                            titan_defconfig
arm                         ebsa110_defconfig
mips                         tb0287_defconfig
ia64                             allyesconfig
sh                           se7780_defconfig
sh                        sh7763rdp_defconfig
m68k                           sun3_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                 mpc836x_mds_defconfig
alpha                            allmodconfig
blackfin                    DNP5370_defconfig
m68k                          multi_defconfig
sh                          rsk7269_defconfig
parisc                        c8000_defconfig
frv                              alldefconfig
arm                       versatile_defconfig
powerpc                     pq2fads_defconfig
xtensa                generic_kc705_defconfig
avr32                       mimc200_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201527
x86_64                 randconfig-b0-07112028
x86_64                 randconfig-b0-07112043
x86_64                 randconfig-b0-07112105
x86_64                 randconfig-b0-07112136
x86_64                 randconfig-b0-07112148
x86_64                 randconfig-b0-07112203
x86_64                 randconfig-b0-07112236
x86_64                 randconfig-b0-07112246
x86_64                 randconfig-b0-07112255
x86_64                 randconfig-b0-07112306
x86_64                 randconfig-b0-07112316
x86_64                 randconfig-b0-07112336
x86_64                 randconfig-b0-07112355
x86_64                 randconfig-b0-07120018
x86_64                 randconfig-b0-07120134
x86_64                 randconfig-b0-07120155
x86_64                 randconfig-b0-07120231
x86_64                 randconfig-b0-07120248
x86_64                 randconfig-b0-07120301
x86_64                 randconfig-b0-07120319
x86_64                 randconfig-b0-07120338
x86_64                 randconfig-b0-07120405
x86_64                 randconfig-b0-07120418
x86_64                 randconfig-b0-07120428
x86_64                 randconfig-b0-07120441
arm                            xcep_defconfig
avr32                      atngw100_defconfig
mips                      maltaaprp_defconfig
powerpc                         ps3_defconfig
arm                        shmobile_defconfig
xtensa                          iss_defconfig
powerpc64                        allyesconfig
sh                        apsh4ad0a_defconfig
sh                        edosk7760_defconfig
arm                           efm32_defconfig
sh                                allnoconfig
arm                        spear6xx_defconfig
parisc                        c3000_defconfig
powerpc                     sbc8548_defconfig
tile                              allnoconfig
arm                         socfpga_defconfig
powerpc                      bamboo_defconfig
sparc64                          allyesconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201527
i386                     randconfig-n1-201527
i386                     randconfig-n0-201528
i386                     randconfig-n1-201528
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                           tegra_defconfig
i386                   randconfig-h0-07112029
i386                   randconfig-h1-07112029
i386                   randconfig-h0-07112108
i386                   randconfig-h1-07112108
i386                   randconfig-h0-07112140
i386                   randconfig-h1-07112140
i386                   randconfig-h0-07112206
i386                   randconfig-h1-07112206
i386                   randconfig-h0-07112250
i386                   randconfig-h1-07112250
i386                   randconfig-h0-07112319
i386                   randconfig-h1-07112319
i386                   randconfig-h0-07120019
i386                   randconfig-h1-07120019
i386                   randconfig-h0-07120233
i386                   randconfig-h1-07120233
i386                   randconfig-h0-07120333
i386                   randconfig-h1-07120333
i386                   randconfig-h0-07120428
i386                   randconfig-h1-07120428
frv                                 defconfig
mn10300                     asb2364_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                      maltasmvp_defconfig
powerpc                     tqm8541_defconfig
sh                          sdk7786_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
powerpc                mpc8610_hpcd_defconfig
m68k                            q40_defconfig
sh                        edosk7705_defconfig
xtensa                       common_defconfig
arm                         bcm2835_defconfig
powerpc                      virtex_defconfig
mips                      malta_kvm_defconfig
powerpc                 canyonlands_defconfig
x86_64                              defconfig
powerpc                      katmai_defconfig
powerpc                        cell_defconfig
microblaze                       allyesconfig
powerpc                 mpc834x_mds_defconfig
s390                              allnoconfig
sh                           se7751_defconfig
m68k                              allnoconfig
m68k                             allyesconfig
sparc                             allnoconfig
x86_64                 randconfig-h0-07112014
x86_64                 randconfig-h0-07112032
x86_64                 randconfig-h0-07112046
x86_64                 randconfig-h0-07112108
x86_64                 randconfig-h0-07112127
x86_64                 randconfig-h0-07112146
x86_64                 randconfig-h0-07112204
x86_64                 randconfig-h0-07112238
x86_64                 randconfig-h0-07112327
x86_64                 randconfig-h0-07120006
x86_64                 randconfig-h0-07120041
x86_64                 randconfig-h0-07120111
x86_64                 randconfig-h0-07120150
x86_64                 randconfig-h0-07120234
x86_64                 randconfig-h0-07120255
x86_64                 randconfig-h0-07120322
x86_64                 randconfig-h0-07120350
x86_64                 randconfig-h0-07120416
x86_64                 randconfig-h0-07120435
x86_64                 randconfig-n0-07112013
x86_64                 randconfig-n0-07112039
x86_64                 randconfig-n0-07112055
x86_64                 randconfig-n0-07112111
x86_64                 randconfig-n0-07112131
x86_64                 randconfig-n0-07112149
x86_64                 randconfig-n0-07112209
x86_64                 randconfig-n0-07112243
x86_64                 randconfig-n0-07112256
x86_64                 randconfig-n0-07112318
x86_64                 randconfig-n0-07112339
x86_64                 randconfig-n0-07112359
x86_64                 randconfig-n0-07120018
x86_64                 randconfig-n0-07120032
x86_64                 randconfig-n0-07120053
x86_64                 randconfig-n0-07120130
x86_64                 randconfig-n0-07120142
x86_64                 randconfig-n0-07120156
x86_64                 randconfig-n0-07120211
x86_64                 randconfig-n0-07120237
x86_64                 randconfig-n0-07120255
x86_64                 randconfig-n0-07120311
x86_64                 randconfig-n0-07120328
x86_64                 randconfig-n0-07120349
x86_64                 randconfig-n0-07120403
x86_64                 randconfig-n0-07120418
x86_64                 randconfig-n0-07120427
x86_64                 randconfig-n0-07120446
arm                          prima2_defconfig
arm                       spear13xx_defconfig
arm                          marzen_defconfig
powerpc                     sequoia_defconfig
xtensa                           allyesconfig
um                                  defconfig
ia64                            sim_defconfig
m32r                      mappi.smp_defconfig
powerpc                   bluestone_defconfig
arm                        clps711x_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      ep88xc_defconfig
powerpc                     taishan_defconfig
avr32                 atngw100_mrmt_defconfig
arm                        magician_defconfig
sh                         apsh4a3a_defconfig
arm                         cm_x2xx_defconfig
arm                        multi_v5_defconfig
arm                        trizeps4_defconfig
arm                        raumfeld_defconfig
blackfin             BF527-TLL6527M_defconfig
arm                        keystone_defconfig
blackfin                            defconfig
sh                        sh7757lcr_defconfig
arm                          simpad_defconfig
m32r                     mappi3.smp_defconfig
arm                         s5pv210_defconfig
mn10300                     asb2303_defconfig
m32r                           usrv_defconfig
arm                       imx_v4_v5_defconfig
arm                           h3600_defconfig
x86_64                           allyesconfig
m68k                          amiga_defconfig
sh                  sh7785lcr_32bit_defconfig
i386                  randconfig-sb0-07112017
i386                  randconfig-sb0-07112034
i386                  randconfig-sb0-07112049
i386                  randconfig-sb0-07112100
i386                  randconfig-sb0-07112127
i386                  randconfig-sb0-07112151
i386                  randconfig-sb0-07112212
i386                  randconfig-sb0-07112245
i386                  randconfig-sb0-07112310
i386                  randconfig-sb0-07112339
i386                  randconfig-sb0-07120006
i386                  randconfig-sb0-07120036
i386                  randconfig-sb0-07120111
i386                  randconfig-sb0-07120145
i386                  randconfig-sb0-07120211
i386                  randconfig-sb0-07120252
i386                  randconfig-sb0-07120314
i386                  randconfig-sb0-07120323
i386                  randconfig-sb0-07120335
i386                  randconfig-sb0-07120350
i386                  randconfig-sb0-07120410
i386                  randconfig-sb0-07120428
i386                  randconfig-sb0-07120446
powerpc                    adder875_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           jazz_defconfig
arm                            hisi_defconfig
powerpc                       holly_defconfig
arm                              zx_defconfig
sh                          urquell_defconfig
arm                         cm_x300_defconfig
mips                      bmips_stb_defconfig
powerpc                      walnut_defconfig
arm                           h5000_defconfig
blackfin                 BlackStamp_defconfig
mips                            gpr_defconfig
powerpc                     rainier_defconfig
m68k                        m5272c3_defconfig
mips                       markeins_defconfig
powerpc                     mpc86xx_defconfig
mips                      loongson3_defconfig
sparc                       sparc32_defconfig
xtensa                           alldefconfig
arm                          ks8695_defconfig
s390                                defconfig
sh                          r7785rp_defconfig
powerpc                      pasemi_defconfig
sparc                            allyesconfig
arm                          nuc950_defconfig
blackfin                BF533-STAMP_defconfig
powerpc                      mgcoge_defconfig
sh                          rsk7203_defconfig
x86_64               randconfig-x000-07111123
x86_64               randconfig-x001-07111123
x86_64               randconfig-x007-07111123
x86_64               randconfig-x009-07111123
x86_64               randconfig-x003-07111123
x86_64               randconfig-x008-07111123
x86_64               randconfig-x002-07111123
x86_64               randconfig-x005-07111123
x86_64               randconfig-x006-07111123
x86_64               randconfig-x004-07111123
x86_64                 randconfig-x000-201528
x86_64                 randconfig-x001-201528
x86_64                 randconfig-x002-201528
x86_64                 randconfig-x003-201528
x86_64                 randconfig-x004-201528
x86_64                 randconfig-x005-201528
x86_64                 randconfig-x006-201528
x86_64                 randconfig-x007-201528
x86_64                 randconfig-x008-201528
x86_64                 randconfig-x009-201528
i386                     randconfig-r0-201527
x86_64                 randconfig-r0-07112011
x86_64                 randconfig-r0-07112037
x86_64                 randconfig-r0-07112048
x86_64                 randconfig-r0-07112106
x86_64                 randconfig-r0-07112132
x86_64                 randconfig-r0-07112146
x86_64                 randconfig-r0-07112158
x86_64                 randconfig-r0-07112208
x86_64                 randconfig-r0-07112241
x86_64                 randconfig-r0-07112254
x86_64                 randconfig-r0-07112307
x86_64                 randconfig-r0-07112335
x86_64                 randconfig-r0-07112346
x86_64                 randconfig-r0-07120000
x86_64                 randconfig-r0-07120020
x86_64                 randconfig-r0-07120108
x86_64                 randconfig-r0-07120210
x86_64                 randconfig-r0-07120234
x86_64                 randconfig-r0-07120247
x86_64                 randconfig-r0-07120333
x86_64                 randconfig-r0-07120359
x86_64                 randconfig-r0-07120416
x86_64                 randconfig-r0-07120432
alpha                               defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                BF533-EZKIT_defconfig
arm                          iop32x_defconfig
m68k                        mvme147_defconfig
openrisc                         alldefconfig
avr32                       favr-32_defconfig
x86_64                 randconfig-s0-07112059
x86_64                 randconfig-s0-07112128
x86_64                 randconfig-s0-07112147
x86_64                 randconfig-s0-07112201
x86_64                 randconfig-s0-07112252
x86_64                 randconfig-s0-07112319
x86_64                 randconfig-s0-07120029
i386                 randconfig-x000-07111123
i386                 randconfig-x004-07111123
i386                 randconfig-x003-07111123
i386                 randconfig-x002-07111123
i386                 randconfig-x006-07111123
i386                 randconfig-x005-07111123
i386                 randconfig-x008-07111123
i386                 randconfig-x007-07111123
i386                 randconfig-x009-07111123
i386                 randconfig-x001-07111123
i386                   randconfig-x0-07112024
i386                   randconfig-x0-07112036
i386                   randconfig-x0-07112047
i386                   randconfig-x0-07112058
i386                   randconfig-x0-07112109
i386                   randconfig-x0-07112127
i386                   randconfig-x0-07112139
i386                   randconfig-x0-07112151
i386                   randconfig-x0-07112203
i386                   randconfig-x0-07112236
i386                   randconfig-x0-07112259
i386                   randconfig-x0-07112317
i386                   randconfig-x0-07112334
i386                   randconfig-x0-07112345
i386                   randconfig-x0-07112359
i386                   randconfig-x0-07120052
i386                   randconfig-x0-07120107
i386                   randconfig-x0-07120129
i386                   randconfig-x0-07120149
i386                   randconfig-x0-07120214
i386                   randconfig-x0-07120230
i386                   randconfig-x0-07120246
i386                   randconfig-x0-07120259
i386                   randconfig-x0-07120310
i386                   randconfig-x0-07120326
i386                   randconfig-x0-07120337
i386                   randconfig-x0-07120356
i386                   randconfig-x0-07120413
i386                   randconfig-x0-07120425
i386                   randconfig-x0-07120434
i386                   randconfig-x0-07120442

Thanks,
Fengguang

