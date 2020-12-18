From: kernel test robot <lkp@intel.com>
Date: Fri, 18 Dec 2020 17:07:32 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 44d4775ca51805b376a8db5b34f650434a08e556
Message-ID: <5fdc7154.00KZolejBi8c94+C%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git  master
branch HEAD: 44d4775ca51805b376a8db5b34f650434a08e556  net/sched: sch_taprio: reset child qdiscs before freeing them

elapsed time: 835m

configs tested: 145
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
xtensa                    smp_lx200_defconfig
arm                         palmz72_defconfig
mips                        nlm_xlp_defconfig
powerpc                  mpc885_ads_defconfig
sh                          landisk_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
arm                       mainstone_defconfig
arm                          prima2_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc512x_defconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
riscv                    nommu_k210_defconfig
c6x                         dsk6455_defconfig
arm                            mps2_defconfig
powerpc                         ps3_defconfig
mips                malta_kvm_guest_defconfig
mips                  cavium_octeon_defconfig
mips                      bmips_stb_defconfig
mips                       capcella_defconfig
openrisc                         alldefconfig
powerpc                      ppc64e_defconfig
arm                          imote2_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
h8300                               defconfig
arm                      jornada720_defconfig
powerpc                           allnoconfig
xtensa                generic_kc705_defconfig
powerpc                    mvme5100_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         lubbock_defconfig
ia64                      gensparse_defconfig
sh                            migor_defconfig
h8300                       h8s-sim_defconfig
nios2                            alldefconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
sh                           se7750_defconfig
arm                         hackkit_defconfig
arm64                            alldefconfig
mips                        jmr3927_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
powerpc                     tqm8541_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc6xx_defconfig
xtensa                           alldefconfig
powerpc                      bamboo_defconfig
arm                        mvebu_v7_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
sh                     magicpanelr2_defconfig
sh                          urquell_defconfig
sparc64                             defconfig
arm                        magician_defconfig
powerpc                     kmeter1_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a003-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
x86_64               randconfig-a016-20201218
x86_64               randconfig-a013-20201218
x86_64               randconfig-a012-20201218
x86_64               randconfig-a015-20201218
x86_64               randconfig-a014-20201218
x86_64               randconfig-a011-20201218
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217
x86_64               randconfig-a003-20201218
x86_64               randconfig-a006-20201218
x86_64               randconfig-a002-20201218
x86_64               randconfig-a005-20201218
x86_64               randconfig-a001-20201218
x86_64               randconfig-a004-20201218

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
