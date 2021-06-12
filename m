From: kernel test robot <lkp@intel.com>
Date: Sat, 12 Jun 2021 17:59:24 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 WARNING 548b127080aa82616a1310e5b8cd1e7925a13885
Message-ID: <60c4857c.JfzKqW23DlO0q2Am%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 548b127080aa82616a1310e5b8cd1e7925a13885  i40e: Refactor arrow operator usage in i40e_update_adq_vsi_queues()

possible Warning in current branch:

drivers/net/mdio/acpi_mdio.c:15:1: iwyu: warning: superfluous #include <linux/types.h>
drivers/net/mdio/fwnode_mdio.c:9:1: iwyu: warning: superfluous #include <linux/acpi.h>
drivers/net/pcs/pcs-xpcs-nxp.c:4:1: iwyu: warning: superfluous #include <linux/pcs/pcs-xpcs.h>

Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-b001-20210611
    |-- drivers-net-mdio-acpi_mdio.c:iwyu:warning:superfluous-include-linux-types.h
    |-- drivers-net-mdio-fwnode_mdio.c:iwyu:warning:superfluous-include-linux-acpi.h
    `-- drivers-net-pcs-pcs-xpcs-nxp.c:iwyu:warning:superfluous-include-linux-pcs-pcs-xpcs.h

elapsed time: 724m

configs tested: 98
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5307c3_defconfig
powerpc                      acadia_defconfig
sh                     sh7710voipgw_defconfig
mips                  maltasmvp_eva_defconfig
mips                malta_qemu_32r6_defconfig
mips                      loongson3_defconfig
powerpc                     kmeter1_defconfig
mips                           ci20_defconfig
arc                          axs103_defconfig
sh                                  defconfig
sh                          rsk7203_defconfig
mips                      fuloong2e_defconfig
sh                        edosk7760_defconfig
sh                   rts7751r2dplus_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                    ge_imp3a_defconfig
mips                        omega2p_defconfig
mips                        bcm47xx_defconfig
xtensa                       common_defconfig
sh                        dreamcast_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210611
i386                 randconfig-a006-20210611
i386                 randconfig-a004-20210611
i386                 randconfig-a001-20210611
i386                 randconfig-a005-20210611
i386                 randconfig-a003-20210611
x86_64               randconfig-a002-20210611
x86_64               randconfig-a001-20210611
x86_64               randconfig-a004-20210611
x86_64               randconfig-a003-20210611
x86_64               randconfig-a006-20210611
x86_64               randconfig-a005-20210611
i386                 randconfig-a015-20210611
i386                 randconfig-a013-20210611
i386                 randconfig-a016-20210611
i386                 randconfig-a014-20210611
i386                 randconfig-a012-20210611
i386                 randconfig-a011-20210611
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
x86_64               randconfig-a015-20210611
x86_64               randconfig-a011-20210611
x86_64               randconfig-a012-20210611
x86_64               randconfig-a014-20210611
x86_64               randconfig-a016-20210611
x86_64               randconfig-a013-20210611

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
