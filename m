From: kbuild test robot <lkp@intel.com>
Date: Tue, 25 Jun 2019 08:12:59 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 ea7a085c3fea4c5148137baec495e9fdb338956a
Message-ID: <5d11670b.5nSanfri0Z3GWlsV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ea7a085c3fea4c5148137baec495e9fdb338956a  iavf: fix dereference of null rx_buffer pointer

Regressions in current branch:

drivers/net/ethernet/intel/ice/ice_xsk.c:487:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-ice-ice_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? i386-randconfig-x073-201925
??? ??? drivers-net-ethernet-intel-ice-ice_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? mips-allyesconfig
??? ??? drivers-net-ethernet-intel-ice-ice_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-ice-ice_xsk.c:warning:cast-to-pointer-from-integer-of-different-size
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-ice-ice_xsk.c:warning:cast-to-pointer-from-integer-of-different-size

elapsed time: 285m

configs tested: 182

i386                   randconfig-x009-201925
i386                   randconfig-x008-201925
i386                   randconfig-x006-201925
i386                   randconfig-x001-201925
i386                   randconfig-x000-201925
i386                   randconfig-x003-201925
i386                   randconfig-x004-201925
i386                   randconfig-x005-201925
i386                   randconfig-x007-201925
i386                   randconfig-x002-201925
x86_64                 randconfig-x012-201925
x86_64                 randconfig-x014-201925
x86_64                 randconfig-x011-201925
x86_64                 randconfig-x013-201925
x86_64                 randconfig-x019-201925
x86_64                 randconfig-x015-201925
x86_64                 randconfig-x010-201925
x86_64                 randconfig-x017-201925
x86_64                 randconfig-x016-201925
x86_64                 randconfig-x018-201925
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
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
riscv                              tinyconfig
i386                               tinyconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                          debug_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
i386                             allmodconfig
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-n001-201925
x86_64                 randconfig-n002-201925
x86_64                 randconfig-n003-201925
x86_64                 randconfig-n004-201925
x86_64                 randconfig-n005-201925
x86_64                 randconfig-n006-201925
x86_64                 randconfig-n007-201925
x86_64                 randconfig-n008-201925
x86_64                 randconfig-n009-201925
x86_64                 randconfig-n010-201925
x86_64                 randconfig-n011-201925
x86_64                 randconfig-n012-201925
x86_64                 randconfig-n013-201925
x86_64                 randconfig-n014-201925
x86_64                 randconfig-n015-201925
x86_64                 randconfig-n016-201925
x86_64                 randconfig-n017-201925
x86_64                 randconfig-n018-201925
x86_64                 randconfig-n019-201925
x86_64                 randconfig-n020-201925
x86_64                 randconfig-n021-201925
x86_64                 randconfig-n022-201925
x86_64                 randconfig-n023-201925
x86_64                 randconfig-n024-201925
x86_64                 randconfig-n025-201925
x86_64                 randconfig-n026-201925
x86_64                 randconfig-n027-201925
x86_64                 randconfig-n028-201925
x86_64                 randconfig-n029-201925
x86_64                 randconfig-n030-201925
x86_64                 randconfig-n031-201925
x86_64                 randconfig-n032-201925
i386                   randconfig-n001-201925
i386                   randconfig-n002-201925
i386                   randconfig-n003-201925
i386                   randconfig-n004-201925
i386                   randconfig-n005-201925
i386                   randconfig-n006-201925
i386                   randconfig-n007-201925
i386                   randconfig-n008-201925
i386                   randconfig-n009-201925
i386                   randconfig-n010-201925
i386                   randconfig-n011-201925
i386                   randconfig-n012-201925
i386                   randconfig-n013-201925
i386                   randconfig-n014-201925
i386                   randconfig-n015-201925
i386                   randconfig-n016-201925
i386                   randconfig-n017-201925
i386                   randconfig-n018-201925
i386                   randconfig-n019-201925
i386                   randconfig-n020-201925
i386                   randconfig-n021-201925
i386                   randconfig-n022-201925
i386                   randconfig-n023-201925
i386                   randconfig-n024-201925
i386                   randconfig-n025-201925
i386                   randconfig-n026-201925
i386                   randconfig-n027-201925
i386                   randconfig-n028-201925
i386                   randconfig-n029-201925
i386                   randconfig-n030-201925
i386                   randconfig-n031-201925
i386                   randconfig-n032-201925
riscv                             allnoconfig
riscv                               defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                           allmodconfig
i386                             alldefconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
i386                   randconfig-x071-201925
i386                   randconfig-x070-201925
i386                   randconfig-x073-201925
i386                   randconfig-x078-201925
i386                   randconfig-x074-201925
i386                   randconfig-x072-201925
i386                   randconfig-x075-201925
i386                   randconfig-x077-201925
i386                   randconfig-x076-201925
i386                   randconfig-x079-201925
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
x86_64                 randconfig-x000-201925
x86_64                 randconfig-x001-201925
x86_64                 randconfig-x002-201925
x86_64                 randconfig-x003-201925
x86_64                 randconfig-x004-201925
x86_64                 randconfig-x005-201925
x86_64                 randconfig-x006-201925
x86_64                 randconfig-x007-201925
x86_64                 randconfig-x008-201925
x86_64                 randconfig-x009-201925
i386                              allnoconfig
i386                                defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
