From: kernel test robot <lkp@intel.com>
Date: Tue, 15 Dec 2020 23:11:50 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 WARNING d2c2bbad93b818020657a82121a147e9ace1230d
Message-ID: <5fd8d236.SC6MIXu3FBoyLETP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git  dev-queue
branch HEAD: d2c2bbad93b818020657a82121a147e9ace1230d  i40e, xsk: Simplify the do-while allocation loop

Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_txrx.c:547:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- arm64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- riscv-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:variable-ret-set-but-not-used

elapsed time: 722m

configs tested: 138
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                      axs103_smp_defconfig
powerpc                      walnut_defconfig
sparc                               defconfig
m68k                          atari_defconfig
powerpc                 mpc8560_ads_defconfig
mips                         rt305x_defconfig
arm                      tct_hammer_defconfig
arm                       cns3420vb_defconfig
alpha                            allyesconfig
mips                      pistachio_defconfig
arc                        nsimosci_defconfig
h8300                       h8s-sim_defconfig
arm                     eseries_pxa_defconfig
sparc                            allyesconfig
m68k                          amiga_defconfig
arm                            dove_defconfig
xtensa                    xip_kc705_defconfig
mips                           xway_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     ppa8548_defconfig
microblaze                    nommu_defconfig
powerpc                       maple_defconfig
h8300                     edosk2674_defconfig
sh                          sdk7780_defconfig
m68k                           sun3_defconfig
arm                            u300_defconfig
i386                             alldefconfig
arc                            hsdk_defconfig
m68k                          sun3x_defconfig
powerpc                      acadia_defconfig
arm                          pxa168_defconfig
xtensa                         virt_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                     pq2fads_defconfig
m68k                       m5475evb_defconfig
parisc                           alldefconfig
m68k                        m5407c3_defconfig
arm                         orion5x_defconfig
powerpc                         ps3_defconfig
powerpc                      obs600_defconfig
sh                ecovec24-romimage_defconfig
sh                   sh7770_generic_defconfig
powerpc                     kmeter1_defconfig
mips                        nlm_xlp_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
sh                          lboxre2_defconfig
sh                          sdk7786_defconfig
sh                            titan_defconfig
powerpc                    gamecube_defconfig
c6x                        evmc6472_defconfig
sh                          rsk7264_defconfig
powerpc                          g5_defconfig
powerpc                   currituck_defconfig
arm                           sunxi_defconfig
sh                         ap325rxa_defconfig
sh                         microdev_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20201214
i386                 randconfig-a004-20201214
i386                 randconfig-a003-20201214
i386                 randconfig-a002-20201214
i386                 randconfig-a006-20201214
i386                 randconfig-a005-20201214
x86_64               randconfig-a016-20201214
x86_64               randconfig-a012-20201214
x86_64               randconfig-a013-20201214
x86_64               randconfig-a015-20201214
x86_64               randconfig-a014-20201214
x86_64               randconfig-a011-20201214
i386                 randconfig-a014-20201214
i386                 randconfig-a013-20201214
i386                 randconfig-a012-20201214
i386                 randconfig-a011-20201214
i386                 randconfig-a015-20201214
i386                 randconfig-a016-20201214
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201214
x86_64               randconfig-a006-20201214
x86_64               randconfig-a002-20201214
x86_64               randconfig-a005-20201214
x86_64               randconfig-a004-20201214
x86_64               randconfig-a001-20201214
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
