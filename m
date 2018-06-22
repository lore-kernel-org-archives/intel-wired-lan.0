From: kbuild test robot <lkp@intel.com>
Date: Sat, 23 Jun 2018 02:40:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 c6fea871ac1cc0b20176b74f63d7106f62b2a58f
Message-ID: <5b2d4296.elvXg5Ak/m2XaG6I%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: c6fea871ac1cc0b20176b74f63d7106f62b2a58f  ixgbe: Be more careful when modifying MAC filters

elapsed time: 104m

configs tested: 145

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                 randconfig-a0-06230216
i386                   randconfig-c0-06230126
i386                               tinyconfig
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
i386                     randconfig-n0-201824
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
i386                     randconfig-i0-201824
i386                     randconfig-i1-201824
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
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
i386                     randconfig-a0-201824
i386                     randconfig-a1-201824
x86_64                 randconfig-s0-06230011
x86_64                 randconfig-s1-06230011
x86_64                 randconfig-s2-06230011
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201824
i386                     randconfig-s1-201824
x86_64                           allmodconfig
x86_64                 randconfig-s3-06230049
x86_64                 randconfig-s4-06230049
x86_64                 randconfig-s5-06230049
x86_64                   randconfig-i0-201824
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-u0-06230206
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
arm                        mvebu_v5_defconfig
mips                           ip28_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-06230058
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
