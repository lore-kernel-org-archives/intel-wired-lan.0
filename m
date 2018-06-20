From: kbuild test robot <lkp@intel.com>
Date: Wed, 20 Jun 2018 14:09:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 33cb3e9de4c29ae27bce032497f0ea417366d4cf
Message-ID: <5b29efb1.TiZWSq+NsfnAcXAO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 33cb3e9de4c29ae27bce032497f0ea417366d4cf  ixgbe: Be more careful when modifying MAC filters

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:496:56: sparse: restricted __be32 degrades to integer

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-allmodconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer

TIMEOUT after 604m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 33

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
x86_64                                  kexec
x86_64                                    lkp
x86_64                          randconfig-i0
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 123

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
i386                               tinyconfig
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
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
x86_64                                   rhel
x86_64                              fedora-25
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
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
i386                             allmodconfig
i386                   randconfig-x008-201824
i386                   randconfig-x009-201824
i386                   randconfig-x003-201824
i386                   randconfig-x000-201824
i386                   randconfig-x001-201824
i386                   randconfig-x005-201824
i386                   randconfig-x006-201824
i386                   randconfig-x004-201824
i386                   randconfig-x002-201824
i386                   randconfig-x007-201824
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
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
