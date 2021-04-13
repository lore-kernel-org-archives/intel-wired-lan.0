From: kernel test robot <lkp@intel.com>
Date: Tue, 13 Apr 2021 21:25:55 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 WARNING 4947076b75387e9e94efd80d0ba4fb26341cd2fd
Message-ID: <60759be3.C+GAkh7bzdqLGbo1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 4947076b75387e9e94efd80d0ba4fb26341cd2fd  i40e: Fix use-after-free in i40e_client_subtask()

Warning in current branch:

drivers/net/ethernet/mellanox/mlx5/core/en/rep/tc.c:654:14: warning: variable 'reg_c1' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm64-defconfig
    `-- drivers-net-ethernet-mellanox-mlx5-core-en-rep-tc.c:warning:variable-reg_c1-set-but-not-used

elapsed time: 721m

configs tested: 147
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
h8300                       h8s-sim_defconfig
mips                       bmips_be_defconfig
powerpc                 canyonlands_defconfig
mips                  decstation_64_defconfig
arm                              alldefconfig
arm                       aspeed_g4_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        mvebu_v7_defconfig
mips                          ath79_defconfig
microblaze                          defconfig
sh                          rsk7269_defconfig
arm                       cns3420vb_defconfig
ia64                          tiger_defconfig
arc                        nsim_700_defconfig
openrisc                 simple_smp_defconfig
sh                           se7750_defconfig
mips                           rs90_defconfig
powerpc                    gamecube_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     redwood_defconfig
powerpc                    klondike_defconfig
m68k                           sun3_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     sbc8548_defconfig
arm                         assabet_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
powerpc                 mpc832x_rdb_defconfig
arm                           h3600_defconfig
powerpc                   lite5200b_defconfig
arm                       netwinder_defconfig
arm                           corgi_defconfig
arm                        magician_defconfig
um                                  defconfig
arm                            zeus_defconfig
openrisc                         alldefconfig
m68k                          atari_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                        fsp2_defconfig
sh                   sh7770_generic_defconfig
powerpc                     pq2fads_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         hackkit_defconfig
m68k                       m5208evb_defconfig
arm                            xcep_defconfig
arm                             ezx_defconfig
um                               allmodconfig
arm                            qcom_defconfig
mips                        omega2p_defconfig
mips                         mpc30x_defconfig
arm                            mmp2_defconfig
arm                          ep93xx_defconfig
m68k                            mac_defconfig
arm                  colibri_pxa270_defconfig
mips                           ci20_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
x86_64                           alldefconfig
sh                           sh2007_defconfig
openrisc                    or1ksim_defconfig
m68k                          multi_defconfig
mips                        workpad_defconfig
m68k                          amiga_defconfig
powerpc                     pseries_defconfig
mips                          ath25_defconfig
mips                 decstation_r4k_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
parisc                generic-32bit_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210413
x86_64               randconfig-a002-20210413
x86_64               randconfig-a001-20210413
x86_64               randconfig-a005-20210413
x86_64               randconfig-a006-20210413
x86_64               randconfig-a004-20210413
i386                 randconfig-a003-20210413
i386                 randconfig-a001-20210413
i386                 randconfig-a006-20210413
i386                 randconfig-a005-20210413
i386                 randconfig-a004-20210413
i386                 randconfig-a002-20210413
i386                 randconfig-a015-20210413
i386                 randconfig-a014-20210413
i386                 randconfig-a013-20210413
i386                 randconfig-a012-20210413
i386                 randconfig-a016-20210413
i386                 randconfig-a011-20210413
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210413
x86_64               randconfig-a015-20210413
x86_64               randconfig-a011-20210413
x86_64               randconfig-a013-20210413
x86_64               randconfig-a012-20210413
x86_64               randconfig-a016-20210413

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
