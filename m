From: kernel test robot <lkp@intel.com>
Date: Fri, 18 Jun 2021 12:17:05 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 9a6a47869718676e12c2c32e559b29bc3d0efcf0
Message-ID: <60cc1e41.Q0iEvyIQ6qD7vOMs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 9a6a47869718676e12c2c32e559b29bc3d0efcf0  iavf: Fix an error handling path in 'iavf_probe()'

elapsed time: 726m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7705_defconfig
arm                         s3c6400_defconfig
powerpc                      arches_defconfig
arm                          ep93xx_defconfig
um                            kunit_defconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
mips                      bmips_stb_defconfig
arm                        mini2440_defconfig
mips                        bcm63xx_defconfig
arm64                            alldefconfig
arm                        keystone_defconfig
riscv                          rv32_defconfig
arm                        trizeps4_defconfig
m68k                            q40_defconfig
arm                       aspeed_g5_defconfig
m68k                       m5249evb_defconfig
riscv                    nommu_virt_defconfig
arm                          lpd270_defconfig
sh                      rts7751r2d1_defconfig
arm                       omap2plus_defconfig
s390                          debug_defconfig
mips                         mpc30x_defconfig
powerpc                      walnut_defconfig
arm                           h3600_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          pxa910_defconfig
mips                      maltasmvp_defconfig
arm                         hackkit_defconfig
sh                           se7206_defconfig
mips                           rs90_defconfig
powerpc                     tqm8555_defconfig
powerpc                     taishan_defconfig
arm                          moxart_defconfig
powerpc                     redwood_defconfig
powerpc                       ppc64_defconfig
h8300                    h8300h-sim_defconfig
mips                     loongson1b_defconfig
sh                             sh03_defconfig
powerpc                     pseries_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                          lboxre2_defconfig
mips                        workpad_defconfig
mips                           gcw0_defconfig
arm                         lubbock_defconfig
arc                              alldefconfig
xtensa                       common_defconfig
arm                         at91_dt_defconfig
arm                      tct_hammer_defconfig
arm                      pxa255-idp_defconfig
arm                        multi_v5_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
