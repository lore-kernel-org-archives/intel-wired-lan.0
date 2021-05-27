From: kernel test robot <lkp@intel.com>
Date: Thu, 27 May 2021 20:16:20 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 c7a551b2e44a65170b5dceaca0afbd59f3715f11
Message-ID: <60af8d94.MDOyQiecfOZORgyP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: c7a551b2e44a65170b5dceaca0afbd59f3715f11  nfc: st-nci: remove unnecessary labels

elapsed time: 953m

configs tested: 165
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                         amcore_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc44x_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
powerpc                    sam440ep_defconfig
sh                        edosk7760_defconfig
arm                          iop32x_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
powerpc                       maple_defconfig
sh                          sdk7780_defconfig
mips                      malta_kvm_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
arm                           sunxi_defconfig
powerpc                     tqm8560_defconfig
powerpc                     skiroot_defconfig
m68k                        m5307c3_defconfig
sh                           se7712_defconfig
arm                        keystone_defconfig
m68k                       m5475evb_defconfig
m68k                         apollo_defconfig
mips                  maltasmvp_eva_defconfig
arm                      footbridge_defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
um                               allyesconfig
powerpc                 mpc8313_rdb_defconfig
arc                     nsimosci_hs_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
sh                     sh7710voipgw_defconfig
mips                           ip22_defconfig
powerpc                    amigaone_defconfig
mips                    maltaup_xpa_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                        vocore2_defconfig
mips                        workpad_defconfig
arm                          moxart_defconfig
mips                          malta_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
mips                          rm200_defconfig
riscv                    nommu_virt_defconfig
arm                          ep93xx_defconfig
sh                           se7343_defconfig
ia64                             allyesconfig
powerpc                   lite5200b_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8548_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
alpha                               defconfig
mips                        omega2p_defconfig
arm                        mini2440_defconfig
arm                          badge4_defconfig
ia64                             alldefconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
powerpc                      mgcoge_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
m68k                             allmodconfig
nios2                         3c120_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
arm                        cerfcube_defconfig
mips                           ci20_defconfig
xtensa                  cadence_csp_defconfig
arm                       omap2plus_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
arm                            qcom_defconfig
arm                       cns3420vb_defconfig
arc                        nsim_700_defconfig
mips                        nlm_xlr_defconfig
mips                         rt305x_defconfig
arm                        mvebu_v5_defconfig
powerpc                      bamboo_defconfig
sparc64                          alldefconfig
mips                      maltaaprp_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
