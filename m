From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 01 Jul 2016 09:36:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 0da4f12d61ce568be2c082cf3340d39112e35608 BUILD INCOMPLETE
Message-ID: <5775c93a.rSm8NCJkuRaz2YHu%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
0da4f12d61ce568be2c082cf3340d39112e35608  i40e: Move the mutex lock in i40e_client_unregister

TIMEOUT after 603m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 52

alpha                            allmodconfig
alpha                            allyesconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
customconfig                                0
customconfig                                1
customconfig                                2
customconfig                                3
customconfig                                4
customconfig                                5
customconfig                                6
customconfig                                7
customconfig                                8
customconfig                                9
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
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
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allyesconfig
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 104

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201626
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
parisc                         b180_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                 randconfig-x019-201626
x86_64                 randconfig-x018-201626
x86_64                 randconfig-x014-201626
x86_64                 randconfig-x013-201626
x86_64                 randconfig-x015-201626
x86_64                 randconfig-x010-201626
x86_64                 randconfig-x016-201626
x86_64                 randconfig-x011-201626
x86_64                 randconfig-x012-201626
x86_64                 randconfig-x017-201626
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s1-201626
i386                     randconfig-s0-201626
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                               tinyconfig
x86_64                   randconfig-i0-201626
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i0-201626
i386                     randconfig-i1-201626
i386                             allyesconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
i386                   randconfig-x017-201626
i386                   randconfig-x018-201626
i386                   randconfig-x010-201626
i386                   randconfig-x013-201626
i386                   randconfig-x014-201626
i386                   randconfig-x016-201626
i386                   randconfig-x011-201626
i386                   randconfig-x015-201626
i386                   randconfig-x019-201626
i386                   randconfig-x012-201626
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201626
i386                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                           allmodconfig
x86_64                 randconfig-x007-201626
x86_64                 randconfig-x000-201626
x86_64                 randconfig-x006-201626
x86_64                 randconfig-x003-201626
x86_64                 randconfig-x008-201626
x86_64                 randconfig-x005-201626
x86_64                 randconfig-x002-201626
x86_64                 randconfig-x001-201626
x86_64                 randconfig-x004-201626
x86_64                 randconfig-x009-201626
i386                     randconfig-r0-201626
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
