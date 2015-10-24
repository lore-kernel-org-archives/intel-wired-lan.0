From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 24 Oct 2015 08:47:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 6d52a6a8fd3a0d5138ce258fd40f792d729b9719 BUILD DONE
Message-ID: <562ad52f.Q5LolnMrOLmfbX0G%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6d52a6a8fd3a0d5138ce258fd40f792d729b9719  ixgbe: Reset interface after enabling SR-IOV

drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1755:2: error: too many arguments to function 'fm10k_dcbnl_set_ops'
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? i386-randconfig-a0-201542
??? ??? drivers-net-ethernet-intel-fm10k-fm10k_pci.c:error:too-many-arguments-to-function-fm10k_dcbnl_set_ops
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 82m

configs tested: 118

i386                     randconfig-a0-201542
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                            allnoconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
x86_64               randconfig-x013-10211707
x86_64               randconfig-x014-10211707
x86_64               randconfig-x011-10211707
x86_64               randconfig-x010-10211707
x86_64               randconfig-x015-10211707
x86_64               randconfig-x016-10211707
x86_64               randconfig-x012-10211707
x86_64               randconfig-x019-10211707
x86_64               randconfig-x017-10211707
x86_64               randconfig-x018-10211707
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201542
i386                     randconfig-s1-201542
x86_64                           allmodconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-i0-10232128
i386                   randconfig-b0-10240709
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201542
i386                     randconfig-i1-201542
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                     randconfig-n0-201542
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-n0-10232136
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
microblaze                        allnoconfig
mips                         tb0287_defconfig
sh                     magicpanelr2_defconfig
x86_64               randconfig-x001-10211812
x86_64               randconfig-x004-10211812
x86_64               randconfig-x005-10211812
x86_64               randconfig-x003-10211812
x86_64               randconfig-x007-10211812
x86_64               randconfig-x000-10211812
x86_64               randconfig-x009-10211812
x86_64               randconfig-x002-10211812
x86_64               randconfig-x008-10211812
x86_64               randconfig-x006-10211812
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-r0-201542
i386                 randconfig-x008-10211814
i386                 randconfig-x002-10211814
i386                 randconfig-x009-10211814
i386                 randconfig-x003-10211814
i386                 randconfig-x004-10211814
i386                 randconfig-x005-10211814
i386                 randconfig-x006-10211814
i386                 randconfig-x000-10211814
i386                 randconfig-x007-10211814
i386                 randconfig-x001-10211814

Thanks,
Fengguang
