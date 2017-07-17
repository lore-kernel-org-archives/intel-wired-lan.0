From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 18 Jul 2017 00:57:12 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 fc0d6a575d24370ffdfb7bd54612f8f7b6672910
Message-ID: <596cec68.uh0MzhdRQi9y33/M%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
fc0d6a575d24370ffdfb7bd54612f8f7b6672910  ixgbe: fix masking of bits read from IXGBE_VXLANCTRL register

TIMEOUT after 603m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 57

alpha                            allmodconfig
alpha                            allyesconfig
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
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
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
s390                        default_defconfig
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                    lkp
x86_64                                   rhel
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 117

powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
i386                   randconfig-n0-07170916
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                             allmodconfig
i386                     randconfig-a1-201729
i386                     randconfig-a0-201729
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
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
x86_64                 randconfig-x019-201729
x86_64                 randconfig-x010-201729
x86_64                 randconfig-x015-201729
x86_64                 randconfig-x017-201729
x86_64                 randconfig-x018-201729
x86_64                 randconfig-x016-201729
x86_64                 randconfig-x014-201729
x86_64                 randconfig-x012-201729
x86_64                 randconfig-x011-201729
x86_64                 randconfig-x013-201729
i386                     randconfig-s0-201729
i386                     randconfig-s1-201729
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
x86_64                   randconfig-i0-201729
i386                   randconfig-i1-07170525
i386                   randconfig-i0-07170525
i386                 randconfig-x076-07162059
i386                 randconfig-x077-07162059
i386                 randconfig-x072-07162059
i386                 randconfig-x073-07162059
i386                 randconfig-x075-07162059
i386                 randconfig-x074-07162059
i386                 randconfig-x078-07162059
i386                 randconfig-x079-07162059
i386                 randconfig-x070-07162059
i386                 randconfig-x071-07162059
x86_64                                  kexec
x86_64                               rhel-7.2
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
x86_64                 randconfig-x006-201729
x86_64                 randconfig-x004-201729
x86_64                 randconfig-x005-201729
x86_64                 randconfig-x007-201729
x86_64                 randconfig-x001-201729
x86_64                 randconfig-x008-201729
x86_64                 randconfig-x002-201729
x86_64                 randconfig-x000-201729
x86_64                 randconfig-x009-201729
x86_64                 randconfig-x003-201729
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                   randconfig-x002-201729
i386                   randconfig-x009-201729
i386                   randconfig-x006-201729
i386                   randconfig-x008-201729
i386                   randconfig-x005-201729
i386                   randconfig-x001-201729
i386                   randconfig-x000-201729
i386                   randconfig-x004-201729
i386                   randconfig-x007-201729
i386                   randconfig-x003-201729
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
