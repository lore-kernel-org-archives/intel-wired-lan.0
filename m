From: kbuild test robot <lkp@intel.com>
Date: Mon, 06 Jan 2020 18:11:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 12afe6269478fcbfd5451376a1e77a02722c4a22
Message-ID: <5e1307e9.9gN849P4gvFu+slm%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 12afe6269478fcbfd5451376a1e77a02722c4a22  i40e: Fix receive buffer starvation for AF_XDP

Regressions in current branch:

drivers/net/ethernet/intel/i40e/i40e_adminq.c:542:27: error: 'I40E_MINOR_VER_GET_LINK_INFO_X722' undeclared (first use in this function); did you mean 'I40E_MINOR_VER_GET_LINK_INFO_XL710'?

Error ids grouped by kconfigs:

recent_errors
|-- alpha-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- arm64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- i386-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- i386-randconfig-e002-20200106
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- i386-randconfig-f003-20200106
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- parisc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- riscv-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- riscv-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- s390-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- s390-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- sparc-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- sparc-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- sparc64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-allmodconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-fedora-25
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-kexec
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-lkp
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-randconfig-h003-20200106
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-rhel
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
|-- x86_64-rhel-7.6
|   `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710
`-- xtensa-allmodconfig
    `-- drivers-net-ethernet-intel-i40e-i40e_adminq.c:error:I40E_MINOR_VER_GET_LINK_INFO_X722-undeclared-(first-use-in-this-function)-did-you-mean-I40E_MINOR_VER_GET_LINK_INFO_XL710

elapsed time: 276m

configs tested: 160

um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allyesconfig
parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-e001-20200106
x86_64               randconfig-e002-20200106
x86_64               randconfig-e003-20200106
i386                 randconfig-e001-20200106
i386                 randconfig-e002-20200106
i386                 randconfig-e003-20200106
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
i386                 randconfig-f001-20200106
x86_64               randconfig-f003-20200106
i386                 randconfig-f002-20200106
i386                 randconfig-f003-20200106
x86_64               randconfig-f001-20200106
x86_64               randconfig-f002-20200106
x86_64               randconfig-f001-20200105
x86_64               randconfig-f002-20200105
i386                 randconfig-f001-20200105
i386                 randconfig-f002-20200105
i386                 randconfig-f003-20200105
csky                 randconfig-a001-20200106
s390                 randconfig-a001-20200106
sh                   randconfig-a001-20200106
xtensa               randconfig-a001-20200106
openrisc             randconfig-a001-20200106
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
c6x                  randconfig-a001-20200106
h8300                randconfig-a001-20200106
microblaze           randconfig-a001-20200106
nios2                randconfig-a001-20200106
sparc64              randconfig-a001-20200106
arm                         at91_dt_defconfig
x86_64               randconfig-a002-20200105
i386                 randconfig-a001-20200105
x86_64               randconfig-a001-20200105
i386                 randconfig-a002-20200105
x86_64               randconfig-a003-20200105
i386                 randconfig-a003-20200105
sparc                            allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
s390                              allnoconfig
s390                             alldefconfig
s390                          debug_defconfig
s390                             allmodconfig
s390                                defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64               randconfig-g001-20200106
x86_64               randconfig-g002-20200106
x86_64               randconfig-g003-20200106
i386                 randconfig-g001-20200106
i386                 randconfig-g003-20200106
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
x86_64               randconfig-h003-20200106
x86_64               randconfig-h002-20200106
i386                 randconfig-h003-20200106
i386                 randconfig-h002-20200106
i386                 randconfig-h001-20200106
x86_64               randconfig-h001-20200106
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
parisc               randconfig-a001-20200106
mips                 randconfig-a001-20200106
riscv                randconfig-a001-20200106
alpha                randconfig-a001-20200106
m68k                 randconfig-a001-20200106
nds32                randconfig-a001-20200106
x86_64               randconfig-b003-20200106
i386                 randconfig-b001-20200106
x86_64               randconfig-b002-20200106
i386                 randconfig-b003-20200106
x86_64               randconfig-b001-20200106
i386                 randconfig-b002-20200106
arm                               allnoconfig
arm                              allyesconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64                               rhel-7.6
x86_64                              fedora-25
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allmodconfig
x86_64               randconfig-d003-20200106
x86_64               randconfig-d002-20200106
x86_64               randconfig-d001-20200106
i386                 randconfig-d002-20200106
i386                 randconfig-d001-20200106
i386                 randconfig-d003-20200106
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
arm                              allmodconfig
arm64                            allmodconfig
m68k                             allmodconfig
x86_64               randconfig-c001-20200106
x86_64               randconfig-c002-20200106
x86_64               randconfig-c003-20200106
i386                 randconfig-c001-20200106
i386                 randconfig-c002-20200106

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org Intel Corporation
