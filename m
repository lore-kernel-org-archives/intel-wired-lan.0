From: kernel test robot <lkp@intel.com>
Date: Sun, 19 Dec 2021 07:25:11 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 dab97cb0b249b82cc5bd089e94799a12f6f8b9cb
Message-ID: <61be6dd7.Onid7LRpxaaGiDeE%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: dab97cb0b249b82cc5bd089e94799a12f6f8b9cb  igc: Do not enable crosstimestamping for i225-V models

elapsed time: 1469m

configs tested: 182
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211216
mips                         rt305x_defconfig
sh                      rts7751r2d1_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      bamboo_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
powerpc                      chrp32_defconfig
nios2                         10m50_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                   sb1250_swarm_defconfig
xtensa                         virt_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
arc                        nsimosci_defconfig
powerpc                    sam440ep_defconfig
nios2                            alldefconfig
powerpc                       ebony_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
riscv                          rv32_defconfig
alpha                            alldefconfig
powerpc                          g5_defconfig
arc                        nsim_700_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       bvme6000_defconfig
arm                              alldefconfig
mips                            ar7_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     powernv_defconfig
powerpc                      mgcoge_defconfig
um                           x86_64_defconfig
powerpc                      katmai_defconfig
arm                        vexpress_defconfig
arc                                 defconfig
sparc                               defconfig
arm                       imx_v6_v7_defconfig
powerpc                      cm5200_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
arm                      pxa255-idp_defconfig
h8300                            alldefconfig
arm                       spear13xx_defconfig
mips                         cobalt_defconfig
powerpc                      pasemi_defconfig
m68k                        m5407c3_defconfig
ia64                          tiger_defconfig
arm                       netwinder_defconfig
powerpc                      pmac32_defconfig
arm                         shannon_defconfig
arm                        clps711x_defconfig
sh                           se7724_defconfig
m68k                       m5249evb_defconfig
arm                            dove_defconfig
mips                             allyesconfig
sh                   sh7770_generic_defconfig
arm                         mv78xx0_defconfig
powerpc                     tqm8560_defconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
m68k                        stmark2_defconfig
powerpc                      makalu_defconfig
powerpc                    adder875_defconfig
m68k                            q40_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                         s5pv210_defconfig
mips                  decstation_64_defconfig
arc                        vdk_hs38_defconfig
sh                            titan_defconfig
arm                           stm32_defconfig
arm                        neponset_defconfig
arm                         lubbock_defconfig
mips                        bcm47xx_defconfig
h8300                            allyesconfig
powerpc                   motionpro_defconfig
powerpc                 linkstation_defconfig
m68k                           sun3_defconfig
openrisc                    or1ksim_defconfig
arm                  randconfig-c002-20211218
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211216
x86_64               randconfig-a005-20211216
x86_64               randconfig-a001-20211216
x86_64               randconfig-a002-20211216
x86_64               randconfig-a003-20211216
x86_64               randconfig-a004-20211216
i386                 randconfig-a001-20211216
i386                 randconfig-a002-20211216
i386                 randconfig-a003-20211216
i386                 randconfig-a006-20211216
i386                 randconfig-a005-20211216
i386                 randconfig-a004-20211216
i386                 randconfig-a002-20211218
i386                 randconfig-a005-20211218
i386                 randconfig-a003-20211218
i386                 randconfig-a006-20211218
i386                 randconfig-a004-20211218
x86_64               randconfig-a011-20211219
x86_64               randconfig-a013-20211219
x86_64               randconfig-a012-20211219
x86_64               randconfig-a014-20211219
x86_64               randconfig-a015-20211219
x86_64               randconfig-a016-20211219
i386                 randconfig-a013-20211219
i386                 randconfig-a011-20211219
i386                 randconfig-a015-20211219
i386                 randconfig-a014-20211219
i386                 randconfig-a012-20211219
i386                 randconfig-a016-20211219
arc                  randconfig-r043-20211216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a011-20211216
x86_64               randconfig-a012-20211216
x86_64               randconfig-a013-20211216
x86_64               randconfig-a016-20211216
x86_64               randconfig-a015-20211216
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
x86_64               randconfig-a014-20211216
x86_64               randconfig-a006-20211219
x86_64               randconfig-a005-20211219
x86_64               randconfig-a001-20211219
x86_64               randconfig-a003-20211219
x86_64               randconfig-a002-20211219
x86_64               randconfig-a004-20211219
hexagon              randconfig-r045-20211216
s390                 randconfig-r044-20211216
hexagon              randconfig-r041-20211216
riscv                randconfig-r042-20211216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
