From: kernel test robot <lkp@intel.com>
Date: Sat, 12 Dec 2020 17:48:59 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 WARNING 49dd24e929ffd092788636429902443068bf9ebc
Message-ID: <5fd4920b.b/v1ufLsE8B2XJ1O%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  dev-queue
branch HEAD: 49dd24e929ffd092788636429902443068bf9ebc  ice, xsk: Move Rx allocation out of while-loop

Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:547:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- parisc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- powerpc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- riscv-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-kexec
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-rhel
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-rhel-7.6-kselftests
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-rhel-8.3
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used

elapsed time: 720m

configs tested: 134
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          r7785rp_defconfig
mips                             allmodconfig
powerpc                     tqm8548_defconfig
m68k                           sun3_defconfig
openrisc                            defconfig
arm                            pleb_defconfig
ia64                             allyesconfig
arm                          collie_defconfig
arm                           sunxi_defconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
arm                            qcom_defconfig
sh                          rsk7264_defconfig
mips                     cu1000-neo_defconfig
powerpc                        cell_defconfig
arm                      jornada720_defconfig
powerpc                 mpc832x_rdb_defconfig
xtensa                    smp_lx200_defconfig
arm                        mvebu_v7_defconfig
sh                             shx3_defconfig
parisc                              defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
powerpc                        warp_defconfig
nios2                         10m50_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                      bamboo_defconfig
riscv                               defconfig
powerpc                     ppa8548_defconfig
m68k                        mvme147_defconfig
arm                        multi_v5_defconfig
arm                          pxa910_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
m68k                       bvme6000_defconfig
powerpc                   currituck_defconfig
mips                      loongson3_defconfig
nds32                               defconfig
parisc                           alldefconfig
ia64                                defconfig
powerpc                    klondike_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         assabet_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     pq2fads_defconfig
sh                        edosk7760_defconfig
arm                             mxs_defconfig
i386                                defconfig
powerpc                           allnoconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
sparc                            allyesconfig
powerpc                          g5_defconfig
sh                           se7724_defconfig
c6x                                 defconfig
sh                   secureedge5410_defconfig
sh                            hp6xx_defconfig
m68k                                defconfig
xtensa                    xip_kc705_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        realview_defconfig
powerpc                      katmai_defconfig
xtensa                           alldefconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
