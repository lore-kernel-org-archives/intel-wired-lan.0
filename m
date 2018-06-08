From: kbuild test robot <lkp@intel.com>
Date: Fri, 08 Jun 2018 08:17:18 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 0e9476e934331e460c596358641449ee381ba87d
Message-ID: <5b19cb0e.tR4Rzyj9SJsuEwFn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 0e9476e934331e460c596358641449ee381ba87d  ixgbe: Fix bit definitions and add support for testing for ipsec support

TIMEOUT after 600m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 33

alpha                            allmodconfig
alpha                            allyesconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sparc                            allmodconfig
sparc                            allyesconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                              defconfig
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 196

x86_64                 randconfig-a0-06080051
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-06071650
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201822
x86_64                 randconfig-x003-201822
x86_64                 randconfig-x007-201822
x86_64                 randconfig-x000-201822
x86_64                 randconfig-x004-201822
x86_64                 randconfig-x005-201822
x86_64                 randconfig-x001-201822
x86_64                 randconfig-x008-201822
x86_64                 randconfig-x002-201822
x86_64                 randconfig-x006-201822
x86_64                 randconfig-x009-201822
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201822
i386                     randconfig-i1-201822
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
x86_64                 randconfig-v0-06070849
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-g0-06070934
i386                             allmodconfig
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
i386                     randconfig-a0-201822
i386                     randconfig-a1-201822
x86_64                 randconfig-s0-06072134
x86_64                 randconfig-s1-06072134
x86_64                 randconfig-s2-06072134
x86_64                 randconfig-s0-06080052
x86_64                 randconfig-s1-06080052
x86_64                 randconfig-s2-06080052
x86_64                 randconfig-s0-06080157
x86_64                 randconfig-s1-06080157
x86_64                 randconfig-s2-06080157
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                          iop33x_defconfig
arm                         lpc18xx_defconfig
powerpc                          allyesconfig
powerpc                   bluestone_defconfig
arm                       versatile_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7721_defconfig
sparc64                          allmodconfig
m68k                        m5407c3_defconfig
mips                     loongson1c_defconfig
powerpc                 canyonlands_defconfig
powerpc                     sbc8548_defconfig
i386                              allnoconfig
arm                         axm55xx_defconfig
arm                           corgi_defconfig
arm                          moxart_defconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201822
i386                     randconfig-s1-201822
x86_64                           allmodconfig
x86_64                 randconfig-s3-06071306
x86_64                 randconfig-s4-06071306
x86_64                 randconfig-s5-06071306
x86_64                 randconfig-s3-06080047
x86_64                 randconfig-s4-06080047
x86_64                 randconfig-s5-06080047
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201822
i386                   randconfig-b0-06071245
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m68k                         amcore_defconfig
sh                               allyesconfig
x86_64                 randconfig-u0-06071218
ia64                         bigsur_defconfig
openrisc                          allnoconfig
arm                          nuc960_defconfig
mips                           jazz_defconfig
s390                       zfcpdump_defconfig
i386                   randconfig-h0-06071222
i386                   randconfig-h1-06071222
arm                          tango4_defconfig
s390                    performance_defconfig
x86_64                randconfig-ne0-06072115
mips                       bmips_be_defconfig
mips                        vocore2_defconfig
arm                            mps2_defconfig
sh                             espt_defconfig
x86_64                 randconfig-h0-06072221
x86_64                 randconfig-h0-06080126
i386                   randconfig-x009-201822
i386                   randconfig-x008-201822
i386                   randconfig-x005-201822
i386                   randconfig-x001-201822
i386                   randconfig-x003-201822
i386                   randconfig-x000-201822
i386                   randconfig-x004-201822
i386                   randconfig-x006-201822
i386                   randconfig-x002-201822
i386                   randconfig-x007-201822
x86_64                 randconfig-x011-201822
x86_64                 randconfig-x015-201822
x86_64                 randconfig-x018-201822
x86_64                 randconfig-x010-201822
x86_64                 randconfig-x014-201822
x86_64                 randconfig-x019-201822
x86_64                 randconfig-x013-201822
x86_64                 randconfig-x017-201822
x86_64                 randconfig-x016-201822
x86_64                 randconfig-x012-201822
i386                   randconfig-x012-201822
i386                   randconfig-x016-201822
i386                   randconfig-x014-201822
i386                   randconfig-x017-201822
i386                   randconfig-x018-201822
i386                   randconfig-x013-201822
i386                   randconfig-x011-201822
i386                   randconfig-x015-201822
i386                   randconfig-x019-201822
i386                   randconfig-x010-201822
i386                   randconfig-x078-201822
i386                   randconfig-x079-201822
i386                   randconfig-x070-201822
i386                   randconfig-x074-201822
i386                   randconfig-x076-201822
i386                   randconfig-x075-201822
i386                   randconfig-x071-201822
i386                   randconfig-x073-201822
i386                   randconfig-x077-201822
i386                   randconfig-x072-201822
i386                  randconfig-sb0-06081001
x86_64                randconfig-ws0-06070848
c6x                        evmc6472_defconfig
sparc64                          allyesconfig
x86_64                 randconfig-r0-06071209
ia64                             allmodconfig
powerpc                         ps3_defconfig
i386                   randconfig-x0-06071204
i386                   randconfig-x0-06080029

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
