From: kernel test robot <lkp@intel.com>
Date: Fri, 27 May 2022 14:25:40 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 2d36988b40dc48f65b9ab676e123958861a6d452
Message-ID: <62906ee4.n9KMoH6a5vpkv+Jl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 2d36988b40dc48f65b9ab676e123958861a6d452  drivers/net/ethernet/intel: fix typos in comments

elapsed time: 724m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                            mps2_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
parisc64                            defconfig
arm                         vf610m4_defconfig
sh                            titan_defconfig
sh                           sh2007_defconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
powerpc                      ep88xc_defconfig
arc                           tb10x_defconfig
powerpc                         ps3_defconfig
sh                          sdk7786_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5249evb_defconfig
powerpc                 linkstation_defconfig
arm                     eseries_pxa_defconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
mips                 decstation_r4k_defconfig
arm                        trizeps4_defconfig
s390                       zfcpdump_defconfig
sh                            hp6xx_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
powerpc                     ep8248e_defconfig
arm                  randconfig-c002-20220524
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220524
arc                  randconfig-r043-20220526
riscv                randconfig-r042-20220526
s390                 randconfig-r044-20220526
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
arm                     am200epdkit_defconfig
mips                           ip28_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                     loongson1c_defconfig
powerpc                      pmac32_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r045-20220524
hexagon              randconfig-r045-20220526
hexagon              randconfig-r041-20220526
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
