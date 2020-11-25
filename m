From: kernel test robot <lkp@intel.com>
Date: Wed, 25 Nov 2020 15:45:02 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 1198f2f4eb68a42696ff48b3d113a5a77d499a36
Message-ID: <5fbe0b7e.GPYxodzFLMvdoKNH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git  dev-queue
branch HEAD: 1198f2f4eb68a42696ff48b3d113a5a77d499a36  i40e: Add zero-initialization of AQ command structures

elapsed time: 720m

configs tested: 197
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
m68k                       m5475evb_defconfig
mips                           jazz_defconfig
c6x                        evmc6474_defconfig
powerpc                      makalu_defconfig
sh                         ap325rxa_defconfig
arm                         at91_dt_defconfig
m68k                        mvme147_defconfig
sh                        dreamcast_defconfig
powerpc                     kmeter1_defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
arm                  colibri_pxa270_defconfig
arm                          ixp4xx_defconfig
arm                           corgi_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                               allmodconfig
powerpc                     ep8248e_defconfig
powerpc                   lite5200b_defconfig
ia64                          tiger_defconfig
arc                     haps_hs_smp_defconfig
mips                            ar7_defconfig
arm                         lubbock_defconfig
parisc                           allyesconfig
sh                        sh7757lcr_defconfig
nios2                         3c120_defconfig
powerpc                      pasemi_defconfig
arm                           sama5_defconfig
mips                          rm200_defconfig
powerpc                  iss476-smp_defconfig
sh                                  defconfig
arm                          gemini_defconfig
csky                             alldefconfig
arm                          tango4_defconfig
xtensa                       common_defconfig
m68k                           sun3_defconfig
arc                        vdk_hs38_defconfig
mips                         db1xxx_defconfig
arm                          prima2_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
arm                       aspeed_g4_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
powerpc                    socrates_defconfig
sh                           se7724_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
sh                     sh7710voipgw_defconfig
sh                         microdev_defconfig
ia64                         bigsur_defconfig
nios2                               defconfig
m68k                         apollo_defconfig
mips                           rs90_defconfig
riscv                               defconfig
arm                            pleb_defconfig
x86_64                           alldefconfig
arm                        neponset_defconfig
sh                            migor_defconfig
mips                      maltaaprp_defconfig
s390                                defconfig
mips                      fuloong2e_defconfig
mips                    maltaup_xpa_defconfig
mips                          rb532_defconfig
arc                     nsimosci_hs_defconfig
sh                          rsk7203_defconfig
arm                        mvebu_v7_defconfig
mips                 decstation_r4k_defconfig
parisc                           alldefconfig
sh                   sh7770_generic_defconfig
powerpc                    gamecube_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc834x_itx_defconfig
arm                            qcom_defconfig
arc                            hsdk_defconfig
m68k                       m5275evb_defconfig
arm                        multi_v5_defconfig
sh                           se7780_defconfig
arm                       imx_v4_v5_defconfig
arm                         ebsa110_defconfig
powerpc                        fsp2_defconfig
mips                malta_kvm_guest_defconfig
powerpc                      ep88xc_defconfig
mips                          ath25_defconfig
microblaze                          defconfig
powerpc                 mpc834x_mds_defconfig
arc                        nsimosci_defconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
h8300                            alldefconfig
powerpc                      walnut_defconfig
powerpc                     sbc8548_defconfig
sh                          rsk7264_defconfig
powerpc                     tqm8548_defconfig
ia64                             alldefconfig
microblaze                    nommu_defconfig
mips                     cu1000-neo_defconfig
arm                   milbeaut_m10v_defconfig
arm                        shmobile_defconfig
sh                               j2_defconfig
parisc                generic-64bit_defconfig
ia64                            zx1_defconfig
sh                              ul2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                              defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201124
i386                 randconfig-a003-20201124
i386                 randconfig-a002-20201124
i386                 randconfig-a005-20201124
i386                 randconfig-a001-20201124
i386                 randconfig-a006-20201124
i386                 randconfig-a004-20201125
i386                 randconfig-a003-20201125
i386                 randconfig-a002-20201125
i386                 randconfig-a005-20201125
i386                 randconfig-a001-20201125
i386                 randconfig-a006-20201125
x86_64               randconfig-a015-20201125
x86_64               randconfig-a011-20201125
x86_64               randconfig-a014-20201125
x86_64               randconfig-a016-20201125
x86_64               randconfig-a012-20201125
x86_64               randconfig-a013-20201125
i386                 randconfig-a012-20201125
i386                 randconfig-a013-20201125
i386                 randconfig-a011-20201125
i386                 randconfig-a016-20201125
i386                 randconfig-a014-20201125
i386                 randconfig-a015-20201125
i386                 randconfig-a012-20201124
i386                 randconfig-a013-20201124
i386                 randconfig-a011-20201124
i386                 randconfig-a016-20201124
i386                 randconfig-a014-20201124
i386                 randconfig-a015-20201124
x86_64               randconfig-a006-20201124
x86_64               randconfig-a003-20201124
x86_64               randconfig-a004-20201124
x86_64               randconfig-a005-20201124
x86_64               randconfig-a001-20201124
x86_64               randconfig-a002-20201124
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201125
x86_64               randconfig-a003-20201125
x86_64               randconfig-a004-20201125
x86_64               randconfig-a005-20201125
x86_64               randconfig-a002-20201125
x86_64               randconfig-a001-20201125
x86_64               randconfig-a015-20201124
x86_64               randconfig-a011-20201124
x86_64               randconfig-a014-20201124
x86_64               randconfig-a016-20201124
x86_64               randconfig-a012-20201124
x86_64               randconfig-a013-20201124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
