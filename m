From: kernel test robot <lkp@intel.com>
Date: Tue, 23 Nov 2021 23:21:27 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 774a90c1e1a340ebad7b1d8783356bed490ca02f
Message-ID: <619d06f7.aUp7OArIkpFv8vdP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 774a90c1e1a340ebad7b1d8783356bed490ca02f  RDMA/irdma: Set protocol based on PF rdma_mode flag

elapsed time: 1270m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211123
mips                 randconfig-c004-20211122
i386                 randconfig-c001-20211122
sh                          landisk_defconfig
mips                      pic32mzda_defconfig
mips                        bcm47xx_defconfig
arc                          axs103_defconfig
arm                       omap2plus_defconfig
arm                         axm55xx_defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
powerpc                    amigaone_defconfig
powerpc64                           defconfig
ia64                        generic_defconfig
arm                        magician_defconfig
sh                         ecovec24_defconfig
powerpc                      tqm8xx_defconfig
arm                         hackkit_defconfig
arm                        shmobile_defconfig
ia64                             alldefconfig
xtensa                  nommu_kc705_defconfig
m68k                       m5475evb_defconfig
arc                      axs103_smp_defconfig
arm                      pxa255-idp_defconfig
arm                          collie_defconfig
mips                     cu1830-neo_defconfig
m68k                        m5407c3_defconfig
arm                          ep93xx_defconfig
powerpc                     akebono_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          lboxre2_defconfig
openrisc                            defconfig
sh                          r7785rp_defconfig
ia64                          tiger_defconfig
sh                           se7343_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                      cm5200_defconfig
arm                           sama7_defconfig
arm                       spear13xx_defconfig
mips                        vocore2_defconfig
arm                    vt8500_v6_v7_defconfig
mips                       rbtx49xx_defconfig
ia64                      gensparse_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                             allyesconfig
arm                            zeus_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     ep8248e_defconfig
sh                          sdk7786_defconfig
powerpc                      acadia_defconfig
arm                             ezx_defconfig
s390                       zfcpdump_defconfig
arm                       aspeed_g4_defconfig
powerpc                      pasemi_defconfig
arc                              alldefconfig
ia64                            zx1_defconfig
mips                          ath79_defconfig
arm                  randconfig-c002-20211123
arm                  randconfig-c002-20211122
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
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20211123
x86_64               randconfig-a003-20211123
x86_64               randconfig-a006-20211123
x86_64               randconfig-a004-20211123
x86_64               randconfig-a005-20211123
x86_64               randconfig-a002-20211123
x86_64               randconfig-a011-20211122
x86_64               randconfig-a012-20211122
x86_64               randconfig-a013-20211122
x86_64               randconfig-a014-20211122
x86_64               randconfig-a015-20211122
x86_64               randconfig-a016-20211122
i386                 randconfig-a016-20211122
i386                 randconfig-a015-20211122
i386                 randconfig-a012-20211122
i386                 randconfig-a013-20211122
i386                 randconfig-a014-20211122
i386                 randconfig-a011-20211122
arc                  randconfig-r043-20211122
s390                 randconfig-r044-20211122
riscv                randconfig-r042-20211122
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
i386                 randconfig-a001-20211122
i386                 randconfig-a002-20211122
i386                 randconfig-a005-20211122
i386                 randconfig-a006-20211122
i386                 randconfig-a004-20211122
i386                 randconfig-a003-20211122
x86_64               randconfig-a001-20211122
x86_64               randconfig-a003-20211122
x86_64               randconfig-a006-20211122
x86_64               randconfig-a004-20211122
x86_64               randconfig-a005-20211122
x86_64               randconfig-a002-20211122
hexagon              randconfig-r045-20211122
hexagon              randconfig-r041-20211122
hexagon              randconfig-r045-20211123
s390                 randconfig-r044-20211123
hexagon              randconfig-r041-20211123
riscv                randconfig-r042-20211123

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
