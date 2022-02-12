From: kernel test robot <lkp@intel.com>
Date: Sat, 12 Feb 2022 23:33:50 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD REGRESSION
 3f6a8609890e9c3173c52ee51428b0ace232b7e4
Message-ID: <6207d35e.rQqSKvc1gRA7qKW4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 3f6a8609890e9c3173c52ee51428b0ace232b7e4  ice: fix concurrent reset and removal of VFs

possible Error/Warning in current branch (please contact us if interested):

net/netfilter/xt_socket.c:224:3: error: implicit declaration of function 'nf_defrag_ipv6_disable'; did you mean 'nf_defrag_ipv4_disable'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-a005
    `-- net-netfilter-xt_socket.c:error:implicit-declaration-of-function-nf_defrag_ipv6_disable

elapsed time: 900m

configs tested: 119
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                      chrp32_defconfig
xtensa                    xip_kc705_defconfig
openrisc                            defconfig
mips                          rb532_defconfig
ia64                             alldefconfig
ia64                        generic_defconfig
xtensa                       common_defconfig
xtensa                         virt_defconfig
arm                         axm55xx_defconfig
m68k                       m5475evb_defconfig
m68k                        m5307c3_defconfig
powerpc64                           defconfig
arm                          pxa3xx_defconfig
arm                     eseries_pxa_defconfig
arm                           sama5_defconfig
powerpc                      bamboo_defconfig
arc                     nsimosci_hs_defconfig
xtensa                generic_kc705_defconfig
mips                        vocore2_defconfig
xtensa                    smp_lx200_defconfig
arm                        realview_defconfig
m68k                        mvme147_defconfig
sh                          rsk7203_defconfig
arc                      axs103_smp_defconfig
um                           x86_64_defconfig
mips                           ci20_defconfig
arm                  randconfig-c002-20220211
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220211
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                       imx_v4_v5_defconfig
mips                          ath79_defconfig
powerpc                      walnut_defconfig
mips                      malta_kvm_defconfig
powerpc                      katmai_defconfig
powerpc                      ppc44x_defconfig
powerpc                     mpc5200_defconfig
hexagon                             defconfig
powerpc               mpc834x_itxgp_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220211
hexagon              randconfig-r041-20220211
riscv                randconfig-r042-20220211
s390                 randconfig-r044-20220211

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
