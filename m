From: kbuild test robot <lkp@intel.com>
Date: Wed, 22 Aug 2018 23:29:54 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD SUCCESS
 ab83b27e947825c298df09f130e67a775ac3e7d0
Message-ID: <5b7d8172.+ce33gbhSEHN5To3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
branch HEAD: ab83b27e947825c298df09f130e67a775ac3e7d0  fq_codel: fix NULL pointer deref in fq_codel_reset

elapsed time: 73m

configs tested: 156

The following configs have been built successfully.
More configs may be tested in the coming days.

powerpc                  mpc885_ads_defconfig
m68k                          hp300_defconfig
powerpc                     tqm8560_defconfig
x86_64                 randconfig-a0-08222229
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-x018-201833
i386                   randconfig-x010-201833
i386                   randconfig-x017-201833
i386                   randconfig-x016-201833
i386                   randconfig-x013-201833
i386                   randconfig-x011-201833
i386                   randconfig-x015-201833
i386                   randconfig-x019-201833
i386                   randconfig-x014-201833
i386                   randconfig-x012-201833
x86_64                              fedora-25
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201833
x86_64                 randconfig-x000-201833
x86_64                 randconfig-x001-201833
x86_64                 randconfig-x002-201833
x86_64                 randconfig-x003-201833
x86_64                 randconfig-x004-201833
x86_64                 randconfig-x005-201833
x86_64                 randconfig-x006-201833
x86_64                 randconfig-x007-201833
x86_64                 randconfig-x008-201833
x86_64                 randconfig-x009-201833
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201833
i386                     randconfig-i1-201833
arm                              allmodconfig
arm                            mmp2_defconfig
x86_64                 randconfig-g0-08221753
i386                             allmodconfig
x86_64                 randconfig-x019-201833
x86_64                 randconfig-x013-201833
x86_64                 randconfig-x017-201833
x86_64                 randconfig-x012-201833
x86_64                 randconfig-x018-201833
x86_64                 randconfig-x010-201833
x86_64                 randconfig-x014-201833
x86_64                 randconfig-x011-201833
x86_64                 randconfig-x016-201833
x86_64                 randconfig-x015-201833
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
i386                     randconfig-a1-201833
i386                     randconfig-a0-201833
x86_64                 randconfig-s0-08222153
x86_64                 randconfig-s1-08222153
x86_64                 randconfig-s2-08222153
openrisc                    or1ksim_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201833
i386                     randconfig-s1-201833
x86_64                 randconfig-s3-08222231
x86_64                 randconfig-s4-08222231
x86_64                 randconfig-s5-08222231
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                   randconfig-i0-201833
i386                   randconfig-b0-08222009
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                          simpad_defconfig
x86_64                 randconfig-u0-08222239
x86_64                randconfig-ne0-08221857
x86_64                 randconfig-h0-08221858
i386                   randconfig-x002-201833
i386                   randconfig-x003-201833
i386                   randconfig-x005-201833
i386                   randconfig-x008-201833
i386                   randconfig-x007-201833
i386                   randconfig-x000-201833
i386                   randconfig-x001-201833
i386                   randconfig-x004-201833
i386                   randconfig-x009-201833
i386                   randconfig-x006-201833
i386                   randconfig-x077-201833
i386                   randconfig-x076-201833
i386                   randconfig-x070-201833
i386                   randconfig-x072-201833
i386                   randconfig-x075-201833
i386                   randconfig-x074-201833
i386                   randconfig-x071-201833
i386                   randconfig-x078-201833
i386                   randconfig-x079-201833
i386                   randconfig-x073-201833
arm                           spitz_defconfig
mips                             alldefconfig
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
x86_64                randconfig-ws0-08221620
x86_64                                  kexec
arm                     davinci_all_defconfig
arm                         socfpga_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                   randconfig-x0-08221827

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
