From: kernel test robot <lkp@intel.com>
Date: Thu, 21 Apr 2022 12:48:50 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 a103297845aeb71949e72a9dba1f8cf06ed046ef
Message-ID: <6260e232.1mErx3P/OxINvuRn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: a103297845aeb71949e72a9dba1f8cf06ed046ef  ice: Protect vf_state check by cfg_lock in ice_vc_process_vf_msg()

elapsed time: 2105m

configs tested: 126
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      pcm030_defconfig
mips                     loongson1b_defconfig
arm                          lpd270_defconfig
arm                         lpc18xx_defconfig
powerpc                 canyonlands_defconfig
mips                       bmips_be_defconfig
arm                      jornada720_defconfig
powerpc                     tqm8541_defconfig
powerpc                        cell_defconfig
xtensa                         virt_defconfig
powerpc                      chrp32_defconfig
ia64                      gensparse_defconfig
sh                        apsh4ad0a_defconfig
mips                         cobalt_defconfig
arm                            qcom_defconfig
um                           x86_64_defconfig
mips                    maltaup_xpa_defconfig
powerpc                  iss476-smp_defconfig
m68k                                defconfig
s390                          debug_defconfig
arm                            xcep_defconfig
xtensa                           allyesconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc834x_itx_defconfig
xtensa                    xip_kc705_defconfig
m68k                       bvme6000_defconfig
powerpc                     stx_gp3_defconfig
sh                   secureedge5410_defconfig
powerpc                       ppc64_defconfig
arm64                            alldefconfig
sh                          polaris_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                              defconfig

clang tested configs:
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
arm                       spear13xx_defconfig
mips                         tb0219_defconfig
powerpc                     skiroot_defconfig
powerpc                      ppc44x_defconfig
arm                          ep93xx_defconfig
powerpc                    gamecube_defconfig
arm                        neponset_defconfig
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
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
