From: kernel test robot <lkp@intel.com>
Date: Wed, 26 May 2021 19:32:50 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 b8e5d8f9c702b5808febb7c86a2689ed8ef0baf8
Message-ID: <60ae31e2.8FqM2OpHrVRp5MEb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: b8e5d8f9c702b5808febb7c86a2689ed8ef0baf8  i40e: Add restoration of VF MSI-X state during PCI reset

elapsed time: 730m

configs tested: 141
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
csky                                defconfig
arm                       multi_v4t_defconfig
mips                           ip22_defconfig
m68k                             allyesconfig
powerpc                     redwood_defconfig
mips                        omega2p_defconfig
arm                            xcep_defconfig
powerpc                       eiger_defconfig
mips                  cavium_octeon_defconfig
powerpc                      obs600_defconfig
mips                            ar7_defconfig
sh                           se7712_defconfig
arm                          iop32x_defconfig
arc                              alldefconfig
powerpc                    ge_imp3a_defconfig
um                               allmodconfig
powerpc                     pq2fads_defconfig
arm                         at91_dt_defconfig
powerpc                       holly_defconfig
sh                          rsk7269_defconfig
sh                         microdev_defconfig
powerpc                        fsp2_defconfig
arm                       netwinder_defconfig
powerpc                  mpc866_ads_defconfig
sh                          sdk7780_defconfig
arm                          pxa168_defconfig
sh                          lboxre2_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
mips                    maltaup_xpa_defconfig
arm                         orion5x_defconfig
mips                           ip28_defconfig
mips                         db1xxx_defconfig
sh                          sdk7786_defconfig
arm                            pleb_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       spear13xx_defconfig
arm                         cm_x300_defconfig
mips                          rm200_defconfig
sparc64                             defconfig
arm                           omap1_defconfig
mips                         mpc30x_defconfig
csky                             alldefconfig
sparc                       sparc32_defconfig
sh                           se7343_defconfig
sh                           se7619_defconfig
arc                          axs101_defconfig
sh                           se7724_defconfig
powerpc               mpc834x_itxgp_defconfig
parisc                generic-32bit_defconfig
arm                         lpc18xx_defconfig
arm                            qcom_defconfig
mips                      fuloong2e_defconfig
sparc                       sparc64_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          malta_defconfig
powerpc                         wii_defconfig
powerpc                      tqm8xx_defconfig
um                               allyesconfig
powerpc                   currituck_defconfig
mips                          ath25_defconfig
arm                        oxnas_v6_defconfig
x86_64                            allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
