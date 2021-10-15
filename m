From: kernel test robot <lkp@intel.com>
Date: Fri, 15 Oct 2021 18:31:24 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 325b2064d00a88d10c511c96adea4e8274778ee1
Message-ID: <6169587c.EYBfEgbtktSXMhOb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 325b2064d00a88d10c511c96adea4e8274778ee1  ice: Implement support for SMA and U.FL on E810-T

elapsed time: 1129m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
i386                 randconfig-c001-20211014
sh                                  defconfig
powerpc                 linkstation_defconfig
powerpc                     mpc83xx_defconfig
ia64                            zx1_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    socrates_defconfig
powerpc                       ebony_defconfig
powerpc                     kmeter1_defconfig
s390                       zfcpdump_defconfig
mips                        qi_lb60_defconfig
arm                  colibri_pxa270_defconfig
powerpc                     tqm8560_defconfig
xtensa                         virt_defconfig
mips                         bigsur_defconfig
arc                              alldefconfig
m68k                            q40_defconfig
sh                        edosk7760_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                   lite5200b_defconfig
arm                         orion5x_defconfig
m68k                             allyesconfig
sh                      rts7751r2d1_defconfig
arc                                 defconfig
riscv                            alldefconfig
powerpc                      ppc40x_defconfig
m68k                           sun3_defconfig
m68k                        stmark2_defconfig
powerpc                      tqm8xx_defconfig
mips                  cavium_octeon_defconfig
powerpc                    gamecube_defconfig
sparc                       sparc32_defconfig
mips                       lemote2f_defconfig
riscv                    nommu_k210_defconfig
sh                           se7206_defconfig
sh                           se7722_defconfig
arm                         s3c6400_defconfig
powerpc                     tqm8540_defconfig
powerpc                         ps3_defconfig
openrisc                  or1klitex_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
mips                      malta_kvm_defconfig
powerpc                      arches_defconfig
mips                        bcm47xx_defconfig
xtensa                              defconfig
riscv                            allmodconfig
arm                         socfpga_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm5200_defconfig
mips                          rb532_defconfig
sh                        dreamcast_defconfig
arm                          gemini_defconfig
powerpc                      pasemi_defconfig
m68k                         apollo_defconfig
arm                       imx_v6_v7_defconfig
sh                            migor_defconfig
powerpc                     stx_gp3_defconfig
arm                  colibri_pxa300_defconfig
s390                          debug_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
m68k                          hp300_defconfig
ia64                                defconfig
riscv                          rv32_defconfig
sh                        sh7757lcr_defconfig
arm                  randconfig-c002-20211014
x86_64               randconfig-c001-20211014
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211014
x86_64               randconfig-a004-20211014
x86_64               randconfig-a001-20211014
x86_64               randconfig-a005-20211014
x86_64               randconfig-a002-20211014
x86_64               randconfig-a003-20211014
i386                 randconfig-a003-20211014
i386                 randconfig-a001-20211014
i386                 randconfig-a005-20211014
i386                 randconfig-a004-20211014
i386                 randconfig-a002-20211014
i386                 randconfig-a006-20211014
arc                  randconfig-r043-20211014
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211014
i386                 randconfig-c001-20211014
s390                 randconfig-c005-20211014
x86_64               randconfig-c007-20211014
powerpc              randconfig-c003-20211014
riscv                randconfig-c006-20211014
x86_64               randconfig-a012-20211014
x86_64               randconfig-a015-20211014
x86_64               randconfig-a016-20211014
x86_64               randconfig-a014-20211014
x86_64               randconfig-a011-20211014
x86_64               randconfig-a013-20211014
i386                 randconfig-a016-20211014
i386                 randconfig-a014-20211014
i386                 randconfig-a011-20211014
i386                 randconfig-a015-20211014
i386                 randconfig-a012-20211014
i386                 randconfig-a013-20211014
hexagon              randconfig-r041-20211014
s390                 randconfig-r044-20211014
riscv                randconfig-r042-20211014
hexagon              randconfig-r045-20211014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
