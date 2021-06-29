From: kernel test robot <lkp@intel.com>
Date: Tue, 29 Jun 2021 14:03:01 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 c4df5f8e2329bbe39ea65be652f23fe1ec8045c9
Message-ID: <60dab795.i2fYTK3oz4BEVRqb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: c4df5f8e2329bbe39ea65be652f23fe1ec8045c9  iavf: Fix ping is lost after untrusted VF had tried to change MAC

elapsed time: 726m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     akebono_defconfig
m68k                       m5249evb_defconfig
powerpc                     sbc8548_defconfig
mips                           ip22_defconfig
arc                          axs101_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    gamecube_defconfig
arm                           sunxi_defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         apsh4a3a_defconfig
csky                             alldefconfig
arm                          pxa910_defconfig
mips                           ip27_defconfig
mips                           jazz_defconfig
arm                          pcm027_defconfig
mips                     loongson1c_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
sh                          urquell_defconfig
powerpc                    socrates_defconfig
powerpc                       ppc64_defconfig
arc                 nsimosci_hs_smp_defconfig
riscv                    nommu_virt_defconfig
mips                  decstation_64_defconfig
arm                          collie_defconfig
mips                      maltaaprp_defconfig
sparc                            allyesconfig
powerpc                      chrp32_defconfig
mips                         tb0226_defconfig
h8300                            alldefconfig
sh                           se7750_defconfig
um                           x86_64_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     sequoia_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
arm                         socfpga_defconfig
arm                           h3600_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210628
i386                 randconfig-a002-20210628
i386                 randconfig-a003-20210628
i386                 randconfig-a006-20210628
i386                 randconfig-a005-20210628
i386                 randconfig-a004-20210628
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
