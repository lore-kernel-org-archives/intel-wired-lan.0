From: kernel test robot <lkp@intel.com>
Date: Fri, 23 Jul 2021 19:26:32 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 6a5961bf9e006306f36dad7e2e1497b6eaf35bd8
Message-ID: <60faa768.qZlwR6j2w4+31Oc+%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 6a5961bf9e006306f36dad7e2e1497b6eaf35bd8  i40e: Fix pre-set max number of queues for VF

elapsed time: 1166m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210723
i386                 randconfig-c001-20210722
arm                       aspeed_g4_defconfig
arm                            qcom_defconfig
sh                          r7780mp_defconfig
arm                          ep93xx_defconfig
xtensa                          iss_defconfig
mips                  decstation_64_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
powerpc                        fsp2_defconfig
arm                         vf610m4_defconfig
m68k                                defconfig
arm                            zeus_defconfig
powerpc                     sbc8548_defconfig
xtensa                  audio_kc705_defconfig
sh                              ul2_defconfig
arm                         axm55xx_defconfig
mips                     loongson2k_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
m68k                            q40_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           rs90_defconfig
powerpc                     tqm8540_defconfig
powerpc                     pq2fads_defconfig
riscv                            allyesconfig
mips                           ci20_defconfig
openrisc                    or1ksim_defconfig
powerpc                           allnoconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20210722
x86_64               randconfig-a006-20210722
x86_64               randconfig-a001-20210722
x86_64               randconfig-a005-20210722
x86_64               randconfig-a004-20210722
x86_64               randconfig-a002-20210722
i386                 randconfig-a005-20210722
i386                 randconfig-a003-20210722
i386                 randconfig-a004-20210722
i386                 randconfig-a002-20210722
i386                 randconfig-a001-20210722
i386                 randconfig-a006-20210722
i386                 randconfig-a005-20210723
i386                 randconfig-a003-20210723
i386                 randconfig-a004-20210723
i386                 randconfig-a002-20210723
i386                 randconfig-a001-20210723
i386                 randconfig-a006-20210723
x86_64               randconfig-a011-20210723
x86_64               randconfig-a016-20210723
x86_64               randconfig-a013-20210723
x86_64               randconfig-a014-20210723
x86_64               randconfig-a012-20210723
x86_64               randconfig-a015-20210723
i386                 randconfig-a016-20210723
i386                 randconfig-a013-20210723
i386                 randconfig-a012-20210723
i386                 randconfig-a011-20210723
i386                 randconfig-a014-20210723
i386                 randconfig-a015-20210723
i386                 randconfig-a016-20210722
i386                 randconfig-a013-20210722
i386                 randconfig-a012-20210722
i386                 randconfig-a011-20210722
i386                 randconfig-a014-20210722
i386                 randconfig-a015-20210722
riscv                    nommu_k210_defconfig
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210723
x86_64               randconfig-c001-20210722
x86_64               randconfig-b001-20210722
x86_64               randconfig-b001-20210723
x86_64               randconfig-a003-20210723
x86_64               randconfig-a006-20210723
x86_64               randconfig-a001-20210723
x86_64               randconfig-a005-20210723
x86_64               randconfig-a004-20210723
x86_64               randconfig-a002-20210723
x86_64               randconfig-a011-20210722
x86_64               randconfig-a016-20210722
x86_64               randconfig-a013-20210722
x86_64               randconfig-a014-20210722
x86_64               randconfig-a012-20210722
x86_64               randconfig-a015-20210722

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
