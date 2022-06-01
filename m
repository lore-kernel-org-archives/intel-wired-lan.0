From: kernel test robot <lkp@intel.com>
Date: Wed, 01 Jun 2022 17:01:51 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 02ae2726bced6aa95cd63a885847b98c874ba4d0
Message-ID: <62972aff.RwdSZ9KBgOHlYhmP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 02ae2726bced6aa95cd63a885847b98c874ba4d0  i40e: Fix dropped jumbo frames statistics

elapsed time: 730m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                  sh7785lcr_32bit_defconfig
arm64                            alldefconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
powerpc                     pq2fads_defconfig
openrisc                 simple_smp_defconfig
powerpc                     tqm8555_defconfig
mips                       capcella_defconfig
arm                           tegra_defconfig
arm                        shmobile_defconfig
sh                          rsk7201_defconfig
arc                           tb10x_defconfig
sh                          sdk7786_defconfig
arm                        realview_defconfig
powerpc                     stx_gp3_defconfig
ia64                         bigsur_defconfig
sh                        dreamcast_defconfig
parisc                generic-64bit_defconfig
sh                          r7780mp_defconfig
mips                         bigsur_defconfig
arm                        cerfcube_defconfig
parisc64                            defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220531
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220531
s390                 randconfig-r044-20220531
riscv                randconfig-r042-20220531
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220531
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220531
arm                  randconfig-c002-20220531
powerpc              randconfig-c003-20220531
riscv                randconfig-c006-20220531
mips                        workpad_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm5200_defconfig
arm                           sama7_defconfig
arm                         shannon_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     skiroot_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0287_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
