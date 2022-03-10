From: kernel test robot <lkp@intel.com>
Date: Thu, 10 Mar 2022 23:36:44 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 02ddec1986ff0b8de20094aae2fa5b8f8ee7e1a3
Message-ID: <622a1b0c.IJs4J4g+CRCGHJH+%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: 02ddec1986ff0b8de20094aae2fa5b8f8ee7e1a3  ice: Add support for outer dest MAC for ADQ tunnels

elapsed time: 729m

configs tested: 89
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
i386                          randconfig-c001
arm                        realview_defconfig
mips                      fuloong2e_defconfig
sh                          kfr2r09_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7770_generic_defconfig
arc                        vdk_hs38_defconfig
sh                               j2_defconfig
sh                             shx3_defconfig
sh                     magicpanelr2_defconfig
xtensa                    xip_kc705_defconfig
ia64                         bigsur_defconfig
arm                        oxnas_v6_defconfig
powerpc                        warp_defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
arc                  randconfig-r043-20220310
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
arm                         orion5x_defconfig
powerpc                      walnut_defconfig
powerpc                        fsp2_defconfig
mips                        qi_lb60_defconfig
powerpc                     mpc5200_defconfig
powerpc               mpc834x_itxgp_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a001
hexagon              randconfig-r041-20220310
hexagon              randconfig-r045-20220310
s390                 randconfig-r044-20220310

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
