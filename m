From: kernel test robot <lkp@intel.com>
Date: Sat, 24 Apr 2021 19:03:33 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 1d227bfdc80d88f6fd3225b973c1e0ecf5060304
Message-ID: <6083fb05.MfLrwbNMF/w4QAsG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 1d227bfdc80d88f6fd3225b973c1e0ecf5060304  ice: Re-organizes reqstd/avail {R, T}XQ check/code for efficiency

elapsed time: 723m

configs tested: 155
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
i386                             allyesconfig
riscv                            allyesconfig
arc                      axs103_smp_defconfig
arm                            pleb_defconfig
um                             i386_defconfig
arm                        vexpress_defconfig
mips                        bcm47xx_defconfig
mips                        nlm_xlp_defconfig
powerpc                  mpc885_ads_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         bcm2835_defconfig
powerpc                      walnut_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
sh                ecovec24-romimage_defconfig
mips                        omega2p_defconfig
sh                           se7780_defconfig
powerpc                           allnoconfig
arc                        vdk_hs38_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5208evb_defconfig
arm                           stm32_defconfig
mips                           ci20_defconfig
mips                        bcm63xx_defconfig
m68k                             alldefconfig
sh                          kfr2r09_defconfig
mips                      pistachio_defconfig
mips                          ath25_defconfig
microblaze                          defconfig
openrisc                    or1ksim_defconfig
powerpc                     powernv_defconfig
sh                               j2_defconfig
arm                           omap1_defconfig
xtensa                       common_defconfig
mips                          ath79_defconfig
powerpc                 mpc836x_mds_defconfig
arm                           sama5_defconfig
arc                 nsimosci_hs_smp_defconfig
i386                                defconfig
arm                          exynos_defconfig
ia64                             alldefconfig
m68k                                defconfig
sh                          rsk7203_defconfig
sh                           se7724_defconfig
arm64                            alldefconfig
mips                  decstation_64_defconfig
m68k                          multi_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                         wii_defconfig
mips                           ip28_defconfig
arm                         hackkit_defconfig
sh                             sh03_defconfig
powerpc                   lite5200b_defconfig
sh                            migor_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5272c3_defconfig
arm                     eseries_pxa_defconfig
powerpc                     tqm8555_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
arm                             pxa_defconfig
parisc                              defconfig
mips                      bmips_stb_defconfig
riscv                             allnoconfig
xtensa                              defconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210423
x86_64               randconfig-a004-20210423
x86_64               randconfig-a001-20210423
x86_64               randconfig-a005-20210423
x86_64               randconfig-a006-20210423
x86_64               randconfig-a003-20210423
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
x86_64               randconfig-a015-20210424
x86_64               randconfig-a016-20210424
x86_64               randconfig-a011-20210424
x86_64               randconfig-a014-20210424
x86_64               randconfig-a013-20210424
x86_64               randconfig-a012-20210424
i386                 randconfig-a012-20210424
i386                 randconfig-a014-20210424
i386                 randconfig-a011-20210424
i386                 randconfig-a013-20210424
i386                 randconfig-a015-20210424
i386                 randconfig-a016-20210424
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
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
x86_64               randconfig-a004-20210424
x86_64               randconfig-a002-20210424
x86_64               randconfig-a001-20210424
x86_64               randconfig-a006-20210424
x86_64               randconfig-a005-20210424
x86_64               randconfig-a003-20210424
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
