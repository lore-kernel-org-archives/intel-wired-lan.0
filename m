From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 04 Oct 2015 19:12:28 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 8872663f877ba5918b2ce996c833ac89ca91b86c BUILD DONE
Message-ID: <5611099c.gNIEmLrL14wpkjRK%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
8872663f877ba5918b2ce996c833ac89ca91b86c  i40evf: fix compiler warning of unused variable

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2354:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]

Error ids grouped by kconfigs:

recent_errors
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 195m

configs tested: 186

blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
i386                     randconfig-a0-201540
x86_64                 randconfig-a0-10041152
arm                              allmodconfig
arm                        shmobile_defconfig
mips                          rm200_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-10041551
i386                   randconfig-c0-10041619
i386                   randconfig-c0-10041641
i386                   randconfig-c0-10041807
i386                   randconfig-c0-10041828
i386                   randconfig-c0-10041842
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
x86_64                 randconfig-v0-10041304
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
i386                             allmodconfig
arm                           omap1_defconfig
arm                        spear6xx_defconfig
arm64                            allyesconfig
mn10300                     asb2364_defconfig
powerpc                      katmai_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s1-201540
i386                     randconfig-s0-201540
x86_64                 randconfig-s0-10041527
x86_64                 randconfig-s1-10041527
x86_64                 randconfig-s2-10041527
x86_64                 randconfig-s0-10041622
x86_64                 randconfig-s1-10041622
x86_64                 randconfig-s2-10041622
x86_64                 randconfig-s0-10041756
x86_64                 randconfig-s1-10041756
x86_64                 randconfig-s2-10041756
x86_64                 randconfig-s0-10041831
x86_64                 randconfig-s1-10041831
x86_64                 randconfig-s2-10041831
x86_64                           allmodconfig
x86_64                 randconfig-s3-10041551
x86_64                 randconfig-s4-10041551
x86_64                 randconfig-s5-10041551
x86_64                 randconfig-s3-10041804
x86_64                 randconfig-s4-10041804
x86_64                 randconfig-s5-10041804
x86_64                 randconfig-s3-10041841
x86_64                 randconfig-s4-10041841
x86_64                 randconfig-s5-10041841
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                            allnoconfig
arm                          moxart_defconfig
powerpc                     rainier_defconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201540
i386                   randconfig-b0-10041052
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                          ks8695_defconfig
mips                           ci20_defconfig
mips                           ls1b_defconfig
sparc64                          allmodconfig
i386                     randconfig-i1-201540
i386                     randconfig-i0-201540
i386                             allyesconfig
x86_64                 randconfig-b0-10041522
x86_64                 randconfig-b0-10041811
x86_64                 randconfig-b0-10041829
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                          lpd270_defconfig
avr32                               defconfig
mips                         mpc30x_defconfig
powerpc                     mpc83xx_defconfig
frv                              alldefconfig
mips                        jmr3927_defconfig
sh                      rts7751r2d1_defconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201540
i386                   randconfig-h0-10041229
i386                   randconfig-h1-10041229
powerpc                     kmeter1_defconfig
sparc                       sparc32_defconfig
ia64                              allnoconfig
ia64                             alldefconfig
x86_64                 randconfig-h0-10041342
x86_64                 randconfig-n0-10041459
x86_64                 randconfig-n0-10041614
x86_64                 randconfig-n0-10041832
arm                         palmz72_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            hp6xx_defconfig
arm                           corgi_defconfig
arm                        mini2440_defconfig
microblaze                          defconfig
i386                  randconfig-sb0-10041554
i386                  randconfig-sb0-10041630
i386                  randconfig-sb0-10041752
i386                  randconfig-sb0-10041840
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
i386                     randconfig-r0-201540
x86_64                 randconfig-r0-10041426
x86_64                 randconfig-r0-10041803
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
i386                   randconfig-x0-10041436
i386                   randconfig-x0-10041638
i386                   randconfig-x0-10041827

Thanks,
Fengguang
