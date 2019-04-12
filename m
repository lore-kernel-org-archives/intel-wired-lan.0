From: kbuild test robot <lkp@intel.com>
Date: Fri, 12 Apr 2019 13:40:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 fa4bbb7d289c73c9aaaf2cf4711c5b98c3f0df6b
Message-ID: <5cb024db.8eUuAuJ6wM+X8wfD%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: fa4bbb7d289c73c9aaaf2cf4711c5b98c3f0df6b  ixgbe: Use LLDP ethertype define ETH_P_LLDP

Regressions in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:278: undefined reference to `__udivdi3'
ERROR: "__aeabi_uldivmod" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
ERROR: "__udivdi3" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!

Error ids grouped by kconfigs:

recent_errors
??? arm-allmodconfig
??? ??? ERROR:__aeabi_uldivmod-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-allmodconfig
??? ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined
??? i386-randconfig-j0-201914
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:undefined-reference-to-__udivdi3
??? mips-allmodconfig
    ??? ERROR:__udivdi3-drivers-net-ethernet-intel-ixgbe-ixgbe.ko-undefined

elapsed time: 211m

configs tested: 221

sh                             espt_defconfig
sh                   rts7751r2dplus_defconfig
sh                             shx3_defconfig
xtensa                    smp_lx200_defconfig
arm                          ixp4xx_defconfig
um                                allnoconfig
arm                       omap2plus_defconfig
alpha                            allmodconfig
mips                          rm200_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
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
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
i386                     randconfig-i0-201914
i386                     randconfig-i2-201914
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
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                        mvebu_v7_defconfig
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
x86_64                 randconfig-s0-04121235
x86_64                 randconfig-s1-04121235
x86_64                 randconfig-s2-04121235
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                 randconfig-i1-04070619
x86_64                 randconfig-i2-04070619
x86_64                 randconfig-i3-04070619
i386                   randconfig-b0-04121205
i386                   randconfig-b0-04121319
arm                         vf610m4_defconfig
mips                           xway_defconfig
mips                        maltaup_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                         amcore_defconfig
mips                     loongson1b_defconfig
arm                           stm32_defconfig
sh                             sh03_defconfig
x86_64                           allmodconfig
arm                  colibri_pxa270_defconfig
mips                           ip22_defconfig
arm                            qcom_defconfig
powerpc                      walnut_defconfig
mips                  cavium_octeon_defconfig
mips                  maltasmvp_eva_defconfig
arm                          gemini_defconfig
arm                            pleb_defconfig
openrisc                            defconfig
parisc                generic-32bit_defconfig
mips                      pistachio_defconfig
s390                             allyesconfig
mips                        bcm63xx_defconfig
arm                          ks8695_defconfig
s390                    performance_defconfig
x86_64                 randconfig-u0-04121156
x86_64                 randconfig-u0-04121219
x86_64                 randconfig-u0-04121244
x86_64                 randconfig-u0-04121255
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
nds32                             allnoconfig
nds32                               defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
x86_64                 randconfig-l0-04120829
x86_64                 randconfig-l1-04120829
x86_64                 randconfig-l3-04120829
i386                   randconfig-l1-04120829
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
arm                         lpc18xx_defconfig
arm                         hackkit_defconfig
arm                   milbeaut_m10v_defconfig
arm                         s3c6400_defconfig
arm                        magician_defconfig
arm                        vexpress_defconfig
i386                             alldefconfig
riscv                              tinyconfig
i386                               tinyconfig
powerpc                 mpc85xx_cds_defconfig
sh                          sdk7780_defconfig
arm                      integrator_defconfig
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
powerpc                     redwood_defconfig
powerpc                     tqm8541_defconfig
microblaze                          defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-g1-04070620
x86_64                 randconfig-g3-04070620
x86_64                 randconfig-e0-04071728
x86_64                 randconfig-e2-04071728
x86_64                 randconfig-e3-04071728
arm                          tango4_defconfig
mips                  decstation_64_defconfig
parisc                        c8000_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
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

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
