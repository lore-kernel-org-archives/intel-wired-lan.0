From: kernel test robot <lkp@intel.com>
Date: Wed, 09 Jun 2021 19:24:32 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 db645d3d4d6d6744826909da5e6c4cb857a075f6
Message-ID: <60c0a4f0.KcI1RfiWBt5kzwLT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: db645d3d4d6d6744826909da5e6c4cb857a075f6  ixgbe, xsk: clean up the resources in ixgbe_xsk_pool_enable error path

elapsed time: 723m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
mips                      maltasmvp_defconfig
arm                         orion5x_defconfig
h8300                       h8s-sim_defconfig
arm                   milbeaut_m10v_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     pseries_defconfig
parisc                generic-32bit_defconfig
xtensa                          iss_defconfig
h8300                    h8300h-sim_defconfig
mips                      loongson3_defconfig
ia64                      gensparse_defconfig
m68k                            q40_defconfig
openrisc                            defconfig
mips                     cu1000-neo_defconfig
arc                        nsim_700_defconfig
arm                       versatile_defconfig
h8300                            allyesconfig
mips                         rt305x_defconfig
sh                         microdev_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 linkstation_defconfig
sh                          sdk7786_defconfig
xtensa                  nommu_kc705_defconfig
i386                             allyesconfig
ia64                        generic_defconfig
powerpc                        warp_defconfig
powerpc                   currituck_defconfig
mips                  cavium_octeon_defconfig
sh                          sdk7780_defconfig
arm                             mxs_defconfig
mips                       rbtx49xx_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
powerpc                      ppc6xx_defconfig
arm                         s5pv210_defconfig
nios2                         3c120_defconfig
powerpc                    mvme5100_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
mips                      maltaaprp_defconfig
csky                                defconfig
um                           x86_64_defconfig
sh                             espt_defconfig
powerpc                    gamecube_defconfig
xtensa                         virt_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       imx_v6_v7_defconfig
um                             i386_defconfig
arm                       netwinder_defconfig
powerpc                  mpc866_ads_defconfig
mips                        workpad_defconfig
powerpc                     mpc83xx_defconfig
arm                      jornada720_defconfig
nds32                             allnoconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
arm                     am200epdkit_defconfig
powerpc                      pmac32_defconfig
arm                        spear6xx_defconfig
x86_64                           alldefconfig
m68k                         amcore_defconfig
powerpc                      ppc64e_defconfig
arc                     nsimosci_hs_defconfig
h8300                               defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
i386                 randconfig-a003-20210609
i386                 randconfig-a006-20210609
i386                 randconfig-a004-20210609
i386                 randconfig-a001-20210609
i386                 randconfig-a002-20210609
i386                 randconfig-a005-20210609
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210608
x86_64               randconfig-a012-20210608
x86_64               randconfig-a014-20210608
x86_64               randconfig-a011-20210608
x86_64               randconfig-a016-20210608
x86_64               randconfig-a013-20210608
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
