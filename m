From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 07 Aug 2015 09:16:10 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 5ead6633e742655fb2bd08178f27c60b82b6598c BUILD DONE
Message-ID: <55c406da.8xvfNJdnVetSH7dl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
5ead6633e742655fb2bd08178f27c60b82b6598c  e1000e: Modify tx/rx configurations to avoid null pointer dereferences in e1000_open

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1499:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' [-Wformat=]
drivers/net/ethernet/intel/igb/igb_main.c:2651:2: error: implicit declaration of function 'igb_disable_sriov' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:153:1-7: WARNING: end returns can be simpified

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_x550.c:WARNING:end-returns-can-be-simpified
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? i386-randconfig-x004-08062210
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? i386-randconfig-x0-08070733
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-b0-08070816
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-h0-08070857
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-r0-08070832
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-x003-08062208
    ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov

elapsed time: 149m

configs tested: 120

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
i386                     randconfig-a0-201531
x86_64                 randconfig-a0-08070842
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                            allnoconfig
i386                   randconfig-c0-08070731
i386                   randconfig-c0-08070803
i386                   randconfig-c0-08070854
ia64                              allnoconfig
ia64                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-08070812
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
powerpc                     pseries_defconfig
sh                        edosk7760_defconfig
tile                             allyesconfig
arm                      tct_hammer_defconfig
avr32        atngw100mkii_evklcd101_defconfig
powerpc64                           defconfig
um                                allnoconfig
arm                         socfpga_defconfig
blackfin                          allnoconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201531
i386                     randconfig-i0-201531
i386                             allyesconfig
x86_64                 randconfig-b0-08070841
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
x86_64                                   rhel
x86_64                 randconfig-h0-08070816
x86_64                 randconfig-h0-08070857
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
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
i386                  randconfig-sb0-08070732
i386                  randconfig-sb0-08070809
x86_64                           allmodconfig
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
x86_64                                    lkp
i386                     randconfig-r0-201531
x86_64                 randconfig-r0-08070832
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
i386                   randconfig-x0-08070733
i386                   randconfig-x0-08070807
i386                   randconfig-x0-08070842

Thanks,
Fengguang
