From: kernel test robot <lkp@intel.com>
Date: Sun, 18 Jul 2021 22:00:55 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 230f64d156af9f8637813d11a32b3b4095f067d1
Message-ID: <60f43417.LvraSsDU3ybpD7v0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 230f64d156af9f8637813d11a32b3b4095f067d1  i40e: Fix pre-set max number of queues for VF

elapsed time: 730m

configs tested: 122
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
sh                          landisk_defconfig
arm                            lart_defconfig
mips                            ar7_defconfig
sh                               allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                       ebony_defconfig
arm                         s3c6400_defconfig
arm                      footbridge_defconfig
arm                            hisi_defconfig
arm                       versatile_defconfig
powerpc                   bluestone_defconfig
powerpc                    amigaone_defconfig
m68k                       m5208evb_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
um                                  defconfig
sh                          urquell_defconfig
powerpc                 mpc8313_rdb_defconfig
xtensa                  audio_kc705_defconfig
m68k                        m5272c3_defconfig
arm                          collie_defconfig
mips                  maltasmvp_eva_defconfig
arm                        spear6xx_defconfig
sh                        dreamcast_defconfig
m68k                           sun3_defconfig
microblaze                          defconfig
powerpc                      chrp32_defconfig
sh                           se7206_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
sh                      rts7751r2d1_defconfig
arc                    vdk_hs38_smp_defconfig
mips                            gpr_defconfig
ia64                            zx1_defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
arm                        realview_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
arm                     davinci_all_defconfig
sh                           se7751_defconfig
arm                           h5000_defconfig
powerpc                        cell_defconfig
sh                           se7780_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
x86_64               randconfig-a005-20210718
x86_64               randconfig-a004-20210718
x86_64               randconfig-a002-20210718
x86_64               randconfig-a003-20210718
x86_64               randconfig-a006-20210718
x86_64               randconfig-a001-20210718
i386                 randconfig-a005-20210718
i386                 randconfig-a004-20210718
i386                 randconfig-a006-20210718
i386                 randconfig-a001-20210718
i386                 randconfig-a003-20210718
i386                 randconfig-a002-20210718
i386                 randconfig-a014-20210718
i386                 randconfig-a015-20210718
i386                 randconfig-a011-20210718
i386                 randconfig-a013-20210718
i386                 randconfig-a016-20210718
i386                 randconfig-a012-20210718
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210718
x86_64               randconfig-a013-20210718
x86_64               randconfig-a015-20210718
x86_64               randconfig-a012-20210718
x86_64               randconfig-a014-20210718
x86_64               randconfig-a011-20210718
x86_64               randconfig-a016-20210718

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
