From: kbuild test robot <lkp@intel.com>
Date: Wed, 04 Jul 2018 11:15:27 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 f3c1678a9a554825d76a8f14a7cc879a5a04f63a
Message-ID: <5b3c3bcf.U1v2ewMtXZtpoXXe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: f3c1678a9a554825d76a8f14a7cc879a5a04f63a  ixgbe: Be more careful when modifying MAC filters

TIMEOUT after 606m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 39

alpha                            allmodconfig
alpha                            allyesconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
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
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                           allyesconfig
x86_64                                    lkp
x86_64                        randconfig-x010
x86_64                        randconfig-x013
x86_64                        randconfig-x014
x86_64                        randconfig-x016
x86_64                        randconfig-x017
x86_64                        randconfig-x018
x86_64                        randconfig-x019
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 146

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                           allmodconfig
mips                        jmr3927_defconfig
powerpc                      chrp32_defconfig
arm                         s3c2410_defconfig
ia64                            sim_defconfig
arm                          exynos_defconfig
parisc                generic-32bit_defconfig
i386                   randconfig-n0-07031211
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                     randconfig-i0-201826
i386                     randconfig-i1-201826
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
i386                   randconfig-a0-07031120
i386                   randconfig-a1-07031120
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                 randconfig-x015-201826
x86_64                 randconfig-x011-201826
x86_64                 randconfig-x012-201826
i386                     randconfig-s0-201826
i386                     randconfig-s1-201826
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                               tinyconfig
i386                             allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                 randconfig-i0-07031126
i386                   randconfig-b0-07041000
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x016-201826
i386                   randconfig-x014-201826
i386                   randconfig-x017-201826
i386                   randconfig-x012-201826
i386                   randconfig-x018-201826
i386                   randconfig-x011-201826
i386                   randconfig-x013-201826
i386                   randconfig-x019-201826
i386                   randconfig-x015-201826
i386                   randconfig-x010-201826
m68k                           sun3_defconfig
powerpc                        warp_defconfig
mips                          ath25_defconfig
powerpc64                        allmodconfig
arm                           u8500_defconfig
i386                 randconfig-x010-07030947
i386                 randconfig-x011-07030947
i386                 randconfig-x012-07030947
i386                 randconfig-x013-07030947
i386                 randconfig-x014-07030947
i386                 randconfig-x015-07030947
i386                 randconfig-x016-07030947
i386                 randconfig-x017-07030947
i386                 randconfig-x018-07030947
i386                 randconfig-x019-07030947
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
i386                   randconfig-x078-201826
i386                   randconfig-x079-201826
i386                   randconfig-x074-201826
i386                   randconfig-x076-201826
i386                   randconfig-x075-201826
i386                   randconfig-x070-201826
i386                   randconfig-x073-201826
i386                   randconfig-x071-201826
i386                   randconfig-x077-201826
i386                   randconfig-x072-201826
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
arm                       aspeed_g4_defconfig
mips                           jazz_defconfig
arm                            netx_defconfig
arm                         palmz72_defconfig
x86_64                 randconfig-x003-201826
x86_64                 randconfig-x007-201826
x86_64                 randconfig-x004-201826
x86_64                 randconfig-x005-201826
x86_64                 randconfig-x000-201826
x86_64                 randconfig-x001-201826
x86_64                 randconfig-x008-201826
x86_64                 randconfig-x006-201826
x86_64                 randconfig-x002-201826
x86_64                 randconfig-x009-201826
m68k                            q40_defconfig
i386                   randconfig-x009-201826
i386                   randconfig-x008-201826
i386                   randconfig-x001-201826
i386                   randconfig-x003-201826
i386                   randconfig-x000-201826
i386                   randconfig-x005-201826
i386                   randconfig-x006-201826
i386                   randconfig-x004-201826
i386                   randconfig-x002-201826
i386                   randconfig-x007-201826
i386                   randconfig-x0-07041000
i386                   randconfig-x0-07040934
i386                   randconfig-x0-07041019

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
