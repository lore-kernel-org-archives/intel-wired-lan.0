From: kbuild test robot <lkp@intel.com>
Date: Fri, 01 Jun 2018 16:22:01 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 e4304178f31434edbdcaf1fd8c8d813b2d37415f
Message-ID: <5b110229.E0zhdWe/iasMD9tq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e4304178f31434edbdcaf1fd8c8d813b2d37415f  ixgbe: fix broken ipsec Rx with proper cast on spi

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:487:56: sparse: restricted __be32 degrades to integer

Error ids grouped by kconfigs:

recent_errors
`-- x86_64-allmodconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_ipsec.c:sparse:restricted-__be32-degrades-to-integer

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 34

alpha                            allmodconfig
alpha                            allyesconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
mips                             allmodconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                               allyesconfig
sparc                            allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
x86_64                            allnoconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                              defconfig
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 238

powerpc                     powernv_defconfig
sh                          rsk7264_defconfig
powerpc                          allyesconfig
powerpc                        fsp2_defconfig
x86_64                 randconfig-a0-06011018
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
ia64                          tiger_defconfig
microblaze                      mmu_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-06010958
x86_64                randconfig-in0-06011311
i386                   randconfig-x012-201821
i386                   randconfig-x017-201821
i386                   randconfig-x014-201821
i386                   randconfig-x016-201821
i386                   randconfig-x018-201821
i386                   randconfig-x013-201821
i386                   randconfig-x011-201821
i386                   randconfig-x015-201821
i386                   randconfig-x019-201821
i386                   randconfig-x010-201821
microblaze                    nommu_defconfig
i386                     randconfig-n0-201821
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
i386                     randconfig-i0-201821
i386                     randconfig-i1-201821
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                     randconfig-a0-201821
i386                     randconfig-a1-201821
x86_64                 randconfig-s0-06010855
x86_64                 randconfig-s1-06010855
x86_64                 randconfig-s2-06010855
x86_64                 randconfig-s0-06010947
x86_64                 randconfig-s1-06010947
x86_64                 randconfig-s2-06010947
x86_64                 randconfig-s0-06011018
x86_64                 randconfig-s1-06011018
x86_64                 randconfig-s2-06011018
x86_64                 randconfig-s0-06011053
x86_64                 randconfig-s1-06011053
x86_64                 randconfig-s2-06011053
x86_64                 randconfig-s0-06011156
x86_64                 randconfig-s1-06011156
x86_64                 randconfig-s2-06011156
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             alldefconfig
mips                            gpr_defconfig
openrisc                 simple_smp_defconfig
powerpc                             defconfig
arm                           efm32_defconfig
arm                            xcep_defconfig
mips                        msp71xx_defconfig
sh                          r7780mp_defconfig
i386                                defconfig
mips                       rbtx49xx_defconfig
um                               allmodconfig
arm                         orion5x_defconfig
arm                            qcom_defconfig
m68k                           sun3_defconfig
arm                        clps711x_defconfig
arm                          iop32x_defconfig
sh                           se7724_defconfig
sh                           sh2007_defconfig
arm                       spear13xx_defconfig
arm                           u8500_defconfig
mips                  maltasmvp_eva_defconfig
openrisc                            defconfig
arm                       aspeed_g5_defconfig
arm                         vf610m4_defconfig
mips                         bigsur_defconfig
mips                            ar7_defconfig
powerpc                    amigaone_defconfig
sh                        dreamcast_defconfig
sh                          polaris_defconfig
arm                      tct_hammer_defconfig
sparc                            alldefconfig
arm                      acs5k_tiny_defconfig
arm                         hackkit_defconfig
mips                          lasat_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                       h8s-sim_defconfig
mips                        nlm_xlp_defconfig
powerpc                     taishan_defconfig
sh                   secureedge5410_defconfig
arm                        realview_defconfig
powerpc                     skiroot_defconfig
powerpc                      walnut_defconfig
powerpc64                           defconfig
powerpc                     asp8347_defconfig
powerpc                  iss476-smp_defconfig
s390                                defconfig
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
i386                              allnoconfig
x86_64                              fedora-25
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-s1-201821
i386                     randconfig-s0-201821
x86_64                 randconfig-s3-06011020
x86_64                 randconfig-s4-06011020
x86_64                 randconfig-s5-06011020
x86_64                 randconfig-s3-06011103
x86_64                 randconfig-s4-06011103
x86_64                 randconfig-s5-06011103
x86_64                 randconfig-s3-06011241
x86_64                 randconfig-s4-06011241
x86_64                 randconfig-s5-06011241
m68k                         amcore_defconfig
mips                          malta_defconfig
x86_64                   randconfig-i0-201821
i386                   randconfig-b0-06011003
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                          badge4_defconfig
sh                          kfr2r09_defconfig
sparc                            allmodconfig
mips                     loongson1b_defconfig
sh                         microdev_defconfig
powerpc                       eiger_defconfig
sh                        edosk7705_defconfig
mips                           xway_defconfig
arm                            lart_defconfig
powerpc                    socrates_defconfig
x86_64                 randconfig-u0-06010916
x86_64                 randconfig-u0-06011025
x86_64                 randconfig-u0-06011210
i386                               tinyconfig
arm                       mainstone_defconfig
microblaze                       allmodconfig
x86_64                randconfig-ne0-06010958
x86_64                randconfig-ne0-06011229
arm                           sunxi_defconfig
mips                             allyesconfig
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
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm64                             allnoconfig
arm64                               defconfig
m68k                             allmodconfig
i386                  randconfig-sb0-06011005
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                           allmodconfig
x86_64                                  kexec
arm                            zeus_defconfig
powerpc                    mvme5100_defconfig
x86_64                 randconfig-r0-06011027
powerpc                 mpc836x_rdk_defconfig
arm                            netx_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
i386                   randconfig-x0-06010950
i386                   randconfig-x0-06011217

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
