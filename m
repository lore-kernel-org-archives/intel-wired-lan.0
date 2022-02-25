From: kernel test robot <lkp@intel.com>
Date: Fri, 25 Feb 2022 17:15:59 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 9e7b78dc8826cd8ddacb68a940a17776110cc224
Message-ID: <62189e4f.LvnhUPOuSVAl1jlB%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 9e7b78dc8826cd8ddacb68a940a17776110cc224  Merge branch '10GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue

elapsed time: 743m

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
i386                          randconfig-c001
mips                 randconfig-c004-20220223
powerpc              randconfig-c003-20220225
mips                 randconfig-c004-20220225
arm                            zeus_defconfig
powerpc                       maple_defconfig
arm                        spear6xx_defconfig
powerpc                     sequoia_defconfig
microblaze                      mmu_defconfig
powerpc                  iss476-smp_defconfig
arm                         axm55xx_defconfig
nios2                            allyesconfig
xtensa                          iss_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                         wii_defconfig
powerpc64                        alldefconfig
sh                           se7750_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc834x_mds_defconfig
sh                     magicpanelr2_defconfig
mips                         rt305x_defconfig
arm                           sama5_defconfig
arm64                            alldefconfig
sh                            shmin_defconfig
x86_64                              defconfig
powerpc                     mpc83xx_defconfig
mips                         db1xxx_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                        keystone_defconfig
sparc                               defconfig
m68k                          amiga_defconfig
mips                       bmips_be_defconfig
sh                            migor_defconfig
xtensa                    xip_kc705_defconfig
arc                    vdk_hs38_smp_defconfig
sh                           se7780_defconfig
powerpc                      tqm8xx_defconfig
arm                     eseries_pxa_defconfig
sh                           se7712_defconfig
m68k                        m5272c3_defconfig
sh                          lboxre2_defconfig
arc                            hsdk_defconfig
arm                          gemini_defconfig
arm                         s3c6400_defconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     tqm8555_defconfig
h8300                               defconfig
arc                          axs103_defconfig
arm                  randconfig-c002-20220224
arm                  randconfig-c002-20220223
arm                  randconfig-c002-20220225
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
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
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
s390                 randconfig-r044-20220224
arc                  randconfig-r043-20220224
arc                  randconfig-r043-20220223
riscv                randconfig-r042-20220224
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
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
powerpc              randconfig-c003-20220224
x86_64                        randconfig-c007
arm                  randconfig-c002-20220224
mips                 randconfig-c004-20220224
i386                          randconfig-c001
riscv                randconfig-c006-20220224
powerpc              randconfig-c003-20220223
arm                  randconfig-c002-20220223
mips                 randconfig-c004-20220223
riscv                randconfig-c006-20220223
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
riscv                    nommu_virt_defconfig
arm                         socfpga_defconfig
mips                           ip22_defconfig
arm                          moxart_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220223
hexagon              randconfig-r041-20220223
riscv                randconfig-r042-20220223
hexagon              randconfig-r045-20220224
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220224
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
