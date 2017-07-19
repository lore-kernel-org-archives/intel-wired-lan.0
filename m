From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 19 Jul 2017 11:13:22 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:master] BUILD INCOMPLETE
 df39a9f106d53532443a804352894480ca6ca5fd
Message-ID: <596ece52.UewstD613pFfO5WA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  master
df39a9f106d53532443a804352894480ca6ca5fd  bpf: check NULL for sk_to_full_sk() return value

TIMEOUT after 1825m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 120

alpha                            allmodconfig
alpha                            allyesconfig
arm64                             allnoconfig
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
arm64                               defconfig
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
blackfin                         allmodconfig
blackfin                         allyesconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
c6x                        evmc6678_defconfig
cris                             allmodconfig
cris                             allyesconfig
cris                 etrax-100lx_v2_defconfig
frv                                 defconfig
h8300                    h8300h-sim_defconfig
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
ia64                             alldefconfig
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
nios2                         10m50_defconfig
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
score                      spct6600_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                               allyesconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc                               defconfig
tile                             allmodconfig
tile                             allyesconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                    lkp
x86_64                          randconfig-i0
xtensa                           allmodconfig
xtensa                           allyesconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig

configs tested: 54

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                   randconfig-x012-201729
i386                   randconfig-x018-201729
i386                   randconfig-x016-201729
i386                   randconfig-x017-201729
i386                   randconfig-x013-201729
i386                   randconfig-x010-201729
i386                   randconfig-x019-201729
i386                   randconfig-x014-201729
i386                   randconfig-x015-201729
i386                   randconfig-x011-201729
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
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                               tinyconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2

Thanks,
Fengguang
