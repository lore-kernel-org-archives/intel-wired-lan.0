From: kernel test robot <lkp@intel.com>
Date: Thu, 25 Jun 2020 17:47:39 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 8ed8d65c1161983eaef29cfa58de210f5c99a79f
Message-ID: <5ef472bb.bEjENFr8pMZXHCMT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 8ed8d65c1161983eaef29cfa58de210f5c99a79f  idpf: Introduce idpf driver

Error/Warning in current branch:

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
|-- alpha-allyesconfig
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
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
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc-allyesconfig
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc64-allmodconfig
|   |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
`-- sparc64-allyesconfig
    |-- drivers-net-ethernet-intel-iecm-iecm_txrx.c:error:last_offset-undeclared-(first-use-in-this-function)
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize

elapsed time: 725m

configs tested: 103
configs skipped: 5

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arc                     haps_hs_smp_defconfig
s390                             allyesconfig
powerpc                          g5_defconfig
mips                        jmr3927_defconfig
sh                           se7751_defconfig
arm                       imx_v6_v7_defconfig
arm                            xcep_defconfig
arm                      pxa255-idp_defconfig
arm                          tango4_defconfig
arm                             pxa_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
arm                     eseries_pxa_defconfig
mips                      loongson3_defconfig
i386                             alldefconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
parisc                            allnoconfig
arm                            lart_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200624
i386                 randconfig-a006-20200624
i386                 randconfig-a003-20200624
i386                 randconfig-a001-20200624
i386                 randconfig-a005-20200624
i386                 randconfig-a004-20200624
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
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
