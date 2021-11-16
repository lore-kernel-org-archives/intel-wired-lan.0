From: kernel test robot <lkp@intel.com>
Date: Tue, 16 Nov 2021 20:02:18 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 4293014230b887d94b68aa460ff00153454a3709
Message-ID: <61939dca.BvuMH7bDqUcx0i4q%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: 4293014230b887d94b68aa460ff00153454a3709  iavf: Restore VLAN filters after link down

elapsed time: 723m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211115
i386                 randconfig-c001-20211116
m68k                             alldefconfig
powerpc                 linkstation_defconfig
mips                         db1xxx_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                        cell_defconfig
arm                         lubbock_defconfig
sh                          lboxre2_defconfig
arc                                 defconfig
arm                       netwinder_defconfig
arm                        mini2440_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        m5307c3_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                               j2_defconfig
powerpc                      ppc6xx_defconfig
mips                          ath25_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
mips                     decstation_defconfig
sh                         apsh4a3a_defconfig
sparc64                             defconfig
arm                       aspeed_g4_defconfig
m68k                       m5275evb_defconfig
arm                        magician_defconfig
sh                             shx3_defconfig
mips                           ip22_defconfig
arm                      tct_hammer_defconfig
sh                          sdk7780_defconfig
powerpc                      cm5200_defconfig
powerpc                   microwatt_defconfig
mips                       bmips_be_defconfig
um                               alldefconfig
sh                          rsk7203_defconfig
m68k                        m5407c3_defconfig
mips                           xway_defconfig
riscv                             allnoconfig
arm                  colibri_pxa270_defconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
sh                   sh7770_generic_defconfig
mips                      malta_kvm_defconfig
sparc                               defconfig
um                             i386_defconfig
s390                             alldefconfig
s390                                defconfig
powerpc                    ge_imp3a_defconfig
sh                        sh7763rdp_defconfig
mips                         mpc30x_defconfig
sh                     sh7710voipgw_defconfig
arm                  randconfig-c002-20211116
arm                  randconfig-c002-20211115
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20211115
i386                 randconfig-a003-20211115
i386                 randconfig-a005-20211115
i386                 randconfig-a001-20211115
i386                 randconfig-a004-20211115
i386                 randconfig-a002-20211115
x86_64               randconfig-a015-20211116
x86_64               randconfig-a013-20211116
x86_64               randconfig-a012-20211116
x86_64               randconfig-a011-20211116
x86_64               randconfig-a016-20211116
x86_64               randconfig-a014-20211116
i386                 randconfig-a014-20211116
i386                 randconfig-a016-20211116
i386                 randconfig-a012-20211116
i386                 randconfig-a013-20211116
i386                 randconfig-a011-20211116
i386                 randconfig-a015-20211116
x86_64               randconfig-a005-20211115
x86_64               randconfig-a003-20211115
x86_64               randconfig-a002-20211115
x86_64               randconfig-a001-20211115
x86_64               randconfig-a006-20211115
x86_64               randconfig-a004-20211115
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211116
i386                 randconfig-c001-20211116
arm                  randconfig-c002-20211116
riscv                randconfig-c006-20211116
powerpc              randconfig-c003-20211116
s390                 randconfig-c005-20211116
mips                 randconfig-c004-20211116
x86_64               randconfig-a005-20211116
x86_64               randconfig-a003-20211116
x86_64               randconfig-a001-20211116
x86_64               randconfig-a002-20211116
x86_64               randconfig-a006-20211116
x86_64               randconfig-a004-20211116
i386                 randconfig-a014-20211115
i386                 randconfig-a016-20211115
i386                 randconfig-a012-20211115
i386                 randconfig-a013-20211115
i386                 randconfig-a011-20211115
i386                 randconfig-a015-20211115
hexagon              randconfig-r045-20211115
hexagon              randconfig-r041-20211115
s390                 randconfig-r044-20211115
riscv                randconfig-r042-20211115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
