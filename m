From: kbuild test robot <lkp@intel.com>
Date: Thu, 02 May 2019 07:18:34 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 27b3ae8c760033d085ce5a45020983fdabd2a7c9
Message-ID: <5cca294a.miIPhLtFy7D3NP4E%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 27b3ae8c760033d085ce5a45020983fdabd2a7c9  i40e: Missing response checks in driver when starting/stopping FW LLDP

Regressions in current branch:

drivers/net/ethernet/aquantia/atlantic/aq_main.c:26:12: sparse: sparse: symbol 'aq_ndev_driver_name' was not declared. Should it be static?

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-aquantia-atlantic-aq_main.c:sparse:sparse:symbol-aq_ndev_driver_name-was-not-declared.-Should-it-be-static

elapsed time: 407m

configs tested: 168

arm                         at91_dt_defconfig
i386                   randconfig-x010-201917
i386                   randconfig-x018-201917
i386                   randconfig-x017-201917
i386                   randconfig-x013-201917
i386                   randconfig-x011-201917
i386                   randconfig-x014-201917
i386                   randconfig-x019-201917
i386                   randconfig-x015-201917
i386                   randconfig-x016-201917
i386                   randconfig-x012-201917
i386                     randconfig-n0-201917
i386                     randconfig-n1-201917
i386                     randconfig-n2-201917
i386                     randconfig-n3-201917
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
i386                     randconfig-i0-201917
i386                     randconfig-i1-201917
i386                     randconfig-i2-201917
i386                     randconfig-i3-201917
arm                              allmodconfig
arm64                            allmodconfig
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                   randconfig-k0-201917
x86_64                   randconfig-k1-201917
x86_64                   randconfig-k2-201917
x86_64                   randconfig-k3-201917
i386                     randconfig-k0-201917
i386                     randconfig-k1-201917
i386                     randconfig-k2-201917
i386                     randconfig-k3-201917
arm                               allnoconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
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
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                   randconfig-m2-201917
i386                     randconfig-m0-201917
i386                     randconfig-m3-201917
i386                     randconfig-m2-201917
x86_64                   randconfig-m1-201917
x86_64                   randconfig-m0-201917
x86_64                   randconfig-m3-201917
i386                     randconfig-m1-201917
riscv                             allnoconfig
riscv                               defconfig
x86_64                 randconfig-l2-05011027
i386                   randconfig-l2-05011027
i386                   randconfig-l1-05011027
i386                   randconfig-l0-05011027
x86_64                 randconfig-l3-05011027
x86_64                 randconfig-l1-05011027
i386                   randconfig-l3-05011027
x86_64                 randconfig-l0-05011027
riscv                              tinyconfig
i386                               tinyconfig
x86_64                 randconfig-i0-04281410
x86_64                 randconfig-i1-04281410
x86_64                 randconfig-i2-04281410
x86_64                 randconfig-i3-04281410
riscv                            allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                   randconfig-g0-201917
x86_64                   randconfig-g3-201917
x86_64                   randconfig-g2-201917
x86_64                   randconfig-g1-201917
x86_64                           allmodconfig
sparc64                           allnoconfig
i386                   randconfig-x077-201917
i386                   randconfig-x074-201917
i386                   randconfig-x070-201917
i386                   randconfig-x072-201917
i386                   randconfig-x075-201917
i386                   randconfig-x071-201917
i386                   randconfig-x079-201917
i386                   randconfig-x078-201917
i386                   randconfig-x073-201917
i386                   randconfig-x076-201917
x86_64                 randconfig-x004-201917
x86_64                 randconfig-x001-201917
x86_64                 randconfig-x000-201917
x86_64                 randconfig-x003-201917
x86_64                 randconfig-x007-201917
x86_64                 randconfig-x008-201917
x86_64                 randconfig-x002-201917
x86_64                 randconfig-x006-201917
x86_64                 randconfig-x009-201917
x86_64                 randconfig-x005-201917
x86_64                   randconfig-e0-201917
x86_64                   randconfig-e1-201917
x86_64                   randconfig-e2-201917
x86_64                   randconfig-e3-201917
i386                   randconfig-x002-201917
i386                   randconfig-x001-201917
i386                   randconfig-x005-201917
i386                   randconfig-x007-201917
i386                   randconfig-x000-201917
i386                   randconfig-x004-201917
i386                   randconfig-x008-201917
i386                   randconfig-x009-201917
i386                   randconfig-x006-201917
i386                   randconfig-x003-201917
x86_64                 randconfig-x015-201917
x86_64                 randconfig-x016-201917
x86_64                 randconfig-x017-201917
x86_64                 randconfig-x012-201917
x86_64                 randconfig-x013-201917
x86_64                 randconfig-x018-201917
x86_64                 randconfig-x010-201917
x86_64                 randconfig-x014-201917
x86_64                 randconfig-x019-201917
x86_64                 randconfig-x011-201917
i386                     randconfig-a1-201917
i386                     randconfig-a2-201917
i386                     randconfig-a0-201917
i386                     randconfig-a3-201917
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                             defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
