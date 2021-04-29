From: kernel test robot <lkp@intel.com>
Date: Thu, 29 Apr 2021 12:00:06 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 0d20bffdab2ac8d7fa2dac91ea77846c6d198919
Message-ID: <608a2f46.D0pwbOEqE2Or1Mag%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 0d20bffdab2ac8d7fa2dac91ea77846c6d198919  ice: Enable configuration of number of qps per VF via devlink

elapsed time: 720m

configs tested: 129
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
arm                        keystone_defconfig
sh                            shmin_defconfig
mips                          ath25_defconfig
s390                          debug_defconfig
sh                         ap325rxa_defconfig
mips                        qi_lb60_defconfig
m68k                             alldefconfig
arm                       mainstone_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
mips                           ci20_defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
arm                        cerfcube_defconfig
sh                        edosk7705_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
sh                           se7750_defconfig
arc                                 defconfig
mips                        bcm47xx_defconfig
powerpc                     ksi8560_defconfig
arm                        mini2440_defconfig
arm                          iop32x_defconfig
mips                  decstation_64_defconfig
arm                            qcom_defconfig
sh                               j2_defconfig
xtensa                          iss_defconfig
mips                         tb0287_defconfig
mips                     cu1830-neo_defconfig
powerpc                   bluestone_defconfig
arm                        clps711x_defconfig
arm                             rpc_defconfig
powerpc                      ppc44x_defconfig
sh                          rsk7201_defconfig
arm                       omap2plus_defconfig
i386                             alldefconfig
m68k                         apollo_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      bamboo_defconfig
powerpc                      makalu_defconfig
powerpc                      obs600_defconfig
arc                         haps_hs_defconfig
m68k                          sun3x_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                           ip22_defconfig
arm                    vt8500_v6_v7_defconfig
sh                         microdev_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         nhk8815_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210428
i386                 randconfig-a002-20210428
i386                 randconfig-a001-20210428
i386                 randconfig-a006-20210428
i386                 randconfig-a003-20210428
i386                 randconfig-a004-20210428
x86_64               randconfig-a015-20210428
x86_64               randconfig-a016-20210428
x86_64               randconfig-a011-20210428
x86_64               randconfig-a014-20210428
x86_64               randconfig-a013-20210428
x86_64               randconfig-a012-20210428
i386                 randconfig-a012-20210428
i386                 randconfig-a014-20210428
i386                 randconfig-a013-20210428
i386                 randconfig-a011-20210428
i386                 randconfig-a015-20210428
i386                 randconfig-a016-20210428
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210428
x86_64               randconfig-a002-20210428
x86_64               randconfig-a005-20210428
x86_64               randconfig-a006-20210428
x86_64               randconfig-a001-20210428
x86_64               randconfig-a003-20210428

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
