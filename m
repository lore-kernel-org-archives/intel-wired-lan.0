From: kernel test robot <lkp@intel.com>
Date: Thu, 23 Dec 2021 02:23:11 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 37cf276df1014aa4647ae364bde878041053b40d
Message-ID: <61c36d0f.+71AXAHKdxFrj+3p%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: 37cf276df1014aa4647ae364bde878041053b40d  fm10k: Fix syntax errors in comments

elapsed time: 1416m

configs tested: 151
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
arm                       aspeed_g4_defconfig
m68k                         apollo_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8541_defconfig
sh                          r7780mp_defconfig
sh                         apsh4a3a_defconfig
arm                           stm32_defconfig
arm                             pxa_defconfig
sh                          rsk7203_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
powerpc                      katmai_defconfig
xtensa                           allyesconfig
powerpc                  mpc866_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           rs90_defconfig
mips                          ath25_defconfig
arm                  colibri_pxa300_defconfig
sh                          landisk_defconfig
xtensa                  audio_kc705_defconfig
sh                            shmin_defconfig
mips                        vocore2_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
powerpc64                           defconfig
ia64                             allyesconfig
powerpc                     kilauea_defconfig
arm                         cm_x300_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
mips                           ip32_defconfig
m68k                             allyesconfig
xtensa                          iss_defconfig
sh                          sdk7786_defconfig
sparc                       sparc64_defconfig
arm                         lpc32xx_defconfig
arm                          pxa168_defconfig
powerpc                      makalu_defconfig
arm                        trizeps4_defconfig
arm                          moxart_defconfig
powerpc                     tqm8555_defconfig
arm                         mv78xx0_defconfig
arm                          lpd270_defconfig
mips                           gcw0_defconfig
mips                  decstation_64_defconfig
sh                        sh7785lcr_defconfig
sh                               j2_defconfig
sparc                       sparc32_defconfig
arm                  randconfig-c002-20211222
arm                  randconfig-c002-20211220
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
i386                   debian-10.3-kselftests
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
i386                 randconfig-a002-20211220
i386                 randconfig-a003-20211220
i386                 randconfig-a001-20211220
i386                 randconfig-a006-20211220
i386                 randconfig-a004-20211220
i386                 randconfig-a005-20211220
i386                 randconfig-a005-20211222
x86_64               randconfig-a001-20211220
x86_64               randconfig-a003-20211220
x86_64               randconfig-a005-20211220
x86_64               randconfig-a006-20211220
x86_64               randconfig-a004-20211220
x86_64               randconfig-a002-20211220
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a013-20211222
x86_64               randconfig-a015-20211222
x86_64               randconfig-a014-20211222
x86_64               randconfig-a012-20211222
x86_64               randconfig-a011-20211222
x86_64               randconfig-a016-20211222
i386                 randconfig-a012-20211222
i386                 randconfig-a011-20211222
i386                 randconfig-a013-20211222
i386                 randconfig-a015-20211222
i386                 randconfig-a014-20211222
i386                 randconfig-a016-20211222
hexagon              randconfig-r041-20211220
hexagon              randconfig-r045-20211220
riscv                randconfig-r042-20211220
s390                 randconfig-r044-20211220
hexagon              randconfig-r041-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222
hexagon              randconfig-r045-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
