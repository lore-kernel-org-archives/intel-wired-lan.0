From: kernel test robot <lkp@intel.com>
Date: Wed, 07 Jul 2021 13:51:14 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 4206b67e352b68da425f2dbb8008fe8ae2c720a9
Message-ID: <60e540d2.YRvqftKaebd75cZA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 4206b67e352b68da425f2dbb8008fe8ae2c720a9  ice: Fix perout start time rounding

elapsed time: 722m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                           h5000_defconfig
h8300                            alldefconfig
sh                           se7206_defconfig
m68k                       bvme6000_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
powerpc                          g5_defconfig
sh                             shx3_defconfig
sh                          polaris_defconfig
mips                      fuloong2e_defconfig
mips                          malta_defconfig
arm                            hisi_defconfig
arm                      integrator_defconfig
sh                             sh03_defconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
arm                        vexpress_defconfig
mips                            e55_defconfig
sh                            hp6xx_defconfig
sh                           se7722_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
arm                      pxa255-idp_defconfig
mips                        nlm_xlp_defconfig
arm                          moxart_defconfig
m68k                          amiga_defconfig
sh                ecovec24-romimage_defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
arm                        multi_v5_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_rdb_defconfig
ia64                          tiger_defconfig
arm                            dove_defconfig
x86_64                            allnoconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210706
i386                 randconfig-a006-20210706
i386                 randconfig-a001-20210706
i386                 randconfig-a003-20210706
i386                 randconfig-a005-20210706
i386                 randconfig-a002-20210706
x86_64               randconfig-a015-20210706
x86_64               randconfig-a014-20210706
x86_64               randconfig-a012-20210706
x86_64               randconfig-a011-20210706
x86_64               randconfig-a016-20210706
x86_64               randconfig-a013-20210706
i386                 randconfig-a015-20210706
i386                 randconfig-a016-20210706
i386                 randconfig-a012-20210706
i386                 randconfig-a011-20210706
i386                 randconfig-a014-20210706
i386                 randconfig-a013-20210706
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210706
x86_64               randconfig-a004-20210706
x86_64               randconfig-a002-20210706
x86_64               randconfig-a005-20210706
x86_64               randconfig-a006-20210706
x86_64               randconfig-a003-20210706
x86_64               randconfig-a001-20210706

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
