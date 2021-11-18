From: kernel test robot <lkp@intel.com>
Date: Thu, 18 Nov 2021 12:57:14 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 a052188f8de23f40bbf33e2ede45ecb14cb8e299
Message-ID: <6195dd2a.IJsUoUtfhaZQpkRm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: a052188f8de23f40bbf33e2ede45ecb14cb8e299  iavf: Fix VLAN feature flags after VFR

elapsed time: 724m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211118
i386                 randconfig-c001-20211117
mips                           ip27_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         s5pv210_defconfig
arm                        cerfcube_defconfig
sh                           se7343_defconfig
sh                ecovec24-romimage_defconfig
m68k                          multi_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                      jornada720_defconfig
sh                          rsk7269_defconfig
riscv                            alldefconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
arm                         hackkit_defconfig
xtensa                    xip_kc705_defconfig
sh                        edosk7760_defconfig
arm                       aspeed_g5_defconfig
mips                         mpc30x_defconfig
powerpc                     mpc5200_defconfig
powerpc                    amigaone_defconfig
powerpc                    adder875_defconfig
arm                          iop32x_defconfig
m68k                            mac_defconfig
powerpc                      pasemi_defconfig
mips                           jazz_defconfig
mips                malta_qemu_32r6_defconfig
sparc                       sparc64_defconfig
i386                                defconfig
m68k                          atari_defconfig
mips                       rbtx49xx_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
powerpc                     mpc512x_defconfig
sh                          kfr2r09_defconfig
riscv                             allnoconfig
mips                          ath79_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
sh                   secureedge5410_defconfig
mips                      loongson3_defconfig
sh                   sh7724_generic_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc832x_mds_defconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
sh                          lboxre2_defconfig
powerpc                     akebono_defconfig
powerpc                      chrp32_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                              ul2_defconfig
powerpc                    socrates_defconfig
powerpc                    klondike_defconfig
sh                          sdk7786_defconfig
arm                        mvebu_v5_defconfig
mips                      fuloong2e_defconfig
ia64                          tiger_defconfig
csky                             alldefconfig
csky                                defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
m68k                          amiga_defconfig
powerpc                      arches_defconfig
arm                      integrator_defconfig
m68k                                defconfig
sh                             espt_defconfig
arm                         lubbock_defconfig
mips                        bcm47xx_defconfig
arm                          simpad_defconfig
powerpc                       holly_defconfig
xtensa                              defconfig
arm                            mps2_defconfig
arm                          collie_defconfig
sh                        edosk7705_defconfig
mips                  cavium_octeon_defconfig
mips                     cu1000-neo_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa270_defconfig
mips                     decstation_defconfig
mips                         db1xxx_defconfig
sh                        sh7763rdp_defconfig
arm                          pxa910_defconfig
mips                           mtx1_defconfig
parisc                generic-64bit_defconfig
powerpc                     asp8347_defconfig
arm                           stm32_defconfig
arm                        magician_defconfig
arm                         assabet_defconfig
mips                     cu1830-neo_defconfig
mips                         bigsur_defconfig
powerpc                      cm5200_defconfig
arm                          exynos_defconfig
mips                         tb0287_defconfig
powerpc64                           defconfig
powerpc                      acadia_defconfig
arm                       versatile_defconfig
arm                            dove_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
xtensa                          iss_defconfig
arm                  randconfig-c002-20211117
arm                  randconfig-c002-20211118
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211117
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
i386                 randconfig-a006-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a005-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a004-20211117
i386                 randconfig-a002-20211117
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-c007-20211117
i386                 randconfig-c001-20211117
arm                  randconfig-c002-20211117
riscv                randconfig-c006-20211117
powerpc              randconfig-c003-20211117
s390                 randconfig-c005-20211117
mips                 randconfig-c004-20211117
i386                 randconfig-c001-20211118
x86_64               randconfig-c007-20211118
arm                  randconfig-c002-20211118
s390                 randconfig-c005-20211118
powerpc              randconfig-c003-20211118
riscv                randconfig-c006-20211118
mips                 randconfig-c004-20211118
x86_64               randconfig-a015-20211117
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a016-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
