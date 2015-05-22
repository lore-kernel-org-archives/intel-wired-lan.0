From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 22 May 2015 15:22:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 1156ea48ab7e76a27b548c7616ae85f6cd3f8e7d BUILD INCOMPLETE
Message-ID: <555ed91b.34dQWS4nWbek6NGy%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
1156ea48ab7e76a27b548c7616ae85f6cd3f8e7d  igb: bump version to igb-5.3.0

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2082:22: sparse: restricted __le16 degrades to integer
include/uapi/linux/ethtool.h:820:17: sparse: constant 0x000000FF00000000 is so big it is long
include/uapi/linux/ethtool.h:820: warning: integer constant is too large for 'long' type

TIMEOUT after 609m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 173

i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                                defconfig
x86_64                 randconfig-a0-05220444
x86_64                 randconfig-a1-05220444
x86_64                            allnoconfig
x86_64                     randconfig-c0-0518
x86_64                     randconfig-c1-0518
x86_64                     randconfig-c2-0518
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-05212033
i386                   randconfig-c1-05212033
arm                              allmodconfig
arm                               allnoconfig
arm                                      arm5
arm                                     arm67
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                                       mmp
arm                       omap2plus_defconfig
arm                          prima2_defconfig
arm                         s3c2410_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
arm                           tegra_defconfig
powerpc                   defconfig-gcc-4.9.0
powerpc             ppc64_defconfig-gcc-4.9.0
powerpc                 allnoconfig-gcc-4.9.0
powerpc                allmodconfig-gcc-4.9.0
x86_64                randconfig-iv0-05211947
x86_64                randconfig-iv1-05211947
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
i386                  randconfig-ib0-05220908
i386                  randconfig-ib1-05220908
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
microblaze                       allyesconfig
x86_64                randconfig-ib0-05220909
parisc              c3000_defconfig-gcc-4.9.0
parisc               b180_defconfig-gcc-4.9.0
parisc                    defconfig-gcc-4.9.0
alpha                     defconfig-gcc-4.9.0
parisc                  allnoconfig-gcc-4.9.0
arm                          ixp4xx_defconfig
blackfin                  CM-BF537U_defconfig
powerpc                     rainier_defconfig
sh                        edosk7705_defconfig
sh                        sh7763rdp_defconfig
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
ia64                   allmodconfig-gcc-4.9.0
ia64                    allnoconfig-gcc-4.9.0
ia64                      defconfig-gcc-4.9.0
ia64                   alldefconfig-gcc-4.9.0
x86_64          randconfig-nexr2-0518-gcc-4.9
i386            randconfig-nexr1-0518-gcc-4.9
x86_64          randconfig-nexr1-0518-gcc-4.9
x86_64          randconfig-nexr0-0518-gcc-4.9
i386            randconfig-nexr0-0518-gcc-4.9
i386            randconfig-nexr2-0518-gcc-4.9
s390                   allmodconfig-gcc-4.9.0
s390                    allnoconfig-gcc-4.9.0
s390                      defconfig-gcc-4.9.0
i386                     allyesconfig-gcc-4.9
x86_64              randconfig-nexs0-05212027
i386                randconfig-nexs0-05212027
x86_64                 randconfig-n0-05211513
x86_64                           allmodconfig
m32r                        oaks32r_defconfig
powerpc                 mpc832x_mds_defconfig
s390                        default_defconfig
sh                          sdk7786_defconfig
sh                           se7343_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                       randconfig-r2-0521
i386                       randconfig-r1-0521
i386                       randconfig-r0-0521
x86_64                 randconfig-r0-05211953
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                          amiga_defconfig
x86_64                 randconfig-s0-05211403
x86_64                 randconfig-s1-05211403
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
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
i386                   randconfig-x0-05181040
i386                   randconfig-x1-05181040
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot

Thanks,
Fengguang
