From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 15 Jun 2015 19:24:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 0bcc39e1cd4b3748b4466b041d2ed69abb56a42b BUILD DONE
Message-ID: <557eb5f4.5SV8pakHD52fvsow%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
0bcc39e1cd4b3748b4466b041d2ed69abb56a42b  e1000e: fix locking issue with e1000e_disable_aspm

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
??? i386-randconfig-b0-06151911
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? i386-randconfig-x0-06151843
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? sparc-sparc64_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-b0-06151900
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-r0-06151904
    ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used

5 directories, 14 files

elapsed time: 76m

configs tested: 73

m68k                            mac_defconfig
mips                         rt305x_defconfig
arm                         cm_x300_defconfig
powerpc                     mpc86xx_defconfig
powerpc                      pasemi_defconfig
i386                   randconfig-c0-06151757
i386                   randconfig-c0-06151837
arm                        realview_defconfig
arm                         s5pv210_defconfig
mips                            ar7_defconfig
arm                          exynos_defconfig
powerpc                     mpc85xx_defconfig
um                                  defconfig
arm                           bockw_defconfig
arm                      jornada720_defconfig
m32r                      mappi.smp_defconfig
m68k                          hp300_defconfig
mips                          rm200_defconfig
sparc                            allyesconfig
x86_64                 randconfig-v0-06151758
x86_64                 randconfig-v0-06151811
x86_64                 randconfig-v0-06151828
x86_64                 randconfig-v0-06151839
x86_64                 randconfig-v0-06151857
x86_64                 randconfig-v0-06151905
x86_64                 randconfig-v0-06151913
i386                   randconfig-b0-06151801
i386                   randconfig-b0-06151813
i386                   randconfig-b0-06151824
i386                   randconfig-b0-06151835
i386                   randconfig-b0-06151844
i386                   randconfig-b0-06151857
i386                   randconfig-b0-06151906
i386                   randconfig-b0-06151911
x86_64                 randconfig-b0-06151804
x86_64                 randconfig-b0-06151821
x86_64                 randconfig-b0-06151850
x86_64                 randconfig-b0-06151900
x86_64                 randconfig-b0-06151912
i386                   randconfig-h0-06151826
i386                   randconfig-h1-06151826
powerpc                     asp8347_defconfig
powerpc                  mpc866_ads_defconfig
sparc                       sparc64_defconfig
blackfin                BF609-EZKIT_defconfig
powerpc                 canyonlands_defconfig
sh                   secureedge5410_defconfig
mips                      maltasmvp_defconfig
mips                          sead3_defconfig
powerpc                     ppa8548_defconfig
x86_64                 randconfig-h0-06151802
x86_64                 randconfig-h0-06151824
x86_64                 randconfig-h0-06151855
x86_64                 randconfig-h0-06151910
x86_64                 randconfig-n0-06151812
x86_64                 randconfig-n0-06151837
x86_64                 randconfig-n0-06151858
x86_64                 randconfig-n0-06151905
arm                         shannon_defconfig
arm                        vexpress_defconfig
avr32                      atngw100_defconfig
i386                  randconfig-sb0-06151807
i386                  randconfig-sb0-06151830
i386                  randconfig-sb0-06151847
x86_64                 randconfig-r0-06151758
x86_64                 randconfig-r0-06151838
x86_64                 randconfig-r0-06151904
x86_64                 randconfig-s0-06151755
x86_64                 randconfig-s0-06151816
x86_64                 randconfig-s0-06151843
i386                   randconfig-x0-06151800
i386                   randconfig-x0-06151829
i386                   randconfig-x0-06151843

Thanks,
Fengguang
