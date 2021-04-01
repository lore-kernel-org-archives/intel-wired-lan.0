From: kernel test robot <lkp@intel.com>
Date: Thu, 01 Apr 2021 17:55:37 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS
 a07cc1786dab69b896af226cf58163237837ee72
Message-ID: <60659899.ioiWQ7i/Cn4hTDXv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: a07cc1786dab69b896af226cf58163237837ee72  ice: Correct comment block style

elapsed time: 722m

configs tested: 144
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
m68k                         amcore_defconfig
arm                       spear13xx_defconfig
arm                           viper_defconfig
um                            kunit_defconfig
xtensa                  cadence_csp_defconfig
arm                  colibri_pxa300_defconfig
nios2                         3c120_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                          simpad_defconfig
powerpc                     akebono_defconfig
arm                           corgi_defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            qcom_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           mtx1_defconfig
arm                         s5pv210_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        bcm63xx_defconfig
arm                         shannon_defconfig
mips                           ip28_defconfig
i386                             alldefconfig
mips                        nlm_xlp_defconfig
sh                         apsh4a3a_defconfig
mips                        jmr3927_defconfig
arm                       versatile_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7722_defconfig
arm                           sama5_defconfig
mips                            gpr_defconfig
parisc                           allyesconfig
s390                       zfcpdump_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
sh                   sh7770_generic_defconfig
arm                           spitz_defconfig
h8300                       h8s-sim_defconfig
arm                         cm_x300_defconfig
powerpc                  storcenter_defconfig
mips                    maltaup_xpa_defconfig
alpha                            allyesconfig
sh                          rsk7203_defconfig
riscv                            alldefconfig
arm                            pleb_defconfig
mips                       lemote2f_defconfig
openrisc                            defconfig
powerpc                     sequoia_defconfig
mips                      loongson3_defconfig
arm                        trizeps4_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
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
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
i386                 randconfig-a015-20210331
i386                 randconfig-a011-20210331
i386                 randconfig-a014-20210331
i386                 randconfig-a013-20210331
i386                 randconfig-a016-20210331
i386                 randconfig-a012-20210331
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
