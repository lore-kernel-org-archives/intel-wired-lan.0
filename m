From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 03 Oct 2015 11:45:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 f2e6d66d803276c3063ac0efa631e2fd6fe3e88a BUILD DONE
Message-ID: <560f4f41.K47Bn61iq4D3sNbs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
f2e6d66d803276c3063ac0efa631e2fd6fe3e88a  ixgbe: Remove CS4227 diagnostic code

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-b0-10030349
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-c0-10030839
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? i386-randconfig-c0-10030945
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? microblaze-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? microblaze-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-b0-10030213
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-randconfig-b0-10030714
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-randconfig-b0-10031002
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-r0-10030343
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-r0-10030809
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-s2-10030705
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-randconfig-s2-10030912
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-s3-10031110
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-randconfig-s4-10030524
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 554m

configs tested: 317

arm64                            allyesconfig
blackfin                          allnoconfig
m68k                            q40_defconfig
i386                     randconfig-a0-201539
x86_64                 randconfig-a0-10030133
x86_64                 randconfig-a0-10030328
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                            allnoconfig
arm                         mv78xx0_defconfig
mips                           ip32_defconfig
sparc                            allyesconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-10030237
i386                   randconfig-c0-10030337
i386                   randconfig-c0-10030454
i386                   randconfig-c0-10030525
i386                   randconfig-c0-10030555
i386                   randconfig-c0-10030638
i386                   randconfig-c0-10030839
i386                   randconfig-c0-10030917
i386                   randconfig-c0-10030945
i386                   randconfig-c0-10031012
i386                   randconfig-c0-10031040
x86_64                           allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
arm                         s3c2410_defconfig
microblaze                       allmodconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                             allyesconfig
x86_64                 randconfig-v0-10022033
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
arm                          badge4_defconfig
arm64                            allmodconfig
m68k                        mvme16x_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm5200_defconfig
arm                      pxa255-idp_defconfig
arm                          simpad_defconfig
arm                           tegra_defconfig
blackfin                       IP0X_defconfig
mips                           ci20_defconfig
x86_64                 randconfig-x014-201539
x86_64                 randconfig-x019-201539
x86_64                 randconfig-x016-201539
x86_64                 randconfig-x011-201539
x86_64                 randconfig-x018-201539
x86_64                 randconfig-x012-201539
x86_64                 randconfig-x017-201539
x86_64                 randconfig-x013-201539
x86_64                 randconfig-x015-201539
x86_64                 randconfig-x010-201539
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201539
i386                     randconfig-s0-201539
x86_64                 randconfig-s0-10030142
x86_64                 randconfig-s1-10030142
x86_64                 randconfig-s2-10030142
x86_64                 randconfig-s0-10030248
x86_64                 randconfig-s1-10030248
x86_64                 randconfig-s2-10030248
x86_64                 randconfig-s0-10030322
x86_64                 randconfig-s1-10030322
x86_64                 randconfig-s2-10030322
x86_64                 randconfig-s0-10030409
x86_64                 randconfig-s1-10030409
x86_64                 randconfig-s2-10030409
x86_64                 randconfig-s0-10030520
x86_64                 randconfig-s1-10030520
x86_64                 randconfig-s2-10030520
x86_64                 randconfig-s0-10030556
x86_64                 randconfig-s1-10030556
x86_64                 randconfig-s2-10030556
x86_64                 randconfig-s0-10030705
x86_64                 randconfig-s1-10030705
x86_64                 randconfig-s2-10030705
x86_64                 randconfig-s0-10030738
x86_64                 randconfig-s1-10030738
x86_64                 randconfig-s2-10030738
x86_64                 randconfig-s0-10030805
x86_64                 randconfig-s1-10030805
x86_64                 randconfig-s2-10030805
x86_64                 randconfig-s0-10030843
x86_64                 randconfig-s1-10030843
x86_64                 randconfig-s2-10030843
x86_64                 randconfig-s0-10030912
x86_64                 randconfig-s1-10030912
x86_64                 randconfig-s2-10030912
x86_64                 randconfig-s0-10030957
x86_64                 randconfig-s1-10030957
x86_64                 randconfig-s2-10030957
x86_64                 randconfig-s0-10031034
x86_64                 randconfig-s1-10031034
x86_64                 randconfig-s2-10031034
x86_64                 randconfig-s3-10030105
x86_64                 randconfig-s4-10030105
x86_64                 randconfig-s5-10030105
x86_64                 randconfig-s3-10030304
x86_64                 randconfig-s4-10030304
x86_64                 randconfig-s5-10030304
x86_64                 randconfig-s3-10030350
x86_64                 randconfig-s4-10030350
x86_64                 randconfig-s5-10030350
x86_64                 randconfig-s3-10030436
x86_64                 randconfig-s4-10030436
x86_64                 randconfig-s5-10030436
x86_64                 randconfig-s3-10030524
x86_64                 randconfig-s4-10030524
x86_64                 randconfig-s5-10030524
x86_64                 randconfig-s3-10030633
x86_64                 randconfig-s4-10030633
x86_64                 randconfig-s5-10030633
x86_64                 randconfig-s3-10030725
x86_64                 randconfig-s4-10030725
x86_64                 randconfig-s5-10030725
x86_64                 randconfig-s3-10030759
x86_64                 randconfig-s4-10030759
x86_64                 randconfig-s5-10030759
x86_64                 randconfig-s3-10030825
x86_64                 randconfig-s4-10030825
x86_64                 randconfig-s5-10030825
x86_64                 randconfig-s3-10030859
x86_64                 randconfig-s4-10030859
x86_64                 randconfig-s5-10030859
x86_64                 randconfig-s3-10030940
x86_64                 randconfig-s4-10030940
x86_64                 randconfig-s5-10030940
x86_64                 randconfig-s3-10031013
x86_64                 randconfig-s4-10031013
x86_64                 randconfig-s5-10031013
x86_64                 randconfig-s3-10031110
x86_64                 randconfig-s4-10031110
x86_64                 randconfig-s5-10031110
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
sh                               allmodconfig
sh                            hp6xx_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201539
i386                   randconfig-b0-10030108
i386                   randconfig-b0-10030315
i386                   randconfig-b0-10030334
i386                   randconfig-b0-10030349
i386                   randconfig-b0-10030406
i386                   randconfig-b0-10030437
i386                   randconfig-b0-10030733
i386                   randconfig-b0-10030809
i386                   randconfig-b0-10030849
i386                   randconfig-b0-10030908
i386                   randconfig-b0-10030950
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                          nuc950_defconfig
mips                        nlm_xlr_defconfig
arm                           corgi_defconfig
arm                    realview-smp_defconfig
mips                           xway_defconfig
arm                        multi_v5_defconfig
blackfin                    DNP5370_defconfig
powerpc                      pcm030_defconfig
sh                        edosk7760_defconfig
i386                     randconfig-i1-201539
i386                     randconfig-i0-201539
x86_64                 randconfig-b0-10030213
x86_64                 randconfig-b0-10030339
x86_64                 randconfig-b0-10030428
x86_64                 randconfig-b0-10030506
x86_64                 randconfig-b0-10030714
x86_64                 randconfig-b0-10030742
x86_64                 randconfig-b0-10030832
x86_64                 randconfig-b0-10030855
x86_64                 randconfig-b0-10030920
x86_64                 randconfig-b0-10030933
x86_64                 randconfig-b0-10031002
x86_64                 randconfig-b0-10031034
x86_64                 randconfig-b0-10031051
arm                              allmodconfig
arm                         iop13xx_defconfig
mips                            e55_defconfig
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201539
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
i386                   randconfig-h0-10030042
i386                   randconfig-h1-10030042
i386                   randconfig-h0-10030437
i386                   randconfig-h1-10030437
i386                   randconfig-h0-10030830
i386                   randconfig-h1-10030830
i386                   randconfig-h0-10030955
i386                   randconfig-h1-10030955
arm                         cm_x2xx_defconfig
ia64                        generic_defconfig
sh                             shx3_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
avr32                       mimc200_defconfig
blackfin                BF527-EZKIT_defconfig
blackfin                  CM-BF537U_defconfig
powerpc                     stx_gp3_defconfig
arm                            mmp2_defconfig
mips                            ar7_defconfig
powerpc                 mpc836x_mds_defconfig
avr32                 atngw100_mrmt_defconfig
mips                          malta_defconfig
sh                   sh7724_generic_defconfig
arm                       cns3420vb_defconfig
arm                          pcm027_defconfig
mips                       bmips_be_defconfig
mips                        qi_lb60_defconfig
powerpc                     asp8347_defconfig
powerpc                      katmai_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h0-10030048
x86_64                 randconfig-h0-10030528
x86_64                 randconfig-h0-10030824
x86_64                 randconfig-h0-10030925
x86_64                 randconfig-h0-10030946
x86_64                 randconfig-h0-10031041
arm                      acs5k_tiny_defconfig
arm                              allyesconfig
mips                        workpad_defconfig
i386                  randconfig-sb0-10022045
x86_64                 randconfig-x000-201539
x86_64                 randconfig-x001-201539
x86_64                 randconfig-x002-201539
x86_64                 randconfig-x003-201539
x86_64                 randconfig-x004-201539
x86_64                 randconfig-x005-201539
x86_64                 randconfig-x006-201539
x86_64                 randconfig-x007-201539
x86_64                 randconfig-x008-201539
x86_64                 randconfig-x009-201539
i386                     randconfig-r0-201539
x86_64                 randconfig-r0-10030112
x86_64                 randconfig-r0-10030343
x86_64                 randconfig-r0-10030407
x86_64                 randconfig-r0-10030526
x86_64                 randconfig-r0-10030557
x86_64                 randconfig-r0-10030638
x86_64                 randconfig-r0-10030741
x86_64                 randconfig-r0-10030809
x86_64                 randconfig-r0-10030907
x86_64                 randconfig-r0-10030946
x86_64                 randconfig-r0-10031042
blackfin              BF561-ACVILON_defconfig
powerpc                 canyonlands_defconfig
m68k                              allnoconfig
parisc                      default_defconfig
sh                      rts7751r2d1_defconfig
microblaze                       allyesconfig
sh                          landisk_defconfig
i386                   randconfig-x000-201539
i386                   randconfig-x005-201539
i386                   randconfig-x003-201539
i386                   randconfig-x007-201539
i386                   randconfig-x004-201539
i386                   randconfig-x001-201539
i386                   randconfig-x008-201539
i386                   randconfig-x006-201539
i386                   randconfig-x009-201539
i386                   randconfig-x002-201539
i386                   randconfig-x0-10022049
i386                   randconfig-x0-10030824
i386                   randconfig-x0-10030913
i386                   randconfig-x0-10031000
i386                   randconfig-x0-10031028

Thanks,
Fengguang
