From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 16 Mar 2018 08:50:35 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 6c078183969059916bbda3ba5be78c17c1df0f57
Message-ID: <5aab14db.hlMdiYh6vtyUmXj8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 6c078183969059916bbda3ba5be78c17c1df0f57  checkpatch.pl: seed camelcase from the provided kernel tree root

TIMEOUT after 609m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 91

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
arm64                               defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
frv                                 defconfig
i386                             alldefconfig
i386                             allmodconfig
i386                              allnoconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                                defconfig
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
i386                            randconfig-s0
i386                            randconfig-s1
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
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
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
tile                             allmodconfig
tile                             allyesconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                    lkp
x86_64                          randconfig-i0
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 84

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
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
i386                               tinyconfig
i386                   randconfig-x006-201810
i386                   randconfig-x000-201810
i386                   randconfig-x008-201810
i386                   randconfig-x004-201810
i386                   randconfig-x009-201810
i386                   randconfig-x003-201810
i386                   randconfig-x002-201810
i386                   randconfig-x005-201810
i386                   randconfig-x001-201810
i386                   randconfig-x007-201810
x86_64                 randconfig-x010-201810
x86_64                 randconfig-x014-201810
x86_64                 randconfig-x013-201810
x86_64                 randconfig-x019-201810
x86_64                 randconfig-x011-201810
x86_64                 randconfig-x015-201810
x86_64                 randconfig-x018-201810
x86_64                 randconfig-x016-201810
x86_64                 randconfig-x017-201810
x86_64                 randconfig-x012-201810
i386                   randconfig-x013-201810
i386                   randconfig-x014-201810
i386                   randconfig-x015-201810
i386                   randconfig-x012-201810
i386                   randconfig-x019-201810
i386                   randconfig-x016-201810
i386                   randconfig-x010-201810
i386                   randconfig-x018-201810
i386                   randconfig-x011-201810
i386                   randconfig-x017-201810
i386                   randconfig-x073-201810
i386                   randconfig-x075-201810
i386                   randconfig-x071-201810
i386                   randconfig-x076-201810
i386                   randconfig-x079-201810
i386                   randconfig-x077-201810
i386                   randconfig-x070-201810
i386                   randconfig-x074-201810
i386                   randconfig-x078-201810
i386                   randconfig-x072-201810
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                 randconfig-x002-201810
x86_64                 randconfig-x006-201810
x86_64                 randconfig-x005-201810
x86_64                 randconfig-x009-201810
x86_64                 randconfig-x004-201810
x86_64                 randconfig-x001-201810
x86_64                 randconfig-x008-201810
x86_64                 randconfig-x003-201810
x86_64                 randconfig-x007-201810
x86_64                 randconfig-x000-201810
x86_64                                  kexec
x86_64                              federa-25
x86_64                                   rhel
x86_64                               rhel-7.2

Thanks,
Fengguang
