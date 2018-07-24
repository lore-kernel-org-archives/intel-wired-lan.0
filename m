From: kbuild test robot <lkp@intel.com>
Date: Tue, 24 Jul 2018 23:13:57 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 fa0d47219922bc26ebab3571844de7e4992f74ee
Message-ID: <5b574235.Qn3mEvkROctYgBCx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: fa0d47219922bc26ebab3571844de7e4992f74ee  fq_codel: fix NULL pointer deref in fq_codel_reset

elapsed time: 36m

configs tested: 143

The following configs have been built successfully.
More configs may be tested in the coming days.

openrisc                         allmodconfig
powerpc                 mpc8560_ads_defconfig
x86_64                 randconfig-a0-07242139
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                          rb532_defconfig
sh                   sh7724_generic_defconfig
i386                   randconfig-c0-07242220
arm                         ebsa110_defconfig
powerpc64                           defconfig
i386                               tinyconfig
i386                   randconfig-x012-201829
i386                   randconfig-x017-201829
i386                   randconfig-x014-201829
i386                   randconfig-x016-201829
i386                   randconfig-x013-201829
i386                   randconfig-x011-201829
i386                   randconfig-x018-201829
i386                   randconfig-x010-201829
i386                   randconfig-x015-201829
i386                   randconfig-x019-201829
i386                     randconfig-n0-201829
x86_64                 randconfig-x007-201829
x86_64                 randconfig-x003-201829
x86_64                 randconfig-x000-201829
x86_64                 randconfig-x005-201829
x86_64                 randconfig-x004-201829
x86_64                 randconfig-x008-201829
x86_64                 randconfig-x001-201829
x86_64                 randconfig-x009-201829
x86_64                 randconfig-x002-201829
x86_64                 randconfig-x006-201829
i386                     randconfig-i0-201829
i386                     randconfig-i1-201829
i386         randconfig-i1-201829-CONFIG_DEBUG_INFO_REDUCED
i386                     randconfig-a0-201829
i386                     randconfig-a1-201829
x86_64                 randconfig-s0-07242150
x86_64                 randconfig-s1-07242150
x86_64                 randconfig-s2-07242150
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
microblaze                      mmu_defconfig
powerpc                      chrp32_defconfig
sh                            migor_defconfig
sh                           se7343_defconfig
x86_64                 randconfig-x018-201829
x86_64                 randconfig-x011-201829
x86_64                 randconfig-x015-201829
x86_64                 randconfig-x019-201829
x86_64                 randconfig-x014-201829
x86_64                 randconfig-x010-201829
x86_64                 randconfig-x013-201829
x86_64                 randconfig-x016-201829
x86_64                 randconfig-x017-201829
x86_64                 randconfig-x012-201829
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201829
i386                     randconfig-s1-201829
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-i0-07241207
arm                            lart_defconfig
powerpc                      pmac32_defconfig
sparc64                             defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-07241752
arm                           viper_defconfig
arm                          lpd270_defconfig
mips                         bigsur_defconfig
x86_64                 randconfig-u0-07242150
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                             pxa_defconfig
h8300                       h8s-sim_defconfig
m68k                             alldefconfig
sh                          rsk7264_defconfig
x86_64                randconfig-ne0-07242103
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
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                           allnoconfig
i386                   randconfig-x078-201829
i386                   randconfig-x070-201829
i386                   randconfig-x075-201829
i386                   randconfig-x076-201829
i386                   randconfig-x074-201829
i386                   randconfig-x079-201829
i386                   randconfig-x071-201829
i386                   randconfig-x073-201829
i386                   randconfig-x072-201829
i386                   randconfig-x077-201829
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
mips                           mtx1_defconfig
i386                   randconfig-x008-201829
i386                   randconfig-x009-201829
i386                   randconfig-x005-201829
i386                   randconfig-x000-201829
i386                   randconfig-x003-201829
i386                   randconfig-x001-201829
i386                   randconfig-x004-201829
i386                   randconfig-x006-201829
i386                   randconfig-x007-201829
i386                   randconfig-x002-201829
i386                   randconfig-x0-07241814

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
