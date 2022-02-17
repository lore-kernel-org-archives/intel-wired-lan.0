From: kernel test robot <lkp@intel.com>
Date: Thu, 17 Feb 2022 22:56:11 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 9bb37bd8ce919db9c18e5bf2440ff3d961d119c8
Message-ID: <620e620b.1t0Cv1xVrfidsb6e%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 9bb37bd8ce919db9c18e5bf2440ff3d961d119c8  ice: convert VF storage to hash table with krefs and RCU

possible Warning in current branch (please contact us if interested):

include/net/gro.h:58:1: sparse: sparse: directive in macro's argument list
net/ipv6/addrconf.c:4307 if6_get_next() warn: ignoring unreachable code.

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-randconfig-s032-20220217
|   `-- include-net-gro.h:sparse:sparse:directive-in-macro-s-argument-list
|-- i386-randconfig-m021
|   `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.
|-- powerpc64-randconfig-s031-20220217
|   `-- include-net-gro.h:sparse:sparse:directive-in-macro-s-argument-list
`-- x86_64-randconfig-m001
    `-- net-ipv6-addrconf.c-if6_get_next()-warn:ignoring-unreachable-code.

elapsed time: 811m

configs tested: 127
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                           corgi_defconfig
powerpc                      ep88xc_defconfig
sh                ecovec24-romimage_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
arc                      axs103_smp_defconfig
m68k                          hp300_defconfig
powerpc                      makalu_defconfig
powerpc                      cm5200_defconfig
openrisc                            defconfig
sh                 kfr2r09-romimage_defconfig
nios2                            alldefconfig
xtensa                  audio_kc705_defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                          sun3x_defconfig
sh                           se7619_defconfig
mips                           gcw0_defconfig
openrisc                  or1klitex_defconfig
mips                    maltaup_xpa_defconfig
arc                           tb10x_defconfig
arm                           viper_defconfig
arc                          axs101_defconfig
sh                            shmin_defconfig
m68k                           sun3_defconfig
m68k                          amiga_defconfig
powerpc                         wii_defconfig
parisc                generic-32bit_defconfig
h8300                               defconfig
sparc64                             defconfig
ia64                         bigsur_defconfig
powerpc64                        alldefconfig
arm                         assabet_defconfig
mips                     decstation_defconfig
s390                       zfcpdump_defconfig
mips                           jazz_defconfig
sh                            migor_defconfig
sh                   sh7724_generic_defconfig
sh                           se7712_defconfig
arm                  randconfig-c002-20220217
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220216
riscv                randconfig-r042-20220216
s390                 randconfig-r044-20220216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests

clang tested configs:
powerpc                     tqm5200_defconfig
arm                     davinci_all_defconfig
mips                        workpad_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                        spear3xx_defconfig
arm                          pcm027_defconfig
arm                       aspeed_g4_defconfig
powerpc                          allyesconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220217
hexagon              randconfig-r041-20220217
riscv                randconfig-r042-20220217
hexagon              randconfig-r041-20220216
hexagon              randconfig-r045-20220216

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
