From: kernel test robot <lkp@intel.com>
Date: Mon, 07 Mar 2022 13:42:12 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 3d5985a185e6abfc0b38ed187819016a79eca864
Message-ID: <62259b34.8YrL8/OC8ITm+fi/%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 3d5985a185e6abfc0b38ed187819016a79eca864  ice: convert VF storage to hash table with krefs and RCU

Unverified Warning (likely false positive, please contact us if interested):

drivers/net/phy/sfp.c:1713 sfp_sm_mod_hpower() warn: passing zero to 'ERR_PTR'
drivers/net/phy/sfp.c:1797 sfp_cotsworks_fixup_check() warn: passing zero to 'ERR_PTR'
drivers/net/phy/sfp.c:1830 sfp_sm_mod_probe() warn: passing zero to 'ERR_PTR'
drivers/net/phy/sfp.c:473 sfp_soft_get_state() warn: passing zero to 'ERR_PTR'
net/dsa/dsa.c:486 dsa_port_walk_fdbs() error: uninitialized symbol 'err'.
net/dsa/dsa.c:506 dsa_port_walk_mdbs() error: uninitialized symbol 'err'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- m68k-randconfig-m031-20220304
    |-- drivers-net-phy-sfp.c-sfp_cotsworks_fixup_check()-warn:passing-zero-to-ERR_PTR
    |-- drivers-net-phy-sfp.c-sfp_sm_mod_hpower()-warn:passing-zero-to-ERR_PTR
    |-- drivers-net-phy-sfp.c-sfp_sm_mod_probe()-warn:passing-zero-to-ERR_PTR
    |-- drivers-net-phy-sfp.c-sfp_soft_get_state()-warn:passing-zero-to-ERR_PTR
    |-- net-dsa-dsa.c-dsa_port_walk_fdbs()-error:uninitialized-symbol-err-.
    `-- net-dsa-dsa.c-dsa_port_walk_mdbs()-error:uninitialized-symbol-err-.

elapsed time: 4820m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220303
sh                            migor_defconfig
arm                           sunxi_defconfig
sh                          rsk7269_defconfig
arm                           sama5_defconfig
mips                         mpc30x_defconfig
mips                      maltasmvp_defconfig
parisc64                         alldefconfig
powerpc                     tqm8548_defconfig
powerpc                     sequoia_defconfig
powerpc                 mpc837x_mds_defconfig
sh                         microdev_defconfig
parisc                generic-64bit_defconfig
arm                  randconfig-c002-20220303
arm                  randconfig-c002-20220304
arm                  randconfig-c002-20220302
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
i386                          randconfig-c001
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
powerpc                          g5_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a016
x86_64                        randconfig-a014
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220304
hexagon              randconfig-r041-20220304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
