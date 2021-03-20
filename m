From: kernel test robot <lkp@intel.com>
Date: Sat, 20 Mar 2021 18:38:43 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 f2d75b178532087c15b2a86ec79e443177611b7a
Message-ID: <6055d0b3.c9yYBWvhDQqlzR/3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: f2d75b178532087c15b2a86ec79e443177611b7a  e1000e: Mark e1000e_pm_prepare() as __maybe_unused

elapsed time: 720m

configs tested: 127
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
riscv                            allyesconfig
i386                             allyesconfig
mips                         tb0287_defconfig
powerpc                     tqm8541_defconfig
arm                         socfpga_defconfig
arc                              alldefconfig
powerpc                  iss476-smp_defconfig
sh                          lboxre2_defconfig
mips                malta_kvm_guest_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
sh                            hp6xx_defconfig
arm                  colibri_pxa300_defconfig
arm                            qcom_defconfig
powerpc                     redwood_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
powerpc                 canyonlands_defconfig
powerpc                  mpc885_ads_defconfig
arm                         cm_x300_defconfig
powerpc                     pq2fads_defconfig
mips                     loongson1c_defconfig
m68k                           sun3_defconfig
mips                        bcm63xx_defconfig
arm                    vt8500_v6_v7_defconfig
arc                            hsdk_defconfig
arm                           u8500_defconfig
arm                          imote2_defconfig
powerpc                     taishan_defconfig
powerpc                        warp_defconfig
arm                        mvebu_v7_defconfig
xtensa                  audio_kc705_defconfig
m68k                        stmark2_defconfig
arm                       aspeed_g4_defconfig
powerpc                       maple_defconfig
arm                       mainstone_defconfig
sparc64                             defconfig
powerpc                      acadia_defconfig
powerpc                      pmac32_defconfig
sh                           se7750_defconfig
mips                     decstation_defconfig
mips                        qi_lb60_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                            zx1_defconfig
powerpc                     skiroot_defconfig
powerpc                     ksi8560_defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
arm                       versatile_defconfig
arm                        clps711x_defconfig
powerpc               mpc834x_itxgp_defconfig
parisc                generic-64bit_defconfig
mips                        maltaup_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210318
i386                 randconfig-a005-20210318
i386                 randconfig-a003-20210318
i386                 randconfig-a002-20210318
i386                 randconfig-a006-20210318
i386                 randconfig-a004-20210318
x86_64               randconfig-a011-20210318
x86_64               randconfig-a016-20210318
x86_64               randconfig-a013-20210318
x86_64               randconfig-a015-20210318
x86_64               randconfig-a014-20210318
x86_64               randconfig-a012-20210318
i386                 randconfig-a013-20210318
i386                 randconfig-a016-20210318
i386                 randconfig-a011-20210318
i386                 randconfig-a014-20210318
i386                 randconfig-a015-20210318
i386                 randconfig-a012-20210318
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210318
x86_64               randconfig-a001-20210318
x86_64               randconfig-a005-20210318
x86_64               randconfig-a002-20210318
x86_64               randconfig-a003-20210318
x86_64               randconfig-a004-20210318

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
