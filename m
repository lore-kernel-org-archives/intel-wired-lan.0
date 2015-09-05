From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 05 Sep 2015 14:03:00 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 261c152af284dcaff72bb403adb94a82c4260e57 BUILD INCOMPLETE
Message-ID: <55ea8594.ZmZvnX9331aDnMFq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
261c152af284dcaff72bb403adb94a82c4260e57  i40e/i40evf: give up the __func__

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 178

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                         shannon_defconfig
parisc                        c8000_defconfig
i386                     randconfig-a0-201535
x86_64                 randconfig-a0-09051121
x86_64                 randconfig-a0-09051213
x86_64                 randconfig-a0-09051344
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                            allnoconfig
m68k                          hp300_defconfig
powerpc                       maple_defconfig
sh                             espt_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-09051115
i386                   randconfig-c0-09051212
i386                   randconfig-c0-09051338
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
powerpc                     taishan_defconfig
sh                     sh7710voipgw_defconfig
arm                         mv78xx0_defconfig
sparc64                          allyesconfig
x86_64                 randconfig-v0-09051113
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
arm                        cerfcube_defconfig
m68k                         apollo_defconfig
powerpc                    klondike_defconfig
arm                           efm32_defconfig
mips                            gpr_defconfig
mips                           mtx1_defconfig
sh                        dreamcast_defconfig
arm                              allyesconfig
arm                      jornada720_defconfig
x86_64                   randconfig-i0-201535
i386                   randconfig-b0-09051136
i386                   randconfig-b0-09051223
i386                   randconfig-b0-09051344
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                            pleb_defconfig
m68k                       m5208evb_defconfig
openrisc                    or1ksim_defconfig
sh                   rts7751r2dplus_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201535
i386                     randconfig-i0-201535
i386                             allyesconfig
x86_64                 randconfig-b0-09051129
x86_64                 randconfig-b0-09051219
x86_64                 randconfig-b0-09051251
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                              alldefconfig
arm                        raumfeld_defconfig
sh                         apsh4a3a_defconfig
arm                          nuc910_defconfig
powerpc                     sbc834x_defconfig
powerpc                    sbc8641d_defconfig
i386                     randconfig-n0-201535
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-09051106
i386                   randconfig-h1-09051106
i386                   randconfig-h0-09051151
i386                   randconfig-h1-09051151
i386                   randconfig-h0-09051314
i386                   randconfig-h1-09051314
ia64                              allnoconfig
m32r                    mappi2.opsp_defconfig
sh                           se7619_defconfig
m32r                      mappi.smp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc64                        allyesconfig
m68k                          atari_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
powerpc                     sequoia_defconfig
um                           x86_64_defconfig
ia64                             alldefconfig
ia64                                defconfig
x86_64                 randconfig-h0-09051050
x86_64                 randconfig-h0-09051133
x86_64                 randconfig-h0-09051209
x86_64                 randconfig-h0-09051334
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                 randconfig-n0-09051056
x86_64                 randconfig-n0-09051157
x86_64                 randconfig-n0-09051325
arm                         lubbock_defconfig
arm                         nhk8815_defconfig
powerpc                          allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                  randconfig-sb0-09051038
i386                  randconfig-sb0-09051156
i386                  randconfig-sb0-09051342
powerpc                    ge_imp3a_defconfig
x86_64                 randconfig-x004-201535
x86_64                 randconfig-x001-201535
x86_64                 randconfig-x000-201535
x86_64                 randconfig-x006-201535
x86_64                 randconfig-x003-201535
x86_64                 randconfig-x005-201535
x86_64                 randconfig-x002-201535
x86_64                 randconfig-x009-201535
x86_64                 randconfig-x007-201535
x86_64                 randconfig-x008-201535
i386                     randconfig-r0-201535
x86_64                 randconfig-r0-09051104
x86_64                 randconfig-r0-09051214
x86_64                 randconfig-r0-09051318
i386                   randconfig-x000-201535
i386                   randconfig-x001-201535
i386                   randconfig-x008-201535
i386                   randconfig-x004-201535
i386                   randconfig-x007-201535
i386                   randconfig-x005-201535
i386                   randconfig-x003-201535
i386                   randconfig-x002-201535
i386                   randconfig-x009-201535
i386                   randconfig-x006-201535
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
i386                   randconfig-x0-09051120
i386                   randconfig-x0-09051142
i386                   randconfig-x0-09051205
i386                   randconfig-x0-09051342

Thanks,
Fengguang
