From: kbuild test robot <lkp@intel.com>
Date: Fri, 19 Apr 2019 09:03:46 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 c3ad34d96c2113a6f2d5af06f6050565a4b5a200
Message-ID: <5cb91e72.47F6jYzk1QTMT/Sg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: c3ad34d96c2113a6f2d5af06f6050565a4b5a200  i40e: Fix of memory leak and integer truncation in i40e_virtchnl.c

elapsed time: 322m

configs tested: 172

The following configs have been built successfully.
More configs may be tested in the coming days.

riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-x010-201915
i386                   randconfig-x018-201915
i386                   randconfig-x017-201915
i386                   randconfig-x013-201915
i386                   randconfig-x011-201915
i386                   randconfig-x014-201915
i386                   randconfig-x019-201915
i386                   randconfig-x015-201915
i386                   randconfig-x016-201915
i386                   randconfig-x012-201915
i386                     randconfig-n2-201915
i386                     randconfig-n3-201915
i386                     randconfig-n0-201915
i386                     randconfig-n1-201915
x86_64                 randconfig-x001-201915
x86_64                 randconfig-x004-201915
x86_64                 randconfig-x000-201915
x86_64                 randconfig-x003-201915
x86_64                 randconfig-x007-201915
x86_64                 randconfig-x008-201915
x86_64                 randconfig-x002-201915
x86_64                 randconfig-x006-201915
x86_64                 randconfig-x009-201915
x86_64                 randconfig-x005-201915
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
nds32                             allnoconfig
nds32                               defconfig
i386                     randconfig-i1-201915
i386                     randconfig-i0-201915
i386                     randconfig-i3-201915
i386                     randconfig-i2-201915
riscv                             allnoconfig
riscv                               defconfig
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201915
x86_64                 randconfig-x016-201915
x86_64                 randconfig-x012-201915
x86_64                 randconfig-x017-201915
x86_64                 randconfig-x013-201915
x86_64                 randconfig-x018-201915
x86_64                 randconfig-x010-201915
x86_64                 randconfig-x014-201915
x86_64                 randconfig-x019-201915
x86_64                 randconfig-x011-201915
i386                     randconfig-a1-201915
i386                     randconfig-a2-201915
i386                     randconfig-a0-201915
i386                     randconfig-a3-201915
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                   randconfig-k2-201915
i386                     randconfig-k2-201915
i386                     randconfig-k3-201915
i386                     randconfig-k0-201915
x86_64                   randconfig-k1-201915
x86_64                   randconfig-k3-201915
i386                     randconfig-k1-201915
x86_64                   randconfig-k0-201915
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                 randconfig-m0-04170939
i386                   randconfig-m2-04170939
i386                   randconfig-m1-04170939
i386                   randconfig-m3-04170939
i386                   randconfig-m0-04170939
x86_64                 randconfig-m2-04170939
x86_64                 randconfig-m1-04170939
x86_64                 randconfig-m3-04170939
i386                   randconfig-l2-04180125
x86_64                 randconfig-l2-04180125
x86_64                 randconfig-l0-04180125
x86_64                 randconfig-l1-04180125
i386                   randconfig-l0-04180125
i386                   randconfig-l1-04180125
x86_64                 randconfig-l3-04180125
i386                   randconfig-l3-04180125
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                   randconfig-i1-201915
x86_64                   randconfig-i2-201915
x86_64                   randconfig-i3-201915
x86_64                   randconfig-i0-201915
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                           allmodconfig
i386                             alldefconfig
arm                              allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
x86_64                   randconfig-g0-201915
x86_64                   randconfig-g3-201915
x86_64                   randconfig-g2-201915
x86_64                   randconfig-g1-201915
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-x077-201915
i386                   randconfig-x074-201915
i386                   randconfig-x070-201915
i386                   randconfig-x072-201915
i386                   randconfig-x075-201915
i386                   randconfig-x071-201915
i386                   randconfig-x079-201915
i386                   randconfig-x078-201915
i386                   randconfig-x073-201915
i386                   randconfig-x076-201915
i386                   randconfig-x002-201915
i386                   randconfig-x001-201915
i386                   randconfig-x005-201915
i386                   randconfig-x007-201915
i386                   randconfig-x000-201915
i386                   randconfig-x004-201915
i386                   randconfig-x008-201915
i386                   randconfig-x009-201915
i386                   randconfig-x006-201915
i386                   randconfig-x003-201915
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
