From: kernel test robot <lkp@intel.com>
Date: Fri, 08 Apr 2022 13:03:57 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 e33163a40d1a1f7fead2ce26f9b75da6b581a49e
Message-ID: <624fc23d.Wg62dFmI+UyccRw3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: e33163a40d1a1f7fead2ce26f9b75da6b581a49e  ice: switch: convert packet template match code to rodata

elapsed time: 732m

configs tested: 169
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                           h5000_defconfig
sh                         apsh4a3a_defconfig
arm                        shmobile_defconfig
sh                          rsk7201_defconfig
powerpc                     asp8347_defconfig
arm                      integrator_defconfig
powerpc                     taishan_defconfig
sh                          polaris_defconfig
powerpc                      bamboo_defconfig
sh                           se7722_defconfig
arm                          iop32x_defconfig
arc                            hsdk_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7780_defconfig
sparc64                          alldefconfig
mips                     decstation_defconfig
arm                            hisi_defconfig
arm                         lubbock_defconfig
sh                              ul2_defconfig
arm                        cerfcube_defconfig
ia64                      gensparse_defconfig
arm                          gemini_defconfig
sh                     sh7710voipgw_defconfig
openrisc                    or1ksim_defconfig
arm                       imx_v6_v7_defconfig
m68k                        mvme16x_defconfig
sh                        sh7757lcr_defconfig
ia64                          tiger_defconfig
sparc64                             defconfig
arm                             ezx_defconfig
powerpc                 mpc834x_itx_defconfig
arm                        clps711x_defconfig
sh                   sh7770_generic_defconfig
ia64                            zx1_defconfig
powerpc                      mgcoge_defconfig
powerpc                      tqm8xx_defconfig
arm                             pxa_defconfig
sparc                               defconfig
powerpc                      pcm030_defconfig
powerpc64                           defconfig
powerpc                       ppc64_defconfig
ia64                        generic_defconfig
arm                       multi_v4t_defconfig
arc                        vdk_hs38_defconfig
sh                ecovec24-romimage_defconfig
riscv                               defconfig
powerpc                     stx_gp3_defconfig
ia64                         bigsur_defconfig
mips                            ar7_defconfig
xtensa                          iss_defconfig
arm                        multi_v7_defconfig
m68k                          multi_defconfig
xtensa                           alldefconfig
sh                          sdk7780_defconfig
i386                             alldefconfig
mips                        vocore2_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220408
arm                  randconfig-c002-20220406
arm                  randconfig-c002-20220407
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220406
arc                  randconfig-r043-20220407
arc                  randconfig-r043-20220408
s390                 randconfig-r044-20220408
s390                 randconfig-r044-20220406
riscv                randconfig-r042-20220406
riscv                randconfig-r042-20220408
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
i386                          randconfig-c001
powerpc              randconfig-c003-20220408
riscv                randconfig-c006-20220408
mips                 randconfig-c004-20220408
arm                  randconfig-c002-20220408
s390                 randconfig-c005-20220406
s390                 randconfig-c005-20220407
powerpc              randconfig-c003-20220407
powerpc              randconfig-c003-20220406
riscv                randconfig-c006-20220407
riscv                randconfig-c006-20220406
mips                 randconfig-c004-20220407
mips                 randconfig-c004-20220406
arm                  randconfig-c002-20220406
arm                  randconfig-c002-20220407
powerpc                      pasemi_defconfig
arm                            mps2_defconfig
arm                       aspeed_g4_defconfig
arm                     davinci_all_defconfig
powerpc                   bluestone_defconfig
mips                        qi_lb60_defconfig
mips                           ip28_defconfig
powerpc                     skiroot_defconfig
arm                        magician_defconfig
powerpc                       ebony_defconfig
powerpc                   microwatt_defconfig
powerpc                    socrates_defconfig
arm                          pcm027_defconfig
riscv                             allnoconfig
arm                          collie_defconfig
arm                       mainstone_defconfig
riscv                            alldefconfig
powerpc                     powernv_defconfig
mips                           rs90_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
