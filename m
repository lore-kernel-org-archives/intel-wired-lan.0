From: kernel test robot <lkp@intel.com>
Date: Wed, 17 Jun 2020 19:26:31 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 8c37258160cd593243cb251b6b44d9b396e59078
Message-ID: <5ee9fde7.dFyM4CBIMnpaw9oo%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: 8c37258160cd593243cb251b6b44d9b396e59078  i40e: fix crash when Rx descriptor count is changed

elapsed time: 724m

configs tested: 118
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
sh                                  defconfig
xtensa                    xip_kc705_defconfig
powerpc                      mgcoge_defconfig
c6x                        evmc6678_defconfig
arc                           tb10x_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
arm                       cns3420vb_defconfig
xtensa                              defconfig
sh                          urquell_defconfig
mips                           mtx1_defconfig
mips                       capcella_defconfig
mips                  mips_paravirt_defconfig
mips                      pistachio_defconfig
mips                   sb1250_swarm_defconfig
mips                           ip28_defconfig
mips                           ip27_defconfig
arm                       netwinder_defconfig
sh                           se7721_defconfig
m68k                          hp300_defconfig
powerpc                    mvme5100_defconfig
sh                          r7785rp_defconfig
arm                        magician_defconfig
arm                         ebsa110_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7757lcr_defconfig
arm                           sunxi_defconfig
i386                              allnoconfig
i386                             allyesconfig
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
m68k                             allyesconfig
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
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200615
i386                 randconfig-a002-20200615
i386                 randconfig-a001-20200615
i386                 randconfig-a004-20200615
i386                 randconfig-a005-20200615
i386                 randconfig-a003-20200615
i386                 randconfig-a015-20200617
i386                 randconfig-a011-20200617
i386                 randconfig-a014-20200617
i386                 randconfig-a016-20200617
i386                 randconfig-a013-20200617
i386                 randconfig-a012-20200617
riscv                            allyesconfig
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
