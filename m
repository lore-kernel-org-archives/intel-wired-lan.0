From: kernel test robot <lkp@intel.com>
Date: Sat, 22 May 2021 18:47:51 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue] BUILD SUCCESS
 da6b3562f212ff8bf0a24b4ab3642afdb863dc61
Message-ID: <60a8e157.La1da0/aIBSUkwhT%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
branch HEAD: da6b3562f212ff8bf0a24b4ab3642afdb863dc61  i40e: Fix failed opcode appearing if handling messages from VF

elapsed time: 2127m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                      mgcoge_defconfig
mips                      bmips_stb_defconfig
mips                        jmr3927_defconfig
sh                           se7343_defconfig
arm                          moxart_defconfig
m68k                       m5208evb_defconfig
mips                malta_qemu_32r6_defconfig
sh                   secureedge5410_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     skiroot_defconfig
powerpc                     pq2fads_defconfig
xtensa                    xip_kc705_defconfig
sparc                       sparc64_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
mips                      malta_kvm_defconfig
arm                       netwinder_defconfig
arm                         palmz72_defconfig
arm                        vexpress_defconfig
powerpc                      pcm030_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc83xx_defconfig
sh                          lboxre2_defconfig
s390                       zfcpdump_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8548_defconfig
mips                            gpr_defconfig
um                                  defconfig
x86_64                            allnoconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a001-20210520
x86_64               randconfig-a006-20210520
x86_64               randconfig-a005-20210520
x86_64               randconfig-a003-20210520
x86_64               randconfig-a004-20210520
x86_64               randconfig-a002-20210520
i386                 randconfig-a001-20210521
i386                 randconfig-a005-20210521
i386                 randconfig-a002-20210521
i386                 randconfig-a006-20210521
i386                 randconfig-a003-20210521
i386                 randconfig-a004-20210521
i386                 randconfig-a016-20210520
i386                 randconfig-a011-20210520
i386                 randconfig-a015-20210520
i386                 randconfig-a012-20210520
i386                 randconfig-a014-20210520
i386                 randconfig-a013-20210520
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210520
x86_64               randconfig-a013-20210520
x86_64               randconfig-a014-20210520
x86_64               randconfig-a012-20210520
x86_64               randconfig-a016-20210520
x86_64               randconfig-a015-20210520
x86_64               randconfig-a011-20210520

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
