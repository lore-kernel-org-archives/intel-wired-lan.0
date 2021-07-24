From: kernel test robot <lkp@intel.com>
Date: Sat, 24 Jul 2021 13:08:07 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD REGRESSION
 cd74f25b28ce092afb09da734a02912b8bf1ccb1
Message-ID: <60fba037.A734jVo/g+7WoeAI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: cd74f25b28ce092afb09da734a02912b8bf1ccb1  e100: Avoid memcpy() over-reading of ETH_SS_STATS

possible Error/Warning in current branch:

net/bridge/br_forward.c:51:5: error: 'struct sk_buff' has no member named 'offload_fwd_mark'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r002-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- i386-randconfig-a003-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- i386-randconfig-s001-20210724
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- m68k-defconfig
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- m68k-randconfig-r033-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- openrisc-buildonly-randconfig-r006-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- openrisc-randconfig-p001-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- parisc-randconfig-r001-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- sh-randconfig-p002-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
|-- sh-randconfig-r015-20210723
|   `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark
`-- x86_64-randconfig-a011-20210723
    `-- net-bridge-br_forward.c:error:struct-sk_buff-has-no-member-named-offload_fwd_mark

elapsed time: 722m

configs tested: 107
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210723
arc                     haps_hs_smp_defconfig
powerpc                    klondike_defconfig
arm                         vf610m4_defconfig
mips                       rbtx49xx_defconfig
sh                        dreamcast_defconfig
m68k                          sun3x_defconfig
arm                          collie_defconfig
powerpc                      makalu_defconfig
powerpc                     redwood_defconfig
mips                      bmips_stb_defconfig
arc                           tb10x_defconfig
sh                           se7750_defconfig
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc64                             defconfig
arc                        nsim_700_defconfig
powerpc                     ppa8548_defconfig
openrisc                  or1klitex_defconfig
sh                          r7785rp_defconfig
h8300                            alldefconfig
powerpc                 mpc85xx_cds_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210723
i386                 randconfig-a003-20210723
i386                 randconfig-a004-20210723
i386                 randconfig-a002-20210723
i386                 randconfig-a001-20210723
i386                 randconfig-a006-20210723
i386                 randconfig-a005-20210724
i386                 randconfig-a003-20210724
i386                 randconfig-a004-20210724
i386                 randconfig-a002-20210724
i386                 randconfig-a001-20210724
i386                 randconfig-a006-20210724
x86_64               randconfig-a011-20210723
x86_64               randconfig-a016-20210723
x86_64               randconfig-a013-20210723
x86_64               randconfig-a014-20210723
x86_64               randconfig-a012-20210723
x86_64               randconfig-a015-20210723
i386                 randconfig-a016-20210724
i386                 randconfig-a013-20210724
i386                 randconfig-a012-20210724
i386                 randconfig-a014-20210724
i386                 randconfig-a011-20210724
i386                 randconfig-a015-20210724
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210723
x86_64               randconfig-c001-20210724
x86_64               randconfig-b001-20210723
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
