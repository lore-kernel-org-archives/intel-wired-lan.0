From: kbuild test robot <lkp@intel.com>
Date: Wed, 10 Apr 2019 07:05:28 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 7d150c75aed54f069f2bac6385ef3ffe8f6b8ddf
Message-ID: <5cad2538.is6p2Q+CXJaSA3cB%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 7d150c75aed54f069f2bac6385ef3ffe8f6b8ddf  ixgbe: add a kernel documentation comment for ixgbe_ptp_get_ts_config

Regressions in current branch:

ERROR: "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-randconfig-i1-201914
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined

elapsed time: 265m

configs tested: 232

riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-x010-201914
i386                   randconfig-x018-201914
i386                   randconfig-x017-201914
i386                   randconfig-x013-201914
i386                   randconfig-x011-201914
i386                   randconfig-x014-201914
i386                   randconfig-x019-201914
i386                   randconfig-x015-201914
i386                   randconfig-x016-201914
i386                   randconfig-x012-201914
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n2-201914
i386                     randconfig-n3-201914
i386                     randconfig-n0-201914
i386                     randconfig-n1-201914
x86_64                 randconfig-x001-201914
x86_64                 randconfig-x004-201914
x86_64                 randconfig-x000-201914
x86_64                 randconfig-x003-201914
x86_64                 randconfig-x008-201914
x86_64                 randconfig-x007-201914
x86_64                 randconfig-x002-201914
x86_64                 randconfig-x006-201914
x86_64                 randconfig-x009-201914
x86_64                 randconfig-x005-201914
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
nds32                             allnoconfig
nds32                               defconfig
i386                     randconfig-i1-201914
i386                     randconfig-i0-201914
i386                     randconfig-i3-201914
i386                     randconfig-i2-201914
riscv                             allnoconfig
riscv                               defconfig
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201914
x86_64                 randconfig-x016-201914
x86_64                 randconfig-x012-201914
x86_64                 randconfig-x017-201914
x86_64                 randconfig-x013-201914
x86_64                 randconfig-x018-201914
x86_64                 randconfig-x010-201914
x86_64                 randconfig-x014-201914
x86_64                 randconfig-x019-201914
x86_64                 randconfig-x011-201914
arm                       omap2plus_defconfig
arm                              allmodconfig
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm64                            alldefconfig
arm                                      arm5
arm                                     arm67
arm                                    sa1100
arm                                   samsung
arm                                        sh
i386                     randconfig-a1-201914
i386                     randconfig-a2-201914
i386                     randconfig-a0-201914
i386                     randconfig-a3-201914
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-i0-04070619
x86_64                 randconfig-i1-04070619
x86_64                 randconfig-i2-04070619
x86_64                 randconfig-i3-04070619
powerpc                 mpc8272_ads_defconfig
powerpc                  mpc866_ads_defconfig
parisc                      default_defconfig
sh                           se7751_defconfig
parisc                        c3000_defconfig
sh                          rsk7201_defconfig
arm                          nuc950_defconfig
mips                      fuloong2e_defconfig
powerpc               mpc85xx_basic_defconfig
arm                            zeus_defconfig
m68k                             alldefconfig
alpha                               defconfig
sparc                       sparc32_defconfig
mips                         cobalt_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
sh                           se7206_defconfig
arm                           u8500_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      katmai_defconfig
sh                            shmin_defconfig
mips                         db1xxx_defconfig
powerpc                          g5_defconfig
m68k                        stmark2_defconfig
arm                          gemini_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc64e_defconfig
x86_64                 randconfig-u0-04100505
x86_64                 randconfig-u0-04100520
x86_64                 randconfig-u0-04100530
x86_64                 randconfig-u0-04100540
x86_64                 randconfig-u0-04100554
x86_64                 randconfig-u0-04100610
x86_64                   randconfig-k0-201914
x86_64                   randconfig-k1-201914
x86_64                   randconfig-k2-201914
x86_64                   randconfig-k3-201914
i386                     randconfig-k0-201914
i386                     randconfig-k1-201914
i386                     randconfig-k2-201914
i386                     randconfig-k3-201914
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                     randconfig-m0-201914
x86_64                   randconfig-m2-201914
i386                     randconfig-m3-201914
i386                     randconfig-m2-201914
x86_64                   randconfig-m1-201914
x86_64                   randconfig-m0-201914
x86_64                   randconfig-m3-201914
i386                     randconfig-m1-201914
i386                   randconfig-l2-04091603
i386                   randconfig-l0-04091603
i386                   randconfig-l1-04091603
x86_64                 randconfig-l1-04091603
x86_64                 randconfig-l0-04091603
i386                   randconfig-l3-04091603
x86_64                 randconfig-l2-04091603
x86_64                 randconfig-l3-04091603
x86_64                 randconfig-s3-04100500
x86_64                 randconfig-s4-04100500
x86_64                 randconfig-s5-04100500
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                              defconfig
um                                  defconfig
i386                   randconfig-x077-201914
i386                   randconfig-x074-201914
i386                   randconfig-x070-201914
i386                   randconfig-x072-201914
i386                   randconfig-x075-201914
i386                   randconfig-x071-201914
i386                   randconfig-x079-201914
i386                   randconfig-x078-201914
i386                   randconfig-x073-201914
i386                   randconfig-x076-201914
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
mips                     decstation_defconfig
sh                          sdk7786_defconfig
x86_64                 randconfig-g1-04070620
x86_64                 randconfig-g3-04070620
x86_64                 randconfig-g0-04070620
x86_64                 randconfig-g2-04070620
x86_64                           allmodconfig
i386                   randconfig-x002-201914
i386                   randconfig-x001-201914
i386                   randconfig-x005-201914
i386                   randconfig-x007-201914
i386                   randconfig-x000-201914
i386                   randconfig-x004-201914
i386                   randconfig-x008-201914
i386                   randconfig-x009-201914
i386                   randconfig-x006-201914
i386                   randconfig-x003-201914
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-e0-04071728
x86_64                 randconfig-e1-04071728
x86_64                 randconfig-e2-04071728
x86_64                 randconfig-e3-04071728
x86_64                 randconfig-j0-04080219
x86_64                 randconfig-j1-04080219
x86_64                 randconfig-j2-04080219
x86_64                 randconfig-j3-04080219
i386                   randconfig-j0-04080219
i386                   randconfig-j1-04080219
i386                   randconfig-j2-04080219
i386                   randconfig-j3-04080219
openrisc                 simple_smp_defconfig
sh                           se7712_defconfig
h8300                            allyesconfig
powerpc                     ep8248e_defconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
