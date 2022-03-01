From: kernel test robot <lkp@intel.com>
Date: Tue, 01 Mar 2022 21:20:59 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:1GbE] BUILD SUCCESS
 ffd24fa2fcc76ecb2e61e7a4ef8588177bcb42a6
Message-ID: <621e1dbb.Xr6/7cNK3QHqmU0q%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 1GbE
branch HEAD: ffd24fa2fcc76ecb2e61e7a4ef8588177bcb42a6  e1000e: Correct NVM checksum verification flow

elapsed time: 727m

configs tested: 141
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
arc                        vdk_hs38_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arc                 nsimosci_hs_smp_defconfig
parisc                              defconfig
mips                             allyesconfig
nios2                         10m50_defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
sh                              ul2_defconfig
sh                            migor_defconfig
nds32                               defconfig
mips                     loongson1b_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7757lcr_defconfig
powerpc                      bamboo_defconfig
arm                        keystone_defconfig
arc                        nsim_700_defconfig
mips                            gpr_defconfig
sh                          landisk_defconfig
sh                          r7785rp_defconfig
mips                  maltasmvp_eva_defconfig
parisc64                         alldefconfig
m68k                         amcore_defconfig
m68k                            q40_defconfig
powerpc                     asp8347_defconfig
arm                        realview_defconfig
arm                        cerfcube_defconfig
arm                          pxa3xx_defconfig
m68k                        m5307c3_defconfig
m68k                          multi_defconfig
powerpc                     redwood_defconfig
parisc                generic-64bit_defconfig
mips                          rb532_defconfig
um                               alldefconfig
sh                        edosk7705_defconfig
sh                                  defconfig
arm                          iop32x_defconfig
arm                         cm_x300_defconfig
sparc                            allyesconfig
m68k                          atari_defconfig
sh                        apsh4ad0a_defconfig
arm                          simpad_defconfig
arm                     eseries_pxa_defconfig
mips                       bmips_be_defconfig
mips                           ip32_defconfig
arm                  randconfig-c002-20220301
arm                  randconfig-c002-20220228
arm                  randconfig-c002-20220227
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a011-20220228
x86_64               randconfig-a013-20220228
x86_64               randconfig-a015-20220228
x86_64               randconfig-a014-20220228
x86_64               randconfig-a016-20220228
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
i386                 randconfig-a011-20220228
i386                 randconfig-a012-20220228
i386                 randconfig-a013-20220228
i386                 randconfig-a015-20220228
i386                 randconfig-a016-20220228
i386                 randconfig-a014-20220228
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220301
riscv                randconfig-c006-20220301
i386                          randconfig-c001
arm                  randconfig-c002-20220301
mips                 randconfig-c004-20220301
mips                      malta_kvm_defconfig
powerpc                     pseries_defconfig
arm                        vexpress_defconfig
powerpc                      pmac32_defconfig
powerpc                        fsp2_defconfig
arm                           spitz_defconfig
arm                     davinci_all_defconfig
mips                     cu1830-neo_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a012
i386                          randconfig-a011
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
