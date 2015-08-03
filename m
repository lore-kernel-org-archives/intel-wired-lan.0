From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 04 Aug 2015 07:46:07 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 2962d8ece2d4a8ed7a48258a1a6a14c4574b6e31 BUILD DONE
Message-ID: <55bffd3f.F/JB9pG2NcQ/tWyJ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
2962d8ece2d4a8ed7a48258a1a6a14c4574b6e31  e1000e: Fix a null dereference in e1000_open

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1499:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' [-Wformat=]
drivers/net/ethernet/intel/igb/igb_main.c:2651:2: error: implicit declaration of function 'igb_disable_sriov' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:153:1-7: WARNING: end returns can be simpified

Error ids grouped by kconfigs:

recent_errors
??? arm-tegra_defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:WARNING:end-returns-can-be-simpified
??? i386-randconfig-x000-201531
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-x001-201531
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-x009-201531
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32

elapsed time: 63m

configs tested: 101

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201531
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
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
x86_64                            allnoconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201531
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201531
i386                     randconfig-i0-201531
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                     randconfig-n1-201531
i386                     randconfig-n0-201531
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                                       mmp
arm                           tegra_defconfig
arm                                      arm5
arm                                     arm67
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
x86_64                                    lkp
x86_64                                   rhel
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                 randconfig-x001-201531
x86_64                 randconfig-x004-201531
x86_64                 randconfig-x000-201531
x86_64                 randconfig-x006-201531
x86_64                 randconfig-x003-201531
x86_64                 randconfig-x009-201531
x86_64                 randconfig-x005-201531
x86_64                 randconfig-x002-201531
x86_64                 randconfig-x008-201531
x86_64                 randconfig-x007-201531
i386                     randconfig-r0-201531
i386                   randconfig-x000-201531
i386                   randconfig-x004-201531
i386                   randconfig-x001-201531
i386                   randconfig-x008-201531
i386                   randconfig-x005-201531
i386                   randconfig-x003-201531
i386                   randconfig-x007-201531
i386                   randconfig-x002-201531
i386                   randconfig-x006-201531
i386                   randconfig-x009-201531

Thanks,
Fengguang
