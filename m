From: kernel test robot <lkp@intel.com>
Date: Tue, 02 Mar 2021 20:37:15 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 3a3e187b7b489df5ae729aeee86b2db852b76a92
Message-ID: <603e317b.xBUT/Z5bX8jiiMw6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 3a3e187b7b489df5ae729aeee86b2db852b76a92  igb: unbreak I2C bit-banging on i350

Error/Warning in current branch:

drivers/net/ethernet/intel/ice/ice_main.c:2074: undefined reference to `ice_flush_fdir_ctx'
drivers/net/ethernet/intel/ice/ice_txrx.c:1122: undefined reference to `ice_vc_fdir_irq_handler'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-a012-20210302
    |-- drivers-net-ethernet-intel-ice-ice_main.c:undefined-reference-to-ice_flush_fdir_ctx
    `-- drivers-net-ethernet-intel-ice-ice_txrx.c:undefined-reference-to-ice_vc_fdir_irq_handler

elapsed time: 722m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        nsim_700_defconfig
arm                        keystone_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
arm                          gemini_defconfig
arm                         at91_dt_defconfig
arm                             rpc_defconfig
ia64                            zx1_defconfig
powerpc                        cell_defconfig
arm                        shmobile_defconfig
parisc                generic-64bit_defconfig
x86_64                           alldefconfig
arm                            hisi_defconfig
powerpc                    gamecube_defconfig
sh                           se7705_defconfig
powerpc                      walnut_defconfig
powerpc                     sbc8548_defconfig
powerpc                   currituck_defconfig
m68k                        mvme147_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210302
i386                 randconfig-a003-20210302
i386                 randconfig-a002-20210302
i386                 randconfig-a004-20210302
i386                 randconfig-a006-20210302
i386                 randconfig-a001-20210302
i386                 randconfig-a016-20210302
i386                 randconfig-a012-20210302
i386                 randconfig-a014-20210302
i386                 randconfig-a013-20210302
i386                 randconfig-a011-20210302
i386                 randconfig-a015-20210302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210301
x86_64               randconfig-a001-20210301
x86_64               randconfig-a004-20210301
x86_64               randconfig-a002-20210301
x86_64               randconfig-a005-20210301
x86_64               randconfig-a003-20210301
x86_64               randconfig-a013-20210302
x86_64               randconfig-a016-20210302
x86_64               randconfig-a015-20210302
x86_64               randconfig-a014-20210302
x86_64               randconfig-a012-20210302
x86_64               randconfig-a011-20210302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
