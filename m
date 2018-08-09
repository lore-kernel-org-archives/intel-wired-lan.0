From: kbuild test robot <lkp@intel.com>
Date: Thu, 09 Aug 2018 23:34:21 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 1b93b3f2b0e397b27651d8de9467d908560e985d
Message-ID: <5b6c5efd.KO7kcjSzOAn7cJTb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 1b93b3f2b0e397b27651d8de9467d908560e985d  i40e: Fix for tx timeouts when interface is brought up if DCB is enabled

elapsed time: 92m

configs tested: 158

The following configs have been built successfully.
More configs may be tested in the coming days.

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-a0-08092204
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-08092105
x86_64                           allmodconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201831
x86_64                 randconfig-x000-201831
x86_64                 randconfig-x009-201831
x86_64                 randconfig-x004-201831
x86_64                 randconfig-x001-201831
x86_64                 randconfig-x003-201831
x86_64                 randconfig-x007-201831
x86_64                 randconfig-x008-201831
x86_64                 randconfig-x002-201831
x86_64                 randconfig-x005-201831
x86_64                 randconfig-x006-201831
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201831
i386                     randconfig-i1-201831
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
m68k                             allyesconfig
mips                      malta_kvm_defconfig
x86_64                 randconfig-g0-08092018
i386                             allmodconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
i386                     randconfig-a0-201831
i386                     randconfig-a1-201831
x86_64                 randconfig-s0-08092201
x86_64                 randconfig-s1-08092201
x86_64                 randconfig-s2-08092201
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                         dsk6455_defconfig
powerpc                    mvme5100_defconfig
sh                            shmin_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201831
i386                     randconfig-s1-201831
x86_64                 randconfig-s3-08092143
x86_64                 randconfig-s4-08092143
x86_64                 randconfig-s5-08092143
x86_64                 randconfig-s3-08092212
x86_64                 randconfig-s4-08092212
x86_64                 randconfig-s5-08092212
arm                          iop32x_defconfig
mips                              allnoconfig
x86_64                   randconfig-i0-201831
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m68k                         apollo_defconfig
sh                           se7751_defconfig
powerpc                      pcm030_defconfig
x86_64                 randconfig-u0-08092109
x86_64                randconfig-ne0-08091902
i386                   randconfig-x002-201831
i386                   randconfig-x005-201831
i386                   randconfig-x003-201831
i386                   randconfig-x008-201831
i386                   randconfig-x007-201831
i386                   randconfig-x000-201831
i386                   randconfig-x001-201831
i386                   randconfig-x004-201831
i386                   randconfig-x009-201831
i386                   randconfig-x006-201831
x86_64                 randconfig-x019-201831
x86_64                 randconfig-x013-201831
x86_64                 randconfig-x017-201831
x86_64                 randconfig-x018-201831
x86_64                 randconfig-x012-201831
x86_64                 randconfig-x010-201831
x86_64                 randconfig-x014-201831
x86_64                 randconfig-x011-201831
x86_64                 randconfig-x016-201831
x86_64                 randconfig-x015-201831
i386                   randconfig-x018-201831
i386                   randconfig-x010-201831
i386                   randconfig-x017-201831
i386                   randconfig-x016-201831
i386                   randconfig-x013-201831
i386                   randconfig-x011-201831
i386                   randconfig-x015-201831
i386                   randconfig-x019-201831
i386                   randconfig-x012-201831
i386                   randconfig-x014-201831
i386                   randconfig-x077-201831
i386                   randconfig-x070-201831
i386                   randconfig-x076-201831
i386                   randconfig-x072-201831
i386                   randconfig-x075-201831
i386                   randconfig-x074-201831
i386                   randconfig-x078-201831
i386                   randconfig-x071-201831
i386                   randconfig-x073-201831
i386                   randconfig-x079-201831
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
mips                       capcella_defconfig
mips                           xway_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-x0-08092206

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
