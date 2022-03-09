From: kernel test robot <lkp@intel.com>
Date: Wed, 09 Mar 2022 14:03:53 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 e5417cbf7ab5df1632e68fe7d9e6331fc0e7dbd6
Message-ID: <62284349.7LNa+J5zeM8RzcBl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: e5417cbf7ab5df1632e68fe7d9e6331fc0e7dbd6  net: dsa: mt7530: fix incorrect test in mt753x_phylink_validate()

elapsed time: 1002m

configs tested: 144
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
m68k                       m5208evb_defconfig
arm                       aspeed_g5_defconfig
m68k                        mvme147_defconfig
sh                          rsk7269_defconfig
mips                             allyesconfig
sh                   secureedge5410_defconfig
powerpc                       ppc64_defconfig
sh                              ul2_defconfig
powerpc                         ps3_defconfig
parisc                              defconfig
mips                     loongson1b_defconfig
m68k                        m5307c3_defconfig
powerpc64                           defconfig
xtensa                  cadence_csp_defconfig
powerpc                  storcenter_defconfig
arm                         vf610m4_defconfig
sh                        sh7757lcr_defconfig
sh                ecovec24-romimage_defconfig
alpha                               defconfig
mips                     decstation_defconfig
ia64                          tiger_defconfig
sparc                       sparc32_defconfig
sh                           se7722_defconfig
m68k                             alldefconfig
arm                         s3c6400_defconfig
arm                         cm_x300_defconfig
sh                   sh7724_generic_defconfig
h8300                    h8300h-sim_defconfig
m68k                        stmark2_defconfig
sh                          rsk7201_defconfig
arm                            zeus_defconfig
sh                          landisk_defconfig
powerpc                   currituck_defconfig
powerpc                      ppc40x_defconfig
xtensa                           alldefconfig
microblaze                          defconfig
s390                          debug_defconfig
ia64                                defconfig
arm                        shmobile_defconfig
arm                            hisi_defconfig
arm                          pxa3xx_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7721_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                       m5249evb_defconfig
riscv                               defconfig
um                           x86_64_defconfig
sh                           se7206_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220309
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                  randconfig-r043-20220308
riscv                randconfig-r042-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220308
powerpc              randconfig-c003-20220308
i386                          randconfig-c001
arm                  randconfig-c002-20220308
mips                 randconfig-c004-20220308
mips                        workpad_defconfig
mips                       lemote2f_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
arm                           spitz_defconfig
x86_64                           allyesconfig
powerpc                 mpc8272_ads_defconfig
arm                       spear13xx_defconfig
arm                         hackkit_defconfig
mips                        omega2p_defconfig
arm                         orion5x_defconfig
powerpc                      walnut_defconfig
arm                          pcm027_defconfig
arm                          imote2_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
