From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 05 May 2017 15:36:04 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:master] BUILD INCOMPLETE
 842be75c77cb72ee546a2b19da9c285fb3ded660
Message-ID: <590c2b64.by9stRqLRgUpw3dn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  master
842be75c77cb72ee546a2b19da9c285fb3ded660  cfg80211: make RATE_INFO_BW_20 the default

TIMEOUT after 602m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 75

alpha                            allmodconfig
alpha                            allyesconfig
alpha                               defconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
c6x                        evmc6678_defconfig
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
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-s0
i386                            randconfig-s1
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m68k                             allmodconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
nios2                         10m50_defconfig
parisc                           allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
score                      spct6600_defconfig
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc                               defconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                             acpi-redef
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.2
xtensa                           allmodconfig
xtensa                           allyesconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig

configs tested: 99

i386                               tinyconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-x015-201718
x86_64                 randconfig-x012-201718
x86_64                 randconfig-x010-201718
x86_64                 randconfig-x017-201718
x86_64                 randconfig-x011-201718
x86_64                 randconfig-x018-201718
x86_64                 randconfig-x013-201718
x86_64                 randconfig-x014-201718
x86_64                 randconfig-x016-201718
x86_64                 randconfig-x019-201718
i386                   randconfig-a0-05010503
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                   randconfig-i0-201718
i386                   randconfig-x016-201718
i386                   randconfig-x014-201718
i386                   randconfig-x010-201718
i386                   randconfig-x017-201718
i386                   randconfig-x019-201718
i386                   randconfig-x013-201718
i386                   randconfig-x018-201718
i386                   randconfig-x012-201718
i386                   randconfig-x015-201718
i386                   randconfig-x011-201718
i386                     randconfig-n0-201718
i386                             allmodconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
x86_64                           allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
ia64                             alldefconfig
h8300                    h8300h-sim_defconfig
i386                 randconfig-x072-05010711
i386                 randconfig-x079-05010711
i386                 randconfig-x071-05010711
i386                 randconfig-x076-05010711
i386                 randconfig-x074-05010711
i386                 randconfig-x078-05010711
i386                 randconfig-x077-05010711
i386                 randconfig-x075-05010711
i386                 randconfig-x070-05010711
i386                 randconfig-x073-05010711
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                  kexec
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                 randconfig-x003-201718
x86_64                 randconfig-x004-201718
x86_64                 randconfig-x009-201718
x86_64                 randconfig-x002-201718
x86_64                 randconfig-x008-201718
x86_64                 randconfig-x000-201718
x86_64                 randconfig-x007-201718
x86_64                 randconfig-x005-201718
x86_64                 randconfig-x006-201718
x86_64                 randconfig-x001-201718
i386                     randconfig-r0-201718
i386                   randconfig-x005-201718
i386                   randconfig-x002-201718
i386                   randconfig-x006-201718
i386                   randconfig-x008-201718
i386                   randconfig-x001-201718
i386                   randconfig-x003-201718
i386                   randconfig-x007-201718
i386                   randconfig-x000-201718
i386                   randconfig-x009-201718
i386                   randconfig-x004-201718

Thanks,
Fengguang
