From: kernel test robot <lkp@intel.com>
Date: Sun, 12 Sep 2021 17:23:50 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 91148bfbf6bbfd334f1dd2fe3d58127c9d303d7b
Message-ID: <613dc726.5ZOycSrPsyS2i/f3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 91148bfbf6bbfd334f1dd2fe3d58127c9d303d7b  igc: Update the device ID

elapsed time: 2390m

configs tested: 197
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc              randconfig-c003-20210911
i386                 randconfig-c001-20210911
i386                 randconfig-c001-20210912
i386                 randconfig-c001-20210910
sh                          landisk_defconfig
sh                          urquell_defconfig
um                           x86_64_defconfig
mips                       rbtx49xx_defconfig
powerpc                     stx_gp3_defconfig
arm                  colibri_pxa300_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                          g5_defconfig
powerpc                   currituck_defconfig
arm                       mainstone_defconfig
sh                          rsk7269_defconfig
powerpc                     powernv_defconfig
arm                      pxa255-idp_defconfig
powerpc                         ps3_defconfig
arm                         shannon_defconfig
mips                         db1xxx_defconfig
sh                           se7712_defconfig
powerpc                      pmac32_defconfig
mips                        vocore2_defconfig
xtensa                           allyesconfig
arm                         cm_x300_defconfig
sh                            migor_defconfig
mips                           ci20_defconfig
mips                        jmr3927_defconfig
powerpc                       holly_defconfig
m68k                       bvme6000_defconfig
powerpc                      acadia_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     ppa8548_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
m68k                       m5475evb_defconfig
powerpc                   microwatt_defconfig
mips                          ath25_defconfig
powerpc                     mpc5200_defconfig
arm                        clps711x_defconfig
s390                             alldefconfig
ia64                      gensparse_defconfig
arm                         lpc18xx_defconfig
powerpc                      bamboo_defconfig
um                                  defconfig
arm                          badge4_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
mips                      maltasmvp_defconfig
arm                          collie_defconfig
sh                   sh7724_generic_defconfig
parisc                           alldefconfig
sh                        sh7763rdp_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                       multi_v4t_defconfig
powerpc                    adder875_defconfig
parisc                              defconfig
sh                          r7785rp_defconfig
arm                          ep93xx_defconfig
arm                           h5000_defconfig
powerpc                     mpc83xx_defconfig
mips                         tb0226_defconfig
arm                          pxa168_defconfig
mips                        bcm63xx_defconfig
arm                              alldefconfig
x86_64               randconfig-c001-20210912
arm                  randconfig-c002-20210912
x86_64               randconfig-c001-20210910
arm                  randconfig-c002-20210910
x86_64               randconfig-c001-20210911
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210911
x86_64               randconfig-a003-20210911
x86_64               randconfig-a004-20210911
x86_64               randconfig-a006-20210911
x86_64               randconfig-a005-20210911
x86_64               randconfig-a001-20210911
i386                 randconfig-a004-20210911
i386                 randconfig-a005-20210911
i386                 randconfig-a002-20210911
i386                 randconfig-a006-20210911
i386                 randconfig-a001-20210911
i386                 randconfig-a003-20210911
x86_64               randconfig-a013-20210910
x86_64               randconfig-a016-20210910
x86_64               randconfig-a012-20210910
x86_64               randconfig-a011-20210910
x86_64               randconfig-a014-20210910
x86_64               randconfig-a015-20210910
x86_64               randconfig-a016-20210912
x86_64               randconfig-a013-20210912
x86_64               randconfig-a012-20210912
x86_64               randconfig-a011-20210912
x86_64               randconfig-a014-20210912
x86_64               randconfig-a015-20210912
i386                 randconfig-a016-20210912
i386                 randconfig-a011-20210912
i386                 randconfig-a015-20210912
i386                 randconfig-a012-20210912
i386                 randconfig-a013-20210912
i386                 randconfig-a014-20210912
i386                 randconfig-a016-20210910
i386                 randconfig-a011-20210910
i386                 randconfig-a012-20210910
i386                 randconfig-a013-20210910
i386                 randconfig-a014-20210910
riscv                randconfig-r042-20210912
s390                 randconfig-r044-20210912
arc                  randconfig-r043-20210912
riscv                randconfig-r042-20210910
s390                 randconfig-r044-20210910
arc                  randconfig-r043-20210910
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210910
x86_64               randconfig-a003-20210910
x86_64               randconfig-a004-20210910
x86_64               randconfig-a006-20210910
x86_64               randconfig-a001-20210910
x86_64               randconfig-a002-20210912
x86_64               randconfig-a003-20210912
x86_64               randconfig-a006-20210912
x86_64               randconfig-a004-20210912
x86_64               randconfig-a005-20210912
x86_64               randconfig-a001-20210912
x86_64               randconfig-a005-20210910
i386                 randconfig-a004-20210910
i386                 randconfig-a005-20210910
i386                 randconfig-a002-20210910
i386                 randconfig-a006-20210910
i386                 randconfig-a001-20210910
i386                 randconfig-a003-20210910
i386                 randconfig-a004-20210912
i386                 randconfig-a005-20210912
i386                 randconfig-a002-20210912
i386                 randconfig-a006-20210912
i386                 randconfig-a003-20210912
i386                 randconfig-a001-20210912
x86_64               randconfig-a013-20210911
x86_64               randconfig-a016-20210911
x86_64               randconfig-a012-20210911
x86_64               randconfig-a011-20210911
x86_64               randconfig-a014-20210911
x86_64               randconfig-a015-20210911
i386                 randconfig-a016-20210911
i386                 randconfig-a011-20210911
i386                 randconfig-a015-20210911
i386                 randconfig-a012-20210911
i386                 randconfig-a013-20210911
i386                 randconfig-a014-20210911
hexagon              randconfig-r045-20210910
hexagon              randconfig-r041-20210910

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
