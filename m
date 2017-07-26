From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 26 Jul 2017 17:47:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:10GbE] BUILD INCOMPLETE
 7adbccbbb5beabe14f3a02ee41abdaa1801395b8
Message-ID: <59786517.kpd4qXM/xmHDMjEB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  10GbE
7adbccbbb5beabe14f3a02ee41abdaa1801395b8  ixgbe: Disable flow control for XFI

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 87

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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                             allmodconfig
cris                             allyesconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
i386                            randconfig-s0
i386                            randconfig-s1
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
i386                          randconfig-x070
i386                          randconfig-x071
i386                          randconfig-x072
i386                          randconfig-x073
i386                          randconfig-x074
i386                          randconfig-x075
i386                          randconfig-x076
i386                          randconfig-x077
i386                          randconfig-x078
i386                          randconfig-x079
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                             allmodconfig
mips                             allyesconfig
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
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc                               defconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                    lkp
x86_64                          randconfig-i0
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 87

sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                                  kexec
x86_64                                   rhel
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
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                 randconfig-x016-201730
x86_64                 randconfig-x011-201730
x86_64                 randconfig-x019-201730
x86_64                 randconfig-x014-201730
x86_64                 randconfig-x012-201730
x86_64                 randconfig-x013-201730
x86_64                 randconfig-x018-201730
x86_64                 randconfig-x015-201730
x86_64                 randconfig-x010-201730
x86_64                 randconfig-x017-201730
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                               tinyconfig
i386                 randconfig-x015-07251811
i386                 randconfig-x019-07251811
i386                 randconfig-x014-07251811
i386                 randconfig-x017-07251811
i386                 randconfig-x011-07251811
i386                 randconfig-x016-07251811
i386                 randconfig-x012-07251811
i386                 randconfig-x010-07251811
i386                 randconfig-x013-07251811
i386                 randconfig-x018-07251811
x86_64                 randconfig-x007-201730
x86_64                 randconfig-x001-201730
x86_64                 randconfig-x000-201730
x86_64                 randconfig-x006-201730
x86_64                 randconfig-x003-201730
x86_64                 randconfig-x004-201730
x86_64                 randconfig-x009-201730
x86_64                 randconfig-x005-201730
x86_64                 randconfig-x008-201730
x86_64                 randconfig-x002-201730
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
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
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
