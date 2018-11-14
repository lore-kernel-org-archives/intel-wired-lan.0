From: kbuild test robot <lkp@intel.com>
Date: Wed, 14 Nov 2018 11:15:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 9ba8f26ed5b4b9a499bcbe0e013070f3a43a8b00
Message-ID: <5beb9363.tXEEQwdkj9G24iZW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 9ba8f26ed5b4b9a499bcbe0e013070f3a43a8b00  igc: Remove obsolete IGC_ERR define

TIMEOUT after 605m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 134

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
arm                         nhk8815_defconfig
arm                          prima2_defconfig
powerpc64                         allnoconfig
sh                ecovec24-romimage_defconfig
arm                         mv78xx0_defconfig
powerpc                     tqm8548_defconfig
arm                     eseries_pxa_defconfig
arm                          simpad_defconfig
arm                       imx_v4_v5_defconfig
openrisc                         alldefconfig
x86_64                 randconfig-a0-11140934
arm                          pxa3xx_defconfig
mips                        bcm63xx_defconfig
m68k                                defconfig
powerpc                 canyonlands_defconfig
arm                           corgi_defconfig
m68k                             allyesconfig
arm                         palmz72_defconfig
xtensa                           allyesconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-11140757
i386                   randconfig-c0-11140856
i386                   randconfig-c0-11140952
i386                 randconfig-x004-11131818
i386                 randconfig-x003-11131818
i386                 randconfig-x005-11131818
i386                 randconfig-x008-11131818
i386                 randconfig-x009-11131818
i386                 randconfig-x001-11131818
i386                 randconfig-x007-11131818
i386                 randconfig-x000-11131818
i386                 randconfig-x006-11131818
i386                 randconfig-x002-11131818
x86_64               randconfig-x010-11131818
x86_64               randconfig-x011-11131818
x86_64               randconfig-x012-11131818
x86_64               randconfig-x013-11131818
x86_64               randconfig-x014-11131818
x86_64               randconfig-x015-11131818
x86_64               randconfig-x016-11131818
x86_64               randconfig-x017-11131818
x86_64               randconfig-x018-11131818
x86_64               randconfig-x019-11131818
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
arm                       omap2plus_defconfig
arm                              allmodconfig
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm64                            alldefconfig
arm                                      arm5
arm                                     arm67
arm                                    sa1100
arm                                   samsung
arm                                        sh
x86_64                 randconfig-s0-11140753
x86_64                 randconfig-s1-11140753
x86_64                 randconfig-s2-11140753
x86_64                 randconfig-s0-11140826
x86_64                 randconfig-s1-11140826
x86_64                 randconfig-s2-11140826
x86_64                 randconfig-s0-11140906
x86_64                 randconfig-s1-11140906
x86_64                 randconfig-s2-11140906
x86_64                 randconfig-s0-11141013
x86_64                 randconfig-s1-11141013
x86_64                 randconfig-s2-11141013
x86_64                 randconfig-s0-11141043
x86_64                 randconfig-s1-11141043
x86_64                 randconfig-s2-11141043
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
x86_64               randconfig-x009-11131125
x86_64               randconfig-x003-11131125
x86_64               randconfig-x002-11131125
x86_64               randconfig-x004-11131125
x86_64               randconfig-x007-11131125
x86_64               randconfig-x005-11131125
x86_64               randconfig-x000-11131125
x86_64               randconfig-x008-11131125
x86_64               randconfig-x006-11131125
x86_64               randconfig-x001-11131125
x86_64                 randconfig-e0-11131125
x86_64                 randconfig-e1-11131125
x86_64                 randconfig-e2-11131125
x86_64                 randconfig-e3-11131125
arm                       netwinder_defconfig
openrisc                         allmodconfig
x86_64                randconfig-ws0-11140946
arm                          tango4_defconfig
sparc64                          allmodconfig
x86_64                              defconfig
powerpc                 mpc8540_ads_defconfig
arm                         iop13xx_defconfig
arm                          nuc960_defconfig
powerpc                     rainier_defconfig
parisc                generic-64bit_defconfig
powerpc                           allnoconfig
x86_64                 randconfig-r0-11140754
x86_64                 randconfig-r0-11140820
x86_64                 randconfig-r0-11140854
x86_64                 randconfig-r0-11140938
i386                 randconfig-x074-11131127
i386                 randconfig-x076-11131127
i386                 randconfig-x078-11131127
i386                 randconfig-x070-11131127
i386                 randconfig-x073-11131127
i386                 randconfig-x072-11131127
i386                 randconfig-x077-11131127
i386                 randconfig-x079-11131127
i386                 randconfig-x075-11131127
i386                 randconfig-x071-11131127
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
