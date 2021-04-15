From: kernel test robot <lkp@intel.com>
Date: Thu, 15 Apr 2021 12:28:28 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:10GbE] BUILD SUCCESS
 ef963ae427aa4669905e0a96b3bd9d44dc85db32
Message-ID: <6077c0ec.kbgnSMDOoFDdAdRl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 10GbE
branch HEAD: ef963ae427aa4669905e0a96b3bd9d44dc85db32  ice: Fix potential infinite loop when using u8 loop counter

elapsed time: 728m

configs tested: 176
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
m68k                          sun3x_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
ia64                         bigsur_defconfig
arc                        vdk_hs38_defconfig
sparc                            alldefconfig
powerpc                 mpc8272_ads_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
xtensa                    smp_lx200_defconfig
mips                           rs90_defconfig
powerpc                       maple_defconfig
arm                          ep93xx_defconfig
mips                            e55_defconfig
ia64                      gensparse_defconfig
powerpc                  mpc866_ads_defconfig
arm                            lart_defconfig
mips                           xway_defconfig
arm                          iop32x_defconfig
mips                        nlm_xlp_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
arm                         palmz72_defconfig
mips                         tb0287_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
powerpc                     ep8248e_defconfig
s390                          debug_defconfig
powerpc                     tqm8555_defconfig
powerpc                      makalu_defconfig
sh                         ap325rxa_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
arm                         s3c2410_defconfig
sh                          rsk7264_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        spear6xx_defconfig
mips                      bmips_stb_defconfig
mips                          malta_defconfig
arm                            zeus_defconfig
mips                     cu1830-neo_defconfig
arm                          gemini_defconfig
microblaze                          defconfig
riscv                          rv32_defconfig
m68k                             allmodconfig
riscv                            alldefconfig
arm                          exynos_defconfig
xtensa                          iss_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
arm                           h3600_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
arm                      jornada720_defconfig
arm                         s3c6400_defconfig
arm                          pcm027_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
xtensa                         virt_defconfig
powerpc64                           defconfig
sh                        edosk7760_defconfig
mips                  decstation_64_defconfig
h8300                            alldefconfig
powerpc                      arches_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                      tct_hammer_defconfig
sh                           se7751_defconfig
openrisc                    or1ksim_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
mips                     decstation_defconfig
powerpc                     tqm8548_defconfig
arm                         at91_dt_defconfig
arm                        realview_defconfig
arc                        nsim_700_defconfig
m68k                       m5275evb_defconfig
arc                           tb10x_defconfig
powerpc                   motionpro_defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                            q40_defconfig
m68k                       m5249evb_defconfig
powerpc                     tqm8540_defconfig
powerpc                    socrates_defconfig
mips                           jazz_defconfig
sh                        apsh4ad0a_defconfig
um                            kunit_defconfig
mips                         cobalt_defconfig
powerpc                    sam440ep_defconfig
arm                             pxa_defconfig
arm                         hackkit_defconfig
mips                     loongson1c_defconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210414
i386                 randconfig-a006-20210414
i386                 randconfig-a001-20210414
i386                 randconfig-a005-20210414
i386                 randconfig-a004-20210414
i386                 randconfig-a002-20210414
x86_64               randconfig-a014-20210414
x86_64               randconfig-a015-20210414
x86_64               randconfig-a011-20210414
x86_64               randconfig-a013-20210414
x86_64               randconfig-a012-20210414
x86_64               randconfig-a016-20210414
i386                 randconfig-a015-20210414
i386                 randconfig-a014-20210414
i386                 randconfig-a013-20210414
i386                 randconfig-a012-20210414
i386                 randconfig-a016-20210414
i386                 randconfig-a011-20210414
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a003-20210414
x86_64               randconfig-a002-20210414
x86_64               randconfig-a005-20210414
x86_64               randconfig-a001-20210414
x86_64               randconfig-a006-20210414
x86_64               randconfig-a004-20210414

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
