From: kernel test robot <lkp@intel.com>
Date: Wed, 09 Mar 2022 22:13:28 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 d307eab593b283849c13703ca3fd6a5b3908d6f8
Message-ID: <6228b608.oHFs5/Z5bqI4dxHQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: d307eab593b283849c13703ca3fd6a5b3908d6f8  Merge branch 'net-phy-lan87xx-use-genphy_read_master_slave-function'

elapsed time: 1340m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arm                            zeus_defconfig
powerpc                         wii_defconfig
sh                   rts7751r2dplus_defconfig
m68k                            q40_defconfig
powerpc                    klondike_defconfig
arm                           u8500_defconfig
sh                           se7619_defconfig
powerpc                      pasemi_defconfig
sh                ecovec24-romimage_defconfig
sh                          rsk7264_defconfig
powerpc                     tqm8548_defconfig
sh                     magicpanelr2_defconfig
m68k                        mvme147_defconfig
arm                            hisi_defconfig
arm                        shmobile_defconfig
sh                   sh7724_generic_defconfig
arm                        mini2440_defconfig
sh                           se7206_defconfig
xtensa                          iss_defconfig
arm                          simpad_defconfig
nds32                             allnoconfig
arm                  randconfig-c002-20220308
arm                  randconfig-c002-20220309
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
nios2                               defconfig
arc                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220308
riscv                randconfig-r042-20220308
s390                 randconfig-r044-20220308
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-c007
riscv                randconfig-c006-20220309
powerpc              randconfig-c003-20220309
i386                          randconfig-c001
arm                  randconfig-c002-20220309
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
mips                           ip22_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0219_defconfig
arm                           spitz_defconfig
x86_64                           allyesconfig
powerpc                      obs600_defconfig
mips                malta_qemu_32r6_defconfig
arm                            mmp2_defconfig
riscv                            alldefconfig
powerpc                      ppc64e_defconfig
arm                       cns3420vb_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                          imote2_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     mpc512x_defconfig
powerpc                     kmeter1_defconfig
hexagon                             defconfig
powerpc                      ppc44x_defconfig
mips                       lemote2f_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220309
hexagon              randconfig-r041-20220309
riscv                randconfig-r042-20220309
hexagon              randconfig-r045-20220308
hexagon              randconfig-r041-20220308

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
