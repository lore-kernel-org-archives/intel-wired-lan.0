From: kernel test robot <lkp@intel.com>
Date: Fri, 04 Mar 2022 03:23:23 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:10GbE] BUILD SUCCESS
 a53c52cf226e561b5ee18c5ffc20e45a616d6643
Message-ID: <622115ab.Kopzb+xOMvJLvXKw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 10GbE
branch HEAD: a53c52cf226e561b5ee18c5ffc20e45a616d6643  ice: avoid XDP checks in ice_clean_tx_irq()

elapsed time: 1427m

configs tested: 160
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220303
sparc64                             defconfig
arm                           sunxi_defconfig
sh                        edosk7705_defconfig
xtensa                           allyesconfig
arc                    vdk_hs38_smp_defconfig
arm                         lubbock_defconfig
mips                         db1xxx_defconfig
sh                            shmin_defconfig
arm                          badge4_defconfig
m68k                             allyesconfig
h8300                     edosk2674_defconfig
powerpc                    amigaone_defconfig
mips                            ar7_defconfig
m68k                          sun3x_defconfig
arm                            mps2_defconfig
nios2                         10m50_defconfig
arm                        cerfcube_defconfig
arc                        nsim_700_defconfig
arm                        realview_defconfig
arm                         axm55xx_defconfig
nds32                            alldefconfig
mips                        jmr3927_defconfig
um                                  defconfig
m68k                        mvme16x_defconfig
arm                          iop32x_defconfig
sh                          lboxre2_defconfig
arc                            hsdk_defconfig
arm                         assabet_defconfig
sh                   sh7724_generic_defconfig
sparc                            allyesconfig
powerpc                     taishan_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
nios2                               defconfig
riscv             nommu_k210_sdcard_defconfig
mips                 decstation_r4k_defconfig
arm                            qcom_defconfig
um                             i386_defconfig
sh                        sh7757lcr_defconfig
sh                          urquell_defconfig
arm                            lart_defconfig
arc                        nsimosci_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
sparc                            alldefconfig
mips                            gpr_defconfig
powerpc                        warp_defconfig
m68k                            q40_defconfig
i386                                defconfig
h8300                               defconfig
sh                           se7705_defconfig
powerpc                       holly_defconfig
arm                        clps711x_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
sh                           se7712_defconfig
m68k                          multi_defconfig
openrisc                  or1klitex_defconfig
sh                  sh7785lcr_32bit_defconfig
csky                                defconfig
riscv                               defconfig
arm                      jornada720_defconfig
m68k                       m5475evb_defconfig
m68k                       bvme6000_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220302
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
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
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220302
riscv                randconfig-r042-20220302
s390                 randconfig-r044-20220302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220303
riscv                randconfig-c006-20220303
i386                          randconfig-c001
arm                  randconfig-c002-20220303
mips                 randconfig-c004-20220303
powerpc              randconfig-c003-20220302
riscv                randconfig-c006-20220302
arm                  randconfig-c002-20220302
mips                 randconfig-c004-20220302
arm                  colibri_pxa300_defconfig
mips                     loongson2k_defconfig
powerpc                       ebony_defconfig
arm                            mmp2_defconfig
powerpc                      pmac32_defconfig
arm                         mv78xx0_defconfig
arm                         lpc32xx_defconfig
mips                            e55_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302
hexagon              randconfig-r045-20220303
riscv                randconfig-r042-20220303
hexagon              randconfig-r041-20220303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
