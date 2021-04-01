From: kernel test robot <lkp@intel.com>
Date: Thu, 01 Apr 2021 17:55:30 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 7be4e40d9936a3ceedd29a92d867ade2724b4f18
Message-ID: <60659892.2tbLhs34Br2D9Vsp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 7be4e40d9936a3ceedd29a92d867ade2724b4f18  i40e: Fix sparse warning: missing error code 'err'

elapsed time: 721m

configs tested: 125
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
i386                             allyesconfig
riscv                            allyesconfig
m68k                             alldefconfig
powerpc                 mpc8560_ads_defconfig
sh                          r7785rp_defconfig
xtensa                  audio_kc705_defconfig
arm                        vexpress_defconfig
um                            kunit_defconfig
mips                malta_kvm_guest_defconfig
sh                        edosk7760_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                         apollo_defconfig
arc                           tb10x_defconfig
arm                            dove_defconfig
arm                        multi_v7_defconfig
m68k                        mvme16x_defconfig
arm                       multi_v4t_defconfig
mips                          ath79_defconfig
sh                          landisk_defconfig
mips                     cu1000-neo_defconfig
xtensa                       common_defconfig
arm                      integrator_defconfig
powerpc                      mgcoge_defconfig
arm64                            alldefconfig
riscv             nommu_k210_sdcard_defconfig
arm                          simpad_defconfig
m68k                        stmark2_defconfig
mips                  maltasmvp_eva_defconfig
mips                           rs90_defconfig
powerpc                     mpc512x_defconfig
mips                        nlm_xlp_defconfig
arm                       mainstone_defconfig
mips                           gcw0_defconfig
powerpc                        fsp2_defconfig
mips                         tb0219_defconfig
mips                    maltaup_xpa_defconfig
sh                     magicpanelr2_defconfig
xtensa                generic_kc705_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
m68k                        mvme147_defconfig
mips                 decstation_r4k_defconfig
arm                              alldefconfig
sh                          rsk7203_defconfig
mips                           mtx1_defconfig
riscv                            alldefconfig
arm                            pleb_defconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
