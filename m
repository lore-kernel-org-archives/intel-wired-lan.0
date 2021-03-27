From: kernel test robot <lkp@intel.com>
Date: Sat, 27 Mar 2021 18:46:28 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:100GbE] BUILD SUCCESS
 d634b8d8814557f5257ce83edb3f55936fe1661d
Message-ID: <605f0d04.YtJdMcP0gnKyO9GA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
branch HEAD: d634b8d8814557f5257ce83edb3f55936fe1661d  ice: Cleanup fltr list in case of allocation issues

elapsed time: 721m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                ecovec24-romimage_defconfig
arc                    vdk_hs38_smp_defconfig
m68k                         amcore_defconfig
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
powerpc                  mpc866_ads_defconfig
arm                          gemini_defconfig
powerpc                        icon_defconfig
powerpc                    sam440ep_defconfig
sh                           se7750_defconfig
arm                        clps711x_defconfig
sh                               alldefconfig
mips                        nlm_xlr_defconfig
arm                       spear13xx_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
arm                          ixp4xx_defconfig
nios2                         10m50_defconfig
powerpc                       holly_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                         orion5x_defconfig
arm                            pleb_defconfig
m68k                        mvme147_defconfig
microblaze                          defconfig
powerpc                       ebony_defconfig
powerpc                      cm5200_defconfig
parisc                generic-64bit_defconfig
mips                             allmodconfig
riscv                             allnoconfig
mips                            ar7_defconfig
powerpc                          g5_defconfig
ia64                            zx1_defconfig
arm                          pxa3xx_defconfig
arm                         hackkit_defconfig
arm                       aspeed_g5_defconfig
mips                     loongson1c_defconfig
sparc                            alldefconfig
mips                           rs90_defconfig
powerpc                          allyesconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v7_defconfig
powerpc                   bluestone_defconfig
xtensa                generic_kc705_defconfig
powerpc                      acadia_defconfig
arm                       multi_v4t_defconfig
arm                            mps2_defconfig
arm                          pxa910_defconfig
arm                            qcom_defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
arc                           tb10x_defconfig
mips                           ip32_defconfig
arc                          axs103_defconfig
powerpc                       eiger_defconfig
sparc                       sparc64_defconfig
arm                         s3c2410_defconfig
sh                          polaris_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
m68k                             allmodconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
arm                       cns3420vb_defconfig
arm                          imote2_defconfig
mips                          rb532_defconfig
arm                         palmz72_defconfig
arm                         mv78xx0_defconfig
alpha                            allyesconfig
mips                            gpr_defconfig
powerpc                       maple_defconfig
powerpc                    socrates_defconfig
powerpc                      bamboo_defconfig
m68k                                defconfig
sh                           se7206_defconfig
sh                           sh2007_defconfig
powerpc                 mpc834x_mds_defconfig
nds32                             allnoconfig
sparc64                             defconfig
arm                           omap1_defconfig
sparc64                          alldefconfig
riscv             nommu_k210_sdcard_defconfig
arm                          simpad_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pcm030_defconfig
mips                        omega2p_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210326
i386                 randconfig-a003-20210326
i386                 randconfig-a001-20210326
i386                 randconfig-a002-20210326
i386                 randconfig-a006-20210326
i386                 randconfig-a005-20210326
x86_64               randconfig-a012-20210326
x86_64               randconfig-a015-20210326
x86_64               randconfig-a014-20210326
x86_64               randconfig-a013-20210326
x86_64               randconfig-a016-20210326
x86_64               randconfig-a011-20210326
i386                 randconfig-a014-20210326
i386                 randconfig-a011-20210326
i386                 randconfig-a015-20210326
i386                 randconfig-a016-20210326
i386                 randconfig-a012-20210326
i386                 randconfig-a013-20210326
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a002-20210326
x86_64               randconfig-a003-20210326
x86_64               randconfig-a001-20210326
x86_64               randconfig-a006-20210326
x86_64               randconfig-a004-20210326
x86_64               randconfig-a005-20210326

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
