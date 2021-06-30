From: kernel test robot <lkp@intel.com>
Date: Wed, 30 Jun 2021 17:39:35 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 fff3ea006287fec848383b6144935cba5ded41a6
Message-ID: <60dc3bd7.5BugYCxqqMrhHhmA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: fff3ea006287fec848383b6144935cba5ded41a6  igc: Export LEDs

Error/Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:180:35: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- alpha-randconfig-r032-20210628
    `-- drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c:error:struct-pci_dev-has-no-member-named-physfn

elapsed time: 723m

configs tested: 116
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                           allyesconfig
arm                         at91_dt_defconfig
arm                       imx_v6_v7_defconfig
ia64                         bigsur_defconfig
powerpc                     mpc512x_defconfig
arm                  colibri_pxa300_defconfig
powerpc64                           defconfig
mips                            gpr_defconfig
powerpc                      ppc44x_defconfig
arm                         hackkit_defconfig
m68k                        m5307c3_defconfig
powerpc                      mgcoge_defconfig
powerpc                     skiroot_defconfig
arm                      integrator_defconfig
powerpc                      chrp32_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
powerpc                     stx_gp3_defconfig
parisc                              defconfig
powerpc                  mpc885_ads_defconfig
arm                            zeus_defconfig
riscv                    nommu_k210_defconfig
arc                         haps_hs_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8540_defconfig
mips                     cu1830-neo_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8540_ads_defconfig
sh                               j2_defconfig
arm                           u8500_defconfig
arc                          axs101_defconfig
mips                            ar7_defconfig
sh                          sdk7786_defconfig
arm                       mainstone_defconfig
openrisc                            defconfig
arm                           tegra_defconfig
mips                      loongson3_defconfig
ia64                             allmodconfig
powerpc                     asp8347_defconfig
powerpc                       holly_defconfig
powerpc                       eiger_defconfig
x86_64                            allnoconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
i386                 randconfig-a001-20210628
i386                 randconfig-a002-20210628
i386                 randconfig-a003-20210628
i386                 randconfig-a006-20210628
i386                 randconfig-a005-20210628
i386                 randconfig-a004-20210628
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
