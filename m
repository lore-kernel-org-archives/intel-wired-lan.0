From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 09 Jan 2016 13:18:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 15281cc37cd55c71869a585c709282f0fd09af6f BUILD INCOMPLETE
Message-ID: <5690983b.EpLopP7xlCMdL4Te%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
15281cc37cd55c71869a585c709282f0fd09af6f  igb: When GbE link up, wait for Remote receiver status condition.

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? arm-tegra_defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? mips-ip27_defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

TIMEOUT after 603m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 25

blackfin                         allyesconfig
cris                             allyesconfig
i386                            randconfig-n0
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
parisc                           allyesconfig
powerpc                          allyesconfig
s390                             allyesconfig
sparc64                          allyesconfig
sparc                            allyesconfig
tile                             allyesconfig
x86_64                           allyesconfig
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
xtensa                           allyesconfig

configs tested: 240

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201601
x86_64                 randconfig-a0-01090654
x86_64                 randconfig-a0-01090810
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                          ixp4xx_defconfig
arm                      tct_hammer_defconfig
avr32                     atstk1002_defconfig
mips                         cobalt_defconfig
powerpc                     tqm8555_defconfig
sh                           se7343_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-01090722
x86_64                           allmodconfig
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
arm                        clps711x_defconfig
mips                                defconfig
sh                               allyesconfig
i386                             allyesconfig
x86_64                 randconfig-v0-01090703
x86_64                 randconfig-v0-01090825
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
arm                         lpc18xx_defconfig
arm                          lpd270_defconfig
mips                       capcella_defconfig
powerpc                      chrp32_defconfig
sh                        sh7763rdp_defconfig
arm                           u8500_defconfig
ia64                                defconfig
mips                        jmr3927_defconfig
parisc                generic-64bit_defconfig
tile                             alldefconfig
arm                         cm_x300_defconfig
avr32                     atstk1006_defconfig
m32r                    m32700ut.up_defconfig
powerpc                    gamecube_defconfig
sparc                       sparc32_defconfig
arm                          iop32x_defconfig
arm                        vexpress_defconfig
sh                            migor_defconfig
arm                          nuc950_defconfig
avr32                      atngw100_defconfig
microblaze                      mmu_defconfig
mips                         rt305x_defconfig
powerpc                     redwood_defconfig
avr32            atngw100_evklcd101_defconfig
frv                                 defconfig
mips                        msp71xx_defconfig
powerpc                     tqm8548_defconfig
powerpc64                         allnoconfig
arm                         s5pv210_defconfig
arm                       versatile_defconfig
mips                      maltaaprp_defconfig
powerpc                  storcenter_defconfig
sh                           se7722_defconfig
avr32                            alldefconfig
blackfin                          allnoconfig
sh                          r7780mp_defconfig
um                                allnoconfig
arm                            netx_defconfig
arm                           spitz_defconfig
powerpc               corenet_basic_defconfig
powerpc                   motionpro_defconfig
powerpc                     rainier_defconfig
alpha                            allyesconfig
avr32                  atngw100mkii_defconfig
powerpc                         wii_defconfig
sh                           se7751_defconfig
xtensa                              defconfig
x86_64               randconfig-x017-01041832
x86_64               randconfig-x011-01041832
x86_64               randconfig-x015-01041832
x86_64               randconfig-x010-01041832
x86_64               randconfig-x016-01041832
x86_64               randconfig-x013-01041832
x86_64               randconfig-x018-01041832
x86_64               randconfig-x019-01041832
x86_64               randconfig-x012-01041832
x86_64               randconfig-x014-01041832
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201601
i386                     randconfig-s1-201601
x86_64                 randconfig-s0-01090642
x86_64                 randconfig-s1-01090642
x86_64                 randconfig-s2-01090642
x86_64                 randconfig-s0-01090655
x86_64                 randconfig-s1-01090655
x86_64                 randconfig-s2-01090655
x86_64                 randconfig-s0-01090710
x86_64                 randconfig-s1-01090710
x86_64                 randconfig-s2-01090710
x86_64                 randconfig-s0-01090729
x86_64                 randconfig-s1-01090729
x86_64                 randconfig-s2-01090729
x86_64                 randconfig-s0-01090743
x86_64                 randconfig-s1-01090743
x86_64                 randconfig-s2-01090743
x86_64                 randconfig-s0-01090759
x86_64                 randconfig-s1-01090759
x86_64                 randconfig-s2-01090759
x86_64                 randconfig-s0-01090812
x86_64                 randconfig-s1-01090812
x86_64                 randconfig-s2-01090812
x86_64                 randconfig-s0-01090831
x86_64                 randconfig-s1-01090831
x86_64                 randconfig-s2-01090831
x86_64                 randconfig-s3-01090639
x86_64                 randconfig-s4-01090639
x86_64                 randconfig-s5-01090639
x86_64                 randconfig-s3-01090654
x86_64                 randconfig-s4-01090654
x86_64                 randconfig-s5-01090654
x86_64                 randconfig-s3-01090709
x86_64                 randconfig-s4-01090709
x86_64                 randconfig-s5-01090709
x86_64                 randconfig-s3-01090727
x86_64                 randconfig-s4-01090727
x86_64                 randconfig-s5-01090727
x86_64                 randconfig-s3-01090747
x86_64                 randconfig-s4-01090747
x86_64                 randconfig-s5-01090747
x86_64                 randconfig-s3-01090759
x86_64                 randconfig-s4-01090759
x86_64                 randconfig-s5-01090759
x86_64                 randconfig-s3-01090812
x86_64                 randconfig-s4-01090812
x86_64                 randconfig-s5-01090812
x86_64                 randconfig-s3-01090829
x86_64                 randconfig-s4-01090829
x86_64                 randconfig-s5-01090829
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
arm                         nhk8815_defconfig
ia64                             alldefconfig
mips                           ip27_defconfig
um                                  defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201601
i386                   randconfig-b0-01090145
i386                   randconfig-b0-01090705
i386                   randconfig-b0-01090801
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201601
i386                     randconfig-i1-201601
x86_64                 randconfig-b0-01090652
x86_64                 randconfig-b0-01090754
x86_64                 randconfig-b0-01090816
m68k                        m5307c3_defconfig
powerpc                     stx_gp3_defconfig
sh                        edosk7760_defconfig
arm                                      arm5
arm                                     arm67
arm                                       mmp
arm                       omap2plus_defconfig
arm                         s3c2410_defconfig
arm                           tegra_defconfig
i386                   randconfig-h0-01090727
i386                   randconfig-h1-01090727
i386                   randconfig-h0-01090817
i386                   randconfig-h1-01090817
frv                               allnoconfig
parisc                           alldefconfig
sh                     sh7710voipgw_defconfig
arm                         hackkit_defconfig
powerpc                     virtex5_defconfig
arm                            hisi_defconfig
x86_64                                   rhel
x86_64                 randconfig-h0-01090749
x86_64                 randconfig-h0-01090834
arm                  colibri_pxa300_defconfig
m32r                    mappi.nommu_defconfig
powerpc                   lite5200b_defconfig
i386                  randconfig-sb0-01090809
arm                       imx_v4_v5_defconfig
m68k                            q40_defconfig
powerpc                        warp_defconfig
powerpc                       ep405_defconfig
x86_64                                    lkp
i386                     randconfig-r0-201601
x86_64                 randconfig-r0-01090755
i386                 randconfig-x005-01040616
i386                 randconfig-x003-01040616
i386                 randconfig-x002-01040616
i386                 randconfig-x001-01040616
i386                 randconfig-x008-01040616
i386                 randconfig-x000-01040616
i386                 randconfig-x009-01040616
i386                 randconfig-x006-01040616
i386                 randconfig-x004-01040616
i386                 randconfig-x007-01040616
i386                   randconfig-x0-01090814

Thanks,
Fengguang
