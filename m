From: kernel test robot <lkp@intel.com>
Date: Fri, 24 Dec 2021 15:26:02 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:master] BUILD SUCCESS
 f2b551fad8d8f2ac5e1f810ad595298381e0b0c5
Message-ID: <61c5760a.FfsTFQqOrwLECgYp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git master
branch HEAD: f2b551fad8d8f2ac5e1f810ad595298381e0b0c5  Merge tag 'wireless-drivers-next-2021-12-23' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next

elapsed time: 797m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211223
xtensa                         virt_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
sh                              ul2_defconfig
sh                      rts7751r2d1_defconfig
arm                   milbeaut_m10v_defconfig
m68k                        mvme147_defconfig
arm                          iop32x_defconfig
arc                          axs103_defconfig
arm                            qcom_defconfig
powerpc                      mgcoge_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
um                           x86_64_defconfig
mips                           ip27_defconfig
arc                              alldefconfig
sh                            migor_defconfig
sh                            hp6xx_defconfig
arm                       spear13xx_defconfig
arm                          gemini_defconfig
arm                         bcm2835_defconfig
powerpc                     rainier_defconfig
sh                            shmin_defconfig
sh                           se7721_defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
arm                            mmp2_defconfig
arm                           omap1_defconfig
mips                            e55_defconfig
alpha                            alldefconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
mips                        vocore2_defconfig
arm                          simpad_defconfig
powerpc                      ep88xc_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      pmac32_defconfig
arm                        oxnas_v6_defconfig
powerpc                     ppa8548_defconfig
mips                         tb0219_defconfig
powerpc                      pcm030_defconfig
powerpc                    amigaone_defconfig
powerpc                      arches_defconfig
sh                        apsh4ad0a_defconfig
arm                           sunxi_defconfig
arm                           corgi_defconfig
powerpc                     redwood_defconfig
arm                         lubbock_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 linkstation_defconfig
arm                           u8500_defconfig
arm                            xcep_defconfig
um                               alldefconfig
mips                 decstation_r4k_defconfig
mips                         tb0287_defconfig
powerpc                 mpc832x_mds_defconfig
arm                       cns3420vb_defconfig
mips                         cobalt_defconfig
mips                         rt305x_defconfig
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                       capcella_defconfig
mips                         tb0226_defconfig
xtensa                           alldefconfig
ia64                             allmodconfig
sh                           se7724_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                     eseries_pxa_defconfig
powerpc64                           defconfig
arm                        neponset_defconfig
arm                         lpc18xx_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
arm                          exynos_defconfig
sh                          lboxre2_defconfig
arm                         palmz72_defconfig
arm                  randconfig-c002-20211224
arm                  randconfig-c002-20211223
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20211224
i386                 randconfig-a003-20211224
i386                 randconfig-a001-20211224
i386                 randconfig-a005-20211224
i386                 randconfig-a004-20211224
i386                 randconfig-a006-20211224
x86_64               randconfig-a013-20211223
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a016-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a013-20211223
arc                  randconfig-r043-20211223
riscv                randconfig-r042-20211223
s390                 randconfig-r044-20211223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20211223
x86_64               randconfig-a003-20211223
x86_64               randconfig-a005-20211223
x86_64               randconfig-a006-20211223
x86_64               randconfig-a004-20211223
x86_64               randconfig-a002-20211223
i386                 randconfig-a006-20211223
i386                 randconfig-a004-20211223
i386                 randconfig-a002-20211223
i386                 randconfig-a003-20211223
i386                 randconfig-a005-20211223
i386                 randconfig-a001-20211223
x86_64               randconfig-a013-20211224
x86_64               randconfig-a014-20211224
x86_64               randconfig-a015-20211224
x86_64               randconfig-a012-20211224
x86_64               randconfig-a011-20211224
x86_64               randconfig-a016-20211224
i386                 randconfig-a012-20211224
i386                 randconfig-a011-20211224
i386                 randconfig-a014-20211224
i386                 randconfig-a016-20211224
i386                 randconfig-a015-20211224
i386                 randconfig-a013-20211224

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
