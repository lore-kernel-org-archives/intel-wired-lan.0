From: kernel test robot <lkp@intel.com>
Date: Tue, 26 Jan 2021 14:56:43 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 68e215084b5a82e94d61a6e5f0f8baa67e3fd6c4
Message-ID: <600fbd2b.unBNnT00Mxy3vyhG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 68e215084b5a82e94d61a6e5f0f8baa67e3fd6c4  i40e: Revert "i40e: don't report link up for a VF who hasn't enabled queues"

elapsed time: 720m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                              allyesconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
arc                            hsdk_defconfig
m68k                          sun3x_defconfig
arm                         s5pv210_defconfig
arm                       mainstone_defconfig
sh                           se7712_defconfig
arm                        keystone_defconfig
powerpc                     ksi8560_defconfig
sh                          rsk7201_defconfig
powerpc                   bluestone_defconfig
arm                  colibri_pxa270_defconfig
riscv                             allnoconfig
sh                           se7722_defconfig
mips                         db1xxx_defconfig
m68k                       m5249evb_defconfig
powerpc                          g5_defconfig
sh                           se7343_defconfig
ia64                             allyesconfig
mips                         rt305x_defconfig
powerpc                      arches_defconfig
mips                        omega2p_defconfig
mips                          ath25_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   motionpro_defconfig
i386                             alldefconfig
mips                  maltasmvp_eva_defconfig
sh                   sh7770_generic_defconfig
sh                           se7705_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm5200_defconfig
sparc                               defconfig
arm                          lpd270_defconfig
arm                         lpc18xx_defconfig
s390                             allyesconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8555_defconfig
powerpc                    amigaone_defconfig
mips                      fuloong2e_defconfig
arm                       aspeed_g5_defconfig
arm                         nhk8815_defconfig
sh                               alldefconfig
sh                               j2_defconfig
mips                       capcella_defconfig
mips                      pistachio_defconfig
openrisc                    or1ksim_defconfig
sh                          polaris_defconfig
arm                           corgi_defconfig
powerpc                      walnut_defconfig
arm                        mvebu_v7_defconfig
mips                         mpc30x_defconfig
powerpc                         ps3_defconfig
arm                  colibri_pxa300_defconfig
arm                     eseries_pxa_defconfig
sparc64                          alldefconfig
sh                        dreamcast_defconfig
xtensa                  cadence_csp_defconfig
m68k                            q40_defconfig
mips                malta_qemu_32r6_defconfig
arm                        multi_v7_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210125
x86_64               randconfig-a002-20210125
x86_64               randconfig-a001-20210125
x86_64               randconfig-a005-20210125
x86_64               randconfig-a006-20210125
x86_64               randconfig-a004-20210125
i386                 randconfig-a001-20210125
i386                 randconfig-a002-20210125
i386                 randconfig-a004-20210125
i386                 randconfig-a006-20210125
i386                 randconfig-a005-20210125
i386                 randconfig-a003-20210125
x86_64               randconfig-a012-20210126
x86_64               randconfig-a016-20210126
x86_64               randconfig-a015-20210126
x86_64               randconfig-a011-20210126
x86_64               randconfig-a013-20210126
x86_64               randconfig-a014-20210126
i386                 randconfig-a013-20210125
i386                 randconfig-a011-20210125
i386                 randconfig-a012-20210125
i386                 randconfig-a015-20210125
i386                 randconfig-a014-20210125
i386                 randconfig-a016-20210125
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210125
x86_64               randconfig-a016-20210125
x86_64               randconfig-a015-20210125
x86_64               randconfig-a011-20210125
x86_64               randconfig-a013-20210125
x86_64               randconfig-a014-20210125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
