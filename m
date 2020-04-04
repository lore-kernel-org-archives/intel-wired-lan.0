From: kbuild test robot <lkp@intel.com>
Date: Sat, 04 Apr 2020 21:06:12 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 7257d395cfc2bcc91545422f6407bf32c3bbb63b
Message-ID: <5e888644.wWb+pxII5dPDpZ39%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 7257d395cfc2bcc91545422f6407bf32c3bbb63b  igc: Refactor VLAN priority filtering code

Regressions in current branch:

const u16 *value;
drivers/net/ethernet/intel/gwdpa/gswip/gswip_core.c:118:9: warning: The scope of the variable 'ret' can be reduced. [variableScope]
drivers/net/ethernet/intel/gwdpa/gswip/gswip_port.c:238:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
drivers/net/ethernet/intel/gwdpa/gswip/gswip_tbl.c:39:13: warning: struct member 'pce_tbl_reg_map::value' is never used. [unusedStructMember]
drivers/net/ethernet/intel/igc/igc_main.c:2192:23: warning: The scope of the variable 'entry' can be reduced. [variableScope]
struct igc_mac_addr *entry;

Error ids grouped by kconfigs:

recent_errors
|-- i386-allmodconfig
|   |-- drivers-net-ethernet-intel-igc-igc_main.c:warning:The-scope-of-the-variable-entry-can-be-reduced.-variableScope
|   `-- struct-igc_mac_addr-entry
`-- x86_64-allyesconfig
    |-- const-u16-value
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_core.c:warning:The-scope-of-the-variable-ret-can-be-reduced.-variableScope
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_port.c:warning:The-scope-of-the-variable-ret-can-be-reduced.-variableScope
    |-- drivers-net-ethernet-intel-gwdpa-gswip-gswip_tbl.c:warning:struct-member-pce_tbl_reg_map::value-is-never-used.-unusedStructMember
    |-- drivers-net-ethernet-intel-igc-igc_main.c:warning:The-scope-of-the-variable-entry-can-be-reduced.-variableScope
    `-- struct-igc_mac_addr-entry

elapsed time: 878m

configs tested: 142
configs skipped: 0

arm64                            allyesconfig
arm                              allyesconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
s390                             alldefconfig
riscv                            allmodconfig
ia64                                defconfig
powerpc                             defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200403
x86_64               randconfig-a002-20200403
x86_64               randconfig-a003-20200403
i386                 randconfig-a001-20200403
i386                 randconfig-a002-20200403
i386                 randconfig-a003-20200403
sparc64              randconfig-a001-20200403
h8300                randconfig-a001-20200403
nios2                randconfig-a001-20200403
microblaze           randconfig-a001-20200403
c6x                  randconfig-a001-20200403
csky                 randconfig-a001-20200403
openrisc             randconfig-a001-20200403
s390                 randconfig-a001-20200403
sh                   randconfig-a001-20200403
xtensa               randconfig-a001-20200403
csky                 randconfig-a001-20200404
openrisc             randconfig-a001-20200404
s390                 randconfig-a001-20200404
sh                   randconfig-a001-20200404
xtensa               randconfig-a001-20200404
i386                 randconfig-b003-20200404
x86_64               randconfig-b002-20200404
i386                 randconfig-b001-20200404
x86_64               randconfig-b001-20200404
x86_64               randconfig-b003-20200404
i386                 randconfig-b002-20200404
i386                 randconfig-c003-20200404
i386                 randconfig-c001-20200404
x86_64               randconfig-c002-20200404
x86_64               randconfig-c003-20200404
i386                 randconfig-c002-20200404
x86_64               randconfig-c001-20200404
i386                 randconfig-e001-20200404
i386                 randconfig-e003-20200404
x86_64               randconfig-e002-20200404
x86_64               randconfig-e001-20200404
i386                 randconfig-e002-20200404
x86_64               randconfig-e003-20200404
i386                 randconfig-g003-20200404
x86_64               randconfig-g002-20200404
i386                 randconfig-g001-20200404
i386                 randconfig-g002-20200404
x86_64               randconfig-g001-20200404
arm64                randconfig-a001-20200403
sparc                randconfig-a001-20200403
ia64                 randconfig-a001-20200403
arc                  randconfig-a001-20200403
arm                  randconfig-a001-20200403
powerpc              randconfig-a001-20200403
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
