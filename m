From: kernel test robot <lkp@intel.com>
Date: Tue, 22 Jun 2021 18:56:53 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 3717c1342e201571591f4602ca40b1858f15b47d
Message-ID: <60d1c1f5.lVobTUPDAXmHk65o%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 3717c1342e201571591f4602ca40b1858f15b47d  ice: Fix a memory leak in an error handling path in 'ice_pf_dcb_cfg()'

elapsed time: 726m

configs tested: 145
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
m68k                        mvme16x_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
powerpc                      obs600_defconfig
arm                            mmp2_defconfig
sh                           se7721_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         at91_dt_defconfig
mips                         db1xxx_defconfig
arc                        nsimosci_defconfig
arm                       imx_v4_v5_defconfig
alpha                            alldefconfig
powerpc                      ppc64e_defconfig
microblaze                          defconfig
mips                         tb0219_defconfig
sh                          r7785rp_defconfig
arm                       spear13xx_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         rt305x_defconfig
arm                        keystone_defconfig
arm                          exynos_defconfig
mips                       lemote2f_defconfig
mips                        workpad_defconfig
ia64                        generic_defconfig
arm                        multi_v5_defconfig
sh                           se7619_defconfig
arm                       aspeed_g5_defconfig
arc                        nsim_700_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
sh                          lboxre2_defconfig
arc                          axs101_defconfig
xtensa                       common_defconfig
ia64                             alldefconfig
m68k                         apollo_defconfig
mips                           jazz_defconfig
mips                        jmr3927_defconfig
m68k                          hp300_defconfig
parisc                           alldefconfig
mips                        vocore2_defconfig
powerpc                  mpc866_ads_defconfig
h8300                     edosk2674_defconfig
powerpc                   lite5200b_defconfig
sh                           se7722_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
ia64                         bigsur_defconfig
sh                 kfr2r09-romimage_defconfig
mips                        omega2p_defconfig
m68k                         amcore_defconfig
xtensa                  nommu_kc705_defconfig
mips                          malta_defconfig
powerpc                     tqm8548_defconfig
arm                       multi_v4t_defconfig
ia64                            zx1_defconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a002-20210621
x86_64               randconfig-a001-20210621
x86_64               randconfig-a005-20210621
x86_64               randconfig-a003-20210621
x86_64               randconfig-a004-20210621
x86_64               randconfig-a006-20210621
i386                 randconfig-a002-20210621
i386                 randconfig-a001-20210621
i386                 randconfig-a003-20210621
i386                 randconfig-a006-20210621
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
