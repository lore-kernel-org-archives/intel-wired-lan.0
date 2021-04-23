From: kernel test robot <lkp@intel.com>
Date: Fri, 23 Apr 2021 19:59:05 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 5ee9f22fb30f02076233f8fb105f83ff68fe6dbc
Message-ID: <6082b689.EdD9eT4xmjpPxfVW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: 5ee9f22fb30f02076233f8fb105f83ff68fe6dbc  igb: Check if num of q_vectors is smaller than max before array access

elapsed time: 723m

configs tested: 114
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
riscv                             allnoconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
mips                        omega2p_defconfig
arm                          exynos_defconfig
arm                         bcm2835_defconfig
openrisc                            defconfig
sh                          r7785rp_defconfig
m68k                           sun3_defconfig
sh                        sh7785lcr_defconfig
arm                          lpd270_defconfig
xtensa                         virt_defconfig
openrisc                         alldefconfig
sh                          rsk7269_defconfig
powerpc                     powernv_defconfig
powerpc                   currituck_defconfig
ia64                      gensparse_defconfig
sh                           se7750_defconfig
sh                          lboxre2_defconfig
h8300                       h8s-sim_defconfig
sparc                               defconfig
powerpc                     ep8248e_defconfig
mips                          rb532_defconfig
powerpc                     tqm8548_defconfig
powerpc                     mpc512x_defconfig
arm                         at91_dt_defconfig
arm                         palmz72_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
arm                           sunxi_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7722_defconfig
m68k                       m5208evb_defconfig
powerpc                      arches_defconfig
m68k                            mac_defconfig
arm                          pxa910_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210423
x86_64               randconfig-a004-20210423
x86_64               randconfig-a001-20210423
x86_64               randconfig-a005-20210423
x86_64               randconfig-a006-20210423
x86_64               randconfig-a003-20210423
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
