From: kernel test robot <lkp@intel.com>
Date: Thu, 10 Jun 2021 16:08:17 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 afcc4ad3acede542d2b26689f3652b7b43db47f6
Message-ID: <60c1c871.vU0sGn6f2qvHHQqV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: afcc4ad3acede542d2b26689f3652b7b43db47f6  ixgbe, xsk: clean up the resources in ixgbe_xsk_pool_enable error path

elapsed time: 726m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                                defconfig
arm                       cns3420vb_defconfig
s390                             alldefconfig
sh                            shmin_defconfig
arm                          collie_defconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
sparc                            alldefconfig
arm                             rpc_defconfig
arm                             ezx_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pasemi_defconfig
sh                          r7785rp_defconfig
s390                                defconfig
arm                              alldefconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
sparc                       sparc64_defconfig
powerpc                    mvme5100_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
sh                             sh03_defconfig
sh                        sh7763rdp_defconfig
mips                     cu1000-neo_defconfig
sh                        dreamcast_defconfig
m68k                             allyesconfig
sh                 kfr2r09-romimage_defconfig
openrisc                  or1klitex_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
i386                                defconfig
mips                         tb0287_defconfig
powerpc                 mpc8560_ads_defconfig
sh                           se7721_defconfig
powerpc                          allyesconfig
sparc64                             defconfig
riscv                               defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
powerpc                     tqm8555_defconfig
arm                          ep93xx_defconfig
mips                      maltasmvp_defconfig
arm                           sunxi_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
