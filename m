From: kernel test robot <lkp@intel.com>
Date: Tue, 08 Feb 2022 20:38:15 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 813d4b9de3b79e60cb9f25b5f60de6ddd24f2d0b
Message-ID: <62026437.3U8+bbzfE64bajmS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 813d4b9de3b79e60cb9f25b5f60de6ddd24f2d0b  ice: fix concurrent reset and removal of VFs

possible Warning in current branch (please contact us if interested):

include/net/gro.h:58:1: sparse: sparse: directive in macro's argument list

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- h8300-randconfig-s032-20220208
|   `-- include-net-gro.h:sparse:sparse:directive-in-macro-s-argument-list
|-- nios2-randconfig-s031-20220207
|   `-- include-net-gro.h:sparse:sparse:directive-in-macro-s-argument-list
|-- s390-randconfig-s031-20220208
|   `-- include-net-gro.h:sparse:sparse:directive-in-macro-s-argument-list
`-- x86_64-randconfig-s031-20220207
    `-- include-net-gro.h:sparse:sparse:directive-in-macro-s-argument-list

elapsed time: 721m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                    sam440ep_defconfig
m68k                       m5249evb_defconfig
mips                         mpc30x_defconfig
mips                         cobalt_defconfig
powerpc                    adder875_defconfig
m68k                         amcore_defconfig
mips                          rb532_defconfig
mips                     decstation_defconfig
sh                ecovec24-romimage_defconfig
powerpc                       maple_defconfig
arm                            qcom_defconfig
arc                     haps_hs_smp_defconfig
mips                            gpr_defconfig
arm                       omap2plus_defconfig
powerpc                     rainier_defconfig
powerpc                  iss476-smp_defconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7724_defconfig
powerpc                      pcm030_defconfig
arm                           corgi_defconfig
arc                         haps_hs_defconfig
xtensa                    xip_kc705_defconfig
arm                  randconfig-c002-20220207
ia64                                defconfig
ia64                             allmodconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a013-20220207
x86_64               randconfig-a016-20220207
x86_64               randconfig-a015-20220207
x86_64               randconfig-a012-20220207
x86_64               randconfig-a014-20220207
x86_64               randconfig-a011-20220207
i386                 randconfig-a013-20220207
i386                 randconfig-a014-20220207
i386                 randconfig-a011-20220207
i386                 randconfig-a016-20220207
i386                 randconfig-a012-20220207
i386                 randconfig-a015-20220207
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig

clang tested configs:
arm                   milbeaut_m10v_defconfig
mips                           ip27_defconfig
arm                  colibri_pxa270_defconfig
mips                           mtx1_defconfig
arm                            dove_defconfig
arm                         hackkit_defconfig
powerpc                     tqm8560_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a004-20220207
i386                 randconfig-a003-20220207
i386                 randconfig-a001-20220207
i386                 randconfig-a002-20220207
i386                 randconfig-a005-20220207
i386                 randconfig-a006-20220207
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208
hexagon              randconfig-r045-20220207
hexagon              randconfig-r041-20220207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
