From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 29 May 2015 02:24:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 017aed890b3853dfc9f3a9c7029dee8648269c65 BUILD DONE
Message-ID: <55675d65.1/ziAh5ZeguLdj4X%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
017aed890b3853dfc9f3a9c7029dee8648269c65  igb: bump version to igb-5.3.0

drivers/net/ethernet/cavium/thunder/nic_main.c:563:28: sparse: restricted __be64 degrades to integer
drivers/net/ethernet/cavium/thunder/nic_main.c:854:21: sparse: constant 0x300000000000 is so big it is long
drivers/net/ethernet/cavium/thunder/nicvf_main.c:1141:26: sparse: symbol 'nicvf_get_stats64' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/nicvf_main.c:267:6: sparse: symbol 'nicvf_get_rss_size' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/nicvf_main.c:333:23: sparse: constant 0xFEED0BADFEED0BAD is so big it is unsigned long
drivers/net/ethernet/cavium/thunder/nicvf_main.c:385:40: sparse: cast to restricted __le64
drivers/net/ethernet/cavium/thunder/nicvf_main.c:575:6: sparse: symbol 'nicvf_handle_qs_err' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/nicvf_queues.c:231:6: sparse: symbol 'nicvf_refill_rbdr' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:256:6: sparse: symbol 'bgx_lmac_handler' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:55:12: sparse: symbol 'bgx_vnic' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:658:6: sparse: symbol 'bgx_lmac_disable' was not declared. Should it be static?
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:897:24: sparse: constant 0x300000000000 is so big it is long
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2082:22: sparse: restricted __le16 degrades to integer
include/uapi/linux/ethtool.h:820:17: sparse: constant 0x000000FF00000000 is so big it is long
include/uapi/linux/ethtool.h:820: warning: integer constant is too large for 'long' type

elapsed time: 509m

configs tested: 253

i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-a2
x86_64                          randconfig-a0
x86_64                          randconfig-a1
x86_64                          randconfig-a2
x86_64                            allnoconfig
x86_64                                   rhel
x86_64                                    lkp
x86_64                                   rhel
x86_64                          randconfig-c0
x86_64                          randconfig-c1
x86_64                          randconfig-c2
i386                            randconfig-c0
i386                            randconfig-c1
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
x86_64                           allyesconfig
alpha                            allyesconfig
avr32                            allyesconfig
blackfin                         allyesconfig
cris                             allyesconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allyesconfig
powerpc                          allyesconfig
s390                             allyesconfig
sh                               allyesconfig
sparc                            allyesconfig
sparc64                          allyesconfig
tile                             allyesconfig
xtensa                           allyesconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
i386                           randconfig-iv0
i386                           randconfig-iv1
x86_64                         randconfig-iv0
x86_64                         randconfig-iv1
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
x86_64                           allyesconfig
alpha                            allyesconfig
avr32                            allyesconfig
blackfin                         allyesconfig
cris                             allyesconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allyesconfig
powerpc                          allyesconfig
s390                             allyesconfig
sh                               allyesconfig
sparc                            allyesconfig
sparc64                          allyesconfig
tile                             allyesconfig
xtensa                           allyesconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
i386                           randconfig-ib0
i386                           randconfig-ib1
i386                           randconfig-ib2
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                      randconfig-ir0-0529
i386                      randconfig-ir1-0529
s390                              allnoconfig
s390                                defconfig
i386                             allyesconfig
x86_64                randconfig-ib0-05281622
x86_64                randconfig-ib1-05281622
x86_64                randconfig-ib2-05281622
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
powerpc                             defconfig
sh                                  defconfig
x86_64                       randconfig-nexe0
x86_64                       randconfig-nexe1
x86_64                       randconfig-nexe2
x86_64                       randconfig-nexe3
x86_64                       randconfig-nexe4
i386                         randconfig-nexe0
i386                         randconfig-nexe1
i386                         randconfig-nexe2
i386                         randconfig-nexe3
i386                         randconfig-nexe4
i386                         randconfig-nexr0
i386                         randconfig-nexr1
s390                              allnoconfig
s390                                defconfig
i386                             allyesconfig
i386                         randconfig-nexs0
i386                         randconfig-nexs1
i386                         randconfig-nexs2
i386                         randconfig-nexs3
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
s390                              allnoconfig
s390                                defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                         randconfig-nh0
x86_64                         randconfig-nh1
x86_64                         randconfig-nh2
x86_64                 randconfig-n0-05281506
x86_64                 randconfig-n1-05281506
x86_64                 randconfig-n2-05281506
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
x86_64                           allyesconfig
alpha                            allyesconfig
avr32                            allyesconfig
blackfin                         allyesconfig
cris                             allyesconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allyesconfig
powerpc                          allyesconfig
s390                             allyesconfig
sh                               allyesconfig
sparc                            allyesconfig
sparc64                          allyesconfig
tile                             allyesconfig
xtensa                           allyesconfig
m68k                          amiga_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
powerpc                             defconfig
sh                                  defconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                            randconfig-r0
i386                            randconfig-r1
i386                            randconfig-r2
x86_64                          randconfig-r0
x86_64                          randconfig-r1
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
m68k                          amiga_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
x86_64                 randconfig-s0-05281634
x86_64                 randconfig-s1-05281634
x86_64                           allmodconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
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
x86_64                                    lkp
x86_64                                   rhel
i386                           randconfig-xi0
i386                           randconfig-xi1
i386                           randconfig-xi2
i386                           randconfig-xi0
i386                           randconfig-xi1

Thanks,
Fengguang
