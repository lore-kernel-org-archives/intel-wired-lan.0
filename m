From: kernel test robot <lkp@intel.com>
Date: Tue, 02 Nov 2021 21:35:12 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 047304d0bfa5be2ace106974f87eec51e0832cd0
Message-ID: <61813e90.YEKjmB0qr+icxjyU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 047304d0bfa5be2ace106974f87eec51e0832cd0  netdevsim: fix uninit value in nsim_drv_configure_vfs()

elapsed time: 800m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
s390                       zfcpdump_defconfig
arc                        nsim_700_defconfig
powerpc                     sequoia_defconfig
mips                           ip32_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        mvebu_v7_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
arc                          axs103_defconfig
powerpc                   bluestone_defconfig
arm                          moxart_defconfig
mips                           gcw0_defconfig
arm                           corgi_defconfig
mips                malta_qemu_32r6_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
powerpc                      ep88xc_defconfig
arm                           spitz_defconfig
arm                      jornada720_defconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
m68k                       m5475evb_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v5_defconfig
microblaze                      mmu_defconfig
mips                     decstation_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
s390                             alldefconfig
arm                         orion5x_defconfig
arm                  randconfig-c002-20211101
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20211101
x86_64               randconfig-a015-20211101
x86_64               randconfig-a016-20211101
x86_64               randconfig-a013-20211101
x86_64               randconfig-a011-20211101
x86_64               randconfig-a014-20211101
i386                 randconfig-a016-20211101
i386                 randconfig-a014-20211101
i386                 randconfig-a015-20211101
i386                 randconfig-a013-20211101
i386                 randconfig-a011-20211101
i386                 randconfig-a012-20211101
arc                  randconfig-r043-20211101
riscv                randconfig-r042-20211101
s390                 randconfig-r044-20211101
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
x86_64               randconfig-a004-20211101
x86_64               randconfig-a006-20211101
x86_64               randconfig-a001-20211101
x86_64               randconfig-a002-20211101
x86_64               randconfig-a003-20211101
x86_64               randconfig-a005-20211101
i386                 randconfig-a005-20211101
i386                 randconfig-a006-20211101
i386                 randconfig-a001-20211101
i386                 randconfig-a003-20211101
i386                 randconfig-a004-20211101
i386                 randconfig-a002-20211101
hexagon              randconfig-r041-20211101
hexagon              randconfig-r045-20211101

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
