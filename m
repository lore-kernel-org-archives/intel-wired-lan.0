From: kernel test robot <lkp@intel.com>
Date: Wed, 24 Jun 2020 19:47:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD REGRESSION
 a9ce8ef80a26ae6dabd0a77dac5de045072d81d6
Message-ID: <5ef33d45.OVaf1YXQI4zfDM20%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: a9ce8ef80a26ae6dabd0a77dac5de045072d81d6  idpf: Introduce idpf driver

Error/Warning in current branch:

drivers/net/ethernet/intel/idpf/idpf_main.c:46:5: warning: no previous prototype for 'idpf_probe' [-Wmissing-prototypes]
include/linux/avf/virtchnl.h:1090:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rss_hash' is not an integer constant
include/linux/avf/virtchnl.h:809:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant
include/linux/avf/virtchnl.h:891:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_txq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:907:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_tx_queues' is not an integer constant
include/linux/avf/virtchnl.h:937:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_rxq_info_v2' is not an integer constant
include/linux/avf/virtchnl.h:952:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_config_rx_queues' is not an integer constant

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arc-allyesconfig
|   |-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arm-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arm64-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arm64-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- i386-allyesconfig
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- i386-debian-10.3
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_rx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_config_tx_queues-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rss_hash-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_rxq_info_v2-is-not-an-integer-constant
|   `-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_txq_info_v2-is-not-an-integer-constant
|-- microblaze-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- riscv-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- s390-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- sparc64-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- sparc64-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe

elapsed time: 722m

configs tested: 92
configs skipped: 2

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
powerpc                      mgcoge_defconfig
sh                ecovec24-romimage_defconfig
arm                        mvebu_v7_defconfig
arm                        multi_v5_defconfig
h8300                       h8s-sim_defconfig
powerpc                          allyesconfig
s390                              allnoconfig
mips                        qi_lb60_defconfig
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
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
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
