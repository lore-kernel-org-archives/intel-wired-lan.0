From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 27 Aug 2015 15:16:53 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue]
 153b47767f0d9def10fd4ab736d3677fc3b91dbe BUILD INCOMPLETE
Message-ID: <55deb965.cTamTXVXSBTO8cwv%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
153b47767f0d9def10fd4ab736d3677fc3b91dbe  i40e: Set defport behavior for the Main VSI when in promiscuous mode

TIMEOUT after 602m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 30

alpha                            allyesconfig
blackfin                         allyesconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                             allyesconfig
cris                 etrax-100lx_v2_defconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allyesconfig
powerpc                          allyesconfig
s390                             allyesconfig
sh                               allyesconfig
sparc64                          allyesconfig
sparc                            allyesconfig
tile                             allyesconfig
x86_64                           allyesconfig
x86_64                        randconfig-x010
x86_64                        randconfig-x011
x86_64                        randconfig-x012
x86_64                        randconfig-x013
x86_64                        randconfig-x014
x86_64                        randconfig-x015
x86_64                        randconfig-x016
x86_64                        randconfig-x017
x86_64                        randconfig-x018
x86_64                        randconfig-x019
xtensa                           allyesconfig

configs tested: 94

i386                     randconfig-a0-201534
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
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
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                           allmodconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                   randconfig-s0-08270734
i386                   randconfig-s1-08270734
x86_64                   randconfig-i0-201534
i386                     randconfig-i1-201534
i386                     randconfig-i0-201534
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                            allnoconfig
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n1-201534
i386                     randconfig-n0-201534
i386                             allyesconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
x86_64                 randconfig-x004-201534
x86_64                 randconfig-x001-201534
x86_64                 randconfig-x000-201534
x86_64                 randconfig-x006-201534
x86_64                 randconfig-x003-201534
x86_64                 randconfig-x002-201534
x86_64                 randconfig-x005-201534
x86_64                 randconfig-x009-201534
x86_64                 randconfig-x007-201534
x86_64                 randconfig-x008-201534
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201534
i386                   randconfig-x000-201534
i386                   randconfig-x001-201534
i386                   randconfig-x008-201534
i386                   randconfig-x004-201534
i386                   randconfig-x007-201534
i386                   randconfig-x005-201534
i386                   randconfig-x003-201534
i386                   randconfig-x002-201534
i386                   randconfig-x009-201534
i386                   randconfig-x006-201534
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
