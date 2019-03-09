From: kbuild test robot <lkp@intel.com>
Date: Sat, 09 Mar 2019 09:01:07 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 4f1ad9d46df8767928825a89146e9dc9238e94d9
Message-ID: <5c831053.1WmOqx4ZSsQWbFlM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 4f1ad9d46df8767928825a89146e9dc9238e94d9  checkpatch.pl: seed camelcase from the provided kernel tree root

elapsed time: 139m

configs tested: 147

The following configs have been built successfully.
More configs may be tested in the coming days.

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-x015-201909
i386                   randconfig-x019-201909
i386                   randconfig-x014-201909
i386                   randconfig-x016-201909
i386                   randconfig-x013-201909
i386                   randconfig-x012-201909
i386                   randconfig-x011-201909
i386                   randconfig-x018-201909
i386                   randconfig-x017-201909
i386                   randconfig-x010-201909
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                   randconfig-i0-03031336
i386                   randconfig-i1-03031336
i386                   randconfig-i2-03031336
i386                   randconfig-i3-03031336
x86_64                 randconfig-x017-201909
x86_64                 randconfig-x013-201909
x86_64                 randconfig-x016-201909
x86_64                 randconfig-x018-201909
x86_64                 randconfig-x011-201909
x86_64                 randconfig-x012-201909
x86_64                 randconfig-x019-201909
x86_64                 randconfig-x014-201909
x86_64                 randconfig-x015-201909
x86_64                 randconfig-x010-201909
i386                   randconfig-a2-03060126
i386                   randconfig-a1-03060126
i386                   randconfig-a3-03060126
i386                   randconfig-a0-03060126
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                     randconfig-s0-201909
i386                     randconfig-s1-201909
i386                     randconfig-s2-201909
i386                     randconfig-s3-201909
x86_64                           allyesconfig
i386                             allmodconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
riscv                             allnoconfig
riscv                               defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                   randconfig-l0-201909
x86_64                   randconfig-l1-201909
x86_64                   randconfig-l2-201909
x86_64                   randconfig-l3-201909
i386                     randconfig-l0-201909
i386                     randconfig-l1-201909
i386                     randconfig-l2-201909
i386                     randconfig-l3-201909
i386                   randconfig-x073-201909
i386                   randconfig-x075-201909
i386                   randconfig-x079-201909
i386                   randconfig-x072-201909
i386                   randconfig-x077-201909
i386                   randconfig-x076-201909
i386                   randconfig-x074-201909
i386                   randconfig-x078-201909
i386                   randconfig-x071-201909
i386                   randconfig-x070-201909
i386                   randconfig-x006-201909
i386                   randconfig-x000-201909
i386                   randconfig-x007-201909
i386                   randconfig-x002-201909
i386                   randconfig-x009-201909
i386                   randconfig-x003-201909
i386                   randconfig-x001-201909
i386                   randconfig-x004-201909
i386                   randconfig-x005-201909
i386                   randconfig-x008-201909
x86_64                 randconfig-x009-201909
x86_64                 randconfig-x008-201909
x86_64                 randconfig-x005-201909
x86_64                 randconfig-x002-201909
x86_64                 randconfig-x001-201909
x86_64                 randconfig-x007-201909
x86_64                 randconfig-x006-201909
x86_64                 randconfig-x003-201909
x86_64                 randconfig-x004-201909
x86_64                 randconfig-x000-201909
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
