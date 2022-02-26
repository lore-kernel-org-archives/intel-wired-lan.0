From: kernel test robot <lkp@intel.com>
Date: Sat, 26 Feb 2022 21:03:46 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 e01b042e580f1fbf4fd8da467442451da00c7a90
Message-ID: <621a2532.4Ag0A4dwGg88LStR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: e01b042e580f1fbf4fd8da467442451da00c7a90  net: stmmac: fix return value of __setup handler

elapsed time: 1081m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220225
powerpc              randconfig-c003-20220225
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
sh                           se7619_defconfig
arm                        oxnas_v6_defconfig
xtensa                  nommu_kc705_defconfig
arc                                 defconfig
sh                          kfr2r09_defconfig
sparc                       sparc64_defconfig
ia64                         bigsur_defconfig
mips                      loongson3_defconfig
s390                       zfcpdump_defconfig
m68k                         apollo_defconfig
powerpc                 linkstation_defconfig
parisc                           allyesconfig
arm                          lpd270_defconfig
nios2                         3c120_defconfig
arm                           h5000_defconfig
sh                        edosk7705_defconfig
arc                      axs103_smp_defconfig
mips                         tb0226_defconfig
arm                       imx_v6_v7_defconfig
sh                               allmodconfig
arm                         assabet_defconfig
mips                  decstation_64_defconfig
sh                        dreamcast_defconfig
xtensa                         virt_defconfig
s390                             allyesconfig
arm                           tegra_defconfig
sh                   sh7724_generic_defconfig
powerpc                     pq2fads_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
nios2                         10m50_defconfig
h8300                               defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         db1xxx_defconfig
powerpc                    klondike_defconfig
mips                             allyesconfig
m68k                        m5272c3_defconfig
powerpc                     tqm8548_defconfig
powerpc                      tqm8xx_defconfig
mips                        vocore2_defconfig
arm                        trizeps4_defconfig
i386                             alldefconfig
powerpc                         wii_defconfig
arm                          pxa910_defconfig
arm                           sunxi_defconfig
powerpc                     redwood_defconfig
mips                     loongson1b_defconfig
arm                        mvebu_v7_defconfig
arm                        shmobile_defconfig
alpha                            allyesconfig
mips                       bmips_be_defconfig
xtensa                           allyesconfig
powerpc                       maple_defconfig
powerpc                     ep8248e_defconfig
sh                          lboxre2_defconfig
m68k                          hp300_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc40x_defconfig
arm                          simpad_defconfig
mips                         rt305x_defconfig
powerpc                   motionpro_defconfig
arm                           viper_defconfig
sh                        sh7757lcr_defconfig
m68k                          multi_defconfig
h8300                       h8s-sim_defconfig
sh                           se7750_defconfig
mips                          rb532_defconfig
mips                     decstation_defconfig
um                               alldefconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc64                            defconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
s390                 randconfig-r044-20220226
arc                  randconfig-r043-20220226
riscv                randconfig-r042-20220226
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220225
arm                  randconfig-c002-20220225
x86_64                        randconfig-c007
mips                 randconfig-c004-20220225
i386                          randconfig-c001
riscv                randconfig-c006-20220225
powerpc                    ge_imp3a_defconfig
mips                      bmips_stb_defconfig
powerpc                   microwatt_defconfig
powerpc                     ppa8548_defconfig
arm                     am200epdkit_defconfig
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220226
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220226
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
