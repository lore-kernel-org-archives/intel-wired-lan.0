From: kernel test robot <lkp@intel.com>
Date: Sat, 18 Dec 2021 02:18:22 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 5afbfddd09957fdebd54df96be359c03c95f1f4f
Message-ID: <61bcd46e.F7vymfpGaXbmUEU2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 5afbfddd09957fdebd54df96be359c03c95f1f4f  igc: Do not enable crosstimestamping for i225-V models

elapsed time: 1469m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211216
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
mips                        vocore2_defconfig
sh                   rts7751r2dplus_defconfig
sparc                               defconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                              alldefconfig
nds32                             allnoconfig
mips                     loongson1b_defconfig
m68k                          atari_defconfig
h8300                    h8300h-sim_defconfig
sh                        dreamcast_defconfig
arm                           sunxi_defconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
sh                               j2_defconfig
powerpc                     tqm8560_defconfig
m68k                            q40_defconfig
sh                         microdev_defconfig
arm                         lubbock_defconfig
s390                       zfcpdump_defconfig
arm                       imx_v4_v5_defconfig
arm                        mvebu_v5_defconfig
sparc64                             defconfig
mips                           ip32_defconfig
mips                            e55_defconfig
arm                        magician_defconfig
arm                       omap2plus_defconfig
powerpc                    adder875_defconfig
parisc                generic-32bit_defconfig
arm                  randconfig-c002-20211216
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a004-20211216
arc                  randconfig-r043-20211216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20211217
x86_64               randconfig-a005-20211217
x86_64               randconfig-a001-20211217
x86_64               randconfig-a002-20211217
x86_64               randconfig-a003-20211217
x86_64               randconfig-a004-20211217
x86_64               randconfig-a011-20211216
x86_64               randconfig-a014-20211216
x86_64               randconfig-a012-20211216
x86_64               randconfig-a013-20211216
x86_64               randconfig-a016-20211216
x86_64               randconfig-a015-20211216
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
riscv                randconfig-r042-20211216
hexagon              randconfig-r041-20211216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
