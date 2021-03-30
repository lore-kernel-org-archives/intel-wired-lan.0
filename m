From: kernel test robot <lkp@intel.com>
Date: Wed, 31 Mar 2021 00:53:17 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 148327fca93837928fe47c94a3e18d007a90f631
Message-ID: <6063577d.HS5+7TeJiXK6XCsI%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 148327fca93837928fe47c94a3e18d007a90f631  i40e: Fix sparse warning: missing error code 'err'

elapsed time: 970m

configs tested: 130
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
mips                        qi_lb60_defconfig
arc                        nsim_700_defconfig
powerpc                     taishan_defconfig
mips                       bmips_be_defconfig
mips                            gpr_defconfig
xtensa                  cadence_csp_defconfig
powerpc                         ps3_defconfig
mips                          ath25_defconfig
m68k                        m5272c3_defconfig
sh                          urquell_defconfig
arc                      axs103_smp_defconfig
mips                           ip22_defconfig
powerpc                    klondike_defconfig
mips                             allyesconfig
powerpc                 mpc832x_mds_defconfig
mips                      loongson3_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      chrp32_defconfig
sh                                  defconfig
arm                            qcom_defconfig
arm                           sama5_defconfig
arm                           corgi_defconfig
powerpc                     pq2fads_defconfig
ia64                        generic_defconfig
powerpc                  iss476-smp_defconfig
arm                             pxa_defconfig
s390                          debug_defconfig
arc                              alldefconfig
arm                       mainstone_defconfig
sh                          landisk_defconfig
arm                   milbeaut_m10v_defconfig
i386                                defconfig
m68k                           sun3_defconfig
arm                  colibri_pxa300_defconfig
arm                         hackkit_defconfig
mips                           jazz_defconfig
arc                         haps_hs_defconfig
mips                      bmips_stb_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                        spear6xx_defconfig
mips                          malta_defconfig
arm                         cm_x300_defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
mips                      pistachio_defconfig
arm                         orion5x_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
arm                       versatile_defconfig
powerpc                     akebono_defconfig
m68k                       m5249evb_defconfig
mips                        maltaup_defconfig
xtensa                  audio_kc705_defconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
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
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a004-20210330
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
