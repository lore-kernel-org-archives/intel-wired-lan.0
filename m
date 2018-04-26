From: kbuild test robot <lkp@intel.com>
Date: Thu, 26 Apr 2018 10:24:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:10GbE] BUILD INCOMPLETE
 8315ef6f395cc4e14171c59e1176711976deeb84
Message-ID: <5ae13850.u6xYolfB5URE1mMn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  10GbE
branch HEAD: 8315ef6f395cc4e14171c59e1176711976deeb84  ixgbe: Avoid performing unnecessary resets for macvlan offload

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 79

alpha                            allmodconfig
alpha                            allyesconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
i386                             alldefconfig
i386                              allnoconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                                defconfig
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-i0
i386                            randconfig-i1
i386                               tinyconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                        default_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                               allyesconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                             acpi-redef
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 99

i386                   randconfig-x010-201816
i386                   randconfig-x011-201816
i386                   randconfig-x012-201816
i386                   randconfig-x013-201816
i386                   randconfig-x014-201816
i386                   randconfig-x015-201816
i386                   randconfig-x016-201816
i386                   randconfig-x017-201816
i386                   randconfig-x018-201816
i386                   randconfig-x019-201816
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201816
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
x86_64                 randconfig-x014-201816
x86_64                 randconfig-x013-201816
x86_64                 randconfig-x010-201816
x86_64                 randconfig-x019-201816
x86_64                 randconfig-x015-201816
x86_64                 randconfig-x011-201816
x86_64                 randconfig-x018-201816
x86_64                 randconfig-x016-201816
x86_64                 randconfig-x017-201816
x86_64                 randconfig-x012-201816
x86_64                              federa-25
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-s0-201816
i386                     randconfig-s1-201816
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
x86_64                   randconfig-i0-201816
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x000-201816
i386                   randconfig-x006-201816
i386                   randconfig-x008-201816
i386                   randconfig-x003-201816
i386                   randconfig-x009-201816
i386                   randconfig-x004-201816
i386                   randconfig-x002-201816
i386                   randconfig-x005-201816
i386                   randconfig-x001-201816
i386                   randconfig-x007-201816
i386                   randconfig-x075-201816
i386                   randconfig-x073-201816
i386                   randconfig-x076-201816
i386                   randconfig-x071-201816
i386                   randconfig-x079-201816
i386                   randconfig-x077-201816
i386                   randconfig-x070-201816
i386                   randconfig-x078-201816
i386                   randconfig-x074-201816
i386                   randconfig-x072-201816
openrisc                 simple_smp_defconfig
sh                           se7206_defconfig
sh                           se7619_defconfig
arm64                               defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-x000-201816
x86_64                 randconfig-x001-201816
x86_64                 randconfig-x002-201816
x86_64                 randconfig-x003-201816
x86_64                 randconfig-x004-201816
x86_64                 randconfig-x005-201816
x86_64                 randconfig-x006-201816
x86_64                 randconfig-x007-201816
x86_64                 randconfig-x008-201816
x86_64                 randconfig-x009-201816
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
