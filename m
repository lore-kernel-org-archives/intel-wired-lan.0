From: kbuild test robot <lkp@intel.com>
Date: Fri, 19 Apr 2019 09:26:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 e280fb683f07216fc6554be0088a150e6b6b70b9
Message-ID: <5cb923c6.uKdvsGtLCJsRgpW/%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: e280fb683f07216fc6554be0088a150e6b6b70b9  i40e: Memory leak in i40e_config_iwarp_qvlist

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_main.c:14840:2-8: ERROR: missing iounmap; ioremap on line 14698 and execution via conditional on line 14839
drivers/net/ethernet/intel/iavf/iavf_adminq.c:554:13-21: Unneeded variable: "ret_code". Return "0" on line 562

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
??? x86_64-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:ERROR:missing-iounmap-ioremap-on-line-and-execution-via-conditional-on-line
    ??? drivers-net-ethernet-intel-iavf-iavf_adminq.c:Unneeded-variable:ret_code-Return-on-line

elapsed time: 255m

configs tested: 236

c6x                              allmodconfig
mips                      maltaaprp_defconfig
i386                                defconfig
arm                           viper_defconfig
i386                   randconfig-x010-201915
i386                   randconfig-x018-201915
i386                   randconfig-x017-201915
i386                   randconfig-x013-201915
i386                   randconfig-x011-201915
i386                   randconfig-x014-201915
i386                   randconfig-x019-201915
i386                   randconfig-x015-201915
i386                   randconfig-x016-201915
i386                   randconfig-x012-201915
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201915
i386                     randconfig-n1-201915
i386                     randconfig-n2-201915
i386                     randconfig-n3-201915
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
nds32                             allnoconfig
nds32                               defconfig
i386                     randconfig-i1-201915
i386                     randconfig-i0-201915
i386                     randconfig-i3-201915
i386                     randconfig-i2-201915
x86_64                           allyesconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201915
x86_64                 randconfig-x016-201915
x86_64                 randconfig-x012-201915
x86_64                 randconfig-x017-201915
x86_64                 randconfig-x013-201915
x86_64                 randconfig-x018-201915
x86_64                 randconfig-x010-201915
x86_64                 randconfig-x014-201915
x86_64                 randconfig-x019-201915
x86_64                 randconfig-x011-201915
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
i386                     randconfig-a1-201915
i386                     randconfig-a2-201915
i386                     randconfig-a0-201915
i386                     randconfig-a3-201915
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
arm                        vexpress_defconfig
sh                        sh7763rdp_defconfig
mips                       capcella_defconfig
arm                        oxnas_v6_defconfig
sh                           se7712_defconfig
arm                         hackkit_defconfig
sh                                allnoconfig
powerpc                             defconfig
mips                         mpc30x_defconfig
powerpc                     powernv_defconfig
arm                         palmz72_defconfig
mips                       bmips_be_defconfig
arm                               allnoconfig
arm                         em_x270_defconfig
c6x                        evmc6472_defconfig
powerpc                 mpc832x_mds_defconfig
mips                 pnx8335_stb225_defconfig
sh                           cayman_defconfig
arm                           efm32_defconfig
powerpc                     redwood_defconfig
powerpc                 canyonlands_defconfig
sparc64                          allyesconfig
arm                      jornada720_defconfig
powerpc                    sam440ep_defconfig
x86_64                 randconfig-u0-04190807
x86_64                 randconfig-u0-04190814
x86_64                 randconfig-u0-04190821
x86_64                 randconfig-u0-04190830
x86_64                 randconfig-u0-04190840
x86_64                   randconfig-k0-201915
x86_64                   randconfig-k1-201915
x86_64                   randconfig-k2-201915
x86_64                   randconfig-k3-201915
i386                     randconfig-k0-201915
i386                     randconfig-k1-201915
i386                     randconfig-k2-201915
i386                     randconfig-k3-201915
arm                         at91_dt_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                              fedora-25
x86_64                                  kexec
x86_64                               rhel-7.6
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                 randconfig-m0-04170939
i386                   randconfig-m2-04170939
i386                   randconfig-m1-04170939
i386                   randconfig-m3-04170939
i386                   randconfig-m0-04170939
x86_64                 randconfig-m2-04170939
x86_64                 randconfig-m1-04170939
x86_64                 randconfig-m3-04170939
riscv                             allnoconfig
riscv                               defconfig
i386                   randconfig-l2-04180125
x86_64                 randconfig-l2-04180125
x86_64                 randconfig-l0-04180125
x86_64                 randconfig-l1-04180125
i386                   randconfig-l0-04180125
i386                   randconfig-l1-04180125
x86_64                 randconfig-l3-04180125
i386                   randconfig-l3-04180125
x86_64                 randconfig-s3-04190758
x86_64                 randconfig-s4-04190758
x86_64                 randconfig-s5-04190758
ia64                      gensparse_defconfig
mips                            e55_defconfig
x86_64                            allnoconfig
powerpc                     mpc5200_defconfig
riscv                          rv32_defconfig
x86_64                 randconfig-a0-04190840
arm                             rpc_defconfig
powerpc64                         allnoconfig
sh                         ecovec24_defconfig
powerpc                     rainier_defconfig
sparc                             allnoconfig
i386                   randconfig-c0-04190820
arm                       spear13xx_defconfig
x86_64                   randconfig-i0-201915
x86_64                   randconfig-i1-201915
x86_64                   randconfig-i2-201915
x86_64                   randconfig-i3-201915
x86_64                 randconfig-b0-04190758
x86_64                 randconfig-b0-04190844
x86_64                           allmodconfig
i386                             alldefconfig
arm                         ebsa110_defconfig
arm                    vt8500_v6_v7_defconfig
x86_64                   randconfig-h0-201915
x86_64                   randconfig-h1-201915
x86_64                   randconfig-h2-201915
x86_64                   randconfig-h3-201915
arm                          gemini_defconfig
m68k                           sun3_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
x86_64                   randconfig-g0-201915
x86_64                   randconfig-g3-201915
x86_64                   randconfig-g2-201915
x86_64                   randconfig-g1-201915
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
um                                  defconfig
riscv                              tinyconfig
i386                               tinyconfig
i386                   randconfig-x077-201915
i386                   randconfig-x074-201915
i386                   randconfig-x070-201915
i386                   randconfig-x072-201915
i386                   randconfig-x075-201915
i386                   randconfig-x071-201915
i386                   randconfig-x079-201915
i386                   randconfig-x078-201915
i386                   randconfig-x073-201915
i386                   randconfig-x076-201915
i386                   randconfig-x002-201915
i386                   randconfig-x001-201915
i386                   randconfig-x005-201915
i386                   randconfig-x007-201915
i386                   randconfig-x000-201915
i386                   randconfig-x004-201915
i386                   randconfig-x008-201915
i386                   randconfig-x009-201915
i386                   randconfig-x006-201915
i386                   randconfig-x003-201915
x86_64                 randconfig-x001-201915
x86_64                 randconfig-x004-201915
x86_64                 randconfig-x000-201915
x86_64                 randconfig-x003-201915
x86_64                 randconfig-x007-201915
x86_64                 randconfig-x008-201915
x86_64                 randconfig-x002-201915
x86_64                 randconfig-x006-201915
x86_64                 randconfig-x009-201915
x86_64                 randconfig-x005-201915
i386                              allnoconfig

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
