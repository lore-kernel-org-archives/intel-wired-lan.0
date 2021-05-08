From: kernel test robot <lkp@intel.com>
Date: Sat, 08 May 2021 19:35:34 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:master] BUILD SUCCESS
 e4d4a27220a3afdfacf7fbcdc895b08d754f0de1
Message-ID: <60967786.dS6GZ98bRFGSajhb%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git master
branch HEAD: e4d4a27220a3afdfacf7fbcdc895b08d754f0de1  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue

elapsed time: 727m

configs tested: 166
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arc                          axs101_defconfig
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
m68k                        m5272c3_defconfig
sh                          lboxre2_defconfig
powerpc                  mpc866_ads_defconfig
sh                           se7724_defconfig
arm                           u8500_defconfig
sh                           se7343_defconfig
xtensa                           alldefconfig
arm                        spear3xx_defconfig
arm                          ep93xx_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     mpc5200_defconfig
m68k                       m5249evb_defconfig
m68k                             allmodconfig
arc                            hsdk_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7705_defconfig
m68k                            q40_defconfig
arm                         s3c6400_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
arm                         shannon_defconfig
parisc                           alldefconfig
m68k                        m5307c3_defconfig
xtensa                    smp_lx200_defconfig
sh                           se7619_defconfig
arm                           sunxi_defconfig
arm                        clps711x_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
mips                             allyesconfig
sh                           se7712_defconfig
arm                         mv78xx0_defconfig
sh                          landisk_defconfig
mips                     loongson2k_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         bcm2835_defconfig
powerpc                  storcenter_defconfig
arm                          gemini_defconfig
m68k                       m5475evb_defconfig
m68k                       m5208evb_defconfig
arm                             mxs_defconfig
mips                        bcm63xx_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      chrp32_defconfig
sparc                       sparc32_defconfig
arm                         s3c2410_defconfig
mips                        nlm_xlp_defconfig
sh                          rsk7269_defconfig
mips                         bigsur_defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
powerpc                      ppc64e_defconfig
arm                         vf610m4_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                          pxa168_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210508
i386                 randconfig-a006-20210508
i386                 randconfig-a001-20210508
i386                 randconfig-a005-20210508
i386                 randconfig-a004-20210508
i386                 randconfig-a003-20210507
i386                 randconfig-a006-20210507
i386                 randconfig-a001-20210507
i386                 randconfig-a005-20210507
i386                 randconfig-a004-20210507
i386                 randconfig-a002-20210507
i386                 randconfig-a002-20210508
x86_64               randconfig-a014-20210508
x86_64               randconfig-a015-20210508
x86_64               randconfig-a011-20210508
x86_64               randconfig-a013-20210508
x86_64               randconfig-a012-20210508
x86_64               randconfig-a016-20210508
i386                 randconfig-a015-20210507
i386                 randconfig-a013-20210507
i386                 randconfig-a016-20210507
i386                 randconfig-a014-20210507
i386                 randconfig-a012-20210507
i386                 randconfig-a011-20210507
i386                 randconfig-a013-20210508
i386                 randconfig-a015-20210508
i386                 randconfig-a014-20210508
i386                 randconfig-a016-20210508
i386                 randconfig-a011-20210508
i386                 randconfig-a012-20210508
x86_64               randconfig-a001-20210507
x86_64               randconfig-a003-20210507
x86_64               randconfig-a005-20210507
x86_64               randconfig-a002-20210507
x86_64               randconfig-a006-20210507
x86_64               randconfig-a004-20210507
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
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506
x86_64               randconfig-a005-20210508
x86_64               randconfig-a003-20210508
x86_64               randconfig-a001-20210508
x86_64               randconfig-a002-20210508
x86_64               randconfig-a006-20210508
x86_64               randconfig-a004-20210508
x86_64               randconfig-a014-20210507
x86_64               randconfig-a015-20210507
x86_64               randconfig-a012-20210507
x86_64               randconfig-a013-20210507
x86_64               randconfig-a011-20210507
x86_64               randconfig-a016-20210507

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
