From: kernel test robot <lkp@intel.com>
Date: Fri, 11 Mar 2022 00:15:06 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD REGRESSION
 24055bb87977e0c687b54ebf7bac8715f3636bc3
Message-ID: <622a240a.1mLRtyudh6zJK1C7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: 24055bb87977e0c687b54ebf7bac8715f3636bc3  net: tcp: fix shim definition of tcp_inbound_md5_hash

Unverified Error/Warning (likely false positive, please contact us if interested):

ld.lld: error: undefined symbol: ptp_clock_index
ld.lld: error: undefined symbol: ptp_clock_register
net/bluetooth/smp.c:1313:3: warning: Null pointer passed as 2nd argument to memory copy function [clang-analyzer-unix.cstring.NullArg]

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- hexagon-randconfig-r041-20220308
|   |-- ld.lld:error:undefined-symbol:ptp_clock_index
|   `-- ld.lld:error:undefined-symbol:ptp_clock_register
`-- i386-randconfig-c001
    `-- net-bluetooth-smp.c:warning:Null-pointer-passed-as-2nd-argument-to-memory-copy-function-clang-analyzer-unix.cstring.NullArg

elapsed time: 771m

configs tested: 124
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
i386                          randconfig-c001
mips                 randconfig-c004-20220310
m68k                          atari_defconfig
alpha                            alldefconfig
sh                 kfr2r09-romimage_defconfig
ia64                      gensparse_defconfig
powerpc                    sam440ep_defconfig
arm                     eseries_pxa_defconfig
powerpc                      makalu_defconfig
powerpc64                           defconfig
sparc64                          alldefconfig
m68k                        stmark2_defconfig
h8300                       h8s-sim_defconfig
mips                            gpr_defconfig
mips                 decstation_r4k_defconfig
sh                      rts7751r2d1_defconfig
sh                          r7785rp_defconfig
mips                         tb0226_defconfig
m68k                        mvme16x_defconfig
arm                           h5000_defconfig
mips                     loongson1b_defconfig
um                               alldefconfig
xtensa                    xip_kc705_defconfig
m68k                                defconfig
sh                     magicpanelr2_defconfig
h8300                               defconfig
riscv                            allmodconfig
csky                                defconfig
powerpc                        warp_defconfig
ia64                         bigsur_defconfig
arm                        oxnas_v6_defconfig
arm                  randconfig-c002-20220310
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
i386                   debian-10.3-kselftests
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220310
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                          ixp4xx_defconfig
arm                        vexpress_defconfig
arm                          collie_defconfig
arm                            mmp2_defconfig
mips                        bcm63xx_defconfig
arm                          moxart_defconfig
arm                         shannon_defconfig
mips                        maltaup_defconfig
powerpc                     kmeter1_defconfig
arm                      tct_hammer_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220310
riscv                randconfig-r042-20220310
hexagon              randconfig-r041-20220310
s390                 randconfig-r044-20220310

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
