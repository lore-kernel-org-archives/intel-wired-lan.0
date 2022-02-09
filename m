From: kernel test robot <lkp@intel.com>
Date: Wed, 09 Feb 2022 15:13:30 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD REGRESSION
 c3e676b98326a419f30dd5d956c68fc33323f4fd
Message-ID: <6203699a.dFeegLCactlnd9Ju%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: c3e676b98326a419f30dd5d956c68fc33323f4fd  Merge branch 'inet-separate-dscp-from-ecn-bits-using-new-dscp_t-type'

Error/Warning reports:

https://lore.kernel.org/lkml/202202090647.RlBrHxf1-lkp at intel.com

Error/Warning in current branch:

(.text+0x2240): undefined reference to `ipv6_mc_check_mld'

possible Error/Warning in current branch (please contact us if interested):

net/hsr/hsr_framereg.c:607 hsr_get_next_node() warn: ignoring unreachable code.

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- parisc-randconfig-r012-20220208
|   `-- (.text):undefined-reference-to-ipv6_mc_check_mld
`-- x86_64-randconfig-m001-20220207
    `-- net-hsr-hsr_framereg.c-hsr_get_next_node()-warn:ignoring-unreachable-code.

elapsed time: 1373m

configs tested: 164
configs skipped: 4

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
i386                          randconfig-c001
powerpc                   motionpro_defconfig
sh                   sh7724_generic_defconfig
sh                               alldefconfig
arc                          axs103_defconfig
sh                          rsk7264_defconfig
mips                  decstation_64_defconfig
sh                           se7750_defconfig
openrisc                         alldefconfig
sparc                       sparc64_defconfig
m68k                        m5272c3_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm8548_defconfig
sh                          urquell_defconfig
mips                     decstation_defconfig
sh                         microdev_defconfig
xtensa                  nommu_kc705_defconfig
h8300                     edosk2674_defconfig
nds32                               defconfig
m68k                       m5475evb_defconfig
powerpc                      mgcoge_defconfig
powerpc                 canyonlands_defconfig
powerpc                     stx_gp3_defconfig
sparc64                             defconfig
mips                       bmips_be_defconfig
mips                           jazz_defconfig
powerpc                     sequoia_defconfig
mips                         tb0226_defconfig
m68k                       m5249evb_defconfig
arm                        realview_defconfig
m68k                          sun3x_defconfig
mips                        jmr3927_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    amigaone_defconfig
sh                          sdk7780_defconfig
sh                   rts7751r2dplus_defconfig
riscv                            allmodconfig
arm                      jornada720_defconfig
mips                         db1xxx_defconfig
sh                             sh03_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
arm                        mvebu_v7_defconfig
mips                            gpr_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7724_defconfig
powerpc                     tqm8541_defconfig
mips                      fuloong2e_defconfig
mips                        bcm47xx_defconfig
sh                         apsh4a3a_defconfig
mips                    maltaup_xpa_defconfig
parisc                           alldefconfig
m68k                        m5407c3_defconfig
sh                           se7780_defconfig
arm                         axm55xx_defconfig
powerpc                  storcenter_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
mips                 decstation_r4k_defconfig
powerpc                       maple_defconfig
riscv                    nommu_k210_defconfig
sh                           se7619_defconfig
arm                  randconfig-c002-20220208
arm                  randconfig-c002-20220209
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a002
x86_64                        randconfig-a004
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220209
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20220209
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220209
i386                          randconfig-c001
mips                 randconfig-c004-20220209
arm                  randconfig-c002-20220209
riscv                randconfig-c006-20220208
powerpc              randconfig-c003-20220208
mips                 randconfig-c004-20220208
arm                  randconfig-c002-20220208
riscv                             allnoconfig
mips                        qi_lb60_defconfig
arm                          ixp4xx_defconfig
mips                           ip27_defconfig
arm                  colibri_pxa270_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                 mpc836x_mds_defconfig
mips                        workpad_defconfig
arm                         s3c2410_defconfig
hexagon                             defconfig
powerpc                        icon_defconfig
powerpc                     tqm8540_defconfig
mips                  cavium_octeon_defconfig
powerpc                     kmeter1_defconfig
arm                         orion5x_defconfig
arm                         hackkit_defconfig
powerpc                     mpc512x_defconfig
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a001
i386                          randconfig-a004
i386                          randconfig-a002
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a015
i386                          randconfig-a011
i386                          randconfig-a013
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
