From: kbuild test robot <lkp@intel.com>
Date: Thu, 15 Nov 2018 17:17:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD INCOMPLETE
 d5585b7b6846a6d0f9517afe57be3843150719da
Message-ID: <5bed39b7.95mdVmrnR+qDshpu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
branch HEAD: d5585b7b6846a6d0f9517afe57be3843150719da  i40e: prevent overlapping tx_timeout recover

TIMEOUT after 605m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 101

alpha                            allmodconfig
alpha                            allyesconfig
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
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-a2
i386                            randconfig-a3
i386                            randconfig-f0
i386                            randconfig-f1
i386                            randconfig-f2
i386                            randconfig-f3
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-i2
i386                            randconfig-i3
i386                            randconfig-j0
i386                            randconfig-j1
i386                            randconfig-j2
i386                            randconfig-j3
i386                            randconfig-k0
i386                            randconfig-k1
i386                            randconfig-k2
i386                            randconfig-k3
i386                            randconfig-n0
i386                            randconfig-n1
i386                            randconfig-n2
i386                            randconfig-n3
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                                   jz4740
mips                                     txx9
nds32                            allmodconfig
nds32                             allnoconfig
nds32                            allyesconfig
nds32                               defconfig
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
x86_64                             acpi-redef
x86_64                           allyesconfig
x86_64                           allyesdebian
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                nfsroot
x86_64                          randconfig-e0
x86_64                          randconfig-e1
x86_64                          randconfig-e2
x86_64                          randconfig-e3
x86_64                          randconfig-f0
x86_64                          randconfig-f1
x86_64                          randconfig-f2
x86_64                          randconfig-f3
x86_64                          randconfig-g0
x86_64                          randconfig-g1
x86_64                          randconfig-g2
x86_64                          randconfig-g3
x86_64                          randconfig-h0
x86_64                          randconfig-h1
x86_64                          randconfig-h2
x86_64                          randconfig-h3
x86_64                          randconfig-i0
x86_64                          randconfig-i1
x86_64                          randconfig-i2
x86_64                          randconfig-i3
x86_64                          randconfig-j0
x86_64                          randconfig-j1
x86_64                          randconfig-j2
x86_64                          randconfig-j3
x86_64                          randconfig-k0
x86_64                          randconfig-k1
x86_64                          randconfig-k2
x86_64                          randconfig-k3
x86_64                                   rhel
x86_64                               rhel-7.2
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 103

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                               tinyconfig
i386                 randconfig-x011-11141412
i386                 randconfig-x017-11141412
i386                 randconfig-x012-11141412
i386                 randconfig-x013-11141412
i386                 randconfig-x018-11141412
i386                 randconfig-x015-11141412
i386                 randconfig-x010-11141412
i386                 randconfig-x016-11141412
i386                 randconfig-x014-11141412
i386                 randconfig-x019-11141412
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
i386                             allmodconfig
x86_64                 randconfig-x017-201845
x86_64                 randconfig-x012-201845
x86_64                 randconfig-x013-201845
x86_64                 randconfig-x016-201845
x86_64                 randconfig-x011-201845
x86_64                 randconfig-x014-201845
x86_64                 randconfig-x018-201845
x86_64                 randconfig-x019-201845
x86_64                 randconfig-x010-201845
x86_64                 randconfig-x015-201845
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
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                   randconfig-s3-11140934
i386                   randconfig-s1-11140934
i386                   randconfig-s2-11140934
i386                   randconfig-s0-11140934
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x077-201845
i386                   randconfig-x071-201845
i386                   randconfig-x073-201845
i386                   randconfig-x070-201845
i386                   randconfig-x075-201845
i386                   randconfig-x072-201845
i386                   randconfig-x074-201845
i386                   randconfig-x079-201845
i386                   randconfig-x076-201845
i386                   randconfig-x078-201845
x86_64                           allmodconfig
i386                   randconfig-x002-201845
i386                   randconfig-x004-201845
i386                   randconfig-x006-201845
i386                   randconfig-x005-201845
i386                   randconfig-x000-201845
i386                   randconfig-x007-201845
i386                   randconfig-x001-201845
i386                   randconfig-x009-201845
i386                   randconfig-x003-201845
i386                   randconfig-x008-201845
x86_64                 randconfig-x001-201845
x86_64                 randconfig-x000-201845
x86_64                 randconfig-x005-201845
x86_64                 randconfig-x002-201845
x86_64                 randconfig-x007-201845
x86_64                 randconfig-x009-201845
x86_64                 randconfig-x008-201845
x86_64                 randconfig-x003-201845
x86_64                 randconfig-x006-201845
x86_64                 randconfig-x004-201845

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
