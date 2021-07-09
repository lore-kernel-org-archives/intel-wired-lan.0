From: kernel test robot <lkp@intel.com>
Date: Fri, 09 Jul 2021 13:03:09 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue] BUILD SUCCESS
 a6c5ae02c186fae2cd3040f328feba345b81a278
Message-ID: <60e7d88d.0O8pBmxb3l2myEQM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
branch HEAD: a6c5ae02c186fae2cd3040f328feba345b81a278  ice: support crosstimestamping on E822 devices if supported

elapsed time: 722m

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
mips                      malta_kvm_defconfig
m68k                       bvme6000_defconfig
arm                         palmz72_defconfig
mips                          rb532_defconfig
sh                           se7721_defconfig
m68k                         apollo_defconfig
powerpc                     asp8347_defconfig
arm                           u8500_defconfig
arm                            hisi_defconfig
sh                 kfr2r09-romimage_defconfig
x86_64                              defconfig
ia64                            zx1_defconfig
m68k                          multi_defconfig
powerpc                       maple_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      chrp32_defconfig
powerpc                   bluestone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     ep8248e_defconfig
arm                        oxnas_v6_defconfig
arm                         axm55xx_defconfig
arm                        clps711x_defconfig
sparc                       sparc64_defconfig
mips                        vocore2_defconfig
powerpc                         ps3_defconfig
powerpc                    sam440ep_defconfig
arm                           corgi_defconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
sh                               alldefconfig
mips                    maltaup_xpa_defconfig
s390                       zfcpdump_defconfig
powerpc                    amigaone_defconfig
sh                               j2_defconfig
xtensa                           alldefconfig
arc                          axs103_defconfig
mips                  cavium_octeon_defconfig
arm                     eseries_pxa_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
sh                           se7712_defconfig
sh                        edosk7705_defconfig
mips                     loongson2k_defconfig
arc                        nsim_700_defconfig
sparc64                          alldefconfig
sh                        sh7757lcr_defconfig
arm                          imote2_defconfig
arm                           h3600_defconfig
arm                        mvebu_v7_defconfig
sh                            hp6xx_defconfig
arm                       cns3420vb_defconfig
powerpc                     sbc8548_defconfig
sh                     magicpanelr2_defconfig
h8300                       h8s-sim_defconfig
riscv                            alldefconfig
xtensa                    smp_lx200_defconfig
arm                           h5000_defconfig
sparc                       sparc32_defconfig
powerpc                  mpc885_ads_defconfig
arm                     davinci_all_defconfig
riscv                    nommu_k210_defconfig
mips                     loongson1c_defconfig
mips                            gpr_defconfig
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
x86_64               randconfig-a004-20210707
x86_64               randconfig-a002-20210707
x86_64               randconfig-a005-20210707
x86_64               randconfig-a006-20210707
x86_64               randconfig-a003-20210707
x86_64               randconfig-a001-20210707
i386                 randconfig-a006-20210708
i386                 randconfig-a004-20210708
i386                 randconfig-a001-20210708
i386                 randconfig-a003-20210708
i386                 randconfig-a005-20210708
i386                 randconfig-a002-20210708
i386                 randconfig-a004-20210707
i386                 randconfig-a006-20210707
i386                 randconfig-a001-20210707
i386                 randconfig-a003-20210707
i386                 randconfig-a005-20210707
i386                 randconfig-a002-20210707
i386                 randconfig-a006-20210709
i386                 randconfig-a004-20210709
i386                 randconfig-a001-20210709
i386                 randconfig-a003-20210709
i386                 randconfig-a005-20210709
i386                 randconfig-a002-20210709
i386                 randconfig-a015-20210707
i386                 randconfig-a016-20210707
i386                 randconfig-a012-20210707
i386                 randconfig-a011-20210707
i386                 randconfig-a014-20210707
i386                 randconfig-a013-20210707
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210707
x86_64               randconfig-b001-20210709
x86_64               randconfig-a015-20210707
x86_64               randconfig-a014-20210707
x86_64               randconfig-a012-20210707
x86_64               randconfig-a011-20210707
x86_64               randconfig-a016-20210707
x86_64               randconfig-a013-20210707

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
