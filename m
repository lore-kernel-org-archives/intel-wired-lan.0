From: kernel test robot <lkp@intel.com>
Date: Tue, 28 Sep 2021 14:24:18 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:1GbE] BUILD SUCCESS
 51032e6f17ce990d06123ad7307f258c50d25aa7
Message-ID: <6152b512.yTSJHQTltC9ltMJZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 1GbE
branch HEAD: 51032e6f17ce990d06123ad7307f258c50d25aa7  e100: fix buffer overrun in e100_get_regs

elapsed time: 726m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20210927
arm                         socfpga_defconfig
sh                               alldefconfig
sh                        dreamcast_defconfig
sh                              ul2_defconfig
powerpc                     ppa8548_defconfig
m68k                       bvme6000_defconfig
arm                       aspeed_g4_defconfig
powerpc                     tqm5200_defconfig
arm                             rpc_defconfig
sh                           se7343_defconfig
arm                         hackkit_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
powerpc                     powernv_defconfig
powerpc                    socrates_defconfig
riscv                    nommu_k210_defconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
sh                        edosk7760_defconfig
arc                        nsim_700_defconfig
riscv                             allnoconfig
powerpc                   motionpro_defconfig
powerpc                      makalu_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    klondike_defconfig
mips                           xway_defconfig
arm                         vf610m4_defconfig
xtensa                          iss_defconfig
arm                         palmz72_defconfig
powerpc                      ppc40x_defconfig
arm                          collie_defconfig
powerpc                      mgcoge_defconfig
arm                           u8500_defconfig
mips                         tb0226_defconfig
arm                          lpd270_defconfig
mips                        bcm63xx_defconfig
arm                      pxa255-idp_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
sh                         ecovec24_defconfig
sh                     magicpanelr2_defconfig
sh                          rsk7264_defconfig
m68k                            q40_defconfig
arc                         haps_hs_defconfig
powerpc                     pseries_defconfig
openrisc                 simple_smp_defconfig
mips                  maltasmvp_eva_defconfig
sh                ecovec24-romimage_defconfig
mips                      maltaaprp_defconfig
powerpc                 xes_mpc85xx_defconfig
arc                     haps_hs_smp_defconfig
alpha                            allyesconfig
arm                          gemini_defconfig
sh                           sh2007_defconfig
mips                           ip22_defconfig
x86_64               randconfig-c001-20210927
arm                  randconfig-c002-20210927
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210927
x86_64               randconfig-a006-20210927
x86_64               randconfig-a001-20210927
x86_64               randconfig-a005-20210927
x86_64               randconfig-a004-20210927
x86_64               randconfig-a003-20210927
i386                 randconfig-a001-20210927
i386                 randconfig-a005-20210927
i386                 randconfig-a006-20210927
i386                 randconfig-a002-20210927
i386                 randconfig-a003-20210927
i386                 randconfig-a004-20210927
arc                  randconfig-r043-20210927
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a014-20210927
x86_64               randconfig-a011-20210927
x86_64               randconfig-a013-20210927
x86_64               randconfig-a016-20210927
x86_64               randconfig-a015-20210927
x86_64               randconfig-a012-20210927
i386                 randconfig-a014-20210927
i386                 randconfig-a013-20210927
i386                 randconfig-a012-20210927
i386                 randconfig-a015-20210927
i386                 randconfig-a011-20210927
i386                 randconfig-a016-20210927
hexagon              randconfig-r045-20210927
riscv                randconfig-r042-20210927
hexagon              randconfig-r041-20210927
s390                 randconfig-r044-20210927

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
