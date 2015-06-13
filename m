From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 13 Jun 2015 11:40:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 40b0c67d5b3b350e65d4fbe33dbb97eace9fae09 BUILD DONE
Message-ID: <557ba636.WGAH9PPF4uXIImAD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
40b0c67d5b3b350e65d4fbe33dbb97eace9fae09  ixgbe: Add support for UDP-encapsulated tx checksum offload

drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning: 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
drivers/net/ethernet/intel/i40e/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40e/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40e/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'
drivers/net/ethernet/intel/i40e/i40e_main.c:7601:2: warning: left shift count >= width of type
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:36: note: in expansion of macro 'high_16_bits'
drivers/net/ethernet/intel/i40evf/i40e_common.c:444:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/net/ethernet/intel/i40evf/i40e_common.c:445:35: note: in expansion of macro 'lower_32_bits'

elapsed time: 275m

configs tested: 138

arm                       omap2plus_defconfig
blackfin                            defconfig
powerpc                 mpc832x_rdb_defconfig
i386                     randconfig-a0-201523
x86_64                 randconfig-a0-06131114
x86_64                 randconfig-a0-06131128
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-c0-06131108
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
mips                           ip32_defconfig
parisc                generic-32bit_defconfig
powerpc                   lite5200b_defconfig
blackfin                BF561-EZKIT_defconfig
powerpc                     kmp204x_defconfig
powerpc                     tqm5200_defconfig
arm                          pxa168_defconfig
powerpc                      ppc64e_defconfig
s390                           gcov_defconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-06131055
x86_64                 randconfig-v0-06131105
x86_64                 randconfig-v0-06131115
x86_64                 randconfig-v0-06131120
x86_64                 randconfig-v0-06131125
x86_64                 randconfig-v0-06131130
arm                       imx_v6_v7_defconfig
arm                             rpc_defconfig
m68k                              allnoconfig
sh                           se7206_defconfig
powerpc                          alldefconfig
powerpc                       ebony_defconfig
powerpc                 mpc8272_ads_defconfig
sh                           sh2007_defconfig
arm                        multi_v7_defconfig
arm                      pxa255-idp_defconfig
mn10300                          allyesconfig
sh                   sh7770_generic_defconfig
x86_64                   randconfig-i0-201523
i386                   randconfig-b0-06131100
i386                   randconfig-b0-06131107
i386                   randconfig-b0-06131120
i386                   randconfig-b0-06131127
i386                   randconfig-b0-06131133
i386                             alldefconfig
powerpc                      walnut_defconfig
powerpc64                        allyesconfig
s390                                defconfig
blackfin                       SRV1_defconfig
m68k                        mvme16x_defconfig
microblaze                          defconfig
powerpc                      pasemi_defconfig
blackfin                         alldefconfig
m68k                            q40_defconfig
parisc                        c3000_defconfig
arm                           sunxi_defconfig
mips                         db1xxx_defconfig
mips                     decstation_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                                 defconfig
arm                           kzm9g_defconfig
sparc                            alldefconfig
arm                        vexpress_defconfig
blackfin                    PNAV-10_defconfig
m32r                    mappi2.opsp_defconfig
powerpc                      virtex_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201523
i386                             allyesconfig
x86_64                 randconfig-b0-06131104
x86_64                 randconfig-b0-06131109
x86_64                 randconfig-b0-06131115
x86_64                 randconfig-b0-06131121
x86_64                 randconfig-b0-06131127
x86_64                 randconfig-b0-06131135
arm                          ixp4xx_defconfig
arm                       netwinder_defconfig
avr32                        merisc_defconfig
i386                   randconfig-h0-06131113
i386                   randconfig-h1-06131113
x86_64                 randconfig-h0-06131106
x86_64                 randconfig-h0-06131112
x86_64                 randconfig-h0-06131122
x86_64                 randconfig-h0-06131129
x86_64                                    lkp
x86_64                                   rhel
x86_64                 randconfig-n0-06131057
x86_64                 randconfig-n0-06131104
x86_64                 randconfig-n0-06131120
arm                          prima2_defconfig
arm                       spear13xx_defconfig
arm                          marzen_defconfig
arm                          ep93xx_defconfig
microblaze                       allmodconfig
avr32                      atngw100_defconfig
avr32                       favr-32_defconfig
sh                          rsk7201_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-06131100
i386                  randconfig-sb0-06131111
i386                  randconfig-sb0-06131120
i386                  randconfig-sb0-06131128
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
x86_64                 randconfig-r0-06131101
x86_64                 randconfig-r0-06131109
x86_64                 randconfig-r0-06131116
x86_64                 randconfig-r0-06131130
x86_64                 randconfig-s0-06131059
x86_64                 randconfig-s0-06131121
x86_64                 randconfig-s0-06131127
i386                   randconfig-x0-06131054
i386                   randconfig-x0-06131124

Thanks,
Fengguang
