From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 25 Sep 2015 08:03:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 e3f5a8c58524af3bd4bff1e2dcd809cb6c3d86c5 BUILD DONE
Message-ID: <56048f4d.eCICVRfHfN2dAVgC%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
e3f5a8c58524af3bd4bff1e2dcd809cb6c3d86c5  i40e: Fix basic support for X722 devices

drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked'
drivers/net/ethernet/intel/e1000e/netdev.c:6785:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000e/netdev.c:6788:3: error: implicit declaration of function 'e1000e_disable_aspm_locked' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? i386-randconfig-x000-09220931
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked
??? x86_64-randconfig-s0-09250725
    ??? drivers-net-ethernet-intel-e1000e-netdev.c:error:implicit-declaration-of-function-e1000e_disable_aspm_locked

elapsed time: 89m

configs tested: 141

i386                     randconfig-a0-201538
x86_64                 randconfig-a0-09250633
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                      default_defconfig
sh                            migor_defconfig
sh                   sh7770_generic_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-09250730
x86_64                 randconfig-v0-09250119
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
arm                     am200epdkit_defconfig
arm                            qcom_defconfig
avr32                    hammerhead_defconfig
blackfin                BF538-EZKIT_defconfig
blackfin                  CM-BF537U_defconfig
x86_64               randconfig-x010-09232308
x86_64               randconfig-x014-09232308
x86_64               randconfig-x018-09232308
x86_64               randconfig-x017-09232308
x86_64               randconfig-x012-09232308
x86_64               randconfig-x016-09232308
x86_64               randconfig-x013-09232308
x86_64               randconfig-x011-09232308
x86_64               randconfig-x015-09232308
x86_64               randconfig-x019-09232308
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
powerpc                           allnoconfig
i386                     randconfig-s1-201538
i386                     randconfig-s0-201538
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201538
i386                   randconfig-b0-09250717
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201538
i386                     randconfig-i0-201538
x86_64                 randconfig-b0-09250713
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
x86_64                            allnoconfig
arm                         ebsa110_defconfig
arm                           efm32_defconfig
arm                          ks8695_defconfig
powerpc                     ppa8548_defconfig
i386                     randconfig-n0-201538
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-09250704
i386                   randconfig-h1-09250704
mips                        msp71xx_defconfig
powerpc                 xes_mpc85xx_defconfig
x86_64                 randconfig-h0-09250647
x86_64                 randconfig-n0-09250709
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
blackfin                BF561-EZKIT_defconfig
powerpc                     sequoia_defconfig
sparc                             allnoconfig
i386                  randconfig-sb0-09250600
x86_64               randconfig-x001-09220935
x86_64               randconfig-x004-09220935
x86_64               randconfig-x006-09220935
x86_64               randconfig-x007-09220935
x86_64               randconfig-x000-09220935
x86_64               randconfig-x009-09220935
x86_64               randconfig-x002-09220935
x86_64               randconfig-x003-09220935
x86_64               randconfig-x005-09220935
x86_64               randconfig-x008-09220935
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-r0-201538
x86_64                 randconfig-r0-09250033
i386                             allmodconfig
i386                 randconfig-x007-09220931
i386                 randconfig-x001-09220931
i386                 randconfig-x002-09220931
i386                 randconfig-x005-09220931
i386                 randconfig-x008-09220931
i386                 randconfig-x003-09220931
i386                 randconfig-x006-09220931
i386                 randconfig-x000-09220931
i386                 randconfig-x004-09220931
i386                 randconfig-x009-09220931
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                   randconfig-x0-09250110

Thanks,
Fengguang
