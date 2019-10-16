From: kbuild test robot <lkp@intel.com>
Date: Wed, 16 Oct 2019 08:05:41 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 5abc663f817aaf2625e2725deda128462ee31d51
Message-ID: <5da65ed5.cTT2l/pEsO2AwT0L%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 5abc663f817aaf2625e2725deda128462ee31d51  ice: Fix return value when SR-IOV is not supported

Regressions in current branch:

drivers/net/ethernet/intel/ice/ice_txrx.c:1667:5: error: implicit declaration of function 'ice_build_ctob'; did you mean 'ice_build_skb'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ice/ice_txrx_lib.c:218:33: error: implicit declaration of function 'ice_build_ctob'; did you mean '__build_skb'? [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ice/ice_xsk.c:980:4: error: implicit declaration of function 'ice_build_ctob'; did you mean 'ice_bump_ntc'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
|   |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
|   `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc
|-- alpha-allyesconfig
|   |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
|   |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
|   `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc
|-- ia64-allmodconfig
|   |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
|   |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
|   `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc
|-- ia64-allyesconfig
|   |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
|   |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
|   `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc
|-- sparc-allmodconfig
|   |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
|   |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
|   `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc
|-- sparc-allyesconfig
|   |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
|   |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
|   `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc
|-- sparc64-allmodconfig
|   |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
|   |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
|   `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc
`-- sparc64-allyesconfig
    |-- drivers-net-ethernet-intel-ice-ice_txrx.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_build_skb
    |-- drivers-net-ethernet-intel-ice-ice_txrx_lib.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-__build_skb
    `-- drivers-net-ethernet-intel-ice-ice_xsk.c:error:implicit-declaration-of-function-ice_build_ctob-did-you-mean-ice_bump_ntc

TIMEOUT after 1442m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 32

arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allmodconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig

configs tested: 81

arm                              allmodconfig
arm64                            allmodconfig
sparc64                          allmodconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
riscv                             allnoconfig
riscv                               defconfig
nds32                               defconfig
alpha                               defconfig
nds32                             allnoconfig
x86_64                 randconfig-c001-201941
x86_64                 randconfig-c002-201941
i386                   randconfig-c001-201941
i386                   randconfig-c004-201941
i386                   randconfig-c003-201941
x86_64                 randconfig-c004-201941
i386                   randconfig-c002-201941
x86_64                 randconfig-c003-201941
i386                   randconfig-f002-201941
i386                   randconfig-f001-201941
x86_64                 randconfig-f003-201941
x86_64                 randconfig-f004-201941
x86_64                 randconfig-f002-201941
i386                   randconfig-f003-201941
x86_64                 randconfig-f001-201941
i386                   randconfig-f004-201941
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
x86_64                 randconfig-a004-201941
x86_64                 randconfig-a001-201941
i386                   randconfig-a002-201941
x86_64                 randconfig-a002-201941
i386                   randconfig-a001-201941
i386                   randconfig-a003-201941
i386                   randconfig-a004-201941
x86_64                 randconfig-a003-201941
x86_64                           allyesconfig
i386                             allmodconfig
mips                             allmodconfig
mips                           32r2_defconfig
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
arc                              allyesconfig
powerpc                             defconfig
microblaze                    nommu_defconfig
powerpc                       ppc64_defconfig
microblaze                      mmu_defconfig
arc                                 defconfig
powerpc                           allnoconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
ia64                             allmodconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
i386                   randconfig-d002-201941
x86_64                 randconfig-d002-201941
x86_64                 randconfig-d004-201941
i386                   randconfig-d004-201941
x86_64                 randconfig-d003-201941
i386                   randconfig-d003-201941
x86_64                 randconfig-d001-201941
i386                   randconfig-d001-201941

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
