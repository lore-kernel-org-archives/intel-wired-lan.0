From: kbuild test robot <lkp@intel.com>
Date: Thu, 09 Aug 2018 03:52:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 2df1944298d9ee88db98535434a22226844b49c3
Message-ID: <5b6b49fd.093CzzKqxzOD9xDM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 2df1944298d9ee88db98535434a22226844b49c3  i40e: Fix for tx timeouts when interface is brought up if DCB is enabled

elapsed time: 95m

configs tested: 159

The following configs have been built successfully.
More configs may be tested in the coming days.

ia64                             allmodconfig
powerpc                  iss476-smp_defconfig
x86_64                 randconfig-a0-08090238
powerpc                      pasemi_defconfig
s390                             allyesconfig
i386                   randconfig-c0-08090243
i386                               tinyconfig
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i1-201831
i386                     randconfig-i0-201831
c6x                        evmc6474_defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              fedora-25
x86_64                 randconfig-g0-08082351
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
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
i386                     randconfig-a1-201831
i386                     randconfig-a0-201831
x86_64                 randconfig-s0-08090253
x86_64                 randconfig-s1-08090253
x86_64                 randconfig-s2-08090253
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                     randconfig-s0-201831
i386                     randconfig-s1-201831
x86_64                           allmodconfig
x86_64                 randconfig-s3-08090255
x86_64                 randconfig-s4-08090255
x86_64                 randconfig-s5-08090255
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201831
i386                   randconfig-b0-08090222
x86_64                 randconfig-b0-08081716
arm                           sunxi_defconfig
mips                      bmips_stb_defconfig
x86_64                 randconfig-u0-08090236
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
x86_64                randconfig-ne0-08090237
x86_64                 randconfig-h0-08090247
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                     stx_gp3_defconfig
x86_64                randconfig-ws0-08082102
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm64                             allnoconfig
arm64                               defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                         tb0219_defconfig
s390                    performance_defconfig
x86_64                 randconfig-r0-08090236
i386                   randconfig-x0-08090252

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
