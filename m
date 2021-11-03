From: kernel test robot <lkp@intel.com>
Date: Wed, 03 Nov 2021 17:59:17 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 11d5a44cb7419a256a18b69c1b64c39e00987d3c
Message-ID: <61825d75.cazgj+fNI7N9p8Gf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 11d5a44cb7419a256a18b69c1b64c39e00987d3c  igc: Fix typo in i225 LTR functions

elapsed time: 722m

configs tested: 128
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211103
arm                         lpc18xx_defconfig
sh                         ecovec24_defconfig
mips                       lemote2f_defconfig
sh                          lboxre2_defconfig
m68k                          hp300_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     kmeter1_defconfig
mips                         rt305x_defconfig
powerpc                     pq2fads_defconfig
sh                          rsk7264_defconfig
m68k                       m5249evb_defconfig
mips                         tb0219_defconfig
h8300                               defconfig
sh                           se7619_defconfig
arm                            mps2_defconfig
arm                            zeus_defconfig
arm                         cm_x300_defconfig
arm                            hisi_defconfig
arm                          collie_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
sh                     magicpanelr2_defconfig
powerpc                    sam440ep_defconfig
arm                     eseries_pxa_defconfig
arm                       imx_v6_v7_defconfig
riscv                    nommu_virt_defconfig
h8300                    h8300h-sim_defconfig
arc                     haps_hs_smp_defconfig
arm                         s3c6400_defconfig
openrisc                 simple_smp_defconfig
mips                      maltaaprp_defconfig
sh                           se7206_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
powerpc                 mpc837x_mds_defconfig
ia64                            zx1_defconfig
arm                            xcep_defconfig
x86_64                              defconfig
m68k                            mac_defconfig
arm                  randconfig-c002-20211103
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a012-20211103
x86_64               randconfig-a015-20211103
x86_64               randconfig-a016-20211103
x86_64               randconfig-a011-20211103
x86_64               randconfig-a013-20211103
x86_64               randconfig-a014-20211103
i386                 randconfig-a014-20211103
i386                 randconfig-a016-20211103
i386                 randconfig-a013-20211103
i386                 randconfig-a015-20211103
i386                 randconfig-a011-20211103
i386                 randconfig-a012-20211103
arc                  randconfig-r043-20211103
riscv                randconfig-r042-20211103
s390                 randconfig-r044-20211103
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
mips                 randconfig-c004-20211103
arm                  randconfig-c002-20211103
i386                 randconfig-c001-20211103
s390                 randconfig-c005-20211103
powerpc              randconfig-c003-20211103
riscv                randconfig-c006-20211103
x86_64               randconfig-c007-20211103
x86_64               randconfig-a006-20211103
x86_64               randconfig-a004-20211103
x86_64               randconfig-a001-20211103
x86_64               randconfig-a002-20211103
x86_64               randconfig-a005-20211103
x86_64               randconfig-a003-20211103
i386                 randconfig-a005-20211103
i386                 randconfig-a003-20211103
i386                 randconfig-a001-20211103
i386                 randconfig-a004-20211103
i386                 randconfig-a006-20211103
i386                 randconfig-a002-20211103
hexagon              randconfig-r041-20211103
hexagon              randconfig-r045-20211103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
