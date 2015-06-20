From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 20 Jun 2015 22:02:34 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 119e932bf913dcbb2d9f4a358537059116312a81 BUILD DONE
Message-ID: <5585727a.wdpHJeFtaYtDDJGr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
119e932bf913dcbb2d9f4a358537059116312a81  e1000e: i219 - fix to enable both ulp and EEE in Sx state

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'

error ids grouped by kconfigs:

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
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-sb0-06202154
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? um-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-r0-06202054
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-v0-06202051
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? xtensa-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size

11 directories, 33 files

elapsed time: 77m

configs tested: 200

avr32                             allnoconfig
powerpc                      bamboo_defconfig
sh                        dreamcast_defconfig
mips                            e55_defconfig
powerpc                       holly_defconfig
powerpc                mpc8610_hpcd_defconfig
openrisc                            defconfig
powerpc                     akebono_defconfig
powerpc                  pseries_le_defconfig
arm                    realview-smp_defconfig
powerpc                 mpc8272_ads_defconfig
um                                  defconfig
arm                             mxs_defconfig
arm                          nuc910_defconfig
avr32            atngw100_evklcd100_defconfig
powerpc                      pasemi_defconfig
powerpc                      tqm8xx_defconfig
um                             i386_defconfig
blackfin                   CM-BF527_defconfig
powerpc                  mpc885_ads_defconfig
arm                         at91_dt_defconfig
arm                          iop33x_defconfig
mips                           xway_defconfig
x86_64                 randconfig-a0-06202048
x86_64                 randconfig-a0-06202101
x86_64                 randconfig-a0-06202112
x86_64                 randconfig-a0-06202141
alpha                            allyesconfig
arm                             ezx_defconfig
arm                            hisi_defconfig
i386                                defconfig
parisc                              defconfig
powerpc                 mpc837x_rdb_defconfig
mips                              allnoconfig
mips                      maltasmvp_defconfig
powerpc                 mpc834x_itx_defconfig
i386                   randconfig-c0-06202059
i386                   randconfig-c0-06202115
x86_64                 randconfig-v0-06202040
x86_64                 randconfig-v0-06202047
x86_64                 randconfig-v0-06202051
x86_64                 randconfig-v0-06202057
x86_64                 randconfig-v0-06202103
x86_64                 randconfig-v0-06202109
x86_64                 randconfig-v0-06202117
x86_64                 randconfig-v0-06202122
x86_64                 randconfig-v0-06202131
x86_64                 randconfig-v0-06202135
x86_64                 randconfig-v0-06202142
x86_64                 randconfig-v0-06202146
x86_64                 randconfig-v0-06202154
blackfin            BF561-EZKIT-SMP_defconfig
m68k                           sun3_defconfig
powerpc                     kmeter1_defconfig
arm                     davinci_all_defconfig
m32r                      mappi.smp_defconfig
mips                        bcm63xx_defconfig
mips                malta_qemu_32r6_defconfig
arm                  colibri_pxa270_defconfig
arm                              zx_defconfig
sh                           se7721_defconfig
arm                         lpc18xx_defconfig
ia64                              allnoconfig
mips                        maltaup_defconfig
powerpc64                        alldefconfig
arm                            netx_defconfig
avr32                      atngw100_defconfig
blackfin                   CM-BF533_defconfig
blackfin                BF561-EZKIT_defconfig
blackfin                       SRV1_defconfig
m32r                   m32700ut.smp_defconfig
s390                           gcov_defconfig
mips                        bcm47xx_defconfig
mn10300                     asb2303_defconfig
mn10300                             defconfig
powerpc                  gef_sbc610_defconfig
avr32            atngw100_evklcd101_defconfig
m68k                          atari_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc85xx_smp_defconfig
arm                           viper_defconfig
blackfin             BF527-TLL6527M_defconfig
powerpc                   gef_ppc9a_defconfig
i386                   randconfig-b0-06202044
i386                   randconfig-b0-06202053
i386                   randconfig-b0-06202104
i386                   randconfig-b0-06202109
i386                   randconfig-b0-06202117
i386                   randconfig-b0-06202125
i386                   randconfig-b0-06202136
i386                   randconfig-b0-06202145
avr32                     atstk1002_defconfig
openrisc                         alldefconfig
powerpc                          g5_defconfig
alpha                               defconfig
blackfin                  CM-BF537E_defconfig
blackfin                      H8606_defconfig
powerpc                          alldefconfig
arm                          pxa910_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     virtex5_defconfig
s390                              allnoconfig
arm                          moxart_defconfig
mips                 pnx8335_stb225_defconfig
powerpc64                           defconfig
sh                           se7712_defconfig
ia64                          tiger_defconfig
sparc64                             defconfig
arm                         cm_x2xx_defconfig
blackfin                 BlackStamp_defconfig
ia64                         bigsur_defconfig
powerpc                       ebony_defconfig
arm                            lart_defconfig
mips                          sead3_defconfig
powerpc                     sbc834x_defconfig
tile                             allmodconfig
avr32        atngw100mkii_evklcd100_defconfig
blackfin                  CM-BF537U_defconfig
mips                            ar7_defconfig
sh                          rsk7203_defconfig
blackfin                  TCM-BF518_defconfig
m68k                       m5475evb_defconfig
sh                            shmin_defconfig
x86_64                 randconfig-b0-06202042
x86_64                 randconfig-b0-06202049
x86_64                 randconfig-b0-06202056
x86_64                 randconfig-b0-06202104
x86_64                 randconfig-b0-06202111
x86_64                 randconfig-b0-06202120
x86_64                 randconfig-b0-06202130
x86_64                 randconfig-b0-06202146
x86_64                 randconfig-b0-06202155
arm                          imote2_defconfig
arm                         socfpga_defconfig
mips                         rt305x_defconfig
parisc                generic-64bit_defconfig
sparc                            allmodconfig
xtensa                           allmodconfig
i386                   randconfig-h0-06202047
i386                   randconfig-h1-06202047
i386                   randconfig-h0-06202100
i386                   randconfig-h1-06202100
arm                              allmodconfig
sh                           sh2007_defconfig
tile                                defconfig
x86_64                 randconfig-h0-06202101
x86_64                 randconfig-h0-06202118
x86_64                 randconfig-h0-06202140
x86_64                 randconfig-n0-06202041
x86_64                 randconfig-n0-06202048
x86_64                 randconfig-n0-06202056
x86_64                 randconfig-n0-06202104
x86_64                 randconfig-n0-06202113
x86_64                 randconfig-n0-06202129
x86_64                 randconfig-n0-06202139
x86_64                 randconfig-n0-06202150
i386                  randconfig-sb0-06202043
i386                  randconfig-sb0-06202050
i386                  randconfig-sb0-06202055
i386                  randconfig-sb0-06202104
i386                  randconfig-sb0-06202111
i386                  randconfig-sb0-06202117
i386                  randconfig-sb0-06202125
i386                  randconfig-sb0-06202139
i386                  randconfig-sb0-06202147
i386                  randconfig-sb0-06202154
powerpc                           allnoconfig
powerpc                     ep8248e_defconfig
alpha                            allmodconfig
parisc                         b180_defconfig
powerpc                    klondike_defconfig
powerpc                      ppc40x_defconfig
x86_64                 randconfig-r0-06202054
x86_64                 randconfig-r0-06202106
x86_64                 randconfig-r0-06202119
x86_64                 randconfig-r0-06202153
i386                             allmodconfig
blackfin                BF609-EZKIT_defconfig
arm                          collie_defconfig
arm                      footbridge_defconfig
arm                         palmz72_defconfig
sh                        sh7757lcr_defconfig
sh                          urquell_defconfig
i386                              allnoconfig
powerpc                      acadia_defconfig
powerpc                         c2k_defconfig
x86_64                 randconfig-s0-06202051
x86_64                 randconfig-s0-06202105
x86_64                 randconfig-s0-06202119
x86_64                 randconfig-s0-06202138
x86_64                 randconfig-s0-06202148
i386                   randconfig-x0-06202043
i386                   randconfig-x0-06202051
i386                   randconfig-x0-06202058
i386                   randconfig-x0-06202103
i386                   randconfig-x0-06202110
i386                   randconfig-x0-06202117
i386                   randconfig-x0-06202133
i386                   randconfig-x0-06202148
i386                   randconfig-x0-06202156

Thanks,
Fengguang
