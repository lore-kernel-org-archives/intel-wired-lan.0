From: kbuild test robot <lkp@intel.com>
Date: Fri, 12 Apr 2019 05:07:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 e1592f91b7b4730b2cd0acf6e5845261ab49fb2e
Message-ID: <5cafaca3.cS3A4PlsHrGzftSG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e1592f91b7b4730b2cd0acf6e5845261ab49fb2e  ixgbe: add a kernel documentation comment for ixgbe_ptp_get_ts_config

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14842:2-8: ERROR: missing iounmap; ioremap on line 14700 and execution via conditional on line 14841
ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? mips-allmodconfig
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line

elapsed time: 255m

configs tested: 213

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
nds32                             allnoconfig
nds32                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201914
i386                     randconfig-i1-201914
i386                     randconfig-i2-201914
i386                     randconfig-i3-201914
x86_64                           allyesconfig
i386                             allmodconfig
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
i386                     randconfig-a1-201914
i386                     randconfig-a2-201914
i386                     randconfig-a0-201914
i386                     randconfig-a3-201914
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
powerpc                    klondike_defconfig
sh                        edosk7705_defconfig
arm                         palmz72_defconfig
powerpc                        cell_defconfig
arm64                             allnoconfig
m68k                        m5407c3_defconfig
mips                       bmips_be_defconfig
powerpc                      ppc64e_defconfig
x86_64                 randconfig-u0-04120426
x86_64                 randconfig-u0-04120439
x86_64                   randconfig-k0-201914
x86_64                   randconfig-k1-201914
x86_64                   randconfig-k2-201914
x86_64                   randconfig-k3-201914
i386                     randconfig-k0-201914
i386                     randconfig-k1-201914
i386                     randconfig-k2-201914
i386                     randconfig-k3-201914
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                    lkp
x86_64                                nfsroot
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
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
riscv                             allnoconfig
riscv                               defconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-l3-04110213
i386                   randconfig-l2-04110213
x86_64                 randconfig-l2-04110213
x86_64                 randconfig-l0-04110213
x86_64                 randconfig-l1-04110213
i386                   randconfig-l0-04110213
x86_64                 randconfig-l3-04110213
i386                   randconfig-l1-04110213
x86_64                 randconfig-s3-04120405
x86_64                 randconfig-s4-04120405
x86_64                 randconfig-s5-04120405
x86_64                   randconfig-j0-201914
x86_64                   randconfig-j1-201914
x86_64                   randconfig-j2-201914
x86_64                   randconfig-j3-201914
i386                     randconfig-j0-201914
i386                     randconfig-j1-201914
i386                     randconfig-j2-201914
i386                     randconfig-j3-201914
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
arm                       aspeed_g5_defconfig
arm                            mps2_defconfig
riscv                              tinyconfig
i386                               tinyconfig
arm                        neponset_defconfig
mips                         rt305x_defconfig
arm                    vt8500_v6_v7_defconfig
sh                        apsh4ad0a_defconfig
x86_64                 randconfig-g0-04070620
x86_64                 randconfig-g1-04070620
x86_64                 randconfig-g2-04070620
x86_64                 randconfig-g3-04070620
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arm                         shannon_defconfig
nds32                            allmodconfig
s390                       zfcpdump_defconfig
xtensa                    smp_lx200_defconfig
sh                              ul2_defconfig
arm                         cm_x300_defconfig
powerpc                     mpc512x_defconfig
sh                           se7722_defconfig
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                           allmodconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
