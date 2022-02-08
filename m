From: kernel test robot <lkp@intel.com>
Date: Tue, 08 Feb 2022 20:38:10 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:1GbE] BUILD SUCCESS
 e62ad74aa534404b3ee7e250b114a3536ac56987
Message-ID: <62026432.y8V71Jihy92cs9ZR%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 1GbE
branch HEAD: e62ad74aa534404b3ee7e250b114a3536ac56987  igb: refactor XDP registration

elapsed time: 722m

configs tested: 146
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
powerpc                    sam440ep_defconfig
m68k                       m5249evb_defconfig
mips                         mpc30x_defconfig
mips                         cobalt_defconfig
arm                             pxa_defconfig
arm                          iop32x_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
powerpc                     pq2fads_defconfig
arc                     haps_hs_smp_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      loongson3_defconfig
sh                           se7619_defconfig
nds32                            alldefconfig
sparc64                             defconfig
arm                        cerfcube_defconfig
sh                            migor_defconfig
powerpc                    adder875_defconfig
m68k                         amcore_defconfig
mips                          rb532_defconfig
arm                        clps711x_defconfig
arm                        keystone_defconfig
sh                        edosk7760_defconfig
mips                     decstation_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      ppc6xx_defconfig
i386                                defconfig
arm                             ezx_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
sh                          urquell_defconfig
arm                       omap2plus_defconfig
powerpc                     rainier_defconfig
powerpc                  iss476-smp_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
riscv                            allyesconfig
arm                     eseries_pxa_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7724_defconfig
s390                       zfcpdump_defconfig
powerpc                     ep8248e_defconfig
sh                            titan_defconfig
powerpc                     asp8347_defconfig
sh                        dreamcast_defconfig
arm                  randconfig-c002-20220207
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
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a013-20220207
x86_64               randconfig-a016-20220207
x86_64               randconfig-a015-20220207
x86_64               randconfig-a012-20220207
x86_64               randconfig-a014-20220207
x86_64               randconfig-a011-20220207
i386                 randconfig-a012-20220207
i386                 randconfig-a013-20220207
i386                 randconfig-a015-20220207
i386                 randconfig-a014-20220207
i386                 randconfig-a011-20220207
i386                 randconfig-a016-20220207
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                   milbeaut_m10v_defconfig
mips                           ip27_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc836x_mds_defconfig
mips                           mtx1_defconfig
arm                            dove_defconfig
arm                         hackkit_defconfig
arm                           sama7_defconfig
riscv                          rv32_defconfig
i386                 randconfig-a003-20220207
i386                 randconfig-a006-20220207
i386                 randconfig-a001-20220207
i386                 randconfig-a002-20220207
i386                 randconfig-a005-20220207
i386                 randconfig-a004-20220207
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220207
hexagon              randconfig-r041-20220207
hexagon              randconfig-r045-20220208
hexagon              randconfig-r041-20220208
riscv                randconfig-r042-20220208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
