From: kernel test robot <lkp@intel.com>
Date: Sun, 10 Oct 2021 04:18:49 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 ee1817d76de3215ad25857f436660ca155911b39
Message-ID: <6161f929.i9B6l02YL0llZYHv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: ee1817d76de3215ad25857f436660ca155911b39  ice: Respond to a NETDEV_UNREGISTER event for LAG

elapsed time: 1574m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
i386                 randconfig-c001-20211009
nios2                         10m50_defconfig
mips                       capcella_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                          moxart_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
xtensa                              defconfig
sh                           se7705_defconfig
sh                          r7785rp_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                generic_kc705_defconfig
mips                         db1xxx_defconfig
arm                          ep93xx_defconfig
powerpc                   microwatt_defconfig
x86_64               randconfig-c001-20211008
i386                 randconfig-c001-20211008
arm                  randconfig-c002-20211008
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                              defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20211010
x86_64               randconfig-a006-20211010
x86_64               randconfig-a001-20211010
x86_64               randconfig-a005-20211010
x86_64               randconfig-a002-20211010
x86_64               randconfig-a003-20211010
x86_64               randconfig-a015-20211008
x86_64               randconfig-a012-20211008
x86_64               randconfig-a016-20211008
x86_64               randconfig-a013-20211008
x86_64               randconfig-a011-20211008
x86_64               randconfig-a014-20211008
i386                 randconfig-a013-20211008
i386                 randconfig-a016-20211008
i386                 randconfig-a014-20211008
i386                 randconfig-a011-20211008
i386                 randconfig-a012-20211008
i386                 randconfig-a015-20211008
arc                  randconfig-r043-20211008
s390                 randconfig-r044-20211008
riscv                randconfig-r042-20211008
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a001-20211008
i386                 randconfig-a003-20211008
i386                 randconfig-a005-20211008
i386                 randconfig-a004-20211008
i386                 randconfig-a002-20211008
i386                 randconfig-a006-20211008
hexagon              randconfig-r045-20211008
hexagon              randconfig-r041-20211008
hexagon              randconfig-r041-20211010
s390                 randconfig-r044-20211010
riscv                randconfig-r042-20211010
hexagon              randconfig-r045-20211010
x86_64               randconfig-a003-20211008
x86_64               randconfig-a005-20211008
x86_64               randconfig-a001-20211008
x86_64               randconfig-a002-20211008
x86_64               randconfig-a004-20211008
x86_64               randconfig-a006-20211008

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
