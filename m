From: kernel test robot <lkp@intel.com>
Date: Tue, 07 Dec 2021 22:28:09 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 4dbb0dad8e63fcd0b5a117c2861d2abe7ff5f186
Message-ID: <61af6f79.4V8+ZagSgIJmwOO3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: 4dbb0dad8e63fcd0b5a117c2861d2abe7ff5f186  devlink: fix netns refcount leak in devlink_nl_cmd_reload()

elapsed time: 798m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211207
powerpc                     tqm8541_defconfig
mips                     decstation_defconfig
parisc                           allyesconfig
powerpc                 mpc837x_rdb_defconfig
arm                       omap2plus_defconfig
sh                                  defconfig
sh                             sh03_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
powerpc                     skiroot_defconfig
mips                        workpad_defconfig
m68k                        m5307c3_defconfig
m68k                         apollo_defconfig
m68k                          atari_defconfig
arm                       multi_v4t_defconfig
xtensa                  nommu_kc705_defconfig
mips                      malta_kvm_defconfig
riscv                    nommu_virt_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
arm                         mv78xx0_defconfig
arc                     nsimosci_hs_defconfig
arm                         bcm2835_defconfig
sh                        apsh4ad0a_defconfig
arm                         vf610m4_defconfig
sh                          lboxre2_defconfig
arm                         shannon_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            titan_defconfig
m68k                             allmodconfig
arm                             rpc_defconfig
mips                    maltaup_xpa_defconfig
xtensa                generic_kc705_defconfig
arm                         at91_dt_defconfig
arm                           spitz_defconfig
arc                           tb10x_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0219_defconfig
arm                           sama7_defconfig
mips                            e55_defconfig
powerpc                   motionpro_defconfig
openrisc                         alldefconfig
powerpc                   lite5200b_defconfig
mips                         mpc30x_defconfig
m68k                                defconfig
arc                         haps_hs_defconfig
sparc                            alldefconfig
arm                         s5pv210_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                        keystone_defconfig
arm                        cerfcube_defconfig
powerpc                     akebono_defconfig
sparc                            allyesconfig
mips                         db1xxx_defconfig
mips                     cu1000-neo_defconfig
powerpc                      pmac32_defconfig
powerpc                        fsp2_defconfig
powerpc                 mpc836x_mds_defconfig
sh                           se7705_defconfig
powerpc                     tqm5200_defconfig
arm                            mps2_defconfig
mips                  cavium_octeon_defconfig
mips                           mtx1_defconfig
sh                   sh7770_generic_defconfig
alpha                               defconfig
arm                      jornada720_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
sh                             shx3_defconfig
arm                  randconfig-c002-20211207
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211207
x86_64               randconfig-a005-20211207
x86_64               randconfig-a001-20211207
x86_64               randconfig-a002-20211207
x86_64               randconfig-a004-20211207
x86_64               randconfig-a003-20211207
i386                 randconfig-a001-20211207
i386                 randconfig-a005-20211207
i386                 randconfig-a002-20211207
i386                 randconfig-a003-20211207
i386                 randconfig-a006-20211207
i386                 randconfig-a004-20211207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c007-20211207
arm                  randconfig-c002-20211207
riscv                randconfig-c006-20211207
mips                 randconfig-c004-20211207
i386                 randconfig-c001-20211207
powerpc              randconfig-c003-20211207
s390                 randconfig-c005-20211207
x86_64               randconfig-a016-20211207
x86_64               randconfig-a011-20211207
x86_64               randconfig-a013-20211207
x86_64               randconfig-a014-20211207
x86_64               randconfig-a015-20211207
x86_64               randconfig-a012-20211207
i386                 randconfig-a016-20211207
i386                 randconfig-a013-20211207
i386                 randconfig-a011-20211207
i386                 randconfig-a014-20211207
i386                 randconfig-a012-20211207
i386                 randconfig-a015-20211207
hexagon              randconfig-r045-20211207
s390                 randconfig-r044-20211207
riscv                randconfig-r042-20211207
hexagon              randconfig-r041-20211207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
