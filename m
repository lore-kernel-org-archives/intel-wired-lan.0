From: kbuild test robot <lkp@intel.com>
Date: Tue, 30 Oct 2018 06:50:38 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 8eb6a44023235707e9af590a0929d38cc646bb73
Message-ID: <5bd78ebe.QzvVItGSSdut8MCo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 8eb6a44023235707e9af590a0929d38cc646bb73  ice: Remove ICE_MAX_TXQ_PER_TXQG check when configuring Tx queue

elapsed time: 220m

configs tested: 149

The following configs have been built successfully.
More configs may be tested in the coming days.

sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
i386                   randconfig-x019-201843
i386                   randconfig-x016-201843
i386                   randconfig-x018-201843
i386                   randconfig-x014-201843
i386                   randconfig-x015-201843
i386                   randconfig-x017-201843
i386                   randconfig-x010-201843
i386                   randconfig-x011-201843
i386                   randconfig-x012-201843
i386                   randconfig-x013-201843
i386                     randconfig-n1-201843
i386                     randconfig-n3-201843
i386                     randconfig-n2-201843
i386                     randconfig-n0-201843
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                     randconfig-i1-201843
i386                     randconfig-i0-201843
i386                     randconfig-i2-201843
i386                     randconfig-i3-201843
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
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
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                 randconfig-x017-201843
x86_64                 randconfig-x016-201843
x86_64                 randconfig-x011-201843
x86_64                 randconfig-x013-201843
x86_64                 randconfig-x012-201843
x86_64                 randconfig-x019-201843
x86_64                 randconfig-x018-201843
x86_64                 randconfig-x014-201843
x86_64                 randconfig-x010-201843
x86_64                 randconfig-x015-201843
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201843
i386                     randconfig-s1-201843
i386                     randconfig-s3-201843
i386                     randconfig-s2-201843
i386                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
x86_64                 randconfig-i0-10282257
x86_64                 randconfig-i3-10282257
x86_64                 randconfig-i2-10282257
x86_64                 randconfig-i1-10282257
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-k2-10291547
i386                   randconfig-k3-10291547
x86_64                 randconfig-k0-10291547
i386                   randconfig-k0-10291547
i386                   randconfig-k1-10291547
x86_64                 randconfig-k1-10291547
i386                   randconfig-k2-10291547
x86_64                 randconfig-k3-10291547
i386                               tinyconfig
i386                   randconfig-x077-201843
i386                   randconfig-x075-201843
i386                   randconfig-x072-201843
i386                   randconfig-x073-201843
i386                   randconfig-x070-201843
i386                   randconfig-x071-201843
i386                   randconfig-x074-201843
i386                   randconfig-x078-201843
i386                   randconfig-x079-201843
i386                   randconfig-x076-201843
i386                   randconfig-x002-201843
i386                   randconfig-x000-201843
i386                   randconfig-x007-201843
i386                   randconfig-x006-201843
i386                   randconfig-x005-201843
i386                   randconfig-x004-201843
i386                   randconfig-x001-201843
i386                   randconfig-x009-201843
i386                   randconfig-x008-201843
i386                   randconfig-x003-201843
x86_64                 randconfig-x005-201843
x86_64                 randconfig-x002-201843
x86_64                 randconfig-x000-201843
x86_64                 randconfig-x001-201843
x86_64                 randconfig-x008-201843
x86_64                 randconfig-x009-201843
x86_64                 randconfig-x007-201843
x86_64                 randconfig-x003-201843
x86_64                 randconfig-x006-201843
x86_64                 randconfig-x004-201843
x86_64                 randconfig-e0-10291134
x86_64                 randconfig-e1-10291134
x86_64                 randconfig-e2-10291134
x86_64                 randconfig-e3-10291134
x86_64                 randconfig-j1-10290909
i386                   randconfig-j3-10290909
x86_64                 randconfig-j0-10290909
x86_64                 randconfig-j3-10290909
i386                   randconfig-j0-10290909
i386                   randconfig-j1-10290909
i386                   randconfig-j2-10290909
x86_64                 randconfig-j2-10290909

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
