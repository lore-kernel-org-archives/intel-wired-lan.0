From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 09 Dec 2017 20:40:46 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 5a7a79e904a9b20eacdb02f02c63cc1ca34ca69f
Message-ID: <5a2bd9ce.rSBYvP8PC0vDMiSV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5a7a79e904a9b20eacdb02f02c63cc1ca34ca69f  i40e/i40evf: Account for frags split over multiple descriptors in check linearize

TIMEOUT after 603m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 46

alpha                            allmodconfig
alpha                            allyesconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
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
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                  kexec
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 128

cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                               tinyconfig
i386                   randconfig-x014-201749
i386                   randconfig-x013-201749
i386                   randconfig-x015-201749
i386                   randconfig-x019-201749
i386                   randconfig-x018-201749
i386                   randconfig-x011-201749
i386                   randconfig-x017-201749
i386                   randconfig-x012-201749
i386                   randconfig-x010-201749
i386                   randconfig-x016-201749
i386                     randconfig-n0-201749
i386                     randconfig-i1-201749
i386                     randconfig-i0-201749
i386                             allmodconfig
i386                     randconfig-a0-201749
i386                     randconfig-a1-201749
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                 randconfig-x011-201749
x86_64                 randconfig-x018-201749
x86_64                 randconfig-x017-201749
x86_64                 randconfig-x012-201749
x86_64                 randconfig-x019-201749
x86_64                 randconfig-x013-201749
x86_64                 randconfig-x010-201749
x86_64                 randconfig-x015-201749
x86_64                 randconfig-x014-201749
x86_64                 randconfig-x016-201749
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201749
i386                     randconfig-s1-201749
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
x86_64                   randconfig-i0-201749
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
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                   randconfig-x074-201749
i386                   randconfig-x076-201749
i386                   randconfig-x071-201749
i386                   randconfig-x077-201749
i386                   randconfig-x073-201749
i386                   randconfig-x075-201749
i386                   randconfig-x070-201749
i386                   randconfig-x079-201749
i386                   randconfig-x072-201749
i386                   randconfig-x078-201749
i386                   randconfig-x001-201749
i386                   randconfig-x003-201749
i386                   randconfig-x004-201749
i386                   randconfig-x002-201749
i386                   randconfig-x008-201749
i386                   randconfig-x006-201749
i386                   randconfig-x009-201749
i386                   randconfig-x000-201749
i386                   randconfig-x005-201749
i386                   randconfig-x007-201749
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-x004-201749
x86_64                 randconfig-x008-201749
x86_64                 randconfig-x001-201749
x86_64                 randconfig-x000-201749
x86_64                 randconfig-x009-201749
x86_64                 randconfig-x003-201749
x86_64                 randconfig-x006-201749
x86_64                 randconfig-x007-201749
x86_64                 randconfig-x005-201749
x86_64                 randconfig-x002-201749
s390                        default_defconfig
powerpc                           allnoconfig
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
