From: kernel test robot <lkp@intel.com>
Date: Thu, 01 Jul 2021 18:14:17 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS WITH
 WARNING 75af1491879a0ba9c5de9492369202c60c5bc5f2
Message-ID: <60dd9579.vKCROokq1705Ma5g%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 75af1491879a0ba9c5de9492369202c60c5bc5f2  ixgbevf: Add support for new mailbox communication between PF and VF

possible Warning in current branch:

drivers/net/ethernet/intel/i40e/i40e_ptp.c:30:57-58: WARNING opportunity for kobj_to_dev()

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- ia64-randconfig-c004-20210630
    `-- drivers-net-ethernet-intel-i40e-i40e_ptp.c:WARNING-opportunity-for-kobj_to_dev()

elapsed time: 725m

configs tested: 97
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5307c3_defconfig
sh                          sdk7786_defconfig
ia64                         bigsur_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc8540_ads_defconfig
parisc                           alldefconfig
mips                         db1xxx_defconfig
sh                          r7785rp_defconfig
sh                           se7712_defconfig
arm                         hackkit_defconfig
powerpc                   bluestone_defconfig
mips                       capcella_defconfig
arm                      pxa255-idp_defconfig
sh                        edosk7705_defconfig
powerpc                  mpc866_ads_defconfig
sh                          landisk_defconfig
arm                         at91_dt_defconfig
um                               alldefconfig
sh                              ul2_defconfig
sh                          sdk7780_defconfig
mips                          rm200_defconfig
mips                        omega2p_defconfig
mips                  decstation_64_defconfig
arc                        nsimosci_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
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
x86_64               randconfig-b001-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
