From: kernel test robot <lkp@intel.com>
Date: Thu, 20 Aug 2020 19:34:24 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 ecb4203e85ea61fef623f9df41b0a68285c48361
Message-ID: <5f3e5fc0.4vaz1OOd8dO7dx4Z%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ecb4203e85ea61fef623f9df41b0a68285c48361  ice: refactor devlink_port to be per-VSI

Error/Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_xsk.c:379 i40e_clean_rx_irq_zc() error: uninitialized symbol 'failure'.
drivers/net/ethernet/intel/iecm/iecm_txrx.c:1370:12: error: 'struct iecm_tx_buf' has no member named 'dma'
drivers/net/ethernet/intel/iecm/iecm_txrx.c:1371:12: error: 'struct iecm_tx_buf' has no member named 'len'
drivers/net/ethernet/intel/igb/igb_main.c:8430 igb_run_xdp() error: (-2147483647) too low for ERR_PTR
drivers/net/ethernet/intel/igb/igb_main.c:8761 igb_clean_rx_irq() error: 'skb' dereferencing possible ERR_PTR()
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2269:15: error: redefinition of 'truesize'

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- i386-randconfig-a004-20200820
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:struct-iecm_tx_buf-has-no-member-named-dma
|   `-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:struct-iecm_tx_buf-has-no-member-named-len
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
`-- x86_64-randconfig-m001-20200819
    |-- drivers-net-ethernet-intel-i40e-i40e_xsk.c-i40e_clean_rx_irq_zc()-error:uninitialized-symbol-failure-.
    |-- drivers-net-ethernet-intel-igb-igb_main.c-igb_clean_rx_irq()-error:skb-dereferencing-possible-ERR_PTR()
    `-- drivers-net-ethernet-intel-igb-igb_main.c-igb_run_xdp()-error:too-low-for-ERR_PTR

elapsed time: 725m

configs tested: 89
configs skipped: 3

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     powernv_defconfig
arm                          pcm027_defconfig
arm                        mvebu_v7_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
sh                         ap325rxa_defconfig
arc                 nsimosci_hs_smp_defconfig
microblaze                      mmu_defconfig
arm                         vf610m4_defconfig
arm                           h5000_defconfig
mips                        nlm_xlp_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20200818
i386                 randconfig-a002-20200818
i386                 randconfig-a001-20200818
i386                 randconfig-a006-20200818
i386                 randconfig-a003-20200818
i386                 randconfig-a004-20200818
i386                 randconfig-a005-20200819
i386                 randconfig-a002-20200819
i386                 randconfig-a001-20200819
i386                 randconfig-a006-20200819
i386                 randconfig-a003-20200819
i386                 randconfig-a004-20200819
i386                 randconfig-a002-20200820
i386                 randconfig-a004-20200820
i386                 randconfig-a005-20200820
i386                 randconfig-a003-20200820
i386                 randconfig-a006-20200820
i386                 randconfig-a001-20200820
x86_64               randconfig-a013-20200818
x86_64               randconfig-a016-20200818
x86_64               randconfig-a012-20200818
x86_64               randconfig-a011-20200818
x86_64               randconfig-a014-20200818
x86_64               randconfig-a015-20200818
i386                 randconfig-a016-20200818
i386                 randconfig-a011-20200818
i386                 randconfig-a015-20200818
i386                 randconfig-a013-20200818
i386                 randconfig-a012-20200818
i386                 randconfig-a014-20200818
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
