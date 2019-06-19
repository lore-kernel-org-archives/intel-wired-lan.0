From: kbuild test robot <lkp@intel.com>
Date: Wed, 19 Jun 2019 10:33:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 42879b20c35fbc77963d6816e7bce7f1e0c3f4b9
Message-ID: <5d099f00.UlMh+Kb7dOjGqxd4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 42879b20c35fbc77963d6816e7bce7f1e0c3f4b9  e1000e: Make watchdog use delayed work

Regressions in current branch:

drivers/net/ethernet/intel/iavf/iavf_main.c:151:6: sparse: sparse: symbol 'iavf_debug_d' was not declared. Should it be static?

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-iavf-iavf_main.c:sparse:sparse:symbol-iavf_debug_d-was-not-declared.-Should-it-be-static
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-iavf-iavf_main.c:sparse:sparse:symbol-iavf_debug_d-was-not-declared.-Should-it-be-static

elapsed time: 362m

configs tested: 178

openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                              allmodconfig
arm64                            allmodconfig
i386                   randconfig-n004-201924
x86_64                 randconfig-n023-201924
i386                   randconfig-n005-201924
x86_64                 randconfig-n022-201924
i386                   randconfig-n025-201924
x86_64                 randconfig-n006-201924
x86_64                 randconfig-n014-201924
x86_64                 randconfig-n012-201924
x86_64                 randconfig-n032-201924
x86_64                 randconfig-n013-201924
i386                   randconfig-n008-201924
x86_64                 randconfig-n016-201924
i386                   randconfig-n028-201924
i386                   randconfig-n011-201924
i386                   randconfig-n023-201924
i386                   randconfig-n031-201924
x86_64                 randconfig-n030-201924
i386                   randconfig-n029-201924
i386                   randconfig-n010-201924
i386                   randconfig-n024-201924
x86_64                 randconfig-n007-201924
i386                   randconfig-n030-201924
x86_64                 randconfig-n031-201924
i386                   randconfig-n013-201924
x86_64                 randconfig-n009-201924
x86_64                 randconfig-n028-201924
x86_64                 randconfig-n011-201924
i386                   randconfig-n021-201924
i386                   randconfig-n018-201924
x86_64                 randconfig-n002-201924
i386                   randconfig-n014-201924
i386                   randconfig-n002-201924
x86_64                 randconfig-n025-201924
i386                   randconfig-n009-201924
x86_64                 randconfig-n017-201924
i386                   randconfig-n003-201924
x86_64                 randconfig-n024-201924
x86_64                 randconfig-n029-201924
x86_64                 randconfig-n010-201924
x86_64                 randconfig-n027-201924
i386                   randconfig-n012-201924
x86_64                 randconfig-n008-201924
x86_64                 randconfig-n015-201924
i386                   randconfig-n015-201924
i386                   randconfig-n007-201924
x86_64                 randconfig-n020-201924
x86_64                 randconfig-n019-201924
i386                   randconfig-n017-201924
i386                   randconfig-n016-201924
i386                   randconfig-n020-201924
i386                   randconfig-n019-201924
x86_64                 randconfig-n003-201924
i386                   randconfig-n001-201924
x86_64                 randconfig-n026-201924
i386                   randconfig-n026-201924
x86_64                 randconfig-n005-201924
i386                   randconfig-n006-201924
x86_64                 randconfig-n021-201924
x86_64                 randconfig-n018-201924
i386                   randconfig-n027-201924
x86_64                 randconfig-n004-201924
i386                   randconfig-n022-201924
x86_64                 randconfig-n001-201924
i386                   randconfig-n032-201924
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
s390                          debug_defconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.6
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                  kexec
x86_64                              fedora-25
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
riscv                             allnoconfig
riscv                               defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
riscv                              tinyconfig
i386                               tinyconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
sparc                            allyesconfig
x86_64                 randconfig-x019-201924
x86_64                 randconfig-x012-201924
x86_64                 randconfig-x014-201924
x86_64                 randconfig-x015-201924
x86_64                 randconfig-x010-201924
x86_64                 randconfig-x017-201924
x86_64                 randconfig-x011-201924
x86_64                 randconfig-x016-201924
x86_64                 randconfig-x018-201924
x86_64                 randconfig-x013-201924
i386                   randconfig-x070-201924
i386                   randconfig-x071-201924
i386                   randconfig-x072-201924
i386                   randconfig-x073-201924
i386                   randconfig-x074-201924
i386                   randconfig-x075-201924
i386                   randconfig-x076-201924
i386                   randconfig-x077-201924
i386                   randconfig-x078-201924
i386                   randconfig-x079-201924
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
i386                   randconfig-x013-201924
i386                   randconfig-x018-201924
i386                   randconfig-x012-201924
i386                   randconfig-x011-201924
i386                   randconfig-x016-201924
i386                   randconfig-x010-201924
i386                   randconfig-x017-201924
i386                   randconfig-x015-201924
i386                   randconfig-x014-201924
i386                   randconfig-x019-201924
i386                   randconfig-x009-201924
i386                   randconfig-x004-201924
i386                   randconfig-x005-201924
i386                   randconfig-x008-201924
i386                   randconfig-x006-201924
i386                   randconfig-x001-201924
i386                   randconfig-x007-201924
i386                   randconfig-x000-201924
i386                   randconfig-x002-201924
i386                   randconfig-x003-201924

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
