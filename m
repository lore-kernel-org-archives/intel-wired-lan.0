From: kernel test robot <lkp@intel.com>
Date: Wed, 24 Jun 2020 23:01:34 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 ab8c4db90d352622139fe9b553ddd0fcfe8089ba
Message-ID: <5ef36ace.A0g3MjMUi+XvdzXm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ab8c4db90d352622139fe9b553ddd0fcfe8089ba  idpf: Introduce idpf driver

Error/Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2039 i40e_set_vsi_promisc() error: uninitialized symbol 'aq_ret'.
drivers/net/ethernet/intel/iecm/iecm_txrx.c:2508:28: error: 'last_offset' undeclared (first use in this function); did you mean 'page_offset'?
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2269:15: error: redefinition of 'truesize'
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
include/linux/avf/virtchnl.h:175:36: warning: division by zero [-Wdiv-by-zero]
include/linux/avf/virtchnl.h:809:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arc-allyesconfig
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
|   `-- include-linux-avf-virtchnl.h:warning:division-by-zero
|-- i386-allyesconfig
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
|   `-- include-linux-avf-virtchnl.h:warning:division-by-zero
|-- i386-debian-10.3
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
|   `-- include-linux-avf-virtchnl.h:warning:division-by-zero
|-- ia64-allmodconfig
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-allyesconfig
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- mips-loongson3_defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
`-- x86_64-randconfig-m001-20200624
    `-- drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c-i40e_set_vsi_promisc()-error:uninitialized-symbol-aq_ret-.

elapsed time: 726m

configs tested: 110
configs skipped: 2

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                            lart_defconfig
s390                              allnoconfig
sparc64                             defconfig
m68k                            mac_defconfig
xtensa                       common_defconfig
sh                          lboxre2_defconfig
arm                      tct_hammer_defconfig
arc                         haps_hs_defconfig
arm                          lpd270_defconfig
sh                         ap325rxa_defconfig
sh                             espt_defconfig
x86_64                              defconfig
sparc                       sparc32_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      loongson3_defconfig
arm                         shannon_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7780mp_defconfig
arm                         lpc32xx_defconfig
c6x                        evmc6472_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                           sun3_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200624
i386                 randconfig-a006-20200624
i386                 randconfig-a003-20200624
i386                 randconfig-a001-20200624
i386                 randconfig-a005-20200624
i386                 randconfig-a004-20200624
x86_64               randconfig-a004-20200624
x86_64               randconfig-a002-20200624
x86_64               randconfig-a003-20200624
x86_64               randconfig-a005-20200624
x86_64               randconfig-a001-20200624
x86_64               randconfig-a006-20200624
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
