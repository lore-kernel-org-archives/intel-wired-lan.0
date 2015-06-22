From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 23 Jun 2015 03:43:09 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 b45b32f197e02d59bcc3f2793be063e15f43f8e8 BUILD DONE
Message-ID: <5588654d.Qa5tZ6yU6cuuxy7X%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
b45b32f197e02d59bcc3f2793be063e15f43f8e8  fm10k: don't store sw_vid at reset

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

error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? arm-allyesconfig
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
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-c0-06230304
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? i386-randconfig-sb0-06230252
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
??? powerpc-currituck_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? sparc-sparc64_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-x007-201525
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
    ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size

13 directories, 46 files

elapsed time: 142m

configs tested: 282

m68k                          hp300_defconfig
mips                      fuloong2e_defconfig
powerpc                   gef_ppc9a_defconfig
arm                         shannon_defconfig
powerpc                      pasemi_defconfig
sparc                             allnoconfig
sh                        edosk7760_defconfig
sh                          kfr2r09_defconfig
sh                         microdev_defconfig
mn10300                     asb2364_defconfig
powerpc                 mpc834x_itx_defconfig
um                           x86_64_defconfig
avr32                 atngw100_mrmt_defconfig
blackfin               BF518F-EZBRD_defconfig
blackfin                  TCM-BF518_defconfig
i386                     randconfig-a0-201525
x86_64                 randconfig-a0-06230236
x86_64                 randconfig-a0-06230311
x86_64                 randconfig-a0-06230328
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                          exynos_defconfig
parisc                         b180_defconfig
sh                               allyesconfig
i386                             allyesconfig
i386                   randconfig-c0-06230304
blackfin                       IP0X_defconfig
mips                           ip27_defconfig
arm                          collie_defconfig
arm                         hackkit_defconfig
arm                          simpad_defconfig
m32r                     mappi3.smp_defconfig
microblaze                        allnoconfig
mips                             allyesconfig
arm                        spear3xx_defconfig
powerpc                  storcenter_defconfig
xtensa                       common_defconfig
mips                        nlm_xlp_defconfig
powerpc                 linkstation_defconfig
sh                        sh7763rdp_defconfig
arm                        mvebu_v7_defconfig
sh                        edosk7705_defconfig
xtensa                          iss_defconfig
arm                       imx_v6_v7_defconfig
blackfin                  TCM-BF537_defconfig
m68k                       m5475evb_defconfig
arm                        cerfcube_defconfig
arm                        raumfeld_defconfig
powerpc                     sequoia_defconfig
arm                              alldefconfig
arm                           sama5_defconfig
powerpc                      ppc6xx_defconfig
x86_64                 randconfig-v0-06230226
x86_64                 randconfig-v0-06230231
x86_64                 randconfig-v0-06230239
x86_64                 randconfig-v0-06230244
x86_64                 randconfig-v0-06230254
x86_64                 randconfig-v0-06230307
x86_64                 randconfig-v0-06230314
x86_64                 randconfig-v0-06230325
x86_64                            allnoconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
arm                          pcm027_defconfig
avr32                             allnoconfig
blackfin                BF538-EZKIT_defconfig
tile                                defconfig
arm                          imote2_defconfig
blackfin                    PNAV-10_defconfig
xtensa                              defconfig
powerpc                      ep88xc_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
blackfin                   CM-BF533_defconfig
mips                        msp71xx_defconfig
tile                             alldefconfig
powerpc                  mpc866_ads_defconfig
sh                           se7721_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                              allyesconfig
arm                           sunxi_defconfig
powerpc                           allnoconfig
sh                     sh7710voipgw_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201525
i386                   randconfig-b0-06230222
i386                   randconfig-b0-06230231
i386                   randconfig-b0-06230239
i386                   randconfig-b0-06230247
i386                   randconfig-b0-06230302
i386                   randconfig-b0-06230311
i386                   randconfig-b0-06230317
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                         orion5x_defconfig
avr32                               defconfig
parisc                        c8000_defconfig
arm                             ezx_defconfig
arm                          nuc960_defconfig
ia64                            sim_defconfig
sh                          sdk7780_defconfig
alpha                             allnoconfig
m32r                        oaks32r_defconfig
openrisc                            defconfig
parisc                            allnoconfig
alpha                            allyesconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc85xx_smp_defconfig
arm                         nhk8815_defconfig
powerpc                   currituck_defconfig
powerpc                     mpc5200_defconfig
sh                           se7722_defconfig
arm                           bockw_defconfig
mips                           ip28_defconfig
powerpc                      katmai_defconfig
sh                         ap325rxa_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201525
x86_64                 randconfig-b0-06230231
x86_64                 randconfig-b0-06230236
x86_64                 randconfig-b0-06230258
x86_64                 randconfig-b0-06230310
x86_64                 randconfig-b0-06230325
x86_64                           allmodconfig
cris                 etrax-100lx_v2_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
arm                            hisi_defconfig
frv                                 defconfig
mips                         bigsur_defconfig
powerpc                     ppa8548_defconfig
arm                            mmp2_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201525
i386                     randconfig-n1-201525
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-06230242
i386                   randconfig-h1-06230242
arm                          pxa168_defconfig
arm                        spear6xx_defconfig
powerpc                     taishan_defconfig
powerpc                     asp8347_defconfig
powerpc                  gef_sbc310_defconfig
powerpc                      mgcoge_defconfig
powerpc                      obs600_defconfig
arm                     davinci_all_defconfig
mips                       capcella_defconfig
mips                           xway_defconfig
arm                      acs5k_tiny_defconfig
arm                           h5000_defconfig
m32r                    mappi.nommu_defconfig
blackfin                          allnoconfig
mips                         tb0287_defconfig
sh                          urquell_defconfig
x86_64                 randconfig-h0-06230222
x86_64                 randconfig-h0-06230238
x86_64                 randconfig-h0-06230255
x86_64                 randconfig-h0-06230313
x86_64                 randconfig-h0-06230321
x86_64                 randconfig-n0-06230225
x86_64                 randconfig-n0-06230235
x86_64                 randconfig-n0-06230243
x86_64                 randconfig-n0-06230255
x86_64                 randconfig-n0-06230305
x86_64                 randconfig-n0-06230314
arm                                    sa1100
arm                          prima2_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
powerpc                          g5_defconfig
mips                       lemote2f_defconfig
powerpc                      virtex_defconfig
arm                           acs5k_defconfig
arm                         cm_x2xx_defconfig
avr32                  atngw100mkii_defconfig
m32r                    m32700ut.up_defconfig
powerpc                  iss476-smp_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                   lite5200b_defconfig
powerpc                     akebono_defconfig
sh                           se7705_defconfig
arm                            dove_defconfig
sh                         ecovec24_defconfig
arm                         lubbock_defconfig
m68k                          multi_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-06230226
i386                  randconfig-sb0-06230235
i386                  randconfig-sb0-06230243
i386                  randconfig-sb0-06230252
i386                  randconfig-sb0-06230306
i386                  randconfig-sb0-06230319
avr32                     atstk1006_defconfig
mips                 pnx8335_stb225_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      tct_hammer_defconfig
sh                           se7724_defconfig
arm                          pxa910_defconfig
powerpc                     sbc834x_defconfig
x86_64                 randconfig-x006-201525
x86_64                 randconfig-x005-201525
x86_64                 randconfig-x009-201525
x86_64                 randconfig-x000-201525
x86_64                 randconfig-x003-201525
x86_64                 randconfig-x007-201525
x86_64                 randconfig-x001-201525
x86_64                 randconfig-x002-201525
x86_64                 randconfig-x008-201525
x86_64                 randconfig-x004-201525
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201525
x86_64                 randconfig-r0-06230227
x86_64                 randconfig-r0-06230243
x86_64                 randconfig-r0-06230304
x86_64                 randconfig-r0-06230324
parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
powerpc                     ep8248e_defconfig
sh                           cayman_defconfig
mips                      bmips_stb_defconfig
xtensa                  audio_kc705_defconfig
mips                          sead3_defconfig
sh                      rts7751r2d1_defconfig
sparc                       sparc64_defconfig
mips                         mpc30x_defconfig
powerpc                       holly_defconfig
x86_64                           alldefconfig
powerpc                     kmeter1_defconfig
x86_64                 randconfig-s0-06230225
x86_64                 randconfig-s0-06230244
x86_64                 randconfig-s0-06230302
x86_64                 randconfig-s0-06230313
x86_64                 randconfig-s0-06230322
openrisc                    or1ksim_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
tile                         tilegx_defconfig
i386                   randconfig-x006-201525
i386                   randconfig-x007-201525
i386                   randconfig-x002-201525
i386                   randconfig-x001-201525
i386                   randconfig-x003-201525
i386                   randconfig-x000-201525
i386                   randconfig-x005-201525
i386                   randconfig-x009-201525
i386                   randconfig-x008-201525
i386                   randconfig-x004-201525
i386                   randconfig-x0-06230222
i386                   randconfig-x0-06230234
i386                   randconfig-x0-06230250
i386                   randconfig-x0-06230305
i386                   randconfig-x0-06230321

Thanks,
Fengguang
