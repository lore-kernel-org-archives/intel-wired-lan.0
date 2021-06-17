From: kernel test robot <lkp@intel.com>
Date: Thu, 17 Jun 2021 21:45:37 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 3a99bf3cea7b8d186755211b86437acc7e44e90b
Message-ID: <60cb5201.Tnzcozs2B/lShSpf%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: 3a99bf3cea7b8d186755211b86437acc7e44e90b  iavf: Fix an error handling path in 'iavf_probe()'

elapsed time: 726m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
powerpc                      pcm030_defconfig
nios2                         10m50_defconfig
mips                            e55_defconfig
arm                          pxa910_defconfig
mips                         tb0219_defconfig
mips                      pistachio_defconfig
um                               alldefconfig
powerpc                 mpc836x_mds_defconfig
arc                          axs103_defconfig
powerpc64                           defconfig
parisc                generic-64bit_defconfig
m68k                       bvme6000_defconfig
arm                            hisi_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
powerpc                        cell_defconfig
arm                         orion5x_defconfig
mips                           ci20_defconfig
parisc                generic-32bit_defconfig
arm                   milbeaut_m10v_defconfig
mips                    maltaup_xpa_defconfig
h8300                    h8300h-sim_defconfig
arm                            dove_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
mips                        bcm47xx_defconfig
sh                           se7705_defconfig
arm                           corgi_defconfig
sh                             sh03_defconfig
xtensa                              defconfig
sparc                       sparc64_defconfig
xtensa                          iss_defconfig
mips                         cobalt_defconfig
mips                           ip22_defconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
powerpc                      ep88xc_defconfig
sh                         ecovec24_defconfig
arm                        multi_v7_defconfig
arm                          imote2_defconfig
arm                            qcom_defconfig
ia64                            zx1_defconfig
mips                 decstation_r4k_defconfig
powerpc                      makalu_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
arm                          simpad_defconfig
s390                       zfcpdump_defconfig
openrisc                  or1klitex_defconfig
sh                           se7724_defconfig
mips                          rm200_defconfig
arm                         nhk8815_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210617
x86_64               randconfig-a001-20210617
x86_64               randconfig-a002-20210617
x86_64               randconfig-a003-20210617
x86_64               randconfig-a006-20210617
x86_64               randconfig-a005-20210617
i386                 randconfig-a002-20210617
i386                 randconfig-a006-20210617
i386                 randconfig-a001-20210617
i386                 randconfig-a004-20210617
i386                 randconfig-a005-20210617
i386                 randconfig-a003-20210617
i386                 randconfig-a015-20210617
i386                 randconfig-a013-20210617
i386                 randconfig-a016-20210617
i386                 randconfig-a012-20210617
i386                 randconfig-a014-20210617
i386                 randconfig-a011-20210617
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
x86_64               randconfig-b001-20210617
x86_64               randconfig-a015-20210617
x86_64               randconfig-a011-20210617
x86_64               randconfig-a014-20210617
x86_64               randconfig-a012-20210617
x86_64               randconfig-a013-20210617
x86_64               randconfig-a016-20210617

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
