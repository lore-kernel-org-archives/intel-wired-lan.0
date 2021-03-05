From: kernel test robot <lkp@intel.com>
Date: Fri, 05 Mar 2021 15:21:11 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 186a1a583de24452bb9e93c9e4cdf53aaa577e69
Message-ID: <6041dbe7.e/4Sc1adDucZ8DT/%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 186a1a583de24452bb9e93c9e4cdf53aaa577e69  ixgbe: move headroom initialization to ixgbe_configure_rx_ring

elapsed time: 721m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                          pxa3xx_defconfig
arm                           u8500_defconfig
m68k                          sun3x_defconfig
arm                        mvebu_v7_defconfig
powerpc                    sam440ep_defconfig
arm                           corgi_defconfig
arm                       netwinder_defconfig
arc                          axs103_defconfig
mips                  cavium_octeon_defconfig
mips                           ip27_defconfig
mips                        qi_lb60_defconfig
sh                           se7619_defconfig
nds32                            alldefconfig
sh                           se7705_defconfig
mips                        maltaup_defconfig
arm                      pxa255-idp_defconfig
arm                          pxa168_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        m5407c3_defconfig
arc                         haps_hs_defconfig
arc                        nsim_700_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
arm                         hackkit_defconfig
mips                           jazz_defconfig
csky                                defconfig
powerpc                     taishan_defconfig
powerpc                         wii_defconfig
mips                     cu1830-neo_defconfig
arc                      axs103_smp_defconfig
m68k                          amiga_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     pq2fads_defconfig
arm                           h3600_defconfig
arm                        cerfcube_defconfig
sh                            shmin_defconfig
ia64                        generic_defconfig
riscv             nommu_k210_sdcard_defconfig
h8300                               defconfig
mips                      maltasmvp_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                     pseries_defconfig
parisc                generic-32bit_defconfig
arm                            mps2_defconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
arm                         cm_x300_defconfig
sh                   secureedge5410_defconfig
powerpc                      ppc6xx_defconfig
arm                          iop32x_defconfig
powerpc                     ksi8560_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20210305
i386                 randconfig-a003-20210305
i386                 randconfig-a002-20210305
i386                 randconfig-a004-20210305
i386                 randconfig-a006-20210305
i386                 randconfig-a001-20210305
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a016-20210305
i386                 randconfig-a012-20210305
i386                 randconfig-a013-20210305
i386                 randconfig-a014-20210305
i386                 randconfig-a011-20210305
i386                 randconfig-a015-20210305
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
