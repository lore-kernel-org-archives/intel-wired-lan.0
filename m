From: kernel test robot <lkp@intel.com>
Date: Wed, 16 Feb 2022 15:07:23 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 477606a501d0705cb1bb86fe7aa86f553861ae7f
Message-ID: <620ca2ab.asSLe2BctrxOO3jh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 477606a501d0705cb1bb86fe7aa86f553861ae7f  ice: initialize local variable 'tlv'

possible Warning in current branch (please contact us if interested):

include/net/gro.h:58:1: sparse: sparse: directive in macro's argument list
net/ipv6/addrconf.c:4307 if6_get_next() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021
|   `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.
`-- nds32-randconfig-s031-20220214
    `-- include-net-gro.h:sparse:sparse:directive-in-macro-s-argument-list

elapsed time: 722m

configs tested: 138
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     taishan_defconfig
arm                         assabet_defconfig
arc                     nsimosci_hs_defconfig
arm                           corgi_defconfig
arc                      axs103_smp_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
parisc                           alldefconfig
arm                           h5000_defconfig
mips                        bcm47xx_defconfig
arm                        shmobile_defconfig
openrisc                 simple_smp_defconfig
sh                                  defconfig
m68k                             alldefconfig
arm                       aspeed_g5_defconfig
xtensa                  nommu_kc705_defconfig
arm                           viper_defconfig
arm                            mps2_defconfig
arm                      jornada720_defconfig
m68k                          atari_defconfig
arm64                            alldefconfig
sh                            shmin_defconfig
sh                        sh7757lcr_defconfig
openrisc                  or1klitex_defconfig
powerpc                        warp_defconfig
arm                        keystone_defconfig
powerpc                        cell_defconfig
i386                             alldefconfig
sh                        edosk7760_defconfig
sh                           se7724_defconfig
powerpc                  iss476-smp_defconfig
arm                  randconfig-c002-20220214
arm                  randconfig-c002-20220216
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a013-20220214
x86_64               randconfig-a012-20220214
x86_64               randconfig-a011-20220214
x86_64               randconfig-a014-20220214
x86_64               randconfig-a016-20220214
x86_64               randconfig-a015-20220214
i386                 randconfig-a013-20220214
i386                 randconfig-a016-20220214
i386                 randconfig-a012-20220214
i386                 randconfig-a015-20220214
i386                 randconfig-a011-20220214
i386                 randconfig-a014-20220214
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220214
arc                  randconfig-r043-20220214
s390                 randconfig-r044-20220214
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc                       ebony_defconfig
hexagon                             defconfig
arm                        neponset_defconfig
powerpc                      ppc44x_defconfig
powerpc                      obs600_defconfig
mips                         tb0287_defconfig
powerpc                      walnut_defconfig
i386                 randconfig-a004-20220214
i386                 randconfig-a005-20220214
i386                 randconfig-a006-20220214
i386                 randconfig-a002-20220214
i386                 randconfig-a003-20220214
i386                 randconfig-a001-20220214
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a002-20220214
x86_64               randconfig-a006-20220214
x86_64               randconfig-a005-20220214
x86_64               randconfig-a004-20220214
x86_64               randconfig-a003-20220214
x86_64               randconfig-a001-20220214
hexagon              randconfig-r045-20220214
hexagon              randconfig-r041-20220214
hexagon              randconfig-r045-20220216
hexagon              randconfig-r041-20220216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
