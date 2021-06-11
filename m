From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Jun 2021 18:48:45 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 8dc0a23f11b8c1f96d92576e74e11cc0056b4784
Message-ID: <60c33f8d.cGrGcPm2bFGtrTXv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 8dc0a23f11b8c1f96d92576e74e11cc0056b4784  i40e: Refactor arrow operator usage in i40e_update_adq_vsi_queues()

Error/Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:180:35: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-a016-20210611
    `-- drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c:error:struct-pci_dev-has-no-member-named-physfn

elapsed time: 723m

configs tested: 117
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         axm55xx_defconfig
powerpc                    socrates_defconfig
alpha                            allyesconfig
ia64                         bigsur_defconfig
sh                           se7722_defconfig
mips                      pic32mzda_defconfig
m68k                        mvme16x_defconfig
powerpc                      ppc6xx_defconfig
arm                         palmz72_defconfig
mips                            gpr_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
arm                          pxa910_defconfig
sh                   rts7751r2dplus_defconfig
arm                         hackkit_defconfig
sh                          kfr2r09_defconfig
mips                        jmr3927_defconfig
arm                     am200epdkit_defconfig
mips                           ip22_defconfig
xtensa                    xip_kc705_defconfig
sparc                       sparc64_defconfig
mips                         mpc30x_defconfig
h8300                            alldefconfig
sh                           se7721_defconfig
arm                  colibri_pxa300_defconfig
arm                       imx_v4_v5_defconfig
h8300                     edosk2674_defconfig
m68k                          atari_defconfig
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
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
