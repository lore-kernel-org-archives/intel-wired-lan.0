From: kernel test robot <lkp@intel.com>
Date: Fri, 04 Jun 2021 18:22:13 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 bd8a54e78190ca960a22f94d5bdbadebf7af9219
Message-ID: <60b9fed5.+cZnfi3hK9T31Nkp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: bd8a54e78190ca960a22f94d5bdbadebf7af9219  i40e: Fix queue-to-TC mapping on Tx

elapsed time: 1982m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      arches_defconfig
powerpc                           allnoconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
sh                            titan_defconfig
arm                           h5000_defconfig
powerpc                     tqm8548_defconfig
s390                       zfcpdump_defconfig
arm                         socfpga_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
sh                         apsh4a3a_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
sh                               alldefconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
powerpc                     tqm5200_defconfig
sh                             shx3_defconfig
arm                           viper_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7722_defconfig
sh                          kfr2r09_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
mips                            e55_defconfig
m68k                       m5475evb_defconfig
arm                        vexpress_defconfig
mips                          rb532_defconfig
sh                           se7343_defconfig
mips                           ci20_defconfig
arm                         axm55xx_defconfig
sh                             espt_defconfig
sh                        dreamcast_defconfig
xtensa                           allyesconfig
arm                       aspeed_g4_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
arm                         shannon_defconfig
powerpc                     tqm8541_defconfig
sh                        sh7785lcr_defconfig
arm                    vt8500_v6_v7_defconfig
arm                          moxart_defconfig
sh                        edosk7705_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                    smp_lx200_defconfig
mips                        jmr3927_defconfig
sh                        apsh4ad0a_defconfig
ia64                             alldefconfig
s390                                defconfig
x86_64                            allnoconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210603
i386                 randconfig-a013-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210603
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
