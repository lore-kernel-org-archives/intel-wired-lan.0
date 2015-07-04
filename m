From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 04 Jul 2015 11:42:10 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 cbc4ef7f754d220e334ade3f1f8d615c60f78fb8 BUILD DONE
Message-ID: <55975612.AXTD7yxbwLF9frNZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
cbc4ef7f754d220e334ade3f1f8d615c60f78fb8  i40e/i40evf: Add TX/RX outer UDP checksum support for X722

drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7591:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? frv-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
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
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-sb0-07011932
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-sb0-07012037
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-x0-07011949
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-x0-07012043
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size

elapsed time: 4234m

configs tested: 348

m68k                       m5275evb_defconfig
mn10300                          allmodconfig
powerpc                      makalu_defconfig
arm                         mv78xx0_defconfig
microblaze                      mmu_defconfig
mips                          ath79_defconfig
arm                        mvebu_v7_defconfig
powerpc                      tqm8xx_defconfig
s390                                defconfig
m32r                    m32700ut.up_defconfig
sh                          r7785rp_defconfig
tile                                defconfig
arm                          pxa168_defconfig
arm                         s5pv210_defconfig
sparc64                          alldefconfig
arm                           spitz_defconfig
arm                         vf610m4_defconfig
powerpc                   gef_ppc9a_defconfig
mips                         bigsur_defconfig
parisc                            allnoconfig
sh                            migor_defconfig
arm                          simpad_defconfig
powerpc                     sequoia_defconfig
sh                     magicpanelr2_defconfig
x86_64                 randconfig-a0-07011324
x86_64                 randconfig-a0-07011933
x86_64                 randconfig-a0-07011946
x86_64                 randconfig-a0-07012000
x86_64                 randconfig-a0-07012015
x86_64                 randconfig-a0-07012029
x86_64                 randconfig-a0-07012050
x86_64                 randconfig-a0-07012118
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
microblaze                    nommu_defconfig
powerpc                     ksi8560_defconfig
powerpc                      mgcoge_defconfig
m68k                          hp300_defconfig
s390                           gcov_defconfig
sh                        edosk7705_defconfig
arm                      footbridge_defconfig
blackfin                    PNAV-10_defconfig
powerpc                       holly_defconfig
m68k                                defconfig
sparc64                             defconfig
arm                        magician_defconfig
mips                              allnoconfig
mips                           jazz_defconfig
arm                        mini2440_defconfig
arm64                               defconfig
blackfin                    DNP5370_defconfig
i386                             allyesconfig
i386                   randconfig-c0-07011325
i386                   randconfig-c0-07011340
i386                   randconfig-c0-07011924
i386                   randconfig-c0-07011944
i386                   randconfig-c0-07012000
i386                   randconfig-c0-07012009
i386                   randconfig-c0-07012018
i386                   randconfig-c0-07012028
i386                   randconfig-c0-07012034
i386                   randconfig-c0-07012046
i386                   randconfig-c0-07012101
i386                   randconfig-c0-07012112
i386                   randconfig-c0-07012129
i386                   randconfig-c0-07041123
arm                           sunxi_defconfig
powerpc                 canyonlands_defconfig
powerpc                      pmac32_defconfig
arm                          iop33x_defconfig
powerpc                  gef_sbc610_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                    sbc8641d_defconfig
s390                             allyesconfig
sh                                allnoconfig
sh                        sh7763rdp_defconfig
arm                        shmobile_defconfig
m68k                            mac_defconfig
sh                         apsh4a3a_defconfig
arm                       omap2plus_defconfig
blackfin              BF561-ACVILON_defconfig
powerpc                  mpc866_ads_defconfig
mips                        bcm47xx_defconfig
mips                          rm200_defconfig
tile                             allyesconfig
arm                           efm32_defconfig
arm                        multi_v7_defconfig
blackfin                   CM-BF527_defconfig
microblaze                        allnoconfig
sh                        dreamcast_defconfig
arm                           u8500_defconfig
sparc                            allyesconfig
x86_64                 randconfig-v0-07011316
x86_64                 randconfig-v0-07011334
x86_64                 randconfig-v0-07011346
x86_64                 randconfig-v0-07011923
x86_64                 randconfig-v0-07011939
x86_64                 randconfig-v0-07011950
x86_64                 randconfig-v0-07011959
x86_64                 randconfig-v0-07012023
x86_64                 randconfig-v0-07012055
x86_64                 randconfig-v0-07012119
alpha                            allyesconfig
arm                        trizeps4_defconfig
arm64                            alldefconfig
powerpc                    adder875_defconfig
arm                  colibri_pxa300_defconfig
avr32                  atngw100mkii_defconfig
sh                          sdk7786_defconfig
alpha                             allnoconfig
arm                              alldefconfig
m68k                          multi_defconfig
powerpc                       eiger_defconfig
arm                          marzen_defconfig
blackfin               BF518F-EZBRD_defconfig
mips                         tb0219_defconfig
arm                           viper_defconfig
sh                          sdk7780_defconfig
um                               alldefconfig
arm                       imx_v4_v5_defconfig
m32r                           usrv_defconfig
powerpc                      ppc6xx_defconfig
arm                          ep93xx_defconfig
parisc                generic-32bit_defconfig
sh                          rsk7201_defconfig
arm                            netx_defconfig
mips                           mtx1_defconfig
sh                        apsh4ad0a_defconfig
arm                          imote2_defconfig
arm                           kzm9g_defconfig
mips                          sead3_defconfig
blackfin                  CM-BF537E_defconfig
openrisc                         allyesconfig
powerpc                        cell_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          pxa910_defconfig
arm                            xcep_defconfig
m68k                             alldefconfig
mips                       bmips_be_defconfig
arm                       versatile_defconfig
avr32                     atstk1006_defconfig
blackfin                      H8606_defconfig
powerpc                   motionpro_defconfig
i386                   randconfig-b0-07011306
i386                   randconfig-b0-07011340
i386                   randconfig-b0-07011932
i386                   randconfig-b0-07011942
i386                   randconfig-b0-07011950
i386                   randconfig-b0-07011956
i386                   randconfig-b0-07012006
i386                   randconfig-b0-07012017
i386                   randconfig-b0-07012036
i386                   randconfig-b0-07012053
i386                   randconfig-b0-07012105
i386                   randconfig-b0-07012120
i386                   randconfig-b0-07012137
i386                   randconfig-b0-07041134
arm                  colibri_pxa270_defconfig
m32r                    mappi2.opsp_defconfig
sh                          r7780mp_defconfig
arm                         s3c2410_defconfig
mips                       markeins_defconfig
openrisc                    or1ksim_defconfig
powerpc                     pq2fads_defconfig
frv                               allnoconfig
m32r                        oaks32r_defconfig
powerpc                      ep88xc_defconfig
powerpc                mpc8641_hpcn_defconfig
arm                              allmodconfig
arm                         shannon_defconfig
mips                        jmr3927_defconfig
mips                        nlm_xlp_defconfig
mn10300                             defconfig
arm                            zeus_defconfig
m68k                           sun3_defconfig
i386                             allmodconfig
arm                             mxs_defconfig
sh                          kfr2r09_defconfig
sh                        sh7757lcr_defconfig
arm                       imx_v6_v7_defconfig
blackfin                          allnoconfig
x86_64                 randconfig-b0-07011319
x86_64                 randconfig-b0-07011357
x86_64                 randconfig-b0-07011929
x86_64                 randconfig-b0-07011941
x86_64                 randconfig-b0-07011951
x86_64                 randconfig-b0-07012003
x86_64                 randconfig-b0-07012011
x86_64                 randconfig-b0-07012031
x86_64                 randconfig-b0-07012055
x86_64                 randconfig-b0-07012120
x86_64                 randconfig-b0-07012135
x86_64                 randconfig-b0-07041135
sparc                               defconfig
sparc64                           allnoconfig
arm                            mmp2_defconfig
blackfin                BF537-STAMP_defconfig
sh                           se7750_defconfig
tile                             allmodconfig
arm                        spear3xx_defconfig
arm64                            allmodconfig
arm64                            allyesconfig
powerpc                      walnut_defconfig
i386                   randconfig-h0-07011341
i386                   randconfig-h1-07011341
i386                   randconfig-h0-07011925
i386                   randconfig-h1-07011925
i386                   randconfig-h0-07011940
i386                   randconfig-h1-07011940
i386                   randconfig-h0-07012001
i386                   randconfig-h1-07012001
i386                   randconfig-h0-07012025
i386                   randconfig-h1-07012025
i386                   randconfig-h0-07012111
i386                   randconfig-h1-07012111
m68k                            q40_defconfig
mips                      maltaaprp_defconfig
mn10300                          alldefconfig
arm                       netwinder_defconfig
sh                         ap325rxa_defconfig
arm                            hisi_defconfig
powerpc                       ppc64_defconfig
arm                         cm_x300_defconfig
arm                           h3600_defconfig
mips                       lemote2f_defconfig
sh                         ecovec24_defconfig
arm                         s3c6400_defconfig
mips                   sb1250_swarm_defconfig
tile                         tilegx_defconfig
arm                      pxa255-idp_defconfig
blackfin                  CM-BF537U_defconfig
mips                         tb0226_defconfig
arm                            dove_defconfig
sh                              ul2_defconfig
powerpc                     tqm5200_defconfig
sh                               allyesconfig
powerpc                     mpc86xx_defconfig
sh                               alldefconfig
sh                          landisk_defconfig
x86_64                 randconfig-h0-07011309
x86_64                 randconfig-h0-07011321
x86_64                 randconfig-h0-07011339
x86_64                 randconfig-h0-07011350
x86_64                 randconfig-h0-07011939
x86_64                 randconfig-h0-07011949
x86_64                 randconfig-h0-07012002
x86_64                 randconfig-h0-07012015
x86_64                 randconfig-h0-07012028
x86_64                 randconfig-h0-07012039
x86_64                 randconfig-h0-07012104
x86_64                 randconfig-h0-07012129
x86_64                                    lkp
x86_64                                   rhel
x86_64                 randconfig-n0-02030033
x86_64                 randconfig-n0-02030046
x86_64                 randconfig-n0-02030108
x86_64                 randconfig-n0-02030118
x86_64                 randconfig-n0-02030713
x86_64                 randconfig-n0-02030724
x86_64                 randconfig-n0-02030738
x86_64                 randconfig-n0-02030753
x86_64                 randconfig-n0-02030805
x86_64                 randconfig-n0-02030829
x86_64                 randconfig-n0-02030847
x86_64                 randconfig-n0-07041124
arm                        spear6xx_defconfig
m68k                          atari_defconfig
powerpc                 linkstation_defconfig
m68k                       m5249evb_defconfig
powerpc                     tqm8560_defconfig
arm                           acs5k_defconfig
ia64                         bigsur_defconfig
i386                             alldefconfig
x86_64                              defconfig
parisc                              defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      bamboo_defconfig
m68k                        m5407c3_defconfig
openrisc                          allnoconfig
i386                  randconfig-sb0-07011315
i386                  randconfig-sb0-07011342
i386                  randconfig-sb0-07011932
i386                  randconfig-sb0-07011947
i386                  randconfig-sb0-07011959
i386                  randconfig-sb0-07012012
i386                  randconfig-sb0-07012037
i386                  randconfig-sb0-07012106
i386                  randconfig-sb0-07012122
ia64                             allyesconfig
mips                  maltasmvp_eva_defconfig
mips                        qi_lb60_defconfig
avr32                    hammerhead_defconfig
powerpc                     virtex5_defconfig
arm                          ks8695_defconfig
powerpc                     ep8248e_defconfig
s390                             allmodconfig
sh                          rsk7203_defconfig
arm                         cm_x2xx_defconfig
arm                         palmz72_defconfig
sh                         microdev_defconfig
powerpc                         c2k_defconfig
arm                     eseries_pxa_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     kmp204x_defconfig
x86_64                 randconfig-r0-07011920
x86_64                 randconfig-r0-07011934
x86_64                 randconfig-r0-07011943
x86_64                 randconfig-r0-07011957
x86_64                 randconfig-r0-07012011
x86_64                 randconfig-r0-07012025
x86_64                 randconfig-r0-07012043
x86_64                 randconfig-r0-07012100
x86_64                 randconfig-r0-07012113
x86_64                 randconfig-r0-07012128
arm                         lubbock_defconfig
sparc64                          allyesconfig
arm                             bcm_defconfig
powerpc                     mpc83xx_defconfig
sh                             sh03_defconfig
sh                            titan_defconfig
mips                           ci20_defconfig
arm                         assabet_defconfig
powerpc                    ge_imp3a_defconfig
mips                     decstation_defconfig
powerpc                        warp_defconfig
s390                             alldefconfig
x86_64                 randconfig-s0-07010516
x86_64                 randconfig-s0-07010553
x86_64                 randconfig-s0-07011134
x86_64                 randconfig-s0-07011152
x86_64                 randconfig-s0-07011206
x86_64                 randconfig-s0-07011215
x86_64                 randconfig-s0-07011241
x86_64                 randconfig-s0-07011309
i386                   randconfig-x0-07011259
i386                   randconfig-x0-07011335
i386                   randconfig-x0-07011930
i386                   randconfig-x0-07011949
i386                   randconfig-x0-07012003
i386                   randconfig-x0-07012016
i386                   randconfig-x0-07012027
i386                   randconfig-x0-07012043
i386                   randconfig-x0-07012109
i386                   randconfig-x0-07012117
i386                   randconfig-x0-07041128

Thanks,
Fengguang
