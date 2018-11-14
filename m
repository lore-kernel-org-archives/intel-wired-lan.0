From: kbuild test robot <lkp@intel.com>
Date: Wed, 14 Nov 2018 12:37:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD INCOMPLETE
 ef878d6086611eda90755e1f17426f0030000fb1
Message-ID: <5beba680.w0MJzcIoUVOXmQYh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: ef878d6086611eda90755e1f17426f0030000fb1  ice: Remove ICE_MAX_TXQ_PER_TXQG check when configuring Tx queue

TIMEOUT after 603m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 119

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
mips                         rt305x_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          rsk7264_defconfig
m68k                           sun3_defconfig
parisc                           alldefconfig
sh                          landisk_defconfig
sh                           se7722_defconfig
arm                              allyesconfig
sh                        sh7763rdp_defconfig
x86_64                 randconfig-a0-11140510
x86_64                 randconfig-a0-11140648
x86_64                 randconfig-a0-11140746
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
powerpc                      pmac32_defconfig
sh                           sh2007_defconfig
mips                        generic_defconfig
sparc64                             defconfig
m68k                             alldefconfig
mips                       lemote2f_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-11140530
i386                             allmodconfig
i386                 randconfig-x000-11131818
i386                 randconfig-x001-11131818
i386                 randconfig-x002-11131818
i386                 randconfig-x003-11131818
i386                 randconfig-x004-11131818
i386                 randconfig-x005-11131818
i386                 randconfig-x006-11131818
i386                 randconfig-x007-11131818
i386                 randconfig-x008-11131818
i386                 randconfig-x009-11131818
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
x86_64                 randconfig-s0-11140629
x86_64                 randconfig-s1-11140629
x86_64                 randconfig-s2-11140629
x86_64                 randconfig-s0-11140716
x86_64                 randconfig-s1-11140716
x86_64                 randconfig-s2-11140716
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-s3-11140934
i386                   randconfig-s1-11140934
i386                   randconfig-s2-11140934
i386                   randconfig-s0-11140934
x86_64               randconfig-x000-11131125
x86_64               randconfig-x001-11131125
x86_64               randconfig-x002-11131125
x86_64               randconfig-x003-11131125
x86_64               randconfig-x004-11131125
x86_64               randconfig-x005-11131125
x86_64               randconfig-x006-11131125
x86_64               randconfig-x007-11131125
x86_64               randconfig-x008-11131125
x86_64               randconfig-x009-11131125
x86_64                 randconfig-e0-11131125
x86_64                 randconfig-e1-11131125
x86_64                 randconfig-e2-11131125
x86_64                 randconfig-e3-11131125
powerpc                   motionpro_defconfig
sparc                               defconfig
x86_64                 randconfig-r0-11140537
x86_64                 randconfig-r0-11140721
i386                 randconfig-x070-11131127
i386                 randconfig-x071-11131127
i386                 randconfig-x072-11131127
i386                 randconfig-x073-11131127
i386                 randconfig-x074-11131127
i386                 randconfig-x075-11131127
i386                 randconfig-x076-11131127
i386                 randconfig-x077-11131127
i386                 randconfig-x078-11131127
i386                 randconfig-x079-11131127
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
