From: kbuild test robot <lkp@intel.com>
Date: Sun, 09 Feb 2020 19:53:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 efd2087941d2bc08b6c0a559aab0d8cdcfa38e0f
Message-ID: <5e3ff2cc.bg5isaXwqSX63wq3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: efd2087941d2bc08b6c0a559aab0d8cdcfa38e0f  gwdpa: gswip: Introduce Gigabit Ethernet Switch (GSWIP) device driver

Regressions in current branch:

drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:32:30: sparse:    expected void [noderef] <asn:2> *base
drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:32:30: sparse:    got void *context
drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:32:30: sparse: sparse: incorrect type in initializer (different address spaces)
drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:77:30: sparse:    expected void *bus_context
drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:77:30: sparse:    got void [noderef] <asn:2> *[assigned] core
drivers/net/ethernet/intel/gwdpa/gswip/gswip_dev.c:77:30: sparse: sparse: incorrect type in argument 3 (different address spaces)
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:119:5: sparse: sparse: symbol 'mac_set_duplex' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:144:5: sparse: sparse: symbol 'mac_get_duplex' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:156:5: sparse: sparse: symbol 'mac_get_linksts' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:168:5: sparse: sparse: symbol 'mac_set_linksts' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:193:5: sparse: sparse: symbol 'mac_set_flowctrl' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:38:5: sparse: sparse: symbol 'mac_get_speed' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/mac_cfg.c:50:5: sparse: sparse: symbol 'mac_set_physpeed' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c:478:5: sparse: sparse: symbol 'xgmac_mdio_single_wr' was not declared. Should it be static?
drivers/net/ethernet/intel/gwdpa/gswip/xgmac.c:529:5: sparse: sparse: symbol 'xgmac_mdio_single_rd' was not declared. Should it be static?
drivers/net/ethernet/intel/ice/ice_flow.c:1048 ice_add_rss_cfg_sync() error: we previously assumed 'prof' could be null (see line 1030)

Error ids grouped by kconfigs:

recent_errors
|-- i386-allyesconfig
|   `-- drivers-net-ethernet-intel-ice-ice_flow.c-ice_add_rss_cfg_sync()-error:we-previously-assumed-prof-could-be-null-(see-line-)
`-- x86_64-allyesconfig
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:sparse:expected-void-bus_context
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:sparse:expected-void-noderef-asn-base
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:sparse:got-void-context
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:sparse:got-void-noderef-asn-assigned-core
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_dev.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)
    |-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:sparse:sparse:symbol-mac_get_duplex-was-not-declared.-Should-it-be-static
    |-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:sparse:sparse:symbol-mac_get_linksts-was-not-declared.-Should-it-be-static
    |-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:sparse:sparse:symbol-mac_get_speed-was-not-declared.-Should-it-be-static
    |-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:sparse:sparse:symbol-mac_set_duplex-was-not-declared.-Should-it-be-static
    |-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:sparse:sparse:symbol-mac_set_flowctrl-was-not-declared.-Should-it-be-static
    |-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:sparse:sparse:symbol-mac_set_linksts-was-not-declared.-Should-it-be-static
    |-- drivers-net-ethernet-intel-gwdpa-gswip-mac_cfg.c:sparse:sparse:symbol-mac_set_physpeed-was-not-declared.-Should-it-be-static
    |-- drivers-net-ethernet-intel-gwdpa-gswip-xgmac.c:sparse:sparse:symbol-xgmac_mdio_single_rd-was-not-declared.-Should-it-be-static
    `-- drivers-net-ethernet-intel-gwdpa-gswip-xgmac.c:sparse:sparse:symbol-xgmac_mdio_single_wr-was-not-declared.-Should-it-be-static

TIMEOUT after 2885m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 3

ia64                             alldefconfig
ia64                             allmodconfig
ia64                             allyesconfig

configs tested: 137
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
sparc                            allyesconfig
sh                          rsk7269_defconfig
ia64                                defconfig
riscv                             allnoconfig
parisc                           allyesconfig
um                                  defconfig
sparc64                          allyesconfig
arc                              allyesconfig
xtensa                          iss_defconfig
m68k                       m5475evb_defconfig
ia64                              allnoconfig
nios2                         3c120_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
nios2                         10m50_defconfig
sparc64                           allnoconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                              allnoconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
nds32                               defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
c6x                  randconfig-a001-20200209
h8300                randconfig-a001-20200209
microblaze           randconfig-a001-20200209
nios2                randconfig-a001-20200209
sparc64              randconfig-a001-20200209
h8300                randconfig-a001-20200207
nios2                randconfig-a001-20200207
sparc64              randconfig-a001-20200207
microblaze           randconfig-a001-20200207
c6x                  randconfig-a001-20200207
sh                   randconfig-a001-20200207
csky                 randconfig-a001-20200207
s390                 randconfig-a001-20200207
xtensa               randconfig-a001-20200207
openrisc             randconfig-a001-20200207
x86_64               randconfig-c001-20200207
x86_64               randconfig-c002-20200207
x86_64               randconfig-c003-20200207
i386                 randconfig-c001-20200207
i386                 randconfig-c002-20200207
i386                 randconfig-c003-20200207
x86_64               randconfig-d003-20200207
i386                 randconfig-d001-20200207
x86_64               randconfig-d002-20200207
i386                 randconfig-d003-20200207
x86_64               randconfig-d001-20200207
i386                 randconfig-d002-20200207
i386                 randconfig-e003-20200207
i386                 randconfig-e002-20200207
x86_64               randconfig-e001-20200207
x86_64               randconfig-e003-20200207
i386                 randconfig-e001-20200207
x86_64               randconfig-e002-20200207
x86_64               randconfig-g001-20200207
x86_64               randconfig-g002-20200207
x86_64               randconfig-g003-20200207
i386                 randconfig-g001-20200207
i386                 randconfig-g002-20200207
i386                 randconfig-g003-20200207
x86_64               randconfig-h001-20200208
x86_64               randconfig-h002-20200208
x86_64               randconfig-h003-20200208
i386                 randconfig-h001-20200208
i386                 randconfig-h002-20200208
i386                 randconfig-h003-20200208
riscv                            allmodconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                             defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
