From: kernel test robot <lkp@intel.com>
Date: Sat, 04 Jul 2020 09:28:50 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 bc53e6ea5a86d2f31ef4e45e3cc88037231e0b63
Message-ID: <5effdb52.35TUhxuaSiI9qeUK%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: bc53e6ea5a86d2f31ef4e45e3cc88037231e0b63  igb: reinit_locked() should be called with rtnl_lock

Error/Warning in current branch:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2269:15: error: redefinition of 'truesize'
include/linux/avf/virtchnl.h:181:36: warning: division by zero [-Wdiv-by-zero]
include/linux/avf/virtchnl.h:861:1: note: in expansion of macro 'VIRTCHNL_CHECK_STRUCT_LEN'
include/linux/avf/virtchnl.h:861:31: error: enumerator value for 'virtchnl_static_assert_virtchnl_get_capabilities' is not an integer constant

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- alpha-randconfig-c004-20200701
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- arc-allyesconfig
|   |-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
|   `-- include-linux-avf-virtchnl.h:warning:division-by-zero
|-- i386-allmodconfig
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
|   `-- include-linux-avf-virtchnl.h:warning:division-by-zero
|-- i386-allyesconfig
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
|   `-- include-linux-avf-virtchnl.h:warning:division-by-zero
|-- i386-debian-10.3
|   |-- include-linux-avf-virtchnl.h:error:enumerator-value-for-virtchnl_static_assert_virtchnl_get_capabilities-is-not-an-integer-constant
|   |-- include-linux-avf-virtchnl.h:note:in-expansion-of-macro-VIRTCHNL_CHECK_STRUCT_LEN
|   `-- include-linux-avf-virtchnl.h:warning:division-by-zero
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- powerpc-defconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
|-- sparc64-allmodconfig
|   `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize
`-- sparc64-allyesconfig
    `-- drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:redefinition-of-truesize

elapsed time: 1593m

configs tested: 111
configs skipped: 6

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm                       aspeed_g4_defconfig
m68k                       m5249evb_defconfig
arm                            mmp2_defconfig
sh                            shmin_defconfig
powerpc                      pmac32_defconfig
parisc                           allmodconfig
arm                          pxa3xx_defconfig
arm                       imx_v6_v7_defconfig
powerpc                      ppc6xx_defconfig
mips                          ath25_defconfig
ia64                             allyesconfig
arm                           efm32_defconfig
sh                               alldefconfig
powerpc                    mvme5100_defconfig
mips                          rb532_defconfig
xtensa                          iss_defconfig
h8300                               defconfig
powerpc                  mpc885_ads_defconfig
arm                   milbeaut_m10v_defconfig
sh                        dreamcast_defconfig
openrisc                    or1ksim_defconfig
mips                  maltasmvp_eva_defconfig
ia64                        generic_defconfig
s390                              allnoconfig
microblaze                    nommu_defconfig
parisc                generic-64bit_defconfig
mips                        jmr3927_defconfig
mips                 decstation_r4k_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
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
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200701
i386                 randconfig-a001-20200701
i386                 randconfig-a006-20200701
i386                 randconfig-a005-20200701
i386                 randconfig-a004-20200701
i386                 randconfig-a003-20200701
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
um                                  defconfig
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
