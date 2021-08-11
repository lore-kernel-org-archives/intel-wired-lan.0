From: kernel test robot <lkp@intel.com>
Date: Thu, 12 Aug 2021 00:41:56 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 aba1e4adb54e020d3ca85a4df3ef0f8febe87548
Message-ID: <6113fdd4.RQSb/bm/tGD/c1ED%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: aba1e4adb54e020d3ca85a4df3ef0f8febe87548  igc: Add support for CBS offloading

elapsed time: 1148m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210810
s390                       zfcpdump_defconfig
sh                                  defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                              ul2_defconfig
sh                               j2_defconfig
mips                          rb532_defconfig
arm                       omap2plus_defconfig
arm                         at91_dt_defconfig
arm                           omap1_defconfig
arm                           viper_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      acadia_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      makalu_defconfig
arm                          imote2_defconfig
powerpc                    adder875_defconfig
ia64                                defconfig
powerpc                     asp8347_defconfig
arm                            hisi_defconfig
arm                         s3c2410_defconfig
arm                       spear13xx_defconfig
powerpc                     powernv_defconfig
m68k                       m5249evb_defconfig
powerpc                      ppc44x_defconfig
s390                          debug_defconfig
powerpc                 mpc834x_itx_defconfig
nds32                               defconfig
mips                           jazz_defconfig
mips                           rs90_defconfig
powerpc                           allnoconfig
m68k                             alldefconfig
mips                      bmips_stb_defconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
xtensa                    xip_kc705_defconfig
arc                      axs103_smp_defconfig
arm                            lart_defconfig
alpha                            allyesconfig
mips                      maltasmvp_defconfig
xtensa                  cadence_csp_defconfig
arm                       aspeed_g4_defconfig
mips                         bigsur_defconfig
sh                          sdk7786_defconfig
sh                        dreamcast_defconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
microblaze                      mmu_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a004-20210810
x86_64               randconfig-a006-20210810
x86_64               randconfig-a003-20210810
x86_64               randconfig-a005-20210810
x86_64               randconfig-a002-20210810
x86_64               randconfig-a001-20210810
i386                 randconfig-a004-20210810
i386                 randconfig-a002-20210810
i386                 randconfig-a001-20210810
i386                 randconfig-a003-20210810
i386                 randconfig-a006-20210810
i386                 randconfig-a005-20210810
i386                 randconfig-a004-20210811
i386                 randconfig-a001-20210811
i386                 randconfig-a002-20210811
i386                 randconfig-a003-20210811
i386                 randconfig-a006-20210811
i386                 randconfig-a005-20210811
x86_64               randconfig-a013-20210811
x86_64               randconfig-a011-20210811
x86_64               randconfig-a012-20210811
x86_64               randconfig-a016-20210811
x86_64               randconfig-a014-20210811
x86_64               randconfig-a015-20210811
i386                 randconfig-a011-20210810
i386                 randconfig-a015-20210810
i386                 randconfig-a013-20210810
i386                 randconfig-a014-20210810
i386                 randconfig-a016-20210810
i386                 randconfig-a012-20210810
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-c001-20210810
x86_64               randconfig-c001-20210811
x86_64               randconfig-a013-20210810
x86_64               randconfig-a011-20210810
x86_64               randconfig-a012-20210810
x86_64               randconfig-a016-20210810
x86_64               randconfig-a014-20210810
x86_64               randconfig-a015-20210810
x86_64               randconfig-a004-20210811
x86_64               randconfig-a006-20210811
x86_64               randconfig-a003-20210811
x86_64               randconfig-a002-20210811
x86_64               randconfig-a005-20210811
x86_64               randconfig-a001-20210811

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
