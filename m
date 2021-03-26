From: kernel test robot <lkp@intel.com>
Date: Fri, 26 Mar 2021 18:50:03 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 f2916ae9a1bc80aa8e9e8a00b75682f5df6fd59c
Message-ID: <605dbc5b.uKrSkHd7MPyhLQdX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: f2916ae9a1bc80aa8e9e8a00b75682f5df6fd59c  i40e: Fix oops at i40e_rebuild()

elapsed time: 733m

configs tested: 193
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
mips                           ip28_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
powerpc                   currituck_defconfig
h8300                            alldefconfig
powerpc                     ksi8560_defconfig
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
sparc64                             defconfig
arm                         assabet_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
powerpc                    ge_imp3a_defconfig
arm                        shmobile_defconfig
powerpc                      cm5200_defconfig
powerpc                         wii_defconfig
arm                      jornada720_defconfig
sh                               alldefconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           gcw0_defconfig
arc                         haps_hs_defconfig
um                             i386_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
um                                allnoconfig
powerpc64                           defconfig
mips                      bmips_stb_defconfig
mips                        maltaup_defconfig
arm                        mvebu_v7_defconfig
parisc                           alldefconfig
arm                            pleb_defconfig
sh                   sh7770_generic_defconfig
powerpc                       ppc64_defconfig
arm                           spitz_defconfig
arm                        keystone_defconfig
arm                          lpd270_defconfig
mips                      maltaaprp_defconfig
arm                        spear3xx_defconfig
sh                          rsk7264_defconfig
arm                       imx_v6_v7_defconfig
mips                     loongson1c_defconfig
powerpc                     sequoia_defconfig
powerpc                      katmai_defconfig
arm                        multi_v7_defconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
arm                            mps2_defconfig
powerpc                      makalu_defconfig
powerpc                      pcm030_defconfig
mips                            ar7_defconfig
openrisc                            defconfig
xtensa                  audio_kc705_defconfig
arm                          pxa168_defconfig
arm                           sunxi_defconfig
powerpc                   motionpro_defconfig
arm                         lpc18xx_defconfig
mips                     decstation_defconfig
sh                             espt_defconfig
mips                        bcm63xx_defconfig
m68k                                defconfig
arm                           corgi_defconfig
powerpc                    amigaone_defconfig
m68k                       m5208evb_defconfig
mips                  cavium_octeon_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                          sdk7780_defconfig
powerpc                      acadia_defconfig
nds32                            alldefconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
mips                        omega2p_defconfig
sh                     magicpanelr2_defconfig
riscv                    nommu_k210_defconfig
m68k                          amiga_defconfig
arc                            hsdk_defconfig
xtensa                  cadence_csp_defconfig
arm                          imote2_defconfig
sh                           se7712_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v5_defconfig
mips                         cobalt_defconfig
powerpc                        icon_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
mips                        qi_lb60_defconfig
m68k                            mac_defconfig
arm                          pxa3xx_defconfig
powerpc                     tqm8548_defconfig
sh                          polaris_defconfig
mips                       lemote2f_defconfig
arm                          gemini_defconfig
arm                         at91_dt_defconfig
sh                        sh7757lcr_defconfig
arm                     eseries_pxa_defconfig
sh                         apsh4a3a_defconfig
powerpc                     sbc8548_defconfig
arc                           tb10x_defconfig
h8300                               defconfig
arm                              alldefconfig
arm                            mmp2_defconfig
powerpc64                        alldefconfig
arc                        nsimosci_defconfig
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
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
x86_64               randconfig-a012-20210326
x86_64               randconfig-a015-20210326
x86_64               randconfig-a014-20210326
x86_64               randconfig-a013-20210326
x86_64               randconfig-a016-20210326
x86_64               randconfig-a011-20210326
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
i386                 randconfig-a014-20210326
i386                 randconfig-a011-20210326
i386                 randconfig-a015-20210326
i386                 randconfig-a016-20210326
i386                 randconfig-a012-20210326
i386                 randconfig-a013-20210326
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325
x86_64               randconfig-a014-20210325
x86_64               randconfig-a013-20210325
x86_64               randconfig-a011-20210325
x86_64               randconfig-a016-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
