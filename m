From: kernel test robot <lkp@intel.com>
Date: Mon, 07 Mar 2022 13:40:45 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 e1bec7fa1cee311a6d3fb9161037c7675904134d
Message-ID: <62259add.PClBPOuvtbb4wwx4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: e1bec7fa1cee311a6d3fb9161037c7675904134d  net: dsa: make dsa_tree_change_tag_proto actually unwind the tag proto change

elapsed time: 4820m

configs tested: 141
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
arm                         axm55xx_defconfig
arm                        mvebu_v7_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
powerpc                  iss476-smp_defconfig
sh                             sh03_defconfig
m68k                       m5275evb_defconfig
sh                           se7751_defconfig
riscv                            allmodconfig
sh                 kfr2r09-romimage_defconfig
sh                               alldefconfig
sh                          sdk7780_defconfig
sh                            titan_defconfig
sh                          lboxre2_defconfig
sh                          kfr2r09_defconfig
sh                          r7780mp_defconfig
arm                           sama5_defconfig
arm                         lubbock_defconfig
sparc                       sparc64_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
powerpc                     ep8248e_defconfig
arm                         vf610m4_defconfig
m68k                          multi_defconfig
sh                          rsk7269_defconfig
mips                         mpc30x_defconfig
mips                      maltasmvp_defconfig
nds32                            alldefconfig
arm                            qcom_defconfig
um                             i386_defconfig
sh                        sh7757lcr_defconfig
sh                ecovec24-romimage_defconfig
sh                   secureedge5410_defconfig
arm                           u8500_defconfig
m68k                          sun3x_defconfig
powerpc                        cell_defconfig
arm                       omap2plus_defconfig
s390                          debug_defconfig
arm                           h5000_defconfig
arm                            mps2_defconfig
arm                        clps711x_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
sh                         microdev_defconfig
parisc                generic-64bit_defconfig
h8300                     edosk2674_defconfig
arc                        vdk_hs38_defconfig
arm                            hisi_defconfig
arm                  randconfig-c002-20220302
arm                  randconfig-c002-20220303
arm                  randconfig-c002-20220304
ia64                             allmodconfig
ia64                                defconfig
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
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220303
riscv                randconfig-c006-20220303
i386                          randconfig-c001
arm                  randconfig-c002-20220303
mips                 randconfig-c004-20220303
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
arm                  colibri_pxa270_defconfig
i386                             allyesconfig
powerpc                      ppc64e_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220304
hexagon              randconfig-r041-20220304
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
