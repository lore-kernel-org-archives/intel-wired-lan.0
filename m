From: kernel test robot <lkp@intel.com>
Date: Fri, 22 Apr 2022 17:47:43 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 9c8774e629a1950c24b44e3c8fb93d76fb644b49
Message-ID: <626279bf.ZQgQCRbUWWAfIiuX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 9c8774e629a1950c24b44e3c8fb93d76fb644b49  net: eql: Use kzalloc instead of kmalloc/memset

elapsed time: 1229m

configs tested: 110
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
powerpc                     asp8347_defconfig
sh                           se7712_defconfig
arc                                 defconfig
sh                        edosk7760_defconfig
arm                             rpc_defconfig
powerpc                 linkstation_defconfig
arm                          pxa3xx_defconfig
powerpc                     tqm8555_defconfig
arm                          pxa910_defconfig
mips                        bcm47xx_defconfig
sh                          polaris_defconfig
arm                        spear6xx_defconfig
mips                            ar7_defconfig
powerpc                     pq2fads_defconfig
arm                           stm32_defconfig
xtensa                    smp_lx200_defconfig
mips                           xway_defconfig
xtensa                          iss_defconfig
openrisc                 simple_smp_defconfig
sh                          sdk7780_defconfig
sh                         ecovec24_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
powerpc                      arches_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220421
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
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220421
s390                 randconfig-r044-20220421
riscv                randconfig-r042-20220421
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220421
mips                 randconfig-c004-20220421
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220421
powerpc              randconfig-c003-20220421
powerpc                      ppc64e_defconfig
mips                           rs90_defconfig
arm                        mvebu_v5_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                        fsp2_defconfig
powerpc                     tqm8560_defconfig
hexagon                          alldefconfig
arm                     davinci_all_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
