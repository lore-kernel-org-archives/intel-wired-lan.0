From: kernel test robot <lkp@intel.com>
Date: Fri, 14 May 2021 00:09:57 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 98fc59dabfb6168f338bfabb84a39b3291578766
Message-ID: <609d4f55.30nZ+z10SnVmt8yH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 98fc59dabfb6168f338bfabb84a39b3291578766  ixgbe: fix large MTU request from VF

elapsed time: 722m

configs tested: 125
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v6_v7_defconfig
mips                          rm200_defconfig
riscv                             allnoconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                         vf610m4_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
arm                        mini2440_defconfig
powerpc                   currituck_defconfig
xtensa                              defconfig
nds32                               defconfig
arm                           h5000_defconfig
h8300                               defconfig
powerpc                     powernv_defconfig
sparc                       sparc64_defconfig
m68k                            mac_defconfig
powerpc                     kmeter1_defconfig
nios2                         3c120_defconfig
powerpc                 mpc834x_itx_defconfig
arm                      tct_hammer_defconfig
sh                             sh03_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                       m5249evb_defconfig
arm                         s5pv210_defconfig
arc                     nsimosci_hs_defconfig
xtensa                generic_kc705_defconfig
nios2                         10m50_defconfig
arm                           spitz_defconfig
sh                           se7619_defconfig
powerpc                     kilauea_defconfig
mips                           ip27_defconfig
sh                           se7751_defconfig
arm                       spear13xx_defconfig
arc                          axs103_defconfig
mips                         tb0219_defconfig
arm                         palmz72_defconfig
arm                         assabet_defconfig
arm                          pxa910_defconfig
powerpc                 mpc836x_mds_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
sh                          sdk7780_defconfig
mips                           xway_defconfig
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
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
