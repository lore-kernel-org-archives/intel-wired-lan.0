From: kernel test robot <lkp@intel.com>
Date: Fri, 23 Apr 2021 16:37:38 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 e41985f0fe8b68d1ac321bd4eda460fb553e65ad
Message-ID: <60828752.FFt9F99qScmLqHE1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: e41985f0fe8b68d1ac321bd4eda460fb553e65ad  iavf: Support for modifying SCTP RSS flow hashing

elapsed time: 892m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                             allyesconfig
powerpc                       ebony_defconfig
powerpc                      cm5200_defconfig
um                             i386_defconfig
arm                      jornada720_defconfig
arm                              alldefconfig
h8300                       h8s-sim_defconfig
powerpc                    amigaone_defconfig
m68k                          sun3x_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                           viper_defconfig
um                           x86_64_defconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc834x_mds_defconfig
riscv                             allnoconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
mips                        omega2p_defconfig
arm                          exynos_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      chrp32_defconfig
sh                          sdk7786_defconfig
arm                       cns3420vb_defconfig
um                               alldefconfig
arm                          lpd270_defconfig
arm                       mainstone_defconfig
mips                      bmips_stb_defconfig
arm                        mvebu_v5_defconfig
arm                        mvebu_v7_defconfig
ia64                            zx1_defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
openrisc                         alldefconfig
sh                          rsk7269_defconfig
powerpc                     powernv_defconfig
powerpc                   currituck_defconfig
ia64                      gensparse_defconfig
openrisc                  or1klitex_defconfig
mips                      pic32mzda_defconfig
nios2                            allyesconfig
mips                        maltaup_defconfig
mips                        vocore2_defconfig
arc                          axs101_defconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
um                            kunit_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc832x_rdb_defconfig
openrisc                    or1ksim_defconfig
sparc                               defconfig
powerpc                     ep8248e_defconfig
mips                          rb532_defconfig
powerpc                     tqm8548_defconfig
powerpc                     mpc512x_defconfig
arm                         at91_dt_defconfig
arm                         palmz72_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                      walnut_defconfig
powerpc                     rainier_defconfig
arm                           stm32_defconfig
powerpc                     mpc83xx_defconfig
arm                        trizeps4_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
x86_64               randconfig-a002-20210423
x86_64               randconfig-a004-20210423
x86_64               randconfig-a001-20210423
x86_64               randconfig-a005-20210423
x86_64               randconfig-a006-20210423
x86_64               randconfig-a003-20210423
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
