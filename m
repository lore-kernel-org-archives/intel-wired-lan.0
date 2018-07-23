From: kbuild test robot <lkp@intel.com>
Date: Tue, 24 Jul 2018 04:31:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:XDP-hints-EXPERIMENTAL]
 BUILD SUCCESS 58e0270bb7ac94a31ff0fe372385cfce4198b56c
Message-ID: <5b563b15.GcVqxt9IbdfwNGBq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  XDP-hints-EXPERIMENTAL
branch HEAD: 58e0270bb7ac94a31ff0fe372385cfce4198b56c  i40e: Initial support to add hw hints for xdp

elapsed time: 90m

configs tested: 121

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                     randconfig-n0-201829
i386                     randconfig-i0-201829
i386                     randconfig-i1-201829
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-x018-201829
x86_64                 randconfig-x011-201829
x86_64                 randconfig-x015-201829
x86_64                 randconfig-x019-201829
x86_64                 randconfig-x014-201829
x86_64                 randconfig-x010-201829
x86_64                 randconfig-x013-201829
x86_64                 randconfig-x016-201829
x86_64                 randconfig-x017-201829
x86_64                 randconfig-x012-201829
i386                     randconfig-a0-201829
i386                     randconfig-a1-201829
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201829
i386                     randconfig-s1-201829
x86_64                           allmodconfig
i386                             allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201829
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                               tinyconfig
i386                   randconfig-x012-201829
i386                   randconfig-x017-201829
i386                   randconfig-x014-201829
i386                   randconfig-x016-201829
i386                   randconfig-x013-201829
i386                   randconfig-x011-201829
i386                   randconfig-x018-201829
i386                   randconfig-x010-201829
i386                   randconfig-x015-201829
i386                   randconfig-x019-201829
i386                   randconfig-x078-201829
i386                   randconfig-x070-201829
i386                   randconfig-x075-201829
i386                   randconfig-x076-201829
i386                   randconfig-x074-201829
i386                   randconfig-x079-201829
i386                   randconfig-x071-201829
i386                   randconfig-x073-201829
i386                   randconfig-x072-201829
i386                   randconfig-x077-201829
x86_64                 randconfig-x007-201829
x86_64                 randconfig-x003-201829
x86_64                 randconfig-x000-201829
x86_64                 randconfig-x005-201829
x86_64                 randconfig-x004-201829
x86_64                 randconfig-x008-201829
x86_64                 randconfig-x001-201829
x86_64                 randconfig-x009-201829
x86_64                 randconfig-x002-201829
x86_64                 randconfig-x006-201829
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64        kexec-CONFIG_DEBUG_INFO_REDUCED
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
i386                   randconfig-x008-201829
i386                   randconfig-x009-201829
i386                   randconfig-x005-201829
i386                   randconfig-x000-201829
i386                   randconfig-x003-201829
i386                   randconfig-x001-201829
i386                   randconfig-x004-201829
i386                   randconfig-x006-201829
i386                   randconfig-x007-201829
i386                   randconfig-x002-201829
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
