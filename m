From: kernel test robot <lkp@intel.com>
Date: Sun, 21 Feb 2021 17:50:31 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 dbf6182dbea6fb836e882ea53202248338323f75
Message-ID: <60322ce7.SKtAtwZ7g8zEO2Fc%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: dbf6182dbea6fb836e882ea53202248338323f75  igc: Fix Supported Pause Frame Link Setting

elapsed time: 720m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
arm                             rpc_defconfig
x86_64                           alldefconfig
mips                       bmips_be_defconfig
powerpc                   motionpro_defconfig
mips                     decstation_defconfig
mips                      malta_kvm_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7722_defconfig
arm                         at91_dt_defconfig
arm                       aspeed_g5_defconfig
sh                   sh7770_generic_defconfig
mips                       rbtx49xx_defconfig
m68k                       m5475evb_defconfig
mips                         bigsur_defconfig
arm                           stm32_defconfig
m68k                       m5275evb_defconfig
mips                      pistachio_defconfig
nios2                               defconfig
sh                               allmodconfig
ia64                          tiger_defconfig
mips                           rs90_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm8541_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
arm                            xcep_defconfig
mips                        nlm_xlr_defconfig
mips                      maltaaprp_defconfig
alpha                            allyesconfig
arm                            u300_defconfig
um                            kunit_defconfig
arm                        oxnas_v6_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210221
i386                 randconfig-a006-20210221
i386                 randconfig-a004-20210221
i386                 randconfig-a003-20210221
i386                 randconfig-a001-20210221
i386                 randconfig-a002-20210221
x86_64               randconfig-a015-20210221
x86_64               randconfig-a011-20210221
x86_64               randconfig-a012-20210221
x86_64               randconfig-a016-20210221
x86_64               randconfig-a014-20210221
x86_64               randconfig-a013-20210221
i386                 randconfig-a013-20210221
i386                 randconfig-a012-20210221
i386                 randconfig-a011-20210221
i386                 randconfig-a014-20210221
i386                 randconfig-a016-20210221
i386                 randconfig-a015-20210221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210221
x86_64               randconfig-a002-20210221
x86_64               randconfig-a003-20210221
x86_64               randconfig-a005-20210221
x86_64               randconfig-a006-20210221
x86_64               randconfig-a004-20210221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
