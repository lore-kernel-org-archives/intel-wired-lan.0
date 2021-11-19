From: kernel test robot <lkp@intel.com>
Date: Fri, 19 Nov 2021 13:56:56 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 666d28d92bc2d230db50e78eab57b08742cc8942
Message-ID: <61973ca8.pH8dctqe4IsYGZ9m%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 666d28d92bc2d230db50e78eab57b08742cc8942  ice: fix choosing UDP header type

elapsed time: 729m

configs tested: 140
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
mips                 randconfig-c004-20211118
arm                         shannon_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
powerpc                      cm5200_defconfig
m68k                          sun3x_defconfig
m68k                           sun3_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                  colibri_pxa300_defconfig
arm                           h3600_defconfig
arc                    vdk_hs38_smp_defconfig
riscv                    nommu_virt_defconfig
mips                   sb1250_swarm_defconfig
powerpc                      pcm030_defconfig
arm                     eseries_pxa_defconfig
powerpc                     powernv_defconfig
mips                malta_qemu_32r6_defconfig
csky                                defconfig
sh                 kfr2r09-romimage_defconfig
mips                           jazz_defconfig
mips                       capcella_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     davinci_all_defconfig
powerpc                      pasemi_defconfig
powerpc                       ppc64_defconfig
mips                          ath25_defconfig
xtensa                           alldefconfig
arc                          axs103_defconfig
mips                      bmips_stb_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
sh                        edosk7760_defconfig
arm                      pxa255-idp_defconfig
arm                     am200epdkit_defconfig
sh                   sh7724_generic_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
arm                          pxa168_defconfig
m68k                          multi_defconfig
arm                              alldefconfig
powerpc                       holly_defconfig
arm                        mini2440_defconfig
mips                       bmips_be_defconfig
sh                           se7619_defconfig
arm                         cm_x300_defconfig
sh                          r7780mp_defconfig
powerpc                      obs600_defconfig
csky                             alldefconfig
mips                        bcm47xx_defconfig
arm                       spear13xx_defconfig
sh                           se7722_defconfig
openrisc                            defconfig
ia64                             alldefconfig
arm                  randconfig-c002-20211118
arm                  randconfig-c002-20211119
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
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a015-20211118
x86_64               randconfig-a012-20211118
x86_64               randconfig-a011-20211118
x86_64               randconfig-a013-20211118
x86_64               randconfig-a016-20211118
x86_64               randconfig-a014-20211118
i386                 randconfig-a016-20211118
i386                 randconfig-a014-20211118
i386                 randconfig-a012-20211118
i386                 randconfig-a011-20211118
i386                 randconfig-a013-20211118
i386                 randconfig-a015-20211118
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
i386                 randconfig-c001-20211118
x86_64               randconfig-c007-20211118
arm                  randconfig-c002-20211118
s390                 randconfig-c005-20211118
powerpc              randconfig-c003-20211118
riscv                randconfig-c006-20211118
mips                 randconfig-c004-20211118
x86_64               randconfig-a005-20211118
x86_64               randconfig-a003-20211118
x86_64               randconfig-a001-20211118
x86_64               randconfig-a002-20211118
x86_64               randconfig-a006-20211118
x86_64               randconfig-a004-20211118
i386                 randconfig-a006-20211118
i386                 randconfig-a003-20211118
i386                 randconfig-a001-20211118
i386                 randconfig-a005-20211118
i386                 randconfig-a004-20211118
i386                 randconfig-a002-20211118
hexagon              randconfig-r045-20211118
hexagon              randconfig-r041-20211118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
