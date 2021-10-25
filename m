From: kernel test robot <lkp@intel.com>
Date: Mon, 25 Oct 2021 17:29:03 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 1f83b835a3eaa5ae4bd825fb07182698bfc243ba
Message-ID: <617678df.bgGf3wWdSrqYdmB1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 1f83b835a3eaa5ae4bd825fb07182698bfc243ba  fcnal-test: kill hanging ping/nettest binaries on cleanup

elapsed time: 1815m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
i386                 randconfig-c001-20211025
sh                         ap325rxa_defconfig
powerpc                      pcm030_defconfig
mips                     decstation_defconfig
powerpc                      arches_defconfig
sh                            migor_defconfig
powerpc                      pmac32_defconfig
powerpc                      walnut_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
powerpc                        cell_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7751_defconfig
xtensa                          iss_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                            alldefconfig
arm                       mainstone_defconfig
mips                          rb532_defconfig
arm                           sunxi_defconfig
xtensa                generic_kc705_defconfig
arm                           h3600_defconfig
mips                      bmips_stb_defconfig
mips                        vocore2_defconfig
sh                        sh7757lcr_defconfig
i386                             alldefconfig
powerpc                 mpc8313_rdb_defconfig
sparc                       sparc32_defconfig
sparc64                          alldefconfig
sh                        sh7785lcr_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc8272_ads_defconfig
arm                            xcep_defconfig
powerpc                     kmeter1_defconfig
openrisc                         alldefconfig
powerpc                     tqm8548_defconfig
arm                       spear13xx_defconfig
mips                 decstation_r4k_defconfig
powerpc                   bluestone_defconfig
nios2                         3c120_defconfig
arc                      axs103_smp_defconfig
powerpc                      obs600_defconfig
mips                          rm200_defconfig
arm                           h5000_defconfig
arm                          pxa3xx_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
mips                           ip32_defconfig
arm                  randconfig-c002-20211025
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
h8300                            allyesconfig
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
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a001-20211024
x86_64               randconfig-a003-20211024
i386                 randconfig-a003-20211024
i386                 randconfig-a004-20211024
i386                 randconfig-a002-20211024
i386                 randconfig-a005-20211024
i386                 randconfig-a006-20211024
i386                 randconfig-a001-20211024
x86_64               randconfig-a013-20211025
x86_64               randconfig-a015-20211025
x86_64               randconfig-a011-20211025
x86_64               randconfig-a014-20211025
x86_64               randconfig-a016-20211025
x86_64               randconfig-a012-20211025
i386                 randconfig-a012-20211025
i386                 randconfig-a013-20211025
i386                 randconfig-a011-20211025
i386                 randconfig-a016-20211025
i386                 randconfig-a015-20211025
i386                 randconfig-a014-20211025
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
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20211025
powerpc              randconfig-c003-20211025
arm                  randconfig-c002-20211025
x86_64               randconfig-c007-20211025
mips                 randconfig-c004-20211025
i386                 randconfig-c001-20211025
s390                 randconfig-c005-20211025
i386                 randconfig-a003-20211025
i386                 randconfig-a004-20211025
i386                 randconfig-a002-20211025
i386                 randconfig-a005-20211025
i386                 randconfig-a001-20211025
i386                 randconfig-a006-20211025
hexagon              randconfig-r045-20211025
hexagon              randconfig-r041-20211025

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
