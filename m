From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 20 Jun 2015 09:05:31 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 6dba68f05469150b74157301f5d11fb1dd568575 BUILD DONE
Message-ID: <5584bc5b.huJzatQHxKzzviYs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6dba68f05469150b74157301f5d11fb1dd568575  fm10k: don't store sw_vid at reset

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
??? x86_64-randconfig-x008-201524
    ??? drivers-net-ethernet-intel-e1000e-netdev.c:warning:e1000e_disable_aspm_locked-defined-but-not-used

3 directories, 15 files

elapsed time: 75m

configs tested: 131

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
blackfin          BF527-AD7160-EVAL_defconfig
m68k                                defconfig
powerpc                          allyesconfig
i386                     randconfig-a0-201524
x86_64                 randconfig-a0-06200527
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                           allmodconfig
blackfin                BF527-EZKIT_defconfig
s390                    performance_defconfig
i386                   randconfig-c0-06200636
x86_64                              defconfig
blackfin                  TCM-BF518_defconfig
powerpc                     mpc86xx_defconfig
x86_64                 randconfig-v0-06200803
x86_64                            allnoconfig
blackfin                      H8606_defconfig
mips                          malta_defconfig
mips                        qi_lb60_defconfig
sparc64                          alldefconfig
arm                              zx_defconfig
mn10300                           allnoconfig
powerpc                          g5_defconfig
xtensa                           allyesconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201524
i386                   randconfig-b0-06200758
i386                   randconfig-b0-06200824
arm                             rpc_defconfig
mips                           mtx1_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc834x_mds_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201524
i386                             allyesconfig
x86_64                 randconfig-b0-06200800
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201524
i386                     randconfig-n1-201524
i386                   randconfig-h0-06200645
i386                   randconfig-h1-06200645
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
arm                             mxs_defconfig
m68k                        m5307c3_defconfig
parisc                          712_defconfig
x86_64                 randconfig-h0-06200755
x86_64                 randconfig-n0-06200757
arm                                    sa1100
arm                          prima2_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                       spear13xx_defconfig
arm                                  iop-adma
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
openrisc                         allmodconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-06200746
mips                      pistachio_defconfig
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
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201524
x86_64                 randconfig-r0-06200731
mn10300                     asb2364_defconfig
sh                           se7751_defconfig
x86_64                 randconfig-s0-06200802
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
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
i386                   randconfig-x0-06200759
i386                   randconfig-x0-06200812

Thanks,
Fengguang
