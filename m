From: kernel test robot <lkp@intel.com>
Date: Tue, 22 Mar 2022 19:58:37 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 23f3121aca93daf4644c2e445c9823c741bf98ff
Message-ID: <6239b9ed.bI63De+vXsEgErl1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 23f3121aca93daf4644c2e445c9823c741bf98ff  ice: switch: convert packet template match code to rodata

elapsed time: 725m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                 randconfig-c001-20220321
mips                      maltasmvp_defconfig
arm                         cm_x300_defconfig
sh                             sh03_defconfig
powerpc                   currituck_defconfig
sh                            titan_defconfig
xtensa                  nommu_kc705_defconfig
ia64                      gensparse_defconfig
sh                        sh7785lcr_defconfig
powerpc64                           defconfig
powerpc                 mpc837x_rdb_defconfig
sh                        sh7757lcr_defconfig
sh                         microdev_defconfig
h8300                     edosk2674_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                              ul2_defconfig
um                                  defconfig
arm                  randconfig-c002-20220320
arm                  randconfig-c002-20220321
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a013-20220321
x86_64               randconfig-a012-20220321
x86_64               randconfig-a011-20220321
x86_64               randconfig-a016-20220321
x86_64               randconfig-a015-20220321
x86_64               randconfig-a014-20220321
i386                 randconfig-a014-20220321
i386                 randconfig-a013-20220321
i386                 randconfig-a011-20220321
i386                 randconfig-a012-20220321
i386                 randconfig-a016-20220321
i386                 randconfig-a015-20220321
arc                  randconfig-r043-20220322
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                           allyesconfig

clang tested configs:
powerpc                 mpc832x_rdb_defconfig
mips                         tb0287_defconfig
mips                          ath79_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        neponset_defconfig
i386                 randconfig-a003-20220321
i386                 randconfig-a004-20220321
i386                 randconfig-a005-20220321
i386                 randconfig-a001-20220321
i386                 randconfig-a006-20220321
i386                 randconfig-a002-20220321
x86_64               randconfig-a002-20220321
x86_64               randconfig-a003-20220321
x86_64               randconfig-a004-20220321
x86_64               randconfig-a001-20220321
x86_64               randconfig-a005-20220321
x86_64               randconfig-a006-20220321
hexagon              randconfig-r045-20220322
hexagon              randconfig-r041-20220322
riscv                randconfig-r042-20220322
s390                 randconfig-r044-20220322

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
