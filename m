From: kernel test robot <lkp@intel.com>
Date: Tue, 24 May 2022 16:23:13 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 f790755ebde8a181920552d5388d398091ae9875
Message-ID: <628c95f1.OtDdNUE+yXL2J4bt%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: f790755ebde8a181920552d5388d398091ae9875  ice: Fix switchdev rules book keeping

elapsed time: 749m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
powerpc                     tqm8541_defconfig
m68k                        mvme147_defconfig
sh                           se7343_defconfig
nios2                            alldefconfig
m68k                         amcore_defconfig
arm                           imxrt_defconfig
arm                        realview_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     pq2fads_defconfig
arm                          lpd270_defconfig
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
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20220523
i386                 randconfig-a006-20220523
i386                 randconfig-a002-20220523
i386                 randconfig-a005-20220523
i386                 randconfig-a003-20220523
i386                 randconfig-a004-20220523
x86_64               randconfig-a003-20220523
x86_64               randconfig-a006-20220523
x86_64               randconfig-a001-20220523
x86_64               randconfig-a004-20220523
x86_64               randconfig-a002-20220523
x86_64               randconfig-a005-20220523
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220523
arc                  randconfig-r043-20220522
s390                 randconfig-r044-20220522
riscv                randconfig-r042-20220522
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
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220522
x86_64                        randconfig-c007
s390                 randconfig-c005-20220522
i386                          randconfig-c001
powerpc              randconfig-c003-20220522
riscv                randconfig-c006-20220522
mips                 randconfig-c004-20220522
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     akebono_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a014-20220523
i386                 randconfig-a011-20220523
i386                 randconfig-a013-20220523
i386                 randconfig-a016-20220523
i386                 randconfig-a012-20220523
i386                 randconfig-a015-20220523
hexagon              randconfig-r045-20220523
hexagon              randconfig-r045-20220522
hexagon              randconfig-r041-20220523
hexagon              randconfig-r041-20220522
riscv                randconfig-r042-20220523

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
