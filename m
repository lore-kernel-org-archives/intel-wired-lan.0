From: kernel test robot <lkp@intel.com>
Date: Sun, 27 Feb 2022 00:00:33 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 3c2ba51a24f6db93c239b34344e66dcca5b91069
Message-ID: <621a4ea1.RFz7AuoLdVwuAl4e%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 3c2ba51a24f6db93c239b34344e66dcca5b91069  ice: Add support for double VLAN in switchdev

possible Warning in current branch (please contact us if interested):

net/ipv6/addrconf.c:4312 if6_get_next() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021
|   `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.
`-- x86_64-randconfig-m001
    `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.

elapsed time: 905m

configs tested: 118
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
powerpc                     pq2fads_defconfig
sh                          kfr2r09_defconfig
arc                      axs103_smp_defconfig
mips                         db1xxx_defconfig
powerpc                    klondike_defconfig
mips                             allyesconfig
m68k                        m5272c3_defconfig
m68k                       m5475evb_defconfig
powerpc                     tqm8548_defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
mips                        vocore2_defconfig
arm                        trizeps4_defconfig
arm                           sama5_defconfig
microblaze                      mmu_defconfig
arm                           h5000_defconfig
parisc                generic-64bit_defconfig
mips                         rt305x_defconfig
m68k                          multi_defconfig
sh                        sh7757lcr_defconfig
arm                           viper_defconfig
powerpc                   motionpro_defconfig
arm                  randconfig-c002-20220225
arm                  randconfig-c002-20220226
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220225
riscv                randconfig-r042-20220226
arc                  randconfig-r043-20220226
s390                 randconfig-r044-20220226
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
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
x86_64                    rhel-8.3-kselftests

clang tested configs:
mips                   sb1250_swarm_defconfig
powerpc                   lite5200b_defconfig
powerpc                     ppa8548_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
hexagon              randconfig-r045-20220225
hexagon              randconfig-r041-20220226
hexagon              randconfig-r045-20220226
hexagon              randconfig-r041-20220225
riscv                randconfig-r042-20220225
s390                 randconfig-r044-20220225

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
