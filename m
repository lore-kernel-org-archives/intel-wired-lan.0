From: kernel test robot <lkp@intel.com>
Date: Tue, 19 Oct 2021 13:49:23 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 ab797d77ffd32f277fbe473594f27dae00fb88c7
Message-ID: <616e5c63.zHLj58jnWGd0b4cp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: ab797d77ffd32f277fbe473594f27dae00fb88c7  igb: support EXTTS on 82580/i354/i350

elapsed time: 727m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
arm                         bcm2835_defconfig
powerpc                    mvme5100_defconfig
arm                            pleb_defconfig
sh                         microdev_defconfig
m68k                       m5275evb_defconfig
arm                         axm55xx_defconfig
arm                            qcom_defconfig
arm64                            alldefconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
sparc                               defconfig
powerpc                     pseries_defconfig
mips                       capcella_defconfig
arm                         assabet_defconfig
powerpc                     kilauea_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         orion5x_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                          imote2_defconfig
powerpc                      makalu_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        neponset_defconfig
powerpc                           allnoconfig
sh                             sh03_defconfig
mips                       rbtx49xx_defconfig
arm                  colibri_pxa270_defconfig
sh                           se7619_defconfig
powerpc                      pasemi_defconfig
powerpc                      acadia_defconfig
ia64                            zx1_defconfig
m68k                        m5307c3_defconfig
powerpc                      mgcoge_defconfig
m68k                        m5407c3_defconfig
arm                        keystone_defconfig
powerpc64                        alldefconfig
arm                           sunxi_defconfig
arm                           corgi_defconfig
arm                        realview_defconfig
powerpc                  storcenter_defconfig
m68k                       bvme6000_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                     eseries_pxa_defconfig
arm                         palmz72_defconfig
powerpc                   currituck_defconfig
riscv                             allnoconfig
h8300                               defconfig
powerpc                 mpc834x_mds_defconfig
arm                  randconfig-c002-20211019
i386                 randconfig-c001-20211019
x86_64               randconfig-c001-20211019
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20211019
x86_64               randconfig-a012-20211019
x86_64               randconfig-a016-20211019
x86_64               randconfig-a014-20211019
x86_64               randconfig-a013-20211019
x86_64               randconfig-a011-20211019
i386                 randconfig-a014-20211019
i386                 randconfig-a016-20211019
i386                 randconfig-a011-20211019
i386                 randconfig-a015-20211019
i386                 randconfig-a012-20211019
i386                 randconfig-a013-20211019
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
i386                 randconfig-a001-20211019
i386                 randconfig-a003-20211019
i386                 randconfig-a004-20211019
i386                 randconfig-a005-20211019
i386                 randconfig-a002-20211019
i386                 randconfig-a006-20211019
x86_64               randconfig-a004-20211019
x86_64               randconfig-a006-20211019
x86_64               randconfig-a005-20211019
x86_64               randconfig-a001-20211019
x86_64               randconfig-a002-20211019
x86_64               randconfig-a003-20211019
hexagon              randconfig-r041-20211019
hexagon              randconfig-r045-20211019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
