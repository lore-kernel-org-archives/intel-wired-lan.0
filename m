From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 01 Jul 2015 22:14:31 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 5b0545e8bc7b5741723a8c4c69e5808a810cf3d6 BUILD DONE
Message-ID: <5593f5c7.SjPW5m4GzLUi/eyB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
5b0545e8bc7b5741723a8c4c69e5808a810cf3d6  e1000e: i219 - Increase minimum FIFO read/write min gap

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/e1000e/netdev.c:6454:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
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
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-b0-07010922
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-b0-07010933
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-x0-07010902
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-s0-07011342
    ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used

elapsed time: 790m

configs tested: 218

microblaze                        allnoconfig
sh                             sh03_defconfig
xtensa                  audio_kc705_defconfig
x86_64                 randconfig-a0-07012142
powerpc                     taishan_defconfig
powerpc64                        alldefconfig
sparc                            allmodconfig
i386                   randconfig-c0-07010910
i386                   randconfig-c0-07010928
i386                   randconfig-c0-07010959
i386                   randconfig-c0-07011229
i386                   randconfig-c0-07012140
i386                   randconfig-c0-07012146
arm                           u8500_defconfig
avr32                            alldefconfig
sh                          urquell_defconfig
blackfin                   CM-BF548_defconfig
m68k                           sun3_defconfig
mips                      malta_kvm_defconfig
blackfin                  CM-BF537U_defconfig
mips                           mtx1_defconfig
sh                           se7751_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                     rainier_defconfig
arm                       netwinder_defconfig
s390                        default_defconfig
xtensa                           allyesconfig
arm                          lpd270_defconfig
avr32                     atstk1003_defconfig
powerpc                      ppc64e_defconfig
arm                           spitz_defconfig
sh                   rts7751r2dplus_defconfig
m32r                       m32104ut_defconfig
mips                             allmodconfig
powerpc                    gamecube_defconfig
x86_64                 randconfig-v0-07010905
x86_64                 randconfig-v0-07010917
x86_64                 randconfig-v0-07010928
x86_64                 randconfig-v0-07010938
x86_64                 randconfig-v0-07010953
x86_64                 randconfig-v0-07011206
x86_64                 randconfig-v0-07011222
x86_64                 randconfig-v0-07011231
x86_64                 randconfig-v0-07011246
x86_64                 randconfig-v0-07011258
x86_64                 randconfig-v0-07012139
arm                          ks8695_defconfig
powerpc                     tqm5200_defconfig
sh                          lboxre2_defconfig
sh                        sh7785lcr_defconfig
arm                  colibri_pxa270_defconfig
arm                          moxart_defconfig
m68k                       m5475evb_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                         alldefconfig
s390                           gcov_defconfig
um                           x86_64_defconfig
arm                       mainstone_defconfig
blackfin                BF527-EZKIT_defconfig
m32r                           usrv_defconfig
powerpc                   bluestone_defconfig
arm                            zeus_defconfig
mips                         mpc30x_defconfig
powerpc                     redwood_defconfig
um                               alldefconfig
arm                            qcom_defconfig
mips                        bcm63xx_defconfig
powerpc                     kmp204x_defconfig
sh                          rsk7264_defconfig
arm                         lpc18xx_defconfig
arm64                            allyesconfig
sh                               allmodconfig
sh                           se7750_defconfig
mips                       markeins_defconfig
mips                        qi_lb60_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7619_defconfig
i386                   randconfig-b0-07010909
i386                   randconfig-b0-07010922
i386                   randconfig-b0-07010933
i386                   randconfig-b0-07010946
i386                   randconfig-b0-07011002
i386                   randconfig-b0-07011211
i386                   randconfig-b0-07011228
i386                   randconfig-b0-07011250
i386                   randconfig-b0-07012149
i386                   randconfig-b0-07012202
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                  colibri_pxa300_defconfig
arm                        shmobile_defconfig
mips                         rt305x_defconfig
powerpc                     ksi8560_defconfig
blackfin                BF561-EZKIT_defconfig
parisc                           allyesconfig
powerpc                     tqm8555_defconfig
um                             i386_defconfig
i386                   randconfig-i0-07011114
i386                             allyesconfig
x86_64                 randconfig-b0-07011254
x86_64                 randconfig-b0-07012151
alpha                               defconfig
arm                          imote2_defconfig
powerpc                 mpc8315_rdb_defconfig
sparc                            alldefconfig
arm                      pxa255-idp_defconfig
blackfin                BF533-EZKIT_defconfig
mips                           ip32_defconfig
powerpc                 mpc834x_itx_defconfig
arm                        magician_defconfig
blackfin                BF533-STAMP_defconfig
ia64                            sim_defconfig
mips                     sead3micro_defconfig
arm                          badge4_defconfig
arm64                               defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-h0-07010939
i386                   randconfig-h1-07010939
i386                   randconfig-h0-07010954
i386                   randconfig-h1-07010954
i386                   randconfig-h0-07011004
i386                   randconfig-h1-07011004
i386                   randconfig-h0-07011212
i386                   randconfig-h1-07011212
i386                   randconfig-h0-07011252
i386                   randconfig-h1-07011252
i386                   randconfig-h0-07012143
i386                   randconfig-h1-07012143
mips                        maltaup_defconfig
powerpc                         c2k_defconfig
tile                             allyesconfig
tile                             allmodconfig
mn10300                          allmodconfig
mn10300                     asb2364_defconfig
arm                           h3600_defconfig
arm                        spear3xx_defconfig
powerpc                        cell_defconfig
sh                           se7721_defconfig
microblaze                          defconfig
openrisc                         allyesconfig
arm                         em_x270_defconfig
blackfin                   CM-BF561_defconfig
sh                            migor_defconfig
x86_64                 randconfig-h0-07010911
x86_64                 randconfig-h0-07010924
x86_64                 randconfig-h0-07010947
x86_64                 randconfig-h0-07010959
x86_64                 randconfig-h0-07011230
x86_64                 randconfig-h0-07011249
x86_64                 randconfig-h0-07012148
x86_64                 randconfig-n0-02022037
x86_64                 randconfig-n0-02022054
x86_64                 randconfig-n0-02022120
x86_64                 randconfig-n0-02022135
x86_64                 randconfig-n0-02022340
x86_64                 randconfig-n0-02030002
x86_64                 randconfig-n0-02030017
x86_64                 randconfig-n0-02030916
arm                        multi_v7_defconfig
mips                             alldefconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc85xx_smp_defconfig
sh                          rsk7203_defconfig
powerpc                  gef_sbc310_defconfig
sh                               allyesconfig
arm                        mini2440_defconfig
sh                                  defconfig
powerpc                      chrp32_defconfig
sh                          sdk7786_defconfig
sh                           sh2007_defconfig
arm                          pxa168_defconfig
arm                           viper_defconfig
powerpc                 mpc836x_mds_defconfig
i386                  randconfig-sb0-07010909
i386                  randconfig-sb0-07010927
i386                  randconfig-sb0-07010935
i386                  randconfig-sb0-07010949
i386                  randconfig-sb0-07011208
i386                  randconfig-sb0-07011225
i386                  randconfig-sb0-07011240
i386                  randconfig-sb0-07012137
i386                  randconfig-sb0-07012153
x86_64                 randconfig-r0-07010915
x86_64                 randconfig-r0-07010937
x86_64                 randconfig-r0-07012150
arm                         vf610m4_defconfig
powerpc                     kmeter1_defconfig
sh                        dreamcast_defconfig
powerpc                     tqm8560_defconfig
sparc64                          alldefconfig
powerpc                       ebony_defconfig
powerpc                     sbc8548_defconfig
sh                         microdev_defconfig
avr32            atngw100_evklcd101_defconfig
mips                          lasat_defconfig
avr32                     atstk1006_defconfig
mips                          sead3_defconfig
arm                         orion5x_defconfig
mips                           xway_defconfig
blackfin                  CM-BF537E_defconfig
m68k                                defconfig
xtensa                    smp_lx200_defconfig
x86_64                 randconfig-s0-07010118
x86_64                 randconfig-s0-07010151
x86_64                 randconfig-s0-07010403
x86_64                 randconfig-s0-07010442
x86_64                 randconfig-s0-07011342
x86_64                           allmodconfig
i386                   randconfig-x0-07010902
i386                   randconfig-x0-07010924
i386                   randconfig-x0-07011001
i386                   randconfig-x0-07011230
i386                   randconfig-x0-07012137
i386                   randconfig-x0-07012149
i386                   randconfig-x0-07012159

Thanks,
Fengguang
