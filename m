From: kernel test robot <lkp@intel.com>
Date: Fri, 13 Nov 2020 22:12:21 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 1323489e64de3881c84ac17b92371b722cf42e6c
Message-ID: <5fae9445.D9TbSKi0iQoR2UTG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git  dev-queue
branch HEAD: 1323489e64de3881c84ac17b92371b722cf42e6c  igb: avoid transmit queue timeout in xdp path

elapsed time: 720m

configs tested: 186
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sbc8548_defconfig
arm                         lubbock_defconfig
powerpc                      acadia_defconfig
mips                  cavium_octeon_defconfig
powerpc                     pq2fads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     loongson1b_defconfig
powerpc                     rainier_defconfig
ia64                          tiger_defconfig
m68k                             alldefconfig
m68k                            q40_defconfig
arm                          ep93xx_defconfig
arm                       multi_v4t_defconfig
mips                      maltasmvp_defconfig
nios2                         10m50_defconfig
arm                             mxs_defconfig
arm                          prima2_defconfig
arm64                            alldefconfig
mips                          ath79_defconfig
powerpc                   motionpro_defconfig
arm                        clps711x_defconfig
powerpc                    gamecube_defconfig
arm                          pxa910_defconfig
mips                         bigsur_defconfig
arm                         s3c6400_defconfig
arm                         s5pv210_defconfig
arm                        cerfcube_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
mips                     loongson1c_defconfig
parisc                generic-32bit_defconfig
arm                          tango4_defconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
sh                          lboxre2_defconfig
arc                            hsdk_defconfig
arc                           tb10x_defconfig
powerpc                 mpc836x_mds_defconfig
mips                     cu1830-neo_defconfig
powerpc                      pcm030_defconfig
arm                            qcom_defconfig
m68k                          amiga_defconfig
powerpc                     mpc512x_defconfig
powerpc                 mpc834x_mds_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
arc                          axs103_defconfig
sh                           se7750_defconfig
c6x                              alldefconfig
arc                     nsimosci_hs_defconfig
mips                        nlm_xlr_defconfig
mips                        workpad_defconfig
ia64                                defconfig
mips                          ath25_defconfig
mips                         cobalt_defconfig
arm                        spear3xx_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    sam440ep_defconfig
arm                           h3600_defconfig
powerpc                     stx_gp3_defconfig
arm                           sunxi_defconfig
powerpc                   bluestone_defconfig
sh                          r7780mp_defconfig
arm                       imx_v6_v7_defconfig
mips                      bmips_stb_defconfig
sh                           se7722_defconfig
c6x                                 defconfig
csky                             alldefconfig
arc                        nsim_700_defconfig
nds32                            alldefconfig
powerpc                      ep88xc_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      pasemi_defconfig
ia64                        generic_defconfig
arm                            dove_defconfig
sh                              ul2_defconfig
sh                            hp6xx_defconfig
microblaze                          defconfig
mips                         tb0287_defconfig
xtensa                generic_kc705_defconfig
arm                              zx_defconfig
mips                            gpr_defconfig
powerpc                     skiroot_defconfig
arm                          lpd270_defconfig
m68k                       m5208evb_defconfig
mips                           xway_defconfig
mips                        jmr3927_defconfig
powerpc                     sequoia_defconfig
mips                          rb532_defconfig
powerpc                          allmodconfig
m68k                          hp300_defconfig
riscv                            allyesconfig
mips                        maltaup_defconfig
mips                        nlm_xlp_defconfig
powerpc                       maple_defconfig
xtensa                  nommu_kc705_defconfig
arm                            u300_defconfig
openrisc                 simple_smp_defconfig
sh                           se7724_defconfig
sh                           se7780_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                         bcm2835_defconfig
m68k                       m5475evb_defconfig
arm                      tct_hammer_defconfig
powerpc                mpc7448_hpc2_defconfig
um                           x86_64_defconfig
arm                        realview_defconfig
powerpc                     ppa8548_defconfig
sh                          rsk7269_defconfig
arm                           spitz_defconfig
powerpc                         wii_defconfig
xtensa                          iss_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
