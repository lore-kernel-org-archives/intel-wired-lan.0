From: kernel test robot <lkp@intel.com>
Date: Fri, 17 Sep 2021 06:38:48 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 7366c23ff492ad260776a3ee1aaabba9fc773a8b
Message-ID: <6143c778.k2KAu/x2HMgvJDbx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 7366c23ff492ad260776a3ee1aaabba9fc773a8b  ptp: dp83640: don't define PAGE0

elapsed time: 2572m

configs tested: 161
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210916
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
sh                        edosk7705_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                    mvme5100_defconfig
arm                             rpc_defconfig
riscv                               defconfig
um                               alldefconfig
sh                          polaris_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
arc                              alldefconfig
powerpc                      ppc44x_defconfig
sh                          landisk_defconfig
um                           x86_64_defconfig
powerpc                     ep8248e_defconfig
arm                        mvebu_v7_defconfig
arc                        nsimosci_defconfig
s390                       zfcpdump_defconfig
sh                           se7724_defconfig
powerpc                     tqm5200_defconfig
sh                   sh7770_generic_defconfig
powerpc                      acadia_defconfig
sh                          lboxre2_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
sh                               alldefconfig
m68k                         amcore_defconfig
arm                        oxnas_v6_defconfig
sh                           se7206_defconfig
arm                         lpc18xx_defconfig
powerpc                    socrates_defconfig
arm                       netwinder_defconfig
arm                         bcm2835_defconfig
riscv                            alldefconfig
sparc                       sparc32_defconfig
m68k                           sun3_defconfig
ia64                      gensparse_defconfig
powerpc                      tqm8xx_defconfig
mips                      bmips_stb_defconfig
arm                      pxa255-idp_defconfig
sh                            hp6xx_defconfig
sh                          sdk7780_defconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
powerpc                   microwatt_defconfig
h8300                               defconfig
powerpc                      chrp32_defconfig
openrisc                         alldefconfig
m68k                       m5475evb_defconfig
powerpc                     pseries_defconfig
mips                           ip27_defconfig
arm                       imx_v6_v7_defconfig
arm                     am200epdkit_defconfig
m68k                            mac_defconfig
mips                        nlm_xlr_defconfig
h8300                       h8s-sim_defconfig
xtensa                generic_kc705_defconfig
arm                        realview_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
powerpc                     kilauea_defconfig
m68k                             alldefconfig
powerpc                 mpc8272_ads_defconfig
sh                            shmin_defconfig
sh                        dreamcast_defconfig
x86_64               randconfig-c001-20210916
arm                  randconfig-c002-20210916
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a016-20210916
x86_64               randconfig-a013-20210916
x86_64               randconfig-a012-20210916
x86_64               randconfig-a011-20210916
x86_64               randconfig-a014-20210916
x86_64               randconfig-a015-20210916
x86_64               randconfig-a002-20210915
x86_64               randconfig-a003-20210915
x86_64               randconfig-a004-20210915
x86_64               randconfig-a006-20210915
x86_64               randconfig-a005-20210915
x86_64               randconfig-a001-20210915
i386                 randconfig-a016-20210916
i386                 randconfig-a015-20210916
i386                 randconfig-a011-20210916
i386                 randconfig-a012-20210916
i386                 randconfig-a013-20210916
i386                 randconfig-a014-20210916
riscv                randconfig-r042-20210916
s390                 randconfig-r044-20210916
arc                  randconfig-r043-20210916
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20210916
x86_64               randconfig-c007-20210916
mips                 randconfig-c004-20210916
powerpc              randconfig-c003-20210916
arm                  randconfig-c002-20210916
i386                 randconfig-c001-20210916
s390                 randconfig-c005-20210916
x86_64               randconfig-a002-20210916
x86_64               randconfig-a003-20210916
x86_64               randconfig-a006-20210916
x86_64               randconfig-a004-20210916
x86_64               randconfig-a005-20210916
x86_64               randconfig-a001-20210916
i386                 randconfig-a004-20210916
i386                 randconfig-a005-20210916
i386                 randconfig-a006-20210916
i386                 randconfig-a002-20210916
i386                 randconfig-a003-20210916
i386                 randconfig-a001-20210916
hexagon              randconfig-r045-20210916
hexagon              randconfig-r041-20210916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
