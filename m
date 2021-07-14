From: kernel test robot <lkp@intel.com>
Date: Wed, 14 Jul 2021 15:25:41 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 f52d0592d48cff3ca4d26012a72ffb4dd68295f1
Message-ID: <60ee9175.0kIk6sKc7p4NqbyW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: f52d0592d48cff3ca4d26012a72ffb4dd68295f1  ice: rearm other interrupt cause register after enabling VFs

elapsed time: 727m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  colibri_pxa270_defconfig
microblaze                          defconfig
ia64                             alldefconfig
powerpc                 mpc832x_mds_defconfig
arc                    vdk_hs38_smp_defconfig
arm                       netwinder_defconfig
powerpc                          allmodconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
mips                           gcw0_defconfig
powerpc                    amigaone_defconfig
mips                           ip32_defconfig
arm                              alldefconfig
h8300                     edosk2674_defconfig
powerpc                   bluestone_defconfig
arm                        clps711x_defconfig
mips                     loongson2k_defconfig
powerpc                       ppc64_defconfig
arc                           tb10x_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arm                         lubbock_defconfig
arm                           spitz_defconfig
s390                                defconfig
mips                           ip28_defconfig
sh                           se7751_defconfig
arm                         palmz72_defconfig
powerpc                     skiroot_defconfig
arm                         nhk8815_defconfig
powerpc                    adder875_defconfig
m68k                        m5272c3_defconfig
h8300                            alldefconfig
mips                          ath79_defconfig
powerpc                 mpc834x_mds_defconfig
mips                     loongson1b_defconfig
ia64                                defconfig
arm                             mxs_defconfig
mips                     cu1000-neo_defconfig
powerpc                     kmeter1_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7722_defconfig
arc                                 defconfig
mips                  maltasmvp_eva_defconfig
mips                           rs90_defconfig
mips                       lemote2f_defconfig
s390                       zfcpdump_defconfig
powerpc                     tqm5200_defconfig
arm                         vf610m4_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         bcm2835_defconfig
sh                ecovec24-romimage_defconfig
sparc                            alldefconfig
powerpc                      bamboo_defconfig
arm                        oxnas_v6_defconfig
arm                         orion5x_defconfig
powerpc                    socrates_defconfig
mips                      fuloong2e_defconfig
mips                         db1xxx_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
arm                         socfpga_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5307c3_defconfig
sh                            hp6xx_defconfig
powerpc                  mpc866_ads_defconfig
arm                            lart_defconfig
mips                       capcella_defconfig
arc                              alldefconfig
sh                        edosk7705_defconfig
mips                      maltaaprp_defconfig
powerpc                       maple_defconfig
powerpc                      cm5200_defconfig
arm                        neponset_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210714
x86_64               randconfig-a004-20210714
x86_64               randconfig-a002-20210714
x86_64               randconfig-a003-20210714
x86_64               randconfig-a006-20210714
x86_64               randconfig-a001-20210714
i386                 randconfig-a005-20210713
i386                 randconfig-a004-20210713
i386                 randconfig-a006-20210713
i386                 randconfig-a001-20210713
i386                 randconfig-a002-20210713
i386                 randconfig-a003-20210713
x86_64               randconfig-a013-20210713
x86_64               randconfig-a014-20210713
x86_64               randconfig-a012-20210713
x86_64               randconfig-a015-20210713
x86_64               randconfig-a016-20210713
x86_64               randconfig-a011-20210713
i386                 randconfig-a015-20210713
i386                 randconfig-a014-20210713
i386                 randconfig-a011-20210713
i386                 randconfig-a013-20210713
i386                 randconfig-a012-20210713
i386                 randconfig-a016-20210713
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
x86_64               randconfig-b001-20210713
x86_64               randconfig-a005-20210713
x86_64               randconfig-a004-20210713
x86_64               randconfig-a003-20210713
x86_64               randconfig-a002-20210713
x86_64               randconfig-a006-20210713
x86_64               randconfig-a001-20210713

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
