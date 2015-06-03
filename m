From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 03 Jun 2015 08:27:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 29e2f069869618af8b107b760f38103965a6ebc8 BUILD DONE
Message-ID: <556e49fa.4qlj4tql2lZLjmME%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
29e2f069869618af8b107b760f38103965a6ebc8  e1000e: Bump the version to 3.2.5

drivers/net/ethernet/cavium/thunder/nic_main.c:563:28: sparse: restricted __be64 degrades to integer
drivers/net/ethernet/cavium/thunder/nic_main.c:854:21: sparse: constant 0x300000000000 is so big it is long
drivers/net/ethernet/cavium/thunder/nicvf_main.c:1141:26: sparse: symbol 'nicvf_get_stats64' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/nicvf_main.c:153:25: sparse: cast to restricted __le64
drivers/net/ethernet/cavium/thunder/nicvf_main.c:267:6: sparse: symbol 'nicvf_get_rss_size' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/nicvf_main.c:329:23: sparse: constant 0xFEED0BADFEED0BAD is so big it is unsigned long
drivers/net/ethernet/cavium/thunder/nicvf_main.c:575:6: sparse: symbol 'nicvf_handle_qs_err' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/nicvf_queues.c:231:6: sparse: symbol 'nicvf_refill_rbdr' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:256:6: sparse: symbol 'bgx_lmac_handler' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:55:12: sparse: symbol 'bgx_vnic' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:658:6: sparse: symbol 'bgx_lmac_disable' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:897:24: sparse: constant 0x300000000000 is so big it is long
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2082:22: sparse: restricted __le16 degrades to integer

elapsed time: 564m

configs tested: 106

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                       randconfig-a0-0602
i386                       randconfig-a1-0602
x86_64                     randconfig-c0-0602
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
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                            allnoconfig
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
x86_64                     randconfig-i0-0602
x86_64                     randconfig-i1-0602
x86_64                     randconfig-i0-0603
x86_64                     randconfig-i1-0603
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                       randconfig-i0-0602
i386                       randconfig-i1-0602
i386                             allyesconfig
x86_64                           allmodconfig
i386                       randconfig-n0-0602
i386                       randconfig-n1-0602
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
arm                              allmodconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                   randconfig-x008-0531
x86_64                   randconfig-x005-0531
x86_64                   randconfig-x004-0531
x86_64                   randconfig-x000-0531
x86_64                   randconfig-x001-0531
x86_64                   randconfig-x007-0531
x86_64                   randconfig-x009-0531
x86_64                   randconfig-x003-0531
x86_64                   randconfig-x002-0531
x86_64                   randconfig-x006-0531
x86_64                                    lkp
x86_64                                   rhel
i386                       randconfig-r1-0602
i386                       randconfig-r0-0602
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
i386                     randconfig-x009-0531
i386                     randconfig-x002-0531
i386                     randconfig-x001-0531
i386                     randconfig-x000-0531
i386                     randconfig-x004-0531
i386                     randconfig-x006-0531
i386                     randconfig-x007-0531
i386                     randconfig-x005-0531
i386                     randconfig-x008-0531
i386                     randconfig-x003-0531
x86_64                     randconfig-x0-0602

Thanks,
Fengguang
