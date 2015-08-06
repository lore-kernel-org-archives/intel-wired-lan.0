From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 07 Aug 2015 06:12:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 c65b5882ddf44d8a80fa2753bd7db42503308f72 BUILD DONE
Message-ID: <55c3dbc6.O9hohpO4AnKOyyo+%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
c65b5882ddf44d8a80fa2753bd7db42503308f72  igb: Fix a deadlock in igb_sriov_reinit

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
??? i386-randconfig-c0-08070244
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? i386-randconfig-c0-08070317
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? i386-randconfig-r0-08062208
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? i386-randconfig-sb0-08070308
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? i386-randconfig-x004-08062210
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-a0-08070508
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-b0-08070241
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-b0-08070603
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov
??? x86_64-randconfig-x003-08062208
    ??? drivers-net-ethernet-intel-igb-igb_main.c:error:implicit-declaration-of-function-igb_disable_sriov

elapsed time: 327m

configs tested: 131

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
i386                   randconfig-a0-08062207
x86_64                 randconfig-a0-08070312
x86_64                 randconfig-a0-08070434
x86_64                 randconfig-a0-08070508
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                            allnoconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                             allyesconfig
i386                   randconfig-c0-08070244
i386                   randconfig-c0-08070317
i386                   randconfig-c0-08070431
i386                   randconfig-c0-08070520
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-v0-08070055
x86_64                 randconfig-v0-08070437
x86_64                 randconfig-v0-08070522
x86_64                 randconfig-v0-08070602
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
arm64                            alldefconfig
mips                        bcm63xx_defconfig
parisc                         a500_defconfig
powerpc                 linkstation_defconfig
arm                          nuc950_defconfig
blackfin                          allnoconfig
powerpc                     sbc8548_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-08070100
i386                   randconfig-i1-08070100
x86_64                 randconfig-b0-08070314
x86_64                 randconfig-b0-08070522
x86_64                 randconfig-b0-08070603
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
ia64                              allnoconfig
ia64                             alldefconfig
x86_64                                   rhel
x86_64                 randconfig-h0-08070252
x86_64                 randconfig-h0-08070321
x86_64                 randconfig-h0-08070527
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
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
m68k                          amiga_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                  randconfig-sb0-08070236
i386                  randconfig-sb0-08070308
i386                  randconfig-sb0-08070429
i386                  randconfig-sb0-08070527
i386                  randconfig-sb0-08070604
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
i386                   randconfig-r0-08062208
x86_64                 randconfig-r0-08070302
x86_64                 randconfig-r0-08070433
x86_64                 randconfig-r0-08070509
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
i386                   randconfig-x0-08070227
i386                   randconfig-x0-08070307
i386                   randconfig-x0-08070428
i386                   randconfig-x0-08070529

Thanks,
Fengguang
