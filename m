From: kernel test robot <lkp@intel.com>
Date: Sat, 07 Aug 2021 18:01:47 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD REGRESSION
 96ea8bee7ce727581d6cc6f23ed4b277dc0e3355
Message-ID: <610e5a0b.fJEgsHgJcgYvvZ4R%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 96ea8bee7ce727581d6cc6f23ed4b277dc0e3355  ice: ndo_setup_tc implementation for PR

Error/Warning reports:

https://lore.kernel.org/lkml/202108071616.TxA4HRdX-lkp at intel.com

Error/Warning in current branch:

(.text+0x1038c): undefined reference to `ice_ptp_link_change'
ice_main.c:(.text+0xb91c): undefined reference to `ice_ptp_link_change'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- arm-randconfig-r003-20210804
    |-- (.text):undefined-reference-to-ice_ptp_link_change
    `-- ice_main.c:(.text):undefined-reference-to-ice_ptp_link_change

elapsed time: 722m

configs tested: 128
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210805
i386                 randconfig-c001-20210804
arm                         socfpga_defconfig
arm                       aspeed_g5_defconfig
arm                            dove_defconfig
xtensa                           alldefconfig
arm                          imote2_defconfig
powerpc                     mpc5200_defconfig
mips                           mtx1_defconfig
sh                            titan_defconfig
mips                          rb532_defconfig
m68k                            mac_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    sam440ep_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
mips                        jmr3927_defconfig
m68k                        m5307c3_defconfig
powerpc                        fsp2_defconfig
arm                      footbridge_defconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                        edosk7760_defconfig
arm                           tegra_defconfig
microblaze                          defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210805
i386                 randconfig-a004-20210805
i386                 randconfig-a002-20210805
i386                 randconfig-a006-20210805
i386                 randconfig-a003-20210805
i386                 randconfig-a001-20210805
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-a002-20210804
x86_64               randconfig-a006-20210804
x86_64               randconfig-a004-20210804
x86_64               randconfig-a003-20210804
x86_64               randconfig-a001-20210804
x86_64               randconfig-a005-20210804

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
