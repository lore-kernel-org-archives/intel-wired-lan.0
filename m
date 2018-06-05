From: kbuild test robot <lkp@intel.com>
Date: Tue, 05 Jun 2018 14:19:14 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 e796d58c317f1448c2871075573842f310f9311a
Message-ID: <5b162b62.GRf0ACIDfu4DLyDz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e796d58c317f1448c2871075573842f310f9311a  ixgbe: check that ipsec is available on the chip

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:490:56: sparse: restricted __be32 degrades to integer

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-allmodconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer

TIMEOUT after 609m


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
x86_64                            allnoconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                              defconfig
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 173

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
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
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
i386                   randconfig-a0-06041847
i386                   randconfig-a1-06041847
x86_64                 randconfig-s0-06050348
x86_64                 randconfig-s1-06050348
x86_64                 randconfig-s2-06050348
x86_64                 randconfig-s0-06050709
x86_64                 randconfig-s1-06050709
x86_64                 randconfig-s2-06050709
x86_64                 randconfig-s0-06050915
x86_64                 randconfig-s1-06050915
x86_64                 randconfig-s2-06050915
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                         lpc18xx_defconfig
ia64                             allmodconfig
powerpc                     akebono_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                        warp_defconfig
sh                         microdev_defconfig
mips                malta_kvm_guest_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                         wii_defconfig
x86_64                           allyesconfig
powerpc                     virtex5_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201822
i386                     randconfig-s1-201822
x86_64                 randconfig-s3-06050013
x86_64                 randconfig-s4-06050013
x86_64                 randconfig-s5-06050013
x86_64                 randconfig-s3-06050632
x86_64                 randconfig-s4-06050632
x86_64                 randconfig-s5-06050632
x86_64                 randconfig-s3-06050812
x86_64                 randconfig-s4-06050812
x86_64                 randconfig-s5-06050812
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201822
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     powernv_defconfig
powerpc                       holly_defconfig
sh                           se7780_defconfig
m68k                          hp300_defconfig
sh                               alldefconfig
x86_64                 randconfig-u0-06050319
x86_64                 randconfig-u0-06050718
x86_64                 randconfig-u0-06050814
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
x86_64                                  kexec

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
