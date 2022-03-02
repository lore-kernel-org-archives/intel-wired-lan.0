From: kernel test robot <lkp@intel.com>
Date: Wed, 02 Mar 2022 23:46:45 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 99dfa925a9491d8916f63b7b1a3b99f23f107756
Message-ID: <621f9165.OGNBYZXHVLVJpg7K%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 99dfa925a9491d8916f63b7b1a3b99f23f107756  ice: Fix re-enablement of FW logging after reset

Unverified Warning (likely false positive, please contact us if interested):

net/ipv6/addrconf.c:4312 if6_get_next() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021
|   `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.
`-- x86_64-randconfig-m001
    `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.

elapsed time: 721m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                               defconfig
arm64                            allyesconfig
i386                          randconfig-c001
parisc                generic-64bit_defconfig
arm                           corgi_defconfig
arm                        multi_v7_defconfig
powerpc64                        alldefconfig
arm                          iop32x_defconfig
xtensa                  nommu_kc705_defconfig
sh                   secureedge5410_defconfig
m68k                          atari_defconfig
arc                     nsimosci_hs_defconfig
arc                          axs101_defconfig
sh                          r7785rp_defconfig
m68k                       m5275evb_defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
m68k                        m5307c3_defconfig
mips                     loongson1b_defconfig
arc                      axs103_smp_defconfig
arm                  randconfig-c002-20220302
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                               defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                  randconfig-r043-20220302
riscv                randconfig-r042-20220302
s390                 randconfig-r044-20220302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                malta_qemu_32r6_defconfig
powerpc                   lite5200b_defconfig
mips                          malta_defconfig
mips                         tb0287_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220302
hexagon              randconfig-r041-20220302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
