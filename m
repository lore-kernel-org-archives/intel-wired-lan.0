From: kbuild test robot <lkp@intel.com>
Date: Tue, 05 Jun 2018 11:59:06 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:10GbE] BUILD INCOMPLETE
 9a75fa5c166346fa3de35fe8020e43bc98a171d0
Message-ID: <5b160a8a.4MKeSniox2bflop7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  10GbE
branch HEAD: 9a75fa5c166346fa3de35fe8020e43bc98a171d0  ixgbe: fix broken ipsec Rx with proper cast on spi

TIMEOUT after 603m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 35

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
x86_64                            allnoconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                              defconfig
x86_64                                  kexec
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 214

arm                            dove_defconfig
arm                          ks8695_defconfig
arm                           spitz_defconfig
powerpc                     mpc5200_defconfig
x86_64                 randconfig-a0-06051237
x86_64                 randconfig-a0-06050311
mips                                defconfig
powerpc                 xes_mpc85xx_defconfig
arm                  colibri_pxa270_defconfig
sh                      rts7751r2d1_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
powerpc                   lite5200b_defconfig
xtensa                              defconfig
x86_64                randconfig-in0-06051239
ia64                                defconfig
i386                               tinyconfig
i386                   randconfig-x010-201822
i386                   randconfig-x011-201822
i386                   randconfig-x012-201822
i386                   randconfig-x013-201822
i386                   randconfig-x014-201822
i386                   randconfig-x015-201822
i386                   randconfig-x016-201822
i386                   randconfig-x017-201822
i386                   randconfig-x018-201822
i386                   randconfig-x019-201822
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201822
x86_64                 randconfig-x000-201822
x86_64                 randconfig-x001-201822
x86_64                 randconfig-x002-201822
x86_64                 randconfig-x003-201822
x86_64                 randconfig-x004-201822
x86_64                 randconfig-x005-201822
x86_64                 randconfig-x006-201822
x86_64                 randconfig-x007-201822
x86_64                 randconfig-x008-201822
x86_64                 randconfig-x009-201822
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201822
i386                     randconfig-i1-201822
i386         randconfig-i0-201822-CONFIG_DEBUG_INFO_REDUCED
i386         randconfig-i1-201822+bisect_validate
arm                             pxa_defconfig
mips                  cavium_octeon_defconfig
arm                        raumfeld_defconfig
c6x                        evmc6457_defconfig
x86_64                 randconfig-v0-06051317
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
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
arm                          tango4_defconfig
mips                             allyesconfig
x86_64                 randconfig-g0-06051214
x86_64                 randconfig-g0-06051326
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
i386                             allmodconfig
x86_64                 randconfig-x010-201822
x86_64                 randconfig-x011-201822
x86_64                 randconfig-x012-201822
x86_64                 randconfig-x013-201822
x86_64                 randconfig-x014-201822
x86_64                 randconfig-x015-201822
x86_64                 randconfig-x016-201822
x86_64                 randconfig-x017-201822
x86_64                 randconfig-x018-201822
x86_64                 randconfig-x019-201822
ia64                             alldefconfig
ia64                              allnoconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                   randconfig-a0-06041847
i386                   randconfig-a1-06041847
x86_64                 randconfig-s0-06050034
x86_64                 randconfig-s1-06050034
x86_64                 randconfig-s2-06050034
x86_64                 randconfig-s0-06050800
x86_64                 randconfig-s1-06050800
x86_64                 randconfig-s2-06050800
x86_64                 randconfig-s0-06050947
x86_64                 randconfig-s1-06050947
x86_64                 randconfig-s2-06050947
x86_64                 randconfig-s0-06051108
x86_64                 randconfig-s1-06051108
x86_64                 randconfig-s2-06051108
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                         lpc18xx_defconfig
ia64                             allmodconfig
powerpc                     akebono_defconfig
x86_64                           allyesconfig
powerpc                     virtex5_defconfig
mips                              allnoconfig
powerpc                     mpc83xx_defconfig
powerpc                  mpc885_ads_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201822
i386                     randconfig-s1-201822
x86_64                           allmodconfig
x86_64                 randconfig-s3-06050013
x86_64                 randconfig-s4-06050013
x86_64                 randconfig-s5-06050013
x86_64                 randconfig-s3-06050510
x86_64                 randconfig-s4-06050510
x86_64                 randconfig-s5-06050510
x86_64                 randconfig-s3-06050632
x86_64                 randconfig-s4-06050632
x86_64                 randconfig-s5-06050632
x86_64                 randconfig-s3-06050957
x86_64                 randconfig-s4-06050957
x86_64                 randconfig-s5-06050957
x86_64                 randconfig-s3-06051118
x86_64                 randconfig-s4-06051118
x86_64                 randconfig-s5-06051118
x86_64                   randconfig-i0-201822
i386                   randconfig-b0-06051330
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     powernv_defconfig
arm                      footbridge_defconfig
arm                            mps2_defconfig
powerpc                       holly_defconfig
sh                           se7780_defconfig
m68k                          hp300_defconfig
sh                               alldefconfig
x86_64                 randconfig-u0-06050018
x86_64                 randconfig-u0-06050524
x86_64                 randconfig-u0-06050814
um                                  defconfig
xtensa                  audio_kc705_defconfig
arm                         cm_x300_defconfig
powerpc64                         allnoconfig
arm                         em_x270_defconfig
c6x                        evmc6474_defconfig
x86_64                randconfig-ne0-06051204
x86_64                randconfig-ne0-06051254
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
i386                   randconfig-x000-201822
i386                   randconfig-x001-201822
i386                   randconfig-x002-201822
i386                   randconfig-x003-201822
i386                   randconfig-x004-201822
i386                   randconfig-x005-201822
i386                   randconfig-x006-201822
i386                   randconfig-x007-201822
i386                   randconfig-x008-201822
i386                   randconfig-x009-201822
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
powerpc                       eiger_defconfig
sh                           se7343_defconfig
i386                   randconfig-x0-06051140

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
