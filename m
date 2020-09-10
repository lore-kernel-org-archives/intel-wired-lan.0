From: kernel test robot <lkp@intel.com>
Date: Thu, 10 Sep 2020 21:41:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 WITH WARNING 68e2960f0dff2cf6dbc4db26539990b286631bde
Message-ID: <5f5a2cfd.UIo0ek7kl2fA0MZx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 68e2960f0dff2cf6dbc4db26539990b286631bde  i40e: Add EEE status getting & setting implementation

Warning in current branch:

drivers/net/ethernet/intel/e1000/e1000_hw.c:4415:58: warning: Same expression in both branches of ternary operator. [duplicateExpressionTernary]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- alpha-randconfig-p001-20200909
    `-- drivers-net-ethernet-intel-e1000-e1000_hw.c:warning:Same-expression-in-both-branches-of-ternary-operator.-duplicateExpressionTernary

elapsed time: 720m

configs tested: 123
configs skipped: 6

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
mips                      fuloong2e_defconfig
sh                         apsh4a3a_defconfig
arm                      footbridge_defconfig
sh                         ecovec24_defconfig
powerpc                      mgcoge_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
powerpc                     powernv_defconfig
arm                       mainstone_defconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
arc                           tb10x_defconfig
arm                        spear3xx_defconfig
sh                           se7712_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
sh                           se7750_defconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
sh                         microdev_defconfig
arm                          ixp4xx_defconfig
sparc                       sparc32_defconfig
mips                      loongson3_defconfig
mips                  maltasmvp_eva_defconfig
sh                              ul2_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
nds32                            alldefconfig
sh                        sh7757lcr_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200910
i386                 randconfig-a006-20200910
i386                 randconfig-a001-20200910
i386                 randconfig-a003-20200910
i386                 randconfig-a002-20200910
i386                 randconfig-a005-20200910
i386                 randconfig-a004-20200909
i386                 randconfig-a005-20200909
i386                 randconfig-a006-20200909
i386                 randconfig-a002-20200909
i386                 randconfig-a001-20200909
i386                 randconfig-a003-20200909
x86_64               randconfig-a004-20200909
x86_64               randconfig-a006-20200909
x86_64               randconfig-a003-20200909
x86_64               randconfig-a001-20200909
x86_64               randconfig-a005-20200909
x86_64               randconfig-a002-20200909
i386                 randconfig-a016-20200909
i386                 randconfig-a015-20200909
i386                 randconfig-a011-20200909
i386                 randconfig-a013-20200909
i386                 randconfig-a014-20200909
i386                 randconfig-a012-20200909
i386                 randconfig-a015-20200910
i386                 randconfig-a014-20200910
i386                 randconfig-a011-20200910
i386                 randconfig-a013-20200910
i386                 randconfig-a016-20200910
i386                 randconfig-a012-20200910
x86_64               randconfig-a004-20200910
x86_64               randconfig-a006-20200910
x86_64               randconfig-a003-20200910
x86_64               randconfig-a002-20200910
x86_64               randconfig-a005-20200910
x86_64               randconfig-a001-20200910
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20200909
x86_64               randconfig-a016-20200909
x86_64               randconfig-a011-20200909
x86_64               randconfig-a012-20200909
x86_64               randconfig-a015-20200909
x86_64               randconfig-a014-20200909

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
