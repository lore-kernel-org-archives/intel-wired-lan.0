From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 05 Oct 2015 07:28:11 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 3ac370e7d4a6aa840f71d8338d27a93e65ba1cf5 BUILD DONE
Message-ID: <5611b60b.9jbQdJFit4ZawwOf%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
3ac370e7d4a6aa840f71d8338d27a93e65ba1cf5  ixgbe: Remove CS4227 diagnostic code

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000e/netdev.c:6788:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? microblaze-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-h0-10040758
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-n0-10040721
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-randconfig-s1-10040830
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-x004-201540
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-rhel+CONFIG_DEBUG_INFO_REDUCED
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 1451m

configs tested: 206

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
i386                     randconfig-a0-201540
i386                   randconfig-a0-10040759
x86_64                 randconfig-a0-10040759
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                            allnoconfig
arm                        raumfeld_defconfig
powerpc                     mpc512x_defconfig
powerpc                  storcenter_defconfig
blackfin                    PNAV-10_defconfig
powerpc64                        allmodconfig
powerpc64                           defconfig
arm                             mxs_defconfig
powerpc                     tqm8555_defconfig
tile                         tilegx_defconfig
arm                     eseries_pxa_defconfig
arm                          pcm027_defconfig
sh                           se7206_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-10040800
i386                   randconfig-c0-10040908
x86_64                           allmodconfig
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
arm                         s3c2410_defconfig
microblaze                       allmodconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                             allyesconfig
x86_64                 randconfig-v0-10040656
parisc                         b180_defconfig
i386                             allmodconfig
sh                                  defconfig
arm                          collie_defconfig
arm                       mainstone_defconfig
arm                            u300_defconfig
m68k                       m5275evb_defconfig
powerpc                  gef_sbc610_defconfig
arm                         shannon_defconfig
arm                           spitz_defconfig
avr32                        merisc_defconfig
sh                   sh7770_generic_defconfig
x86_64               randconfig-x010-10040830
x86_64               randconfig-x011-10040830
x86_64               randconfig-x012-10040830
x86_64               randconfig-x013-10040830
x86_64               randconfig-x014-10040830
x86_64               randconfig-x015-10040830
x86_64               randconfig-x016-10040830
x86_64               randconfig-x017-10040830
x86_64               randconfig-x018-10040830
x86_64               randconfig-x019-10040830
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-10040830
i386                   randconfig-s1-10040830
x86_64                 randconfig-s0-10040830
x86_64                 randconfig-s1-10040830
x86_64                 randconfig-s2-10040830
x86_64                 randconfig-s3-10040830
x86_64                 randconfig-s4-10040830
x86_64                 randconfig-s5-10040830
x86_64                 randconfig-s3-10040922
x86_64                 randconfig-s4-10040922
x86_64                 randconfig-s5-10040922
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                          moxart_defconfig
powerpc                     rainier_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201540
x86_64                 randconfig-i0-10040800
i386                   randconfig-b0-10040800
mips                       rbtx49xx_defconfig
powerpc                     virtex5_defconfig
sh                        apsh4ad0a_defconfig
m68k                             allyesconfig
mips                       lemote2f_defconfig
mips                        nlm_xlp_defconfig
s390                                defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201540
i386                     randconfig-i0-201540
x86_64                 randconfig-b0-10040742
x86_64                 randconfig-b0-10040844
x86_64                 randconfig-b0-10040929
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                           tegra_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                   randconfig-n0-10040721
i386                     randconfig-n0-201540
i386                   randconfig-h0-10040801
i386                   randconfig-h1-10040801
powerpc                    gamecube_defconfig
sh                           se7750_defconfig
xtensa                  audio_kc705_defconfig
ia64                              allnoconfig
ia64                             alldefconfig
x86_64         rhel+CONFIG_DEBUG_INFO_REDUCED
x86_64                 randconfig-h0-10040758
x86_64                 randconfig-n0-10040721
x86_64                 randconfig-n0-10040826
x86_64                 randconfig-n0-10040931
i386                  randconfig-sb0-10040801
x86_64                 randconfig-x002-201540
x86_64                 randconfig-x009-201540
x86_64                 randconfig-x003-201540
x86_64                 randconfig-x000-201540
x86_64                 randconfig-x004-201540
x86_64                 randconfig-x001-201540
x86_64                 randconfig-x006-201540
x86_64                 randconfig-x007-201540
x86_64                 randconfig-x008-201540
x86_64                 randconfig-x005-201540
x86_64               randconfig-x000-10040759
x86_64               randconfig-x001-10040759
x86_64               randconfig-x002-10040759
x86_64               randconfig-x003-10040759
x86_64               randconfig-x004-10040759
x86_64               randconfig-x005-10040759
x86_64               randconfig-x006-10040759
x86_64               randconfig-x007-10040759
x86_64               randconfig-x008-10040759
x86_64               randconfig-x009-10040759
i386                     randconfig-r0-201540
i386                   randconfig-r0-10040759
x86_64                 randconfig-r0-10040759
x86_64                 randconfig-r0-10040908
arm                           bockw_defconfig
blackfin                   CM-BF561_defconfig
ia64                             allyesconfig
i386                   randconfig-x004-201540
i386                   randconfig-x009-201540
i386                   randconfig-x003-201540
i386                   randconfig-x007-201540
i386                   randconfig-x006-201540
i386                   randconfig-x005-201540
i386                   randconfig-x008-201540
i386                   randconfig-x002-201540
i386                   randconfig-x001-201540
i386                   randconfig-x000-201540
i386                 randconfig-x000-10040759
i386                 randconfig-x001-10040759
i386                 randconfig-x002-10040759
i386                 randconfig-x003-10040759
i386                 randconfig-x004-10040759
i386                 randconfig-x005-10040759
i386                 randconfig-x006-10040759
i386                 randconfig-x007-10040759
i386                 randconfig-x008-10040759
i386                 randconfig-x009-10040759
i386                   randconfig-x0-10040759

Thanks,
Fengguang
