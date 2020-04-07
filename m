From: kbuild test robot <lkp@intel.com>
Date: Tue, 07 Apr 2020 20:12:31 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 ebc01afcb1211f9330713d9b439bffa5570ddabf
Message-ID: <5e8c6e2f.A5ebpIv2XCNWtqGV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: ebc01afcb1211f9330713d9b439bffa5570ddabf  igc: Refactor VLAN priority filtering code

Warning in current branch:

const u16 *value;
drivers/net/ethernet/intel/gwdpa/gswip/gswip_tbl.c:39:13: warning: struct member 'pce_tbl_reg_map::value' is never used. [unusedStructMember]
drivers/net/ethernet/intel/igc/igc_main.c:5188:6: note: Assuming that condition 'err' is not redundant
drivers/net/ethernet/intel/igc/igc_main.c:5216:6: note: Condition '!err' is always true
drivers/net/ethernet/intel/igc/igc_main.c:5216:6: warning: Condition '!err' is always true [knownConditionTrueFalse]
struct igc_mac_addr *entry;

Warning ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   |-- drivers-net-ethernet-intel-igc-igc_main.c:note:Assuming-that-condition-err-is-not-redundant
|   |-- drivers-net-ethernet-intel-igc-igc_main.c:note:Condition-err-is-always-true
|   |-- drivers-net-ethernet-intel-igc-igc_main.c:warning:Condition-err-is-always-true-knownConditionTrueFalse
|   `-- struct-igc_mac_addr-entry
`-- x86_64-allyesconfig
    |-- const-u16-value
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_tbl.c:warning:struct-member-pce_tbl_reg_map::value-is-never-used.-unusedStructMember
    |-- drivers-net-ethernet-intel-igc-igc_main.c:note:Assuming-that-condition-err-is-not-redundant
    |-- drivers-net-ethernet-intel-igc-igc_main.c:note:Condition-err-is-always-true
    |-- drivers-net-ethernet-intel-igc-igc_main.c:warning:Condition-err-is-always-true-knownConditionTrueFalse
    `-- struct-igc_mac_addr-entry

elapsed time: 865m

configs tested: 160
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
powerpc                           allnoconfig
parisc                generic-32bit_defconfig
riscv                             allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
arm                              allmodconfig
arm64                            allmodconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-64bit_defconfig
i386                 randconfig-a003-20200407
mips                 randconfig-a001-20200407
nds32                randconfig-a001-20200407
m68k                 randconfig-a001-20200407
parisc               randconfig-a001-20200407
alpha                randconfig-a001-20200407
riscv                randconfig-a001-20200407
alpha                randconfig-a001-20200406
m68k                 randconfig-a001-20200406
nds32                randconfig-a001-20200406
parisc               randconfig-a001-20200406
riscv                randconfig-a001-20200406
sparc64              randconfig-a001-20200406
h8300                randconfig-a001-20200406
nios2                randconfig-a001-20200406
microblaze           randconfig-a001-20200406
c6x                  randconfig-a001-20200406
c6x                  randconfig-a001-20200407
h8300                randconfig-a001-20200407
microblaze           randconfig-a001-20200407
nios2                randconfig-a001-20200407
sparc64              randconfig-a001-20200407
s390                 randconfig-a001-20200406
xtensa               randconfig-a001-20200406
csky                 randconfig-a001-20200406
openrisc             randconfig-a001-20200406
sh                   randconfig-a001-20200406
x86_64               randconfig-b001-20200407
x86_64               randconfig-b002-20200407
x86_64               randconfig-b003-20200407
i386                 randconfig-b001-20200407
i386                 randconfig-b002-20200407
i386                 randconfig-b003-20200407
i386                 randconfig-b003-20200406
x86_64               randconfig-b002-20200406
x86_64               randconfig-b001-20200406
i386                 randconfig-b001-20200406
x86_64               randconfig-b003-20200406
i386                 randconfig-b002-20200406
x86_64               randconfig-d001-20200407
i386                 randconfig-d003-20200407
i386                 randconfig-d001-20200407
i386                 randconfig-d002-20200407
x86_64               randconfig-d002-20200407
x86_64               randconfig-d003-20200407
i386                 randconfig-e001-20200406
i386                 randconfig-e003-20200406
x86_64               randconfig-e002-20200406
x86_64               randconfig-e001-20200406
i386                 randconfig-e002-20200406
x86_64               randconfig-e003-20200406
i386                 randconfig-f001-20200406
x86_64               randconfig-f003-20200406
i386                 randconfig-f003-20200406
x86_64               randconfig-f001-20200406
i386                 randconfig-f002-20200406
x86_64               randconfig-g003-20200406
i386                 randconfig-g003-20200406
x86_64               randconfig-g002-20200406
i386                 randconfig-g001-20200406
i386                 randconfig-g002-20200406
x86_64               randconfig-g001-20200406
x86_64               randconfig-h002-20200406
i386                 randconfig-h002-20200406
i386                 randconfig-h003-20200406
i386                 randconfig-h001-20200406
x86_64               randconfig-h003-20200406
x86_64               randconfig-h001-20200406
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
