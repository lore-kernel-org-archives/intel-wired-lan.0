From: kbuild test robot <lkp@intel.com>
Date: Sat, 02 Jun 2018 01:03:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 04629d14bef8519bb7ef0dc70976f30fc887e4b1
Message-ID: <5b117c67.U0RntsyqBQ0+LONf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 04629d14bef8519bb7ef0dc70976f30fc887e4b1  ixgbe: fix broken ipsec Rx with proper cast on spi

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:487:56: sparse: restricted __be32 degrades to integer

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer

elapsed time: 164m

configs tested: 173

powerpc                          allyesconfig
powerpc                        fsp2_defconfig
x86_64                 randconfig-a0-06012028
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
ia64                            sim_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-06011941
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
x86_64                randconfig-it0-06010858
i386                   randconfig-x010-201821
i386                   randconfig-x011-201821
i386                   randconfig-x012-201821
i386                   randconfig-x013-201821
i386                   randconfig-x014-201821
i386                   randconfig-x015-201821
i386                   randconfig-x016-201821
i386                   randconfig-x017-201821
i386                   randconfig-x018-201821
i386                   randconfig-x019-201821
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201821
i386                     randconfig-i0-201821
i386                     randconfig-i1-201821
x86_64                 randconfig-v0-06010829
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                 randconfig-x011-201821
x86_64                 randconfig-x015-201821
x86_64                 randconfig-x018-201821
x86_64                 randconfig-x010-201821
x86_64                 randconfig-x019-201821
x86_64                 randconfig-x014-201821
x86_64                 randconfig-x013-201821
x86_64                 randconfig-x016-201821
x86_64                 randconfig-x017-201821
x86_64                 randconfig-x012-201821
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
i386                     randconfig-a0-201821
i386                     randconfig-a1-201821
x86_64                 randconfig-s0-06012209
x86_64                 randconfig-s1-06012209
x86_64                 randconfig-s2-06012209
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             allyesconfig
arm                         bcm2835_defconfig
powerpc                      ep88xc_defconfig
powerpc                     tqm8560_defconfig
nios2                         3c120_defconfig
parisc                           allyesconfig
powerpc                    socrates_defconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                     randconfig-s0-201821
i386                     randconfig-s1-201821
i386         randconfig-s1-201821-CONFIG_DEBUG_INFO_REDUCED
x86_64                           allmodconfig
x86_64                 randconfig-s3-06012155
x86_64                 randconfig-s4-06012155
x86_64                 randconfig-s5-06012155
i386                               tinyconfig
i386                             allmodconfig
m68k                         apollo_defconfig
sh                          landisk_defconfig
xtensa                              defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201821
i386                   randconfig-b0-06012150
x86_64                 randconfig-b0-06012146
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-u0-06012225
i386                   randconfig-h0-06010704
i386                   randconfig-h1-06010704
arm                       mainstone_defconfig
microblaze                       allmodconfig
x86_64                randconfig-ne0-06012220
i386                   randconfig-x078-201821
i386                   randconfig-x079-201821
i386                   randconfig-x070-201821
i386                   randconfig-x075-201821
i386                   randconfig-x076-201821
i386                   randconfig-x074-201821
i386                   randconfig-x071-201821
i386                   randconfig-x073-201821
i386                   randconfig-x077-201821
i386                   randconfig-x072-201821
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-x008-201821
i386                   randconfig-x009-201821
i386                   randconfig-x005-201821
i386                   randconfig-x000-201821
i386                   randconfig-x003-201821
i386                   randconfig-x001-201821
i386                   randconfig-x004-201821
i386                   randconfig-x006-201821
i386                   randconfig-x002-201821
i386                   randconfig-x007-201821
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
x86_64                randconfig-ws0-06011943
mips                         db1xxx_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                randconfig-ws0-06010814
x86_64                 randconfig-x003-201821
x86_64                 randconfig-x007-201821
x86_64                 randconfig-x000-201821
x86_64                 randconfig-x005-201821
x86_64                 randconfig-x004-201821
x86_64                 randconfig-x001-201821
x86_64                 randconfig-x008-201821
x86_64                 randconfig-x002-201821
x86_64                 randconfig-x006-201821
x86_64                 randconfig-x009-201821
microblaze                          defconfig
parisc                         a500_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
