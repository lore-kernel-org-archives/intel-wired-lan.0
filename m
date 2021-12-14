From: kernel test robot <lkp@intel.com>
Date: Tue, 14 Dec 2021 20:39:44 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 fe523d7c9a8332855376ad5eb1aa301091129ba4
Message-ID: <61b89090.xPZ8fwHMneB1ksUf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: fe523d7c9a8332855376ad5eb1aa301091129ba4  iavf: do not override the adapter state in the watchdog task (again)

elapsed time: 725m

configs tested: 169
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211214
i386                 randconfig-c001-20211213
sh                           se7705_defconfig
arc                              allyesconfig
arm                          gemini_defconfig
powerpc                      walnut_defconfig
powerpc                      cm5200_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                          landisk_defconfig
powerpc                         wii_defconfig
powerpc                      acadia_defconfig
arm                        magician_defconfig
arm                        oxnas_v6_defconfig
arc                        vdk_hs38_defconfig
powerpc                     pq2fads_defconfig
arm                           h5000_defconfig
powerpc                 mpc837x_mds_defconfig
openrisc                 simple_smp_defconfig
mips                  maltasmvp_eva_defconfig
mips                     loongson1c_defconfig
arm                        mini2440_defconfig
xtensa                  audio_kc705_defconfig
arm                         orion5x_defconfig
arm                         hackkit_defconfig
xtensa                    xip_kc705_defconfig
mips                      bmips_stb_defconfig
sh                   secureedge5410_defconfig
sh                   sh7770_generic_defconfig
arm                     davinci_all_defconfig
powerpc                    ge_imp3a_defconfig
mips                         db1xxx_defconfig
arm                            hisi_defconfig
powerpc                  iss476-smp_defconfig
arm                         cm_x300_defconfig
mips                           gcw0_defconfig
arm                             mxs_defconfig
powerpc                     tqm8555_defconfig
sh                        apsh4ad0a_defconfig
arm                          imote2_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      ppc6xx_defconfig
arm                        shmobile_defconfig
arc                 nsimosci_hs_smp_defconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
arm                         assabet_defconfig
h8300                               defconfig
sh                          polaris_defconfig
mips                           mtx1_defconfig
powerpc                     ksi8560_defconfig
sh                           se7721_defconfig
mips                         tb0287_defconfig
arm                         vf610m4_defconfig
powerpc                   currituck_defconfig
powerpc                         ps3_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7206_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
nds32                            alldefconfig
sh                           se7712_defconfig
m68k                        mvme147_defconfig
powerpc                     kilauea_defconfig
sh                        dreamcast_defconfig
powerpc                     tqm8540_defconfig
powerpc64                        alldefconfig
arm                  randconfig-c002-20211213
arm                  randconfig-c002-20211214
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211214
x86_64               randconfig-a005-20211214
x86_64               randconfig-a001-20211214
x86_64               randconfig-a002-20211214
x86_64               randconfig-a003-20211214
x86_64               randconfig-a004-20211214
i386                 randconfig-a001-20211214
i386                 randconfig-a002-20211214
i386                 randconfig-a005-20211214
i386                 randconfig-a003-20211214
i386                 randconfig-a006-20211214
i386                 randconfig-a004-20211214
x86_64               randconfig-a011-20211213
x86_64               randconfig-a012-20211213
x86_64               randconfig-a014-20211213
x86_64               randconfig-a013-20211213
x86_64               randconfig-a015-20211213
x86_64               randconfig-a016-20211213
i386                 randconfig-a013-20211213
i386                 randconfig-a011-20211213
i386                 randconfig-a016-20211213
i386                 randconfig-a014-20211213
i386                 randconfig-a015-20211213
i386                 randconfig-a012-20211213
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211213
arm                  randconfig-c002-20211213
riscv                randconfig-c006-20211213
mips                 randconfig-c004-20211213
i386                 randconfig-c001-20211213
s390                 randconfig-c005-20211213
powerpc              randconfig-c003-20211213
x86_64               randconfig-a011-20211214
x86_64               randconfig-a014-20211214
x86_64               randconfig-a012-20211214
x86_64               randconfig-a013-20211214
x86_64               randconfig-a016-20211214
x86_64               randconfig-a015-20211214
i386                 randconfig-a013-20211214
i386                 randconfig-a011-20211214
i386                 randconfig-a016-20211214
i386                 randconfig-a014-20211214
i386                 randconfig-a015-20211214
i386                 randconfig-a012-20211214
hexagon              randconfig-r045-20211214
s390                 randconfig-r044-20211214
riscv                randconfig-r042-20211214
hexagon              randconfig-r041-20211214
hexagon              randconfig-r045-20211213
hexagon              randconfig-r041-20211213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
