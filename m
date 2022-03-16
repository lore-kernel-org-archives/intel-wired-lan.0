From: kernel test robot <lkp@intel.com>
Date: Wed, 16 Mar 2022 19:09:42 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 5a57ee83d9612342552f63b7a7f4f4bd2e885832
Message-ID: <6231c576.Sg3TrsivxySELegD%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 5a57ee83d9612342552f63b7a7f4f4bd2e885832  ice: remove PF pointer from ice_check_vf_init

elapsed time: 728m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20220314
ia64                         bigsur_defconfig
xtensa                              defconfig
arm                        realview_defconfig
mips                         mpc30x_defconfig
xtensa                  cadence_csp_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          rsk7269_defconfig
sparc                            alldefconfig
openrisc                 simple_smp_defconfig
sh                             shx3_defconfig
arm                  randconfig-c002-20220314
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a003-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a005-20220314
i386                 randconfig-a004-20220314
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220313
riscv                randconfig-r042-20220313
arc                  randconfig-r043-20220314
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                            mmp2_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       imx_v4_v5_defconfig
arm                    vt8500_v6_v7_defconfig
arm                          pcm027_defconfig
powerpc                        icon_defconfig
x86_64               randconfig-a011-20220314
x86_64               randconfig-a014-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a015-20220314
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220313
hexagon              randconfig-r045-20220314
hexagon              randconfig-r041-20220313
s390                 randconfig-r044-20220314
hexagon              randconfig-r041-20220314
riscv                randconfig-r042-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
