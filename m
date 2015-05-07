From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 07 May 2015 14:28:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 ab8b8ac80a4b0a3f586f7bdae1ae1f13261b376f BUILD DONE
Message-ID: <554b0613.ycsrgsKQAWBA6ifx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
ab8b8ac80a4b0a3f586f7bdae1ae1f13261b376f  ixgbevf: add support for reporting RSS key and hash table for X550

drivers/net/ethernet/intel/e1000e/netdev.c:3811:30: sparse: incorrect type in assignment (different base types)
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:1551 i40e_active_vfs() warn: bit shifter 'I40E_VF_STAT_ACTIVE' used for logical '&'
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2082:22: sparse: restricted __le16 degrades to integer
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:981 i40e_pci_sriov_enable() warn: bit shifter '__I40E_TESTING' used for logical '&'
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:981 i40e_pci_sriov_enable() warn: bitwise AND condition is false here

elapsed time: 468m

configs tested: 185

i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                 randconfig-a0-05040840
x86_64                 randconfig-a1-05040840
x86_64                            allnoconfig
x86_64                     randconfig-c0-0504
x86_64                     randconfig-c1-0504
x86_64                     randconfig-c2-0504
i386                   randconfig-c0-05040833
i386                   randconfig-c1-05040833
arm             omap2plus_defconfig-gcc-4.9.0
arm                          sa1100-gcc-4.9.0
arm                    allmodconfig-gcc-4.9.0
arm                prima2_defconfig-gcc-4.9.0
arm               at91_dt_defconfig-gcc-4.9.0
arm                     allnoconfig-gcc-4.9.0
arm                         samsung-gcc-4.9.0
arm             spear13xx_defconfig-gcc-4.9.0
arm               s3c2410_defconfig-gcc-4.9.0
arm                        iop-adma-gcc-4.9.0
arm             imx_v6_v7_defconfig-gcc-4.9.0
arm                             mmp-gcc-4.9.0
arm                 tegra_defconfig-gcc-4.9.0
arm                            arm5-gcc-4.9.0
arm                marzen_defconfig-gcc-4.9.0
arm                        at_hdmac-gcc-4.9.0
arm                          ep93xx-gcc-4.9.0
arm                              sh-gcc-4.9.0
arm                           arm67-gcc-4.9.0
ia64                   allmodconfig-gcc-4.9.0
ia64                    allnoconfig-gcc-4.9.0
ia64                      defconfig-gcc-4.9.0
ia64                   alldefconfig-gcc-4.9.0
powerpc                   defconfig-gcc-4.9.0
powerpc             ppc64_defconfig-gcc-4.9.0
powerpc                 allnoconfig-gcc-4.9.0
powerpc                allmodconfig-gcc-4.9.0
x86_64                randconfig-iv0-05071008
x86_64                randconfig-iv1-05071008
i386                  randconfig-ib0-05071217
i386                  randconfig-ib1-05071217
sparc                     defconfig-gcc-4.9.0
sparc64                 allnoconfig-gcc-4.9.0
sparc64                   defconfig-gcc-4.9.0
xtensa             common_defconfig-gcc-4.9.0
m32r             m32104ut_defconfig-gcc-4.9.0
xtensa                iss_defconfig-gcc-4.9.0
m32r               opsput_defconfig-gcc-4.9.0
m32r                 usrv_defconfig-gcc-4.9.0
m32r           mappi3.smp_defconfig-gcc-4.9.0
microblaze            mmu_defconfig-gcc-4.9.0
microblaze          nommu_defconfig-gcc-4.9.0
microblaze             allyesconfig-gcc-4.9.0
s390                   allmodconfig-gcc-4.9.0
s390                    allnoconfig-gcc-4.9.0
s390                      defconfig-gcc-4.9.0
i386                             allyesconfig
x86_64                randconfig-ib0-05071328
parisc              c3000_defconfig-gcc-4.9.0
parisc               b180_defconfig-gcc-4.9.0
parisc                    defconfig-gcc-4.9.0
alpha                     defconfig-gcc-4.9.0
parisc                  allnoconfig-gcc-4.9.0
mips                          ath79_defconfig
powerpc                   lite5200b_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                          amiga_defconfig
arm                     eseries_pxa_defconfig
x86_64                       randconfig-nexe0
x86_64                       randconfig-nexe1
x86_64                       randconfig-nexe2
x86_64                       randconfig-nexe3
x86_64                       randconfig-nexe4
x86_64                       randconfig-nexe5
x86_64                       randconfig-nexe6
x86_64                       randconfig-nexe7
x86_64                       randconfig-nexe8
x86_64                       randconfig-nexe9
i386                         randconfig-nexe0
i386                         randconfig-nexe1
i386                         randconfig-nexe2
i386                         randconfig-nexe3
i386                         randconfig-nexe4
i386                         randconfig-nexe5
i386                         randconfig-nexe6
i386                         randconfig-nexe7
i386                         randconfig-nexe8
i386                         randconfig-nexe9
x86_64                  randconfig-nexr0-0505
x86_64                  randconfig-nexr1-0505
x86_64                  randconfig-nexr2-0505
i386                    randconfig-nexr0-0505
i386                    randconfig-nexr1-0505
i386                    randconfig-nexr2-0505
x86_64              randconfig-nexs0-05071253
i386                randconfig-nexs0-05071253
powerpc                      chroma_defconfig
powerpc               corenet64_smp_defconfig
powerpc                    gamecube_defconfig
powerpc                 linkstation_defconfig
powerpc                               mpc512x
powerpc                               powerpc
powerpc                                ppc44x
powerpc                         wii_defconfig
x86_64                 randconfig-n0-05071015
xtensa                 allyesconfig-gcc-4.9.0
sparc64                allyesconfig-gcc-4.9.0
mips                   allyesconfig-gcc-4.9.0
m68k                   allyesconfig-gcc-4.9.0
sparc                  allyesconfig-gcc-4.9.0
tile                   allyesconfig-gcc-4.6.2
alpha                  allyesconfig-gcc-4.9.0
powerpc                allyesconfig-gcc-4.9.0
sh                     allyesconfig-gcc-4.6.3
avr32                  allyesconfig-gcc-4.2.4
ia64                   allyesconfig-gcc-4.9.0
parisc                 allyesconfig-gcc-4.9.0
cris                   allyesconfig-gcc-4.6.3
blackfin               allyesconfig-gcc-4.6.3
s390                   allyesconfig-gcc-4.9.0
m68k                multi_defconfig-gcc-4.9.0
m68k             m5475evb_defconfig-gcc-4.9.0
m68k                   allmodconfig-gcc-4.9.0
m68k                amiga_defconfig-gcc-4.9.0
sh                  titan_defconfig-gcc-4.6.3
sh                rsk7269_defconfig-gcc-4.6.3
sh           sh7785lcr_32bit_defconfig-gcc-4.6.3
sh                      allnoconfig-gcc-4.6.3
x86_64                   allmodconfig-gcc-4.9
arm                         bcm2835_defconfig
arm                            hisi_defconfig
ia64                          tiger_defconfig
powerpc                      bamboo_defconfig
powerpc                       eiger_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386               randconfig-r0-0507-gcc-4.9
i386               randconfig-r2-0507-gcc-4.9
i386               randconfig-r1-0507-gcc-4.9
x86_64                 randconfig-r0-05071205
cris         etrax-100lx_v2_defconfig-gcc-4.6.3
blackfin        TCM-BF537_defconfig-gcc-4.6.3
blackfin     BF561-EZKIT-SMP_defconfig-gcc-4.6.3
blackfin      BF533-EZKIT_defconfig-gcc-4.6.3
blackfin      BF526-EZBRD_defconfig-gcc-4.6.3
x86_64                 randconfig-s0-05071042
x86_64                 randconfig-s1-05071042
mn10300           asb2364_defconfig-gcc-4.9.0
openrisc     or1ksim_defconfig-gcc-4.5.1-or32-1.0rc1
avr32            atngw100_defconfig-gcc-4.2.4
frv                       defconfig-gcc-4.9.0
avr32           atstk1006_defconfig-gcc-4.2.4
tile               tilegx_defconfig-gcc-4.6.2
x86_64                        randconfig-x000
x86_64                        randconfig-x001
x86_64                        randconfig-x002
x86_64                        randconfig-x003
x86_64                        randconfig-x004
x86_64                        randconfig-x005
x86_64                        randconfig-x006
x86_64                        randconfig-x007
x86_64                        randconfig-x008
x86_64                        randconfig-x009
i386                          randconfig-x000
i386                          randconfig-x001
i386                          randconfig-x002
i386                          randconfig-x003
i386                          randconfig-x004
i386                          randconfig-x005
i386                          randconfig-x006
i386                          randconfig-x007
i386                          randconfig-x008
i386                          randconfig-x009
i386                   randconfig-x0-05040910
i386                   randconfig-x1-05040910
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot

Thanks,
Fengguang
