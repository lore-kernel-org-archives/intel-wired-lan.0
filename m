From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 19 Jun 2015 09:48:28 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 cf5195d0002f33b3398ddd8cd61b0ed3f33a81c9 BUILD DONE
Message-ID: <558374ec.qvWOPWuZVe4vmhX4%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
cf5195d0002f33b3398ddd8cd61b0ed3f33a81c9  ixgbe: Remove unused PCI bus types

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/e1000e/netdev.c:6454:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'

error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
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
??? i386-randconfig-x0-06190931
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? microblaze-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:warning:left-shift-count-width-of-type
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-high_16_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:note:in-expansion-of-macro-lower_32_bits
??? ??? drivers-net-ethernet-intel-i40evf-i40e_common.c:warning:cast-from-pointer-to-integer-of-different-size
??? powerpc-corenet64_smp_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? sparc-sparc64_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-n0-06190816
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-n0-06190940
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-v0-06190924
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used
??? x86_64-randconfig-x008-201524
    ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used

10 directories, 29 files

elapsed time: 131m

configs tested: 192

i386                     randconfig-a0-201524
x86_64                 randconfig-a0-06190749
x86_64                            allnoconfig
arm                          iop33x_defconfig
m68k                           sun3_defconfig
sh                     sh7710voipgw_defconfig
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
blackfin                  CM-BF537E_defconfig
mips                        jmr3927_defconfig
powerpc                             defconfig
i386                              allnoconfig
mips                          sead3_defconfig
xtensa                            allnoconfig
arm                        keystone_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7722_defconfig
arm                            lart_defconfig
mips                        qi_lb60_defconfig
powerpc                    sam440ep_defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-06190825
x86_64                 randconfig-v0-06190840
x86_64                 randconfig-v0-06190853
x86_64                 randconfig-v0-06190906
x86_64                 randconfig-v0-06190924
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
arm                         lubbock_defconfig
arm64                               defconfig
mips                        bcm47xx_defconfig
powerpc                      ppc6xx_defconfig
arm                        neponset_defconfig
arm                          prima2_defconfig
arm                    vt8500_v6_v7_defconfig
sh                           se7705_defconfig
arm                         bcm2835_defconfig
microblaze                       allyesconfig
openrisc                         alldefconfig
sh                           cayman_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201524
i386                   randconfig-b0-06190832
i386                   randconfig-b0-06190850
i386                   randconfig-b0-06190916
i386                   randconfig-b0-06190930
m68k                       m5208evb_defconfig
powerpc                 xes_mpc85xx_defconfig
s390                        default_defconfig
mips                          rb532_defconfig
s390                                defconfig
sh                          rsk7201_defconfig
sh                          sdk7780_defconfig
arm                              allmodconfig
mips                       bmips_be_defconfig
powerpc                     asp8347_defconfig
i386                     randconfig-i0-201524
i386                             allyesconfig
x86_64                 randconfig-b0-06190819
x86_64                 randconfig-b0-06190829
x86_64                 randconfig-b0-06190847
x86_64                 randconfig-b0-06190903
x86_64                 randconfig-b0-06190932
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201524
i386                     randconfig-n1-201524
i386                   randconfig-h0-06190755
i386                   randconfig-h1-06190755
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m32r                   m32700ut.smp_defconfig
mn10300                           allnoconfig
um                                  defconfig
mips                          rm200_defconfig
parisc                              defconfig
powerpc64                           defconfig
x86_64                 randconfig-h0-06190818
x86_64                 randconfig-h0-06190843
x86_64                 randconfig-h0-06190923
x86_64                 randconfig-h0-06190939
x86_64                 randconfig-n0-06190816
x86_64                 randconfig-n0-06190833
x86_64                 randconfig-n0-06190843
x86_64                 randconfig-n0-06190857
x86_64                 randconfig-n0-06190920
x86_64                 randconfig-n0-06190932
x86_64                 randconfig-n0-06190940
avr32                    hammerhead_defconfig
frv                               allnoconfig
powerpc                 mpc8272_ads_defconfig
arm                            dove_defconfig
frv                              alldefconfig
mips                      loongson3_defconfig
blackfin                  TCM-BF518_defconfig
mips                          malta_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-06190820
i386                  randconfig-sb0-06190842
i386                  randconfig-sb0-06190905
i386                  randconfig-sb0-06190932
alpha                               defconfig
arm                         iop13xx_defconfig
powerpc               corenet64_smp_defconfig
arm                       cns3420vb_defconfig
m32r                   mappi2.vdec2_defconfig
m68k                                defconfig
m32r                      mappi.smp_defconfig
m68k                       bvme6000_defconfig
powerpc                  mpc885_ads_defconfig
m68k                          sun3x_defconfig
powerpc                      acadia_defconfig
sh                        apsh4ad0a_defconfig
arm                             ezx_defconfig
arm                        magician_defconfig
xtensa                          iss_defconfig
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
x86_64                 randconfig-r0-06190841
x86_64                 randconfig-r0-06190918
x86_64                 randconfig-r0-06190935
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                            allnoconfig
arm                           bockw_defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
x86_64                 randconfig-s0-06190856
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
i386                   randconfig-x0-06190824
i386                   randconfig-x0-06190857
i386                   randconfig-x0-06190920
i386                   randconfig-x0-06190931

Thanks,
Fengguang
