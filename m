From: kernel test robot <lkp@intel.com>
Date: Tue, 22 Jun 2021 18:49:59 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 9ae4a7e8f9b121e10936b7284fb82cd1e1609abe
Message-ID: <60d1c057.hE5f+ZyesIboAJOh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 9ae4a7e8f9b121e10936b7284fb82cd1e1609abe  i40e: Fix creation of first queue by omitting it if is not power of two

elapsed time: 720m

configs tested: 154
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
m68k                        mvme16x_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
nios2                         10m50_defconfig
sh                         microdev_defconfig
m68k                          sun3x_defconfig
sh                           se7343_defconfig
powerpc                          allmodconfig
powerpc                    ge_imp3a_defconfig
arm                         at91_dt_defconfig
m68k                       m5475evb_defconfig
mips                     cu1000-neo_defconfig
arm                         mv78xx0_defconfig
mips                         tb0219_defconfig
sh                               allmodconfig
sh                          r7785rp_defconfig
arm                       spear13xx_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         rt305x_defconfig
arm                        keystone_defconfig
arm                          exynos_defconfig
mips                       lemote2f_defconfig
mips                           ip28_defconfig
mips                        workpad_defconfig
arm                         s3c6400_defconfig
mips                          rm200_defconfig
ia64                             allyesconfig
powerpc                  mpc866_ads_defconfig
sh                          landisk_defconfig
powerpc                      ep88xc_defconfig
mips                  maltasmvp_eva_defconfig
s390                             alldefconfig
m68k                          multi_defconfig
powerpc                         ps3_defconfig
arm                             pxa_defconfig
powerpc                      walnut_defconfig
mips                malta_qemu_32r6_defconfig
sparc                       sparc64_defconfig
mips                      maltasmvp_defconfig
arm                            qcom_defconfig
powerpc                     pq2fads_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
m68k                          hp300_defconfig
sh                           se7722_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
ia64                         bigsur_defconfig
sh                                  defconfig
arm                        mini2440_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                          axs103_defconfig
sh                 kfr2r09-romimage_defconfig
alpha                            alldefconfig
mips                        omega2p_defconfig
m68k                         amcore_defconfig
xtensa                  nommu_kc705_defconfig
h8300                       h8s-sim_defconfig
sparc64                             defconfig
csky                                defconfig
mips                        bcm47xx_defconfig
powerpc                        icon_defconfig
arm                       aspeed_g4_defconfig
arc                        vdk_hs38_defconfig
parisc                generic-64bit_defconfig
powerpc                     sbc8548_defconfig
powerpc                   currituck_defconfig
um                               alldefconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
powerpc                           allnoconfig
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
i386                 randconfig-a002-20210621
i386                 randconfig-a001-20210621
i386                 randconfig-a003-20210621
i386                 randconfig-a006-20210621
i386                 randconfig-a005-20210621
i386                 randconfig-a004-20210621
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
x86_64               randconfig-a002-20210621
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
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
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
