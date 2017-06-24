From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 24 Jun 2017 18:53:50 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 b7e825fd3fa8e23cfdde05e4ede216a67cea4399
Message-ID: <594e44be.wkN3N8UK885JLMth%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
b7e825fd3fa8e23cfdde05e4ede216a67cea4399  e1000e: add check on e1e_wphy() return value

TIMEOUT after 601m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 60

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
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-n0
i386                            randconfig-s0
i386                            randconfig-s1
i386                          randconfig-x010
i386                          randconfig-x011
i386                          randconfig-x012
i386                          randconfig-x013
i386                          randconfig-x014
i386                          randconfig-x015
i386                          randconfig-x016
i386                          randconfig-x017
i386                          randconfig-x018
i386                          randconfig-x019
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
sh                                allnoconfig
sh                               allyesconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                                  kexec
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 112

powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-x010-201725
x86_64                 randconfig-x019-201725
x86_64                 randconfig-x015-201725
x86_64                 randconfig-x014-201725
x86_64                 randconfig-x012-201725
x86_64                 randconfig-x017-201725
x86_64                 randconfig-x018-201725
x86_64                 randconfig-x016-201725
x86_64                 randconfig-x013-201725
x86_64                 randconfig-x011-201725
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
i386                               tinyconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201725
i386                     randconfig-i0-201725
i386                     randconfig-i1-201725
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                 randconfig-x079-06190854
i386                 randconfig-x073-06190854
i386                 randconfig-x077-06190854
i386                 randconfig-x075-06190854
i386                 randconfig-x071-06190854
i386                 randconfig-x076-06190854
i386                 randconfig-x078-06190854
i386                 randconfig-x072-06190854
i386                 randconfig-x074-06190854
i386                 randconfig-x070-06190854
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
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-x006-201725
x86_64                 randconfig-x007-201725
x86_64                 randconfig-x001-201725
x86_64                 randconfig-x004-201725
x86_64                 randconfig-x005-201725
x86_64                 randconfig-x000-201725
x86_64                 randconfig-x008-201725
x86_64                 randconfig-x002-201725
x86_64                 randconfig-x003-201725
x86_64                 randconfig-x009-201725
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                             allmodconfig
i386                   randconfig-x009-201725
i386                   randconfig-x006-201725
i386                   randconfig-x008-201725
i386                   randconfig-x002-201725
i386                   randconfig-x001-201725
i386                   randconfig-x000-201725
i386                   randconfig-x005-201725
i386                   randconfig-x007-201725
i386                   randconfig-x004-201725
i386                   randconfig-x003-201725
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
