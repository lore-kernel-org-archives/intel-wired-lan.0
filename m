From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 02 Feb 2018 12:51:45 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 479b90797b4500fc88a953dade5af125989f201e
Message-ID: <5a73ee61.W4WGz0ckrQl1oBq9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 479b90797b4500fc88a953dade5af125989f201e  e1000e: Remove Other from EIAC

TIMEOUT after 609m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 47

alpha                            allmodconfig
alpha                            allyesconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                               tinyconfig
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
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 128

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                   randconfig-x019-201804
i386                   randconfig-x010-201804
i386                   randconfig-x015-201804
i386                   randconfig-x014-201804
i386                   randconfig-x012-201804
i386                   randconfig-x011-201804
i386                   randconfig-x017-201804
i386                   randconfig-x016-201804
i386                   randconfig-x018-201804
i386                   randconfig-x013-201804
i386                     randconfig-n0-201804
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                     randconfig-i0-201804
i386                     randconfig-i1-201804
x86_64                                  kexec
x86_64                              federa-25
x86_64                                   rhel
x86_64                               rhel-7.2
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
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
i386                             allmodconfig
x86_64                 randconfig-x017-201804
x86_64                 randconfig-x018-201804
x86_64                 randconfig-x013-201804
x86_64                 randconfig-x016-201804
x86_64                 randconfig-x011-201804
x86_64                 randconfig-x014-201804
x86_64                 randconfig-x015-201804
x86_64                 randconfig-x012-201804
x86_64                 randconfig-x010-201804
x86_64                 randconfig-x019-201804
i386                     randconfig-a1-201804
i386                     randconfig-a0-201804
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
i386                     randconfig-s0-201804
i386                     randconfig-s1-201804
x86_64                   randconfig-i0-201804
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                           allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-x004-201804
i386                   randconfig-x007-201804
i386                   randconfig-x002-201804
i386                   randconfig-x009-201804
i386                   randconfig-x003-201804
i386                   randconfig-x005-201804
i386                   randconfig-x006-201804
i386                   randconfig-x000-201804
i386                   randconfig-x008-201804
i386                   randconfig-x001-201804
x86_64                 randconfig-x008-201804
x86_64                 randconfig-x000-201804
x86_64                 randconfig-x005-201804
x86_64                 randconfig-x002-201804
x86_64                 randconfig-x007-201804
x86_64                 randconfig-x009-201804
x86_64                 randconfig-x006-201804
x86_64                 randconfig-x001-201804
x86_64                 randconfig-x003-201804
x86_64                 randconfig-x004-201804
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
i386                   randconfig-x071-201804
i386                   randconfig-x079-201804
i386                   randconfig-x072-201804
i386                   randconfig-x077-201804
i386                   randconfig-x076-201804
i386                   randconfig-x070-201804
i386                   randconfig-x073-201804
i386                   randconfig-x075-201804
i386                   randconfig-x078-201804
i386                   randconfig-x074-201804
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
