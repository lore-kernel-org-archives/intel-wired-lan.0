From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 30 Jun 2016 16:06:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:1GbE]
 64f2525ca4e76b1704b867458808ed6ffc58b803 BUILD INCOMPLETE
Message-ID: <5774d318.ho8DLEXNDBqoJrv2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  1GbE
64f2525ca4e76b1704b867458808ed6ffc58b803  igb: Only DMA sync frame length

TIMEOUT after 606m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 39

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

configs tested: 117

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201626
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                             allyesconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201626
i386                     randconfig-s0-201626
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
i386                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201626
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201626
i386                     randconfig-i1-201626
x86_64                           allmodconfig
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
i386                     randconfig-n0-201626
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
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
i386                   randconfig-x005-201626
i386                   randconfig-x008-201626
i386                   randconfig-x000-201626
i386                   randconfig-x009-201626
i386                   randconfig-x007-201626
i386                   randconfig-x004-201626
i386                   randconfig-x003-201626
i386                   randconfig-x001-201626
i386                   randconfig-x006-201626
i386                   randconfig-x002-201626

Thanks,
Fengguang
