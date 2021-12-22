From: kernel test robot <lkp@intel.com>
Date: Thu, 23 Dec 2021 02:23:23 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 13a64f0b9894886b2c08ab84de209735abf5a789
Message-ID: <61c36d1b.eWudDLzy+IdBa6cF%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 13a64f0b9894886b2c08ab84de209735abf5a789  ice: support crosstimestamping on E822 devices if supported

elapsed time: 1416m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
sh                        edosk7760_defconfig
powerpc                        fsp2_defconfig
mips                    maltaup_xpa_defconfig
arm                        magician_defconfig
arm                          collie_defconfig
mips                  cavium_octeon_defconfig
powerpc                      pcm030_defconfig
powerpc                     pseries_defconfig
arm                         vf610m4_defconfig
xtensa                          iss_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                  storcenter_defconfig
powerpc                     tqm8541_defconfig
sh                          r7780mp_defconfig
sh                         apsh4a3a_defconfig
arm                           stm32_defconfig
arm                             pxa_defconfig
sh                          rsk7203_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
powerpc                      katmai_defconfig
mips                      bmips_stb_defconfig
sh                            shmin_defconfig
arm                         cm_x300_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
mips                           ip32_defconfig
m68k                             allyesconfig
sh                               j2_defconfig
arm                          exynos_defconfig
ia64                      gensparse_defconfig
arm                  randconfig-c002-20211222
arm                  randconfig-c002-20211220
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a002-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a002-20211222
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a001-20211222
i386                 randconfig-a005-20211222
arc                  randconfig-r043-20211220
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
i386                 randconfig-a004-20211221
i386                 randconfig-a002-20211221
i386                 randconfig-a003-20211221
i386                 randconfig-a005-20211221
i386                 randconfig-a001-20211221
i386                 randconfig-a006-20211221
x86_64               randconfig-a013-20211222
x86_64               randconfig-a012-20211222
x86_64               randconfig-a011-20211222
x86_64               randconfig-a015-20211222
x86_64               randconfig-a016-20211222
x86_64               randconfig-a014-20211222
i386                 randconfig-a012-20211222
i386                 randconfig-a011-20211222
i386                 randconfig-a014-20211222
i386                 randconfig-a015-20211222
i386                 randconfig-a013-20211222
i386                 randconfig-a016-20211222
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
s390                 randconfig-r044-20211220
riscv                randconfig-r042-20211220
hexagon              randconfig-r041-20211222
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
