From: kernel test robot <lkp@intel.com>
Date: Sat, 09 Apr 2022 14:09:19 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 7d59706dbef8de83b3662026766507bc494223d7
Message-ID: <6251230f.qTZmvONgU7K7XsuE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: 7d59706dbef8de83b3662026766507bc494223d7  Revert "iavf: Fix deadlock occurrence during resetting VF interface"

elapsed time: 722m

configs tested: 135
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
mips                  maltasmvp_eva_defconfig
mips                 decstation_r4k_defconfig
arm                       aspeed_g5_defconfig
mips                      loongson3_defconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
powerpc                    sam440ep_defconfig
xtensa                              defconfig
m68k                        m5407c3_defconfig
h8300                            alldefconfig
sh                        edosk7760_defconfig
sh                           se7722_defconfig
arc                          axs103_defconfig
m68k                          atari_defconfig
ia64                             alldefconfig
arc                            hsdk_defconfig
arm                           stm32_defconfig
powerpc                       maple_defconfig
openrisc                            defconfig
sh                           se7206_defconfig
arm64                            alldefconfig
nios2                         10m50_defconfig
sh                            migor_defconfig
mips                    maltaup_xpa_defconfig
powerpc                      chrp32_defconfig
arm                            xcep_defconfig
arm                          badge4_defconfig
sh                        sh7785lcr_defconfig
s390                       zfcpdump_defconfig
arm                          exynos_defconfig
powerpc64                           defconfig
ia64                          tiger_defconfig
powerpc                 mpc8540_ads_defconfig
arm                          gemini_defconfig
ia64                             allmodconfig
xtensa                generic_kc705_defconfig
arc                     haps_hs_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                  nommu_kc705_defconfig
h8300                       h8s-sim_defconfig
parisc                generic-32bit_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220408
ia64                             allyesconfig
ia64                                defconfig
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
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220408
s390                 randconfig-r044-20220408
riscv                randconfig-r042-20220408
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
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220408
powerpc              randconfig-c003-20220408
riscv                randconfig-c006-20220408
mips                 randconfig-c004-20220408
arm                  randconfig-c002-20220408
mips                      pic32mzda_defconfig
powerpc                     pseries_defconfig
powerpc                   bluestone_defconfig
powerpc                      obs600_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        qi_lb60_defconfig
mips                     cu1000-neo_defconfig
riscv                             allnoconfig
mips                   sb1250_swarm_defconfig
mips                     loongson1c_defconfig
powerpc                       ebony_defconfig
powerpc                     mpc5200_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220408
hexagon              randconfig-r041-20220408

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
