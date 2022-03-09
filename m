From: kernel test robot <lkp@intel.com>
Date: Wed, 09 Mar 2022 23:41:19 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 ad35ffa252af67d4cc7c744b9377a2b577748e3f
Message-ID: <6228ca9f.0tQmdm91606EtgvY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: ad35ffa252af67d4cc7c744b9377a2b577748e3f  ice: Fix curr_link_speed advertised speed

elapsed time: 728m

configs tested: 133
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                    klondike_defconfig
sh                   secureedge5410_defconfig
openrisc                 simple_smp_defconfig
m68k                          multi_defconfig
nios2                            alldefconfig
arm                        keystone_defconfig
microblaze                      mmu_defconfig
arm                           stm32_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          lpd270_defconfig
arc                          axs103_defconfig
sh                           se7722_defconfig
m68k                             alldefconfig
arm                         s3c6400_defconfig
mips                           xway_defconfig
ia64                          tiger_defconfig
h8300                     edosk2674_defconfig
xtensa                generic_kc705_defconfig
powerpc                     ep8248e_defconfig
sh                        apsh4ad0a_defconfig
sparc                       sparc32_defconfig
um                               alldefconfig
powerpc                        cell_defconfig
sh                   rts7751r2dplus_defconfig
sh                   sh7724_generic_defconfig
arm                        mini2440_defconfig
sh                           se7206_defconfig
xtensa                          iss_defconfig
arc                      axs103_smp_defconfig
powerpc                      arches_defconfig
microblaze                          defconfig
arm                  randconfig-c002-20220309
arm                  randconfig-c002-20220308
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
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
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
arc                  randconfig-r043-20220309
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
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220309
powerpc              randconfig-c003-20220309
i386                          randconfig-c001
arm                  randconfig-c002-20220309
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
mips                           ip22_defconfig
mips                         tb0219_defconfig
arm                           spitz_defconfig
arm                       cns3420vb_defconfig
powerpc                     pseries_defconfig
arm                         s3c2410_defconfig
powerpc                          allyesconfig
arm                           sama7_defconfig
mips                            e55_defconfig
powerpc                     ppa8548_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
arm                  colibri_pxa300_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          ath25_defconfig
powerpc                     skiroot_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       netwinder_defconfig
powerpc                      katmai_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220309
hexagon              randconfig-r041-20220309
riscv                randconfig-r042-20220309
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
