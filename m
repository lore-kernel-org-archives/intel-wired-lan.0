From: kernel test robot <lkp@intel.com>
Date: Thu, 04 Jun 2020 21:43:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 1ce658b95bf35a2d655bef40caa780543ec2a319
Message-ID: <5ed8fa82.OmyOS4bI85BwMP0n%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 1ce658b95bf35a2d655bef40caa780543ec2a319  ethernet/intel: Convert fallthrough code comments

Error/Warning in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2269:15: error: redefinition of 'truesize'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-defconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize

elapsed time: 486m

configs tested: 98
configs skipped: 1

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                         hackkit_defconfig
sh                         apsh4a3a_defconfig
arm                            mmp2_defconfig
arm                        neponset_defconfig
arm                         orion5x_defconfig
arm                       aspeed_g4_defconfig
sh                          r7780mp_defconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
mips                           ci20_defconfig
arm                         ebsa110_defconfig
arm                          moxart_defconfig
arm                     eseries_pxa_defconfig
arm                           stm32_defconfig
arm                     am200epdkit_defconfig
powerpc                    gamecube_defconfig
nios2                            alldefconfig
arm                              zx_defconfig
microblaze                    nommu_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
