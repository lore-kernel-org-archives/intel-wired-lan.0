From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 15 Jul 2017 18:35:48 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 d5024bf462c873f0db28e2d383fb4211b98f5a4e
Message-ID: <5969f004.vXlU+8TmZHDRYooG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
d5024bf462c873f0db28e2d383fb4211b98f5a4e  ixgbe: fix masking of bits read from IXGBE_VXLANCTRL register

TIMEOUT after 608m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 49

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
i386                            randconfig-s0
i386                            randconfig-s1
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
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                  kexec
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 125

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
i386                     randconfig-n0-201728
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
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
i386                   randconfig-a1-07130840
i386                   randconfig-a0-07130840
x86_64                 randconfig-x019-201728
x86_64                 randconfig-x010-201728
x86_64                 randconfig-x015-201728
x86_64                 randconfig-x018-201728
x86_64                 randconfig-x017-201728
x86_64                 randconfig-x016-201728
x86_64                 randconfig-x014-201728
x86_64                 randconfig-x012-201728
x86_64                 randconfig-x011-201728
x86_64                 randconfig-x013-201728
x86_64                 randconfig-i0-07121632
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-07141916
i386                   randconfig-i1-07141916
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
i386                   randconfig-x012-201728
i386                   randconfig-x018-201728
i386                   randconfig-x016-201728
i386                   randconfig-x017-201728
i386                   randconfig-x013-201728
i386                   randconfig-x010-201728
i386                   randconfig-x019-201728
i386                   randconfig-x014-201728
i386                   randconfig-x015-201728
i386                   randconfig-x011-201728
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
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
i386                 randconfig-x076-07130833
i386                 randconfig-x074-07130833
i386                 randconfig-x073-07130833
i386                 randconfig-x079-07130833
i386                 randconfig-x070-07130833
i386                 randconfig-x078-07130833
i386                 randconfig-x077-07130833
i386                 randconfig-x072-07130833
i386                 randconfig-x075-07130833
i386                 randconfig-x071-07130833
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-x006-201728
x86_64                 randconfig-x004-201728
x86_64                 randconfig-x005-201728
x86_64                 randconfig-x007-201728
x86_64                 randconfig-x001-201728
x86_64                 randconfig-x008-201728
x86_64                 randconfig-x002-201728
x86_64                 randconfig-x000-201728
x86_64                 randconfig-x009-201728
x86_64                 randconfig-x003-201728
i386                             allmodconfig
i386                 randconfig-x009-07121650
i386                 randconfig-x004-07121650
i386                 randconfig-x006-07121650
i386                 randconfig-x008-07121650
i386                 randconfig-x003-07121650
i386                 randconfig-x005-07121650
i386                 randconfig-x007-07121650
i386                 randconfig-x002-07121650
i386                 randconfig-x001-07121650
i386                 randconfig-x000-07121650
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
