From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 15 Dec 2015 15:24:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 8b20d4866b488b517ed9a24eaa17782709b82f33 BUILD SUCCESS
Message-ID: <566fc040.EiZMBzLE9FmaeuWP%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
8b20d4866b488b517ed9a24eaa17782709b82f33  ixgbevf: Fix handling of napi budget when multiple queues are enabled per vector

elapsed time: 66m

configs tested: 104

i386                     randconfig-a0-201550
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
i386                             allmodconfig
x86_64               randconfig-x011-12141150
x86_64               randconfig-x016-12141150
x86_64               randconfig-x013-12141150
x86_64               randconfig-x019-12141150
x86_64               randconfig-x017-12141150
x86_64               randconfig-x012-12141150
x86_64               randconfig-x014-12141150
x86_64               randconfig-x010-12141150
x86_64               randconfig-x018-12141150
x86_64               randconfig-x015-12141150
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                     randconfig-s0-201550
i386                     randconfig-s1-201550
x86_64                           allmodconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201550
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-n0-201550
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-x005-12141102
x86_64               randconfig-x003-12141102
x86_64               randconfig-x000-12141102
x86_64               randconfig-x001-12141102
x86_64               randconfig-x007-12141102
x86_64               randconfig-x004-12141102
x86_64               randconfig-x009-12141102
x86_64               randconfig-x006-12141102
x86_64               randconfig-x002-12141102
x86_64               randconfig-x008-12141102
i386                     randconfig-r0-201550
i386                 randconfig-x000-12141102
i386                 randconfig-x007-12141102
i386                 randconfig-x009-12141102
i386                 randconfig-x004-12141102
i386                 randconfig-x003-12141102
i386                 randconfig-x006-12141102
i386                 randconfig-x005-12141102
i386                 randconfig-x002-12141102
i386                 randconfig-x008-12141102
i386                 randconfig-x001-12141102

Thanks,
Fengguang
