From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 10 Oct 2015 04:27:32 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:master]
 96f6095b11195da46ddd6e4e70550baa5354cd0c BUILD INCOMPLETE
Message-ID: <56182334.FJjiZZOsoCormMrN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  master
96f6095b11195da46ddd6e4e70550baa5354cd0c  Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/davem/net

TIMEOUT after 608m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 210

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
arm                       spear13xx_defconfig
i386                     randconfig-a0-201540
x86_64                 randconfig-a0-10091657
x86_64                 randconfig-a0-10091911
x86_64                 randconfig-a0-10092327
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                   randconfig-c0-10091838
i386                   randconfig-c0-10092213
i386                   randconfig-c0-10092253
i386                   randconfig-c0-10100048
i386                   randconfig-c0-10100125
i386                   randconfig-c0-10100229
i386                   randconfig-c0-10100258
arm                         lubbock_defconfig
mips                           ls1b_defconfig
mips                       markeins_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-10091834
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
parisc                         b180_defconfig
arm                     am200epdkit_defconfig
mips                        msp71xx_defconfig
mips                        qi_lb60_defconfig
sparc                             allnoconfig
i386                                defconfig
m68k                              allnoconfig
mips                        bcm47xx_defconfig
xtensa                    smp_lx200_defconfig
x86_64                 randconfig-x015-201540
x86_64                 randconfig-x019-201540
x86_64                 randconfig-x014-201540
x86_64                 randconfig-x018-201540
x86_64                 randconfig-x016-201540
x86_64                 randconfig-x011-201540
x86_64                 randconfig-x010-201540
x86_64                 randconfig-x013-201540
x86_64                 randconfig-x017-201540
x86_64                 randconfig-x012-201540
i386                              allnoconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s1-201540
i386                     randconfig-s0-201540
x86_64                 randconfig-s0-10091833
x86_64                 randconfig-s1-10091833
x86_64                 randconfig-s2-10091833
x86_64                 randconfig-s0-10092246
x86_64                 randconfig-s1-10092246
x86_64                 randconfig-s2-10092246
x86_64                 randconfig-s0-10100109
x86_64                 randconfig-s1-10100109
x86_64                 randconfig-s2-10100109
x86_64                 randconfig-s0-10100137
x86_64                 randconfig-s1-10100137
x86_64                 randconfig-s2-10100137
x86_64                 randconfig-s0-10100233
x86_64                 randconfig-s1-10100233
x86_64                 randconfig-s2-10100233
x86_64                 randconfig-s0-10100323
x86_64                 randconfig-s1-10100323
x86_64                 randconfig-s2-10100323
x86_64                           allmodconfig
x86_64                 randconfig-s3-10091813
x86_64                 randconfig-s4-10091813
x86_64                 randconfig-s5-10091813
x86_64                 randconfig-s3-10091907
x86_64                 randconfig-s4-10091907
x86_64                 randconfig-s5-10091907
x86_64                 randconfig-s3-10092245
x86_64                 randconfig-s4-10092245
x86_64                 randconfig-s5-10092245
x86_64                 randconfig-s3-10100016
x86_64                 randconfig-s4-10100016
x86_64                 randconfig-s5-10100016
x86_64                 randconfig-s3-10100125
x86_64                 randconfig-s4-10100125
x86_64                 randconfig-s5-10100125
x86_64                 randconfig-s3-10100206
x86_64                 randconfig-s4-10100206
x86_64                 randconfig-s5-10100206
x86_64                 randconfig-s3-10100322
x86_64                 randconfig-s4-10100322
x86_64                 randconfig-s5-10100322
i386                             allmodconfig
arm                          moxart_defconfig
powerpc                     rainier_defconfig
x86_64                   randconfig-i0-201540
i386                   randconfig-b0-10091704
i386                   randconfig-b0-10091908
i386                   randconfig-b0-10092211
i386                   randconfig-b0-10100048
i386                   randconfig-b0-10100132
i386                   randconfig-b0-10100219
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                            pleb_defconfig
powerpc                    mvme5100_defconfig
xtensa                           allmodconfig
i386                     randconfig-i1-201540
i386                     randconfig-i0-201540
x86_64                 randconfig-b0-10091802
x86_64                 randconfig-b0-10091854
x86_64                 randconfig-b0-10092206
x86_64                 randconfig-b0-10092258
x86_64                 randconfig-b0-10100133
x86_64                 randconfig-b0-10100238
arm                    vt8500_v6_v7_defconfig
blackfin                BF538-EZKIT_defconfig
ia64                             allmodconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                         s3c2410_defconfig
arm                           tegra_defconfig
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201540
i386                             allyesconfig
i386                   randconfig-h0-10091822
i386                   randconfig-h1-10091822
m68k                       m5249evb_defconfig
sh                               allyesconfig
sh                          polaris_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h0-10091815
x86_64                 randconfig-h0-10092250
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
arm                                  iop-adma
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
powerpc                     tqm8541_defconfig
sh                           se7619_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-10091839
i386                  randconfig-sb0-10100207
x86_64                              defconfig
arm                              allyesconfig
m68k                            mac_defconfig
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
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
i386                   randconfig-x0-10091704

Thanks,
Fengguang
