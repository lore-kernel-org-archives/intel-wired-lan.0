From: kernel test robot <lkp@intel.com>
Date: Sat, 04 Dec 2021 10:37:22 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 404189e29907502e06179af67790aea01d826f30
Message-ID: <61aad462.kbTs2qEgp7+JQ4C0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 404189e29907502e06179af67790aea01d826f30  ice: remove dead store on XSK hotpath

elapsed time: 1880m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20211202
i386                 randconfig-c001-20211203
arm                         lubbock_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
microblaze                          defconfig
arm                        shmobile_defconfig
arm                       imx_v6_v7_defconfig
um                             i386_defconfig
powerpc                     sequoia_defconfig
arm                          ep93xx_defconfig
arm                     davinci_all_defconfig
h8300                     edosk2674_defconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
powerpc                     ppa8548_defconfig
nios2                               defconfig
powerpc                  mpc866_ads_defconfig
sh                          kfr2r09_defconfig
mips                           mtx1_defconfig
powerpc                     tqm8555_defconfig
powerpc                     tqm8541_defconfig
arm                        mini2440_defconfig
sh                        apsh4ad0a_defconfig
arm                             pxa_defconfig
arm                         hackkit_defconfig
parisc                              defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         at91_dt_defconfig
powerpc                     powernv_defconfig
um                           x86_64_defconfig
arm                            qcom_defconfig
arm                     eseries_pxa_defconfig
ia64                          tiger_defconfig
mips                         tb0226_defconfig
arm                       multi_v4t_defconfig
arm                          simpad_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                         apsh4a3a_defconfig
arm                            pleb_defconfig
h8300                            alldefconfig
arm                         socfpga_defconfig
m68k                       m5208evb_defconfig
powerpc                    mvme5100_defconfig
arm                        multi_v7_defconfig
sh                           se7751_defconfig
sh                         microdev_defconfig
powerpc                       eiger_defconfig
sh                          sdk7786_defconfig
m68k                             allmodconfig
powerpc                    gamecube_defconfig
arm                           h5000_defconfig
m68k                                defconfig
arm                  randconfig-c002-20211203
arm                  randconfig-c002-20211202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211203
x86_64               randconfig-a005-20211203
x86_64               randconfig-a001-20211203
x86_64               randconfig-a002-20211203
x86_64               randconfig-a004-20211203
x86_64               randconfig-a003-20211203
i386                 randconfig-a001-20211203
i386                 randconfig-a005-20211203
i386                 randconfig-a002-20211203
i386                 randconfig-a003-20211203
i386                 randconfig-a006-20211203
i386                 randconfig-a004-20211203
x86_64               randconfig-a016-20211202
x86_64               randconfig-a011-20211202
x86_64               randconfig-a013-20211202
x86_64               randconfig-a014-20211202
x86_64               randconfig-a012-20211202
x86_64               randconfig-a015-20211202
i386                 randconfig-a016-20211202
i386                 randconfig-a013-20211202
i386                 randconfig-a011-20211202
i386                 randconfig-a014-20211202
i386                 randconfig-a012-20211202
i386                 randconfig-a015-20211202
arc                  randconfig-r043-20211202
s390                 randconfig-r044-20211202
riscv                randconfig-r042-20211202
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211203
x86_64               randconfig-c007-20211203
riscv                randconfig-c006-20211203
mips                 randconfig-c004-20211203
i386                 randconfig-c001-20211203
powerpc              randconfig-c003-20211203
s390                 randconfig-c005-20211203
x86_64               randconfig-a006-20211202
x86_64               randconfig-a005-20211202
x86_64               randconfig-a001-20211202
x86_64               randconfig-a002-20211202
x86_64               randconfig-a004-20211202
x86_64               randconfig-a003-20211202
i386                 randconfig-a001-20211202
i386                 randconfig-a005-20211202
i386                 randconfig-a002-20211202
i386                 randconfig-a003-20211202
i386                 randconfig-a006-20211202
i386                 randconfig-a004-20211202
x86_64               randconfig-a016-20211203
x86_64               randconfig-a011-20211203
x86_64               randconfig-a013-20211203
x86_64               randconfig-a014-20211203
x86_64               randconfig-a015-20211203
x86_64               randconfig-a012-20211203
i386                 randconfig-a016-20211203
i386                 randconfig-a013-20211203
i386                 randconfig-a011-20211203
i386                 randconfig-a014-20211203
i386                 randconfig-a012-20211203
i386                 randconfig-a015-20211203
hexagon              randconfig-r045-20211203
s390                 randconfig-r044-20211203
hexagon              randconfig-r041-20211203
riscv                randconfig-r042-20211203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
