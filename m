From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 May 2020 16:38:06 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 1ae51690bc317eb011c6fcc8f5549b151b347167
Message-ID: <5ebfa66e.RjiXGOYeRkpvcU/K%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 1ae51690bc317eb011c6fcc8f5549b151b347167  e1000e: Relax condition to trigger reset for ME workaround

Error/Warning in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2271:15: error: redefinition of 'truesize'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
`-- sparc-allyesconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize

elapsed time: 507m

configs tested: 119
configs skipped: 7

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
mips                             allyesconfig
arm                           u8500_defconfig
arm                           spitz_defconfig
microblaze                          defconfig
arm                         at91_dt_defconfig
sh                          sdk7786_defconfig
powerpc                    gamecube_defconfig
ia64                         bigsur_defconfig
sh                        sh7757lcr_defconfig
powerpc                          allyesconfig
arm                        spear6xx_defconfig
m68k                        m5407c3_defconfig
x86_64                              defconfig
arm                           sama5_defconfig
arm                        realview_defconfig
arm                       spear13xx_defconfig
sh                           se7751_defconfig
arm                  colibri_pxa270_defconfig
openrisc                    or1ksim_defconfig
arm                        spear3xx_defconfig
i386                             allyesconfig
arm                           omap1_defconfig
arm                         lubbock_defconfig
arm                          badge4_defconfig
powerpc                         ps3_defconfig
arm                         bcm2835_defconfig
c6x                        evmc6678_defconfig
arm                           tegra_defconfig
arm                              zx_defconfig
i386                              allnoconfig
arm                         lpc18xx_defconfig
arm                       cns3420vb_defconfig
riscv                    nommu_virt_defconfig
microblaze                    nommu_defconfig
um                                allnoconfig
arm                       mainstone_defconfig
mips                  maltasmvp_eva_defconfig
mips                          malta_defconfig
sh                                allnoconfig
sh                          rsk7201_defconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
microblaze                        allnoconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a012-20200515
i386                 randconfig-a016-20200515
i386                 randconfig-a014-20200515
i386                 randconfig-a011-20200515
i386                 randconfig-a013-20200515
i386                 randconfig-a015-20200515
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
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
