From: kernel test robot <lkp@intel.com>
Date: Wed, 16 Sep 2020 14:21:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE] BUILD SUCCESS
 8cbf74149903382cf422c653d4ee8fb2f44e3ec8
Message-ID: <5f61aeea.xRxB8gbaFc+tjOKz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  40GbE
branch HEAD: 8cbf74149903382cf422c653d4ee8fb2f44e3ec8  i40e, xsk: move buffer allocation out of the Rx processing loop

elapsed time: 1985m

configs tested: 210
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
arm                           corgi_defconfig
sparc64                             defconfig
powerpc                      ppc6xx_defconfig
powerpc                      walnut_defconfig
c6x                         dsk6455_defconfig
powerpc                 canyonlands_defconfig
sh                               j2_defconfig
arm                          ixp4xx_defconfig
xtensa                              defconfig
mips                         cobalt_defconfig
sh                          r7780mp_defconfig
powerpc                    mvme5100_defconfig
um                             i386_defconfig
arc                            hsdk_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         socfpga_defconfig
sh                          r7785rp_defconfig
s390                             alldefconfig
mips                        nlm_xlp_defconfig
microblaze                    nommu_defconfig
sh                           se7780_defconfig
arm                         shannon_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
i386                             alldefconfig
powerpc                     tqm5200_defconfig
m68k                        m5407c3_defconfig
powerpc                       holly_defconfig
mips                      maltaaprp_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      mgcoge_defconfig
mips                        bcm47xx_defconfig
arc                        nsimosci_defconfig
ia64                                defconfig
arm                         ebsa110_defconfig
arm                          gemini_defconfig
arc                           tb10x_defconfig
powerpc                     tqm8560_defconfig
m68k                          hp300_defconfig
powerpc                      obs600_defconfig
riscv                            alldefconfig
arm                        multi_v5_defconfig
powerpc                     tqm8541_defconfig
arm                         hackkit_defconfig
nds32                             allnoconfig
arm                             ezx_defconfig
xtensa                    xip_kc705_defconfig
arm                        spear6xx_defconfig
mips                           jazz_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc64e_defconfig
arm                         lpc18xx_defconfig
mips                     loongson1c_defconfig
sh                   secureedge5410_defconfig
mips                  decstation_64_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          pcm027_defconfig
powerpc                       eiger_defconfig
arm                      integrator_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      katmai_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         wii_defconfig
arm                          exynos_defconfig
ia64                         bigsur_defconfig
arm                       aspeed_g5_defconfig
sparc                       sparc64_defconfig
riscv                            allmodconfig
arm                        spear3xx_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7751_defconfig
sh                   sh7770_generic_defconfig
ia64                            zx1_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  iss476-smp_defconfig
mips                         tb0219_defconfig
arm                        mini2440_defconfig
arm                          lpd270_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     tqm8540_defconfig
powerpc                     kmeter1_defconfig
arm                          simpad_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
x86_64               randconfig-a004-20200914
x86_64               randconfig-a006-20200914
x86_64               randconfig-a003-20200914
x86_64               randconfig-a002-20200914
x86_64               randconfig-a001-20200914
x86_64               randconfig-a005-20200914
i386                 randconfig-a004-20200913
i386                 randconfig-a006-20200913
i386                 randconfig-a003-20200913
i386                 randconfig-a001-20200913
i386                 randconfig-a002-20200913
i386                 randconfig-a005-20200913
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a004-20200914
i386                 randconfig-a006-20200914
i386                 randconfig-a001-20200914
i386                 randconfig-a003-20200914
i386                 randconfig-a002-20200914
i386                 randconfig-a005-20200914
x86_64               randconfig-a014-20200913
x86_64               randconfig-a011-20200913
x86_64               randconfig-a012-20200913
x86_64               randconfig-a016-20200913
x86_64               randconfig-a015-20200913
x86_64               randconfig-a013-20200913
i386                 randconfig-a015-20200915
i386                 randconfig-a014-20200915
i386                 randconfig-a011-20200915
i386                 randconfig-a013-20200915
i386                 randconfig-a016-20200915
i386                 randconfig-a012-20200915
i386                 randconfig-a015-20200913
i386                 randconfig-a014-20200913
i386                 randconfig-a011-20200913
i386                 randconfig-a013-20200913
i386                 randconfig-a016-20200913
i386                 randconfig-a012-20200913
i386                 randconfig-a015-20200914
i386                 randconfig-a014-20200914
i386                 randconfig-a011-20200914
i386                 randconfig-a013-20200914
i386                 randconfig-a016-20200914
i386                 randconfig-a012-20200914
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200913
x86_64               randconfig-a004-20200913
x86_64               randconfig-a003-20200913
x86_64               randconfig-a002-20200913
x86_64               randconfig-a005-20200913
x86_64               randconfig-a001-20200913
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916
x86_64               randconfig-a014-20200914
x86_64               randconfig-a011-20200914
x86_64               randconfig-a016-20200914
x86_64               randconfig-a012-20200914
x86_64               randconfig-a015-20200914
x86_64               randconfig-a013-20200914

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
