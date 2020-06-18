From: kernel test robot <lkp@intel.com>
Date: Fri, 19 Jun 2020 00:45:52 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:100GbE] BUILD SUCCESS WITH
 WARNING 2c89ef0b849b5d1bdba9bcc93a70f52c4752bc23
Message-ID: <5eeb9a40.8Hw6gTozHzGjacQP%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  100GbE
branch HEAD: 2c89ef0b849b5d1bdba9bcc93a70f52c4752bc23  idpf: Introduce idpf driver

Warning in current branch:

drivers/net/ethernet/intel/idpf/idpf_main.c:46:5: warning: no previous prototype for 'idpf_probe' [-Wmissing-prototypes]

Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arc-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arm-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arm-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arm64-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- arm64-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- i386-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- i386-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- ia64-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- ia64-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- mips-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- mips-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- parisc-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- parisc-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- powerpc-allmodconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
|-- powerpc-allyesconfig
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
|-- x86_64-allyesconfig
|   `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe
`-- xtensa-allyesconfig
    `-- drivers-net-ethernet-intel-idpf-idpf_main.c:warning:no-previous-prototype-for-idpf_probe

elapsed time: 723m

configs tested: 117
configs skipped: 3

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
nds32                            alldefconfig
mips                         tb0287_defconfig
arm                       mainstone_defconfig
arm                          collie_defconfig
mips                        nlm_xlp_defconfig
sh                          polaris_defconfig
arm                         bcm2835_defconfig
ia64                                defconfig
parisc                generic-64bit_defconfig
arm                       spear13xx_defconfig
arc                          axs103_defconfig
arm                         lubbock_defconfig
arm                      footbridge_defconfig
arm                          tango4_defconfig
arm                           tegra_defconfig
arm                        neponset_defconfig
arc                        nsimosci_defconfig
powerpc                      chrp32_defconfig
sh                           se7722_defconfig
s390                              allnoconfig
arm                        mvebu_v7_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
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
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20200618
x86_64               randconfig-a003-20200618
x86_64               randconfig-a006-20200618
x86_64               randconfig-a002-20200618
x86_64               randconfig-a005-20200618
x86_64               randconfig-a004-20200618
i386                 randconfig-a002-20200618
i386                 randconfig-a006-20200618
i386                 randconfig-a001-20200618
i386                 randconfig-a004-20200618
i386                 randconfig-a005-20200618
i386                 randconfig-a003-20200618
i386                 randconfig-a011-20200618
i386                 randconfig-a015-20200618
i386                 randconfig-a014-20200618
i386                 randconfig-a013-20200618
i386                 randconfig-a016-20200618
i386                 randconfig-a012-20200618
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
