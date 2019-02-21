From: kbuild test robot <lkp@intel.com>
Date: Thu, 21 Feb 2019 08:51:28 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 ed9b5e227f42c4c484ccf79c3e20a56f97bae463
Message-ID: <5c6df610.twu0dunlY1TZmmbp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: ed9b5e227f42c4c484ccf79c3e20a56f97bae463  ixgbe: don't do any AF_XDP zero-copy transmit if netif is not OK

elapsed time: 468m

configs tested: 137

The following configs have been built successfully.
More configs may be tested in the coming days.

x86_64                                    lkp
x86_64                                   rhel
riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-x019-201907
i386                   randconfig-x015-201907
i386                   randconfig-x016-201907
i386                   randconfig-x014-201907
i386                   randconfig-x012-201907
i386                   randconfig-x013-201907
i386                   randconfig-x010-201907
i386                   randconfig-x018-201907
i386                   randconfig-x017-201907
i386                   randconfig-x011-201907
x86_64                                  kexec
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.2
x86_64                              fedora-25
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-x005-201907
x86_64                 randconfig-x008-201907
x86_64                 randconfig-x009-201907
x86_64                 randconfig-x001-201907
x86_64                 randconfig-x002-201907
x86_64                 randconfig-x003-201907
x86_64                 randconfig-x006-201907
x86_64                 randconfig-x007-201907
x86_64                 randconfig-x000-201907
x86_64                 randconfig-x004-201907
i386                             allmodconfig
i386                   randconfig-x007-201907
i386                   randconfig-x000-201907
i386                   randconfig-x006-201907
i386                   randconfig-x002-201907
i386                   randconfig-x001-201907
i386                   randconfig-x003-201907
i386                   randconfig-x009-201907
i386                   randconfig-x008-201907
i386                   randconfig-x005-201907
i386                   randconfig-x004-201907
x86_64                 randconfig-x013-201907
x86_64                 randconfig-x017-201907
x86_64                 randconfig-x016-201907
x86_64                 randconfig-x019-201907
x86_64                 randconfig-x012-201907
x86_64                 randconfig-x011-201907
x86_64                 randconfig-x018-201907
x86_64                 randconfig-x010-201907
x86_64                 randconfig-x015-201907
x86_64                 randconfig-x014-201907
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                   randconfig-a1-02210309
i386                   randconfig-a3-02210309
i386                   randconfig-a2-02210309
i386                   randconfig-a0-02210309
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
i386                     randconfig-s0-201907
i386                     randconfig-s1-201907
i386                     randconfig-s2-201907
i386                     randconfig-s3-201907
x86_64                           allmodconfig
arm                              allmodconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
nds32                             allnoconfig
nds32                               defconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                             allmodconfig
mips                      malta_kvm_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
riscv                             allnoconfig
riscv                               defconfig
i386                   randconfig-l2-02210034
x86_64                 randconfig-l0-02210034
x86_64                 randconfig-l3-02210034
x86_64                 randconfig-l1-02210034
x86_64                 randconfig-l2-02210034
i386                   randconfig-l1-02210034
i386                   randconfig-l3-02210034
i386                   randconfig-l0-02210034
parisc                        c3000_defconfig
um                                  defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                   randconfig-x072-201907
i386                   randconfig-x079-201907
i386                   randconfig-x075-201907
i386                   randconfig-x073-201907
i386                   randconfig-x077-201907
i386                   randconfig-x078-201907
i386                   randconfig-x074-201907
i386                   randconfig-x076-201907
i386                   randconfig-x070-201907
i386                   randconfig-x071-201907

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
