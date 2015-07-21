From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 21 Jul 2015 12:43:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 a6e104cc4b4d38778b436072e415e92c79bda374 BUILD INCOMPLETE
Message-ID: <55adce0a.7+0alXHlsj3uM0M2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
a6e104cc4b4d38778b436072e415e92c79bda374  e1000e: Fix incorrect ASPM locking

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 201

m68k                             allyesconfig
microblaze                    nommu_defconfig
s390                                defconfig
arm                          nuc960_defconfig
m68k                        mvme147_defconfig
mips                       markeins_defconfig
x86_64                 randconfig-a0-07210356
x86_64                 randconfig-a0-07210619
x86_64                            allnoconfig
arm                          exynos_defconfig
mips                        jmr3927_defconfig
sh                             sh03_defconfig
arm                           u8500_defconfig
powerpc                    gamecube_defconfig
tile                             allmodconfig
alpha                             allnoconfig
ia64                      gensparse_defconfig
sparc                            allmodconfig
i386                   randconfig-c0-07210424
i386                   randconfig-c0-07210508
i386                   randconfig-c0-07210621
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
arm                         shannon_defconfig
arm64                             allnoconfig
sh                   rts7751r2dplus_defconfig
m68k                        m5272c3_defconfig
mips                       lemote2f_defconfig
powerpc                     stx_gp3_defconfig
m32r                   m32700ut.smp_defconfig
powerpc                         wii_defconfig
sh                           se7780_defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-v0-07210352
x86_64                 randconfig-v0-07210513
x86_64                 randconfig-v0-07210623
i386                             allmodconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
powerpc                          allmodconfig
powerpc                mpc7448_hpc2_defconfig
sh                              ul2_defconfig
x86_64                           allyesconfig
arm                          simpad_defconfig
microblaze                      mmu_defconfig
powerpc                   currituck_defconfig
x86_64                   randconfig-i0-201529
i386                   randconfig-b0-07210414
i386                   randconfig-b0-07210505
i386                   randconfig-b0-07210620
avr32        atngw100mkii_evklcd100_defconfig
ia64                         bigsur_defconfig
mn10300                           allnoconfig
sparc64                           allnoconfig
alpha                            alldefconfig
arm                        realview_defconfig
m32r                        oaks32r_defconfig
mips                           jazz_defconfig
sparc64                          allmodconfig
i386                     randconfig-i0-201529
i386                             allyesconfig
x86_64                 randconfig-b0-07210420
x86_64                 randconfig-b0-07210505
x86_64                 randconfig-b0-07210604
sparc                               defconfig
sparc64                             defconfig
arm                         cm_x300_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     redwood_defconfig
blackfin              BF561-ACVILON_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     ppa8548_defconfig
sh                        sh7763rdp_defconfig
mips                      pistachio_defconfig
powerpc                        cell_defconfig
powerpc               corenet32_smp_defconfig
i386                     randconfig-n0-201529
i386                     randconfig-n1-201529
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-07210107
i386                   randconfig-h1-07210107
i386                   randconfig-h0-07210509
i386                   randconfig-h1-07210509
ia64                                defconfig
mips                        maltaup_defconfig
x86_64                 randconfig-h0-07210344
x86_64                 randconfig-h0-07210512
x86_64                 randconfig-h0-07210621
x86_64                           allmodconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                 randconfig-n0-07210416
x86_64                 randconfig-n0-07210501
x86_64                 randconfig-n0-07210621
arm                          prima2_defconfig
arm                       spear13xx_defconfig
arm                       imx_v6_v7_defconfig
arm                          marzen_defconfig
avr32                 atngw100_mrmt_defconfig
mn10300                          allmodconfig
sh                         ap325rxa_defconfig
m32r                      mappi.smp_defconfig
powerpc                 mpc836x_mds_defconfig
avr32                       favr-32_defconfig
m32r                    m32700ut.up_defconfig
mips                        nlm_xlp_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                  randconfig-sb0-07210427
i386                  randconfig-sb0-07210513
i386                  randconfig-sb0-07210610
m68k                        m5407c3_defconfig
sh                           se7722_defconfig
sh                                  defconfig
x86_64               randconfig-x004-07200849
x86_64               randconfig-x002-07200849
x86_64               randconfig-x001-07200849
x86_64               randconfig-x008-07200849
x86_64               randconfig-x005-07200849
x86_64               randconfig-x007-07200849
x86_64               randconfig-x000-07200849
x86_64               randconfig-x006-07200849
x86_64               randconfig-x003-07200849
x86_64               randconfig-x009-07200849
ia64                              allnoconfig
ia64                             alldefconfig
i386                     randconfig-r0-201529
x86_64                 randconfig-r0-07210401
x86_64                 randconfig-r0-07210619
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
arm                      pxa255-idp_defconfig
powerpc                  gef_sbc310_defconfig
powerpc                     mpc512x_defconfig
mips                  maltasmvp_eva_defconfig
mips                 pnx8335_stb225_defconfig
powerpc                       holly_defconfig
arm                         lubbock_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc834x_itx_defconfig
x86_64                 randconfig-s0-07210423
x86_64                 randconfig-s0-07210454
x86_64                 randconfig-s0-07210607
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
powerpc                     kilauea_defconfig
powerpc                     kmp204x_defconfig
arm                          pxa910_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      pmac32_defconfig
arm                       imx_v4_v5_defconfig
mips                      malta_kvm_defconfig
s390                    performance_defconfig
i386                 randconfig-x007-07200849
i386                 randconfig-x005-07200849
i386                 randconfig-x008-07200849
i386                 randconfig-x003-07200849
i386                 randconfig-x004-07200849
i386                 randconfig-x000-07200849
i386                 randconfig-x006-07200849
i386                 randconfig-x009-07200849
i386                 randconfig-x002-07200849
i386                 randconfig-x001-07200849
i386                   randconfig-x0-07210426
i386                   randconfig-x0-07210458
i386                   randconfig-x0-07210626

Thanks,
Fengguang
