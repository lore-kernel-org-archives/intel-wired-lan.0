From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 07 Aug 2015 15:31:34 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 85880cd3b12d7274e87e670cabbe6aa1e9480415 BUILD DONE
Message-ID: <55c45ed6.8ThcSvYF5yCVLzEv%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
85880cd3b12d7274e87e670cabbe6aa1e9480415  ixgbevf: Enables TSO for stacked vlan

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1499:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' [-Wformat=]
drivers/net/ethernet/intel/igb/igb_main.c:2652:2: error: implicit declaration of function 'igb_disable_sriov' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? arm-tegra_defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? i386-randconfig-x004-08062210
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-x003-08062208
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32

elapsed time: 81m

configs tested: 103

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201531
x86_64                           allmodconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201531
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201531
i386                     randconfig-i0-201531
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
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
i386                             allyesconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                                    lkp
x86_64                                   rhel
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64               randconfig-x006-08062208
x86_64               randconfig-x000-08062208
x86_64               randconfig-x001-08062208
x86_64               randconfig-x003-08062208
x86_64               randconfig-x007-08062208
x86_64               randconfig-x004-08062208
x86_64               randconfig-x008-08062208
x86_64               randconfig-x009-08062208
x86_64               randconfig-x002-08062208
x86_64               randconfig-x005-08062208
i386                     randconfig-r0-201531
i386                 randconfig-x006-08062210
i386                 randconfig-x002-08062210
i386                 randconfig-x007-08062210
i386                 randconfig-x008-08062210
i386                 randconfig-x009-08062210
i386                 randconfig-x004-08062210
i386                 randconfig-x005-08062210
i386                 randconfig-x000-08062210
i386                 randconfig-x001-08062210
i386                 randconfig-x003-08062210
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
