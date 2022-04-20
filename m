From: kernel test robot <lkp@intel.com>
Date: Wed, 20 Apr 2022 19:57:54 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 99c07327ae11e24886d552dddbe4537bfca2765d
Message-ID: <625ff542.O9cRIjodvggNwj1x%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 99c07327ae11e24886d552dddbe4537bfca2765d  netlink: reset network and mac headers in netlink_dump()

elapsed time: 1341m

configs tested: 137
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220420
sh                              ul2_defconfig
arm                       aspeed_g5_defconfig
nios2                               defconfig
nios2                            alldefconfig
riscv             nommu_k210_sdcard_defconfig
mips                        vocore2_defconfig
powerpc                        warp_defconfig
sh                     magicpanelr2_defconfig
ia64                         bigsur_defconfig
arm                        keystone_defconfig
powerpc                     redwood_defconfig
mips                     loongson1b_defconfig
m68k                         amcore_defconfig
s390                                defconfig
powerpc                      makalu_defconfig
ia64                        generic_defconfig
mips                            ar7_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7721_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        mvme16x_defconfig
arc                            hsdk_defconfig
mips                       bmips_be_defconfig
mips                      loongson3_defconfig
arc                        nsimosci_defconfig
sh                            hp6xx_defconfig
microblaze                          defconfig
sh                           se7722_defconfig
i386                                defconfig
xtensa                       common_defconfig
m68k                        mvme147_defconfig
ia64                             alldefconfig
sh                        dreamcast_defconfig
sh                   rts7751r2dplus_defconfig
mips                         cobalt_defconfig
arc                     nsimosci_hs_defconfig
arm                           u8500_defconfig
sh                           sh2007_defconfig
csky                                defconfig
sh                        apsh4ad0a_defconfig
sh                          r7785rp_defconfig
arm                        shmobile_defconfig
m68k                        m5307c3_defconfig
arm                        mvebu_v7_defconfig
powerpc                     asp8347_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220420
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220419
s390                 randconfig-r044-20220419
arc                  randconfig-r043-20220419
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
riscv                randconfig-c006-20220420
mips                 randconfig-c004-20220420
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220420
arm                  randconfig-c002-20220420
powerpc              randconfig-c003-20220420
mips                        qi_lb60_defconfig
arm                         s3c2410_defconfig
powerpc                    socrates_defconfig
mips                           ip22_defconfig
arm                         shannon_defconfig
powerpc                      katmai_defconfig
arm                       mainstone_defconfig
powerpc                     ksi8560_defconfig
powerpc                  mpc885_ads_defconfig
arm                         mv78xx0_defconfig
powerpc                      ppc64e_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220420
riscv                randconfig-r042-20220420
hexagon              randconfig-r045-20220420
hexagon              randconfig-r041-20220419
hexagon              randconfig-r045-20220419

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
