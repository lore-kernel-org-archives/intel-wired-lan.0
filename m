From: kernel test robot <lkp@intel.com>
Date: Sat, 19 Mar 2022 17:18:06 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 f52f53abfd80dfb00f2cde5db43821b50fe57be5
Message-ID: <62359fce.yVOs7jzs4jwmftTL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: f52f53abfd80dfb00f2cde5db43821b50fe57be5  ice: clear cmd_type_offset_bsz for TX rings

elapsed time: 721m

configs tested: 144
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
arm64                            alldefconfig
arm                            xcep_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                         ap325rxa_defconfig
sh                             espt_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
m68k                          multi_defconfig
csky                             alldefconfig
arm                        mini2440_defconfig
arm                        mvebu_v7_defconfig
arm                        multi_v7_defconfig
mips                         rt305x_defconfig
ia64                        generic_defconfig
arm                        keystone_defconfig
xtensa                           alldefconfig
arm                            hisi_defconfig
arm                          lpd270_defconfig
parisc                           allyesconfig
mips                     decstation_defconfig
sh                              ul2_defconfig
arc                                 defconfig
m68k                        m5307c3_defconfig
mips                         mpc30x_defconfig
m68k                           sun3_defconfig
sh                        edosk7705_defconfig
powerpc                   motionpro_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           sh2007_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
arm                           corgi_defconfig
ia64                          tiger_defconfig
powerpc                  storcenter_defconfig
powerpc                       maple_defconfig
powerpc                     ep8248e_defconfig
sh                           se7343_defconfig
mips                         tb0226_defconfig
sh                           se7619_defconfig
alpha                            alldefconfig
arm                             rpc_defconfig
arm                        trizeps4_defconfig
alpha                               defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7705_defconfig
openrisc                         alldefconfig
sh                          sdk7780_defconfig
powerpc                      bamboo_defconfig
arm                         lubbock_defconfig
arc                          axs101_defconfig
arm                             pxa_defconfig
mips                  maltasmvp_eva_defconfig
arm                        realview_defconfig
m68k                            mac_defconfig
sh                            hp6xx_defconfig
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
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
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
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
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220318
arm                  randconfig-c002-20220317
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220318
riscv                randconfig-c006-20220318
riscv                randconfig-c006-20220317
powerpc              randconfig-c003-20220317
mips                 randconfig-c004-20220317
mips                 randconfig-c004-20220318
i386                          randconfig-c001
mips                        qi_lb60_defconfig
hexagon                          alldefconfig
powerpc                     tqm8540_defconfig
mips                           ip22_defconfig
powerpc                        icon_defconfig
i386                             allyesconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220318
hexagon              randconfig-r045-20220317
hexagon              randconfig-r041-20220318
riscv                randconfig-r042-20220318
hexagon              randconfig-r041-20220317

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
