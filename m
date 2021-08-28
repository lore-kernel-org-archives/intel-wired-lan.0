From: kernel test robot <lkp@intel.com>
Date: Sat, 28 Aug 2021 13:06:02 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 4baf0e0b329874ec5e85480f53851b5f05a7ae58
Message-ID: <6129c43a.qouBfmWloeC35uE/%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 4baf0e0b329874ec5e85480f53851b5f05a7ae58  um: vector: adjust to coalesce API changes

elapsed time: 728m

configs tested: 103
configs skipped: 110

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                            hsdk_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
powerpc                      tqm8xx_defconfig
arm                         at91_dt_defconfig
mips                     loongson1b_defconfig
arm                         s5pv210_defconfig
xtensa                           alldefconfig
sh                        edosk7705_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
arm                         vf610m4_defconfig
m68k                        m5272c3_defconfig
xtensa                              defconfig
um                                  defconfig
sh                         apsh4a3a_defconfig
arm                        keystone_defconfig
powerpc                     akebono_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                         ap325rxa_defconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         s3c6400_defconfig
powerpc                       holly_defconfig
arm                         bcm2835_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7343_defconfig
arm                         nhk8815_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a013-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
i386                 randconfig-a011-20210827
i386                 randconfig-a016-20210827
i386                 randconfig-a012-20210827
i386                 randconfig-a014-20210827
i386                 randconfig-a013-20210827
i386                 randconfig-a015-20210827
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-a006-20210827
i386                 randconfig-a001-20210827
i386                 randconfig-a002-20210827
i386                 randconfig-a005-20210827
i386                 randconfig-a004-20210827
i386                 randconfig-a003-20210827

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
