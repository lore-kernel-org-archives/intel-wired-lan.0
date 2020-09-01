From: kernel test robot <lkp@intel.com>
Date: Tue, 01 Sep 2020 18:43:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 6d046ecc1304263afa6f58b7617da6927a08fa72
Message-ID: <5f4e25e3.RUcsRK4bSm8jNEhT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 6d046ecc1304263afa6f58b7617da6927a08fa72  igc: Remove reset disable flag

Error/Warning in current branch:

drivers/net/ethernet/intel/igb/igb_main.c:2880:6: warning: no previous prototype for 'igb_xdp_ring_update_tail' [-Wmissing-prototypes]
drivers/net/ethernet/intel/igb/igb_main.c:2881:6: warning: no previous prototype for 'igb_xdp_ring_update_tail' [-Wmissing-prototypes]
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2273:15: error: redefinition of 'truesize'
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant
net/ipv4/udp_tunnel_nic.c:849:6-10: ERROR: invalid reference to the index variable of the iterator on line 846

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- alpha-allyesconfig
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- alpha-randconfig-r004-20200831
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- arc-allyesconfig
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- arm-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- arm-defconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- arm64-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- arm64-defconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- arm64-randconfig-r022-20200831
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- i386-allyesconfig
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- i386-randconfig-a015-20200901
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- i386-randconfig-r026-20200831
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- ia64-allmodconfig
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-allyesconfig
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-defconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- ia64-randconfig-c003-20200831
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-randconfig-r005-20200831
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- ia64-randconfig-r013-20200831
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- mips-loongson3_defconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- parisc-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- powerpc-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- powerpc-powernv_defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- powerpc-ppc6xx_defconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- powerpc64-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- riscv-allmodconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- sparc-allyesconfig
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc-randconfig-c004-20200831
|   `-- net-ipv4-udp_tunnel_nic.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line
|-- sparc64-allyesconfig
|   |-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- x86_64-allmodconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- x86_64-kexec
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- x86_64-rhel
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- x86_64-rhel-7.6-kselftests
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
|-- x86_64-rhel-8.3
|   `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-igb-igb_main.c:warning:no-previous-prototype-for-igb_xdp_ring_update_tail

elapsed time: 724m

configs tested: 135
configs skipped: 9

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         hackkit_defconfig
powerpc                     pq2fads_defconfig
arm                           h3600_defconfig
sh                           se7712_defconfig
powerpc64                        alldefconfig
nds32                            alldefconfig
arm                       omap2plus_defconfig
m68k                        mvme16x_defconfig
arm                             mxs_defconfig
sh                ecovec24-romimage_defconfig
mips                        nlm_xlp_defconfig
arm                         s3c6400_defconfig
m68k                          sun3x_defconfig
ia64                            zx1_defconfig
sh                           se7750_defconfig
nios2                         3c120_defconfig
ia64                      gensparse_defconfig
mips                 decstation_r4k_defconfig
sh                   sh7724_generic_defconfig
m68k                         apollo_defconfig
powerpc                      ppc6xx_defconfig
arc                           tb10x_defconfig
sh                        edosk7705_defconfig
arm                        mini2440_defconfig
arm                        cerfcube_defconfig
h8300                               defconfig
arm                       spear13xx_defconfig
mips                       capcella_defconfig
i386                                defconfig
mips                      loongson3_defconfig
arm                            zeus_defconfig
sparc                               defconfig
m68k                          atari_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    mvme5100_defconfig
mips                       lemote2f_defconfig
powerpc                     powernv_defconfig
arc                            hsdk_defconfig
nios2                               defconfig
arm                       imx_v6_v7_defconfig
mips                           rs90_defconfig
arm                            mps2_defconfig
powerpc                      tqm8xx_defconfig
nios2                            alldefconfig
powerpc                      ppc64e_defconfig
sh                               alldefconfig
mips                      bmips_stb_defconfig
arm                           stm32_defconfig
mips                        jmr3927_defconfig
arc                     haps_hs_smp_defconfig
mips                malta_qemu_32r6_defconfig
sh                        dreamcast_defconfig
ia64                             alldefconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a004-20200901
x86_64               randconfig-a006-20200901
x86_64               randconfig-a003-20200901
x86_64               randconfig-a005-20200901
x86_64               randconfig-a001-20200901
x86_64               randconfig-a002-20200901
i386                 randconfig-a004-20200901
i386                 randconfig-a005-20200901
i386                 randconfig-a006-20200901
i386                 randconfig-a002-20200901
i386                 randconfig-a001-20200901
i386                 randconfig-a003-20200901
i386                 randconfig-a001-20200831
i386                 randconfig-a002-20200831
i386                 randconfig-a004-20200831
i386                 randconfig-a006-20200831
i386                 randconfig-a005-20200831
i386                 randconfig-a003-20200831
x86_64               randconfig-a012-20200831
x86_64               randconfig-a015-20200831
x86_64               randconfig-a014-20200831
x86_64               randconfig-a011-20200831
x86_64               randconfig-a016-20200831
x86_64               randconfig-a013-20200831
i386                 randconfig-a013-20200831
i386                 randconfig-a011-20200831
i386                 randconfig-a012-20200831
i386                 randconfig-a015-20200831
i386                 randconfig-a016-20200831
i386                 randconfig-a014-20200831
i386                 randconfig-a016-20200901
i386                 randconfig-a015-20200901
i386                 randconfig-a011-20200901
i386                 randconfig-a013-20200901
i386                 randconfig-a014-20200901
i386                 randconfig-a012-20200901
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
