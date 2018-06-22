From: kbuild test robot <lkp@intel.com>
Date: Fri, 22 Jun 2018 08:05:54 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 9acbe71c6e4e0715796a89053e3c352c78d41316
Message-ID: <5b2c3d62.KkElyTWOlgI1mM6Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 9acbe71c6e4e0715796a89053e3c352c78d41316  ixgbe: Be more careful when modifying MAC filters

TIMEOUT after 608m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 31

alpha                            allmodconfig
alpha                            allyesconfig
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
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
sh                               allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                           allyesconfig
x86_64                          randconfig-i0
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 217

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
i386                   randconfig-x014-201824
i386                   randconfig-x017-201824
i386                   randconfig-x016-201824
i386                   randconfig-x012-201824
i386                   randconfig-x018-201824
i386                   randconfig-x011-201824
i386                   randconfig-x013-201824
i386                   randconfig-x019-201824
i386                   randconfig-x015-201824
i386                   randconfig-x010-201824
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-x003-201824
x86_64                 randconfig-x007-201824
x86_64                 randconfig-x005-201824
x86_64                 randconfig-x004-201824
x86_64                 randconfig-x000-201824
x86_64                 randconfig-x001-201824
x86_64                 randconfig-x008-201824
x86_64                 randconfig-x006-201824
x86_64                 randconfig-x002-201824
x86_64                 randconfig-x009-201824
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                                  kexec
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201824
x86_64                 randconfig-x011-201824
x86_64                 randconfig-x018-201824
x86_64                 randconfig-x010-201824
x86_64                 randconfig-x019-201824
x86_64                 randconfig-x014-201824
x86_64                 randconfig-x016-201824
x86_64                 randconfig-x017-201824
x86_64                 randconfig-x013-201824
x86_64                 randconfig-x012-201824
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-s3-06220235
x86_64                 randconfig-s4-06220235
x86_64                 randconfig-s5-06220235
x86_64                 randconfig-s3-06220307
x86_64                 randconfig-s4-06220307
x86_64                 randconfig-s5-06220307
x86_64                 randconfig-s3-06220337
x86_64                 randconfig-s4-06220337
x86_64                 randconfig-s5-06220337
x86_64                 randconfig-s3-06220348
x86_64                 randconfig-s4-06220348
x86_64                 randconfig-s5-06220348
x86_64                 randconfig-s3-06220353
x86_64                 randconfig-s4-06220353
x86_64                 randconfig-s5-06220353
x86_64                 randconfig-s3-06220357
x86_64                 randconfig-s4-06220357
x86_64                 randconfig-s5-06220357
x86_64                 randconfig-s3-06220407
x86_64                 randconfig-s4-06220407
x86_64                 randconfig-s5-06220407
x86_64                 randconfig-s3-06220415
x86_64                 randconfig-s4-06220415
x86_64                 randconfig-s5-06220415
x86_64                 randconfig-s3-06220429
x86_64                 randconfig-s4-06220429
x86_64                 randconfig-s5-06220429
x86_64                 randconfig-s3-06220442
x86_64                 randconfig-s4-06220442
x86_64                 randconfig-s5-06220442
x86_64                 randconfig-s3-06220447
x86_64                 randconfig-s4-06220447
x86_64                 randconfig-s5-06220447
x86_64                 randconfig-s3-06220451
x86_64                 randconfig-s4-06220451
x86_64                 randconfig-s5-06220451
x86_64                 randconfig-s3-06220456
x86_64                 randconfig-s4-06220456
x86_64                 randconfig-s5-06220456
x86_64                 randconfig-s3-06220459
x86_64                 randconfig-s4-06220459
x86_64                 randconfig-s5-06220459
x86_64                 randconfig-s3-06220519
x86_64                 randconfig-s4-06220519
x86_64                 randconfig-s5-06220519
x86_64                 randconfig-s3-06220527
x86_64                 randconfig-s4-06220527
x86_64                 randconfig-s5-06220527
x86_64                 randconfig-s3-06220538
x86_64                 randconfig-s4-06220538
x86_64                 randconfig-s5-06220538
x86_64                 randconfig-s3-06220542
x86_64                 randconfig-s4-06220542
x86_64                 randconfig-s5-06220542
x86_64                 randconfig-s3-06220549
x86_64                 randconfig-s4-06220549
x86_64                 randconfig-s5-06220549
x86_64                 randconfig-s3-06220611
x86_64                 randconfig-s4-06220611
x86_64                 randconfig-s5-06220611
x86_64                 randconfig-s3-06220615
x86_64                 randconfig-s4-06220615
x86_64                 randconfig-s5-06220615
x86_64                 randconfig-s3-06220632
x86_64                 randconfig-s4-06220632
x86_64                 randconfig-s5-06220632
x86_64                 randconfig-s3-06220643
x86_64                 randconfig-s4-06220643
x86_64                 randconfig-s5-06220643
x86_64                 randconfig-s3-06220655
x86_64                 randconfig-s4-06220655
x86_64                 randconfig-s5-06220655
x86_64                 randconfig-s3-06220707
x86_64                 randconfig-s4-06220707
x86_64                 randconfig-s5-06220707
x86_64                 randconfig-s3-06220718
x86_64                 randconfig-s4-06220718
x86_64                 randconfig-s5-06220718
x86_64                 randconfig-s3-06220735
x86_64                 randconfig-s4-06220735
x86_64                 randconfig-s5-06220735
x86_64                 randconfig-s3-06220743
x86_64                 randconfig-s4-06220743
x86_64                 randconfig-s5-06220743
x86_64                 randconfig-s3-06220749
x86_64                 randconfig-s4-06220749
x86_64                 randconfig-s5-06220749
x86_64                 randconfig-s3-06220758
x86_64                 randconfig-s4-06220758
x86_64                 randconfig-s5-06220758
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x000-201824
i386                   randconfig-x001-201824
i386                   randconfig-x002-201824
i386                   randconfig-x003-201824
i386                   randconfig-x004-201824
i386                   randconfig-x005-201824
i386                   randconfig-x006-201824
i386                   randconfig-x007-201824
i386                   randconfig-x008-201824
i386                   randconfig-x009-201824
i386                   randconfig-x078-201824
i386                   randconfig-x079-201824
i386                   randconfig-x076-201824
i386                   randconfig-x075-201824
i386                   randconfig-x074-201824
i386                   randconfig-x070-201824
i386                   randconfig-x073-201824
i386                   randconfig-x071-201824
i386                   randconfig-x077-201824
i386                   randconfig-x072-201824
i386                             allyesconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
