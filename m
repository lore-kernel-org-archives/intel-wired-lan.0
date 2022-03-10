From: kernel test robot <lkp@intel.com>
Date: Thu, 10 Mar 2022 23:36:27 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 d5f9c30f862e2437e3f88c17bcf299f9b282586e
Message-ID: <622a1afb.vMFr0t9DysWS7rhO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: d5f9c30f862e2437e3f88c17bcf299f9b282586e  iavf: Fix double free in iavf_reset_task

Unverified Warning (likely false positive, please contact us if interested):

net/ipv6/addrconf.c:4316 if6_get_next() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021
|   `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.
`-- x86_64-randconfig-m001
    `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.

elapsed time: 727m

configs tested: 103
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220310
sh                 kfr2r09-romimage_defconfig
alpha                            alldefconfig
m68k                          atari_defconfig
ia64                      gensparse_defconfig
powerpc                      makalu_defconfig
powerpc                    sam440ep_defconfig
arm                     eseries_pxa_defconfig
h8300                       h8s-sim_defconfig
mips                 decstation_r4k_defconfig
mips                            gpr_defconfig
sh                     magicpanelr2_defconfig
xtensa                    xip_kc705_defconfig
m68k                                defconfig
h8300                               defconfig
riscv                            allmodconfig
ia64                         bigsur_defconfig
arm                        oxnas_v6_defconfig
powerpc                        warp_defconfig
csky                                defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
alpha                            allyesconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                                defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a016
arc                  randconfig-r043-20220310
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
arm                          ixp4xx_defconfig
arm                        vexpress_defconfig
mips                        maltaup_defconfig
arm                         socfpga_defconfig
arm                          imote2_defconfig
mips                     loongson2k_defconfig
arm                         shannon_defconfig
powerpc                     kmeter1_defconfig
powerpc                        fsp2_defconfig
mips                        qi_lb60_defconfig
arm                      tct_hammer_defconfig
powerpc                     mpc5200_defconfig
powerpc               mpc834x_itxgp_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220310
hexagon              randconfig-r041-20220310
riscv                randconfig-r042-20220310
s390                 randconfig-r044-20220310
x86_64                        randconfig-a001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
