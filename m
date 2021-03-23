From: kernel test robot <lkp@intel.com>
Date: Tue, 23 Mar 2021 15:32:59 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:100GbE] BUILD SUCCESS WITH
 WARNING a6379db818a850d1c1012cffe160cfc14d64cb40
Message-ID: <605999ab.iH9K3SJTUKMCGiKy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git 100GbE
branch HEAD: a6379db818a850d1c1012cffe160cfc14d64cb40  iavf: Enable flex-bytes support

Warning in current branch:

drivers/net/ethernet/intel/iavf/iavf_fdir.c:340:5: warning: format specifies type 'unsigned short' but the argument has type 'int' [-Wformat]

Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-r034-20210322
    `-- drivers-net-ethernet-intel-iavf-iavf_fdir.c:warning:format-specifies-type-unsigned-short-but-the-argument-has-type-int

elapsed time: 724m

configs tested: 131
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
arc                          axs101_defconfig
m68k                          amiga_defconfig
powerpc                     asp8347_defconfig
sh                     sh7710voipgw_defconfig
mips                     cu1830-neo_defconfig
sh                         ap325rxa_defconfig
m68k                       m5208evb_defconfig
arc                         haps_hs_defconfig
mips                        jmr3927_defconfig
powerpc                   motionpro_defconfig
powerpc                      chrp32_defconfig
arm                          moxart_defconfig
arm                  colibri_pxa270_defconfig
arm                         s3c2410_defconfig
arm                          ixp4xx_defconfig
mips                         rt305x_defconfig
arm                          gemini_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                   sb1250_swarm_defconfig
riscv                    nommu_k210_defconfig
sh                                  defconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
arm                       imx_v4_v5_defconfig
sh                           se7724_defconfig
mips                      malta_kvm_defconfig
sh                        apsh4ad0a_defconfig
mips                         mpc30x_defconfig
arc                          axs103_defconfig
arm                         shannon_defconfig
powerpc                    adder875_defconfig
parisc                           alldefconfig
mips                        omega2p_defconfig
arm                      pxa255-idp_defconfig
powerpc                     akebono_defconfig
powerpc                     redwood_defconfig
arm                            lart_defconfig
arm                         palmz72_defconfig
arm                        mvebu_v7_defconfig
sh                           se7780_defconfig
arm                            qcom_defconfig
m68k                        m5307c3_defconfig
ia64                                defconfig
mips                      pic32mzda_defconfig
sh                        sh7785lcr_defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210322
i386                 randconfig-a003-20210322
i386                 randconfig-a001-20210322
i386                 randconfig-a002-20210322
i386                 randconfig-a006-20210322
i386                 randconfig-a005-20210322
x86_64               randconfig-a002-20210323
x86_64               randconfig-a003-20210323
x86_64               randconfig-a006-20210323
x86_64               randconfig-a001-20210323
x86_64               randconfig-a004-20210323
x86_64               randconfig-a005-20210323
x86_64               randconfig-a012-20210322
x86_64               randconfig-a015-20210322
x86_64               randconfig-a013-20210322
x86_64               randconfig-a014-20210322
x86_64               randconfig-a016-20210322
x86_64               randconfig-a011-20210322
i386                 randconfig-a014-20210322
i386                 randconfig-a011-20210322
i386                 randconfig-a015-20210322
i386                 randconfig-a016-20210322
i386                 randconfig-a012-20210322
i386                 randconfig-a013-20210322
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210322
x86_64               randconfig-a003-20210322
x86_64               randconfig-a001-20210322
x86_64               randconfig-a006-20210322
x86_64               randconfig-a004-20210322
x86_64               randconfig-a005-20210322
x86_64               randconfig-a012-20210323
x86_64               randconfig-a015-20210323
x86_64               randconfig-a013-20210323
x86_64               randconfig-a014-20210323
x86_64               randconfig-a011-20210323
x86_64               randconfig-a016-20210323

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
