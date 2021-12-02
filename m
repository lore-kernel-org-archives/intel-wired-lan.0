From: kernel test robot <lkp@intel.com>
Date: Thu, 02 Dec 2021 19:10:26 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:40GbE] BUILD SUCCESS
 27b0f1485fe9a68d52554a85af81440644fc7675
Message-ID: <61a8a9a2.itOdIRqAdSI66fpg%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 40GbE
branch HEAD: 27b0f1485fe9a68d52554a85af81440644fc7675  i40e: Fix NULL pointer dereference in i40e_dbg_dump_desc

elapsed time: 748m

configs tested: 164
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211202
arm                           corgi_defconfig
sparc                       sparc64_defconfig
powerpc                        warp_defconfig
arm                          pxa910_defconfig
powerpc                          g5_defconfig
arc                        nsim_700_defconfig
openrisc                 simple_smp_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 linkstation_defconfig
sh                        apsh4ad0a_defconfig
arm                       versatile_defconfig
sh                     sh7710voipgw_defconfig
riscv                    nommu_k210_defconfig
arm                          moxart_defconfig
sh                               allmodconfig
arm                         lubbock_defconfig
xtensa                          iss_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc8540_ads_defconfig
sh                          r7780mp_defconfig
sh                         apsh4a3a_defconfig
xtensa                    smp_lx200_defconfig
arm                         hackkit_defconfig
arm                         mv78xx0_defconfig
s390                                defconfig
nds32                            alldefconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
m68k                       m5275evb_defconfig
arm                      tct_hammer_defconfig
mips                        bcm63xx_defconfig
s390                       zfcpdump_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
nds32                               defconfig
arm                            pleb_defconfig
arm                          pxa168_defconfig
m68k                          hp300_defconfig
m68k                            q40_defconfig
arm                           sama5_defconfig
powerpc                   lite5200b_defconfig
arm                        spear3xx_defconfig
powerpc                      mgcoge_defconfig
arm                       cns3420vb_defconfig
arm                            hisi_defconfig
um                                  defconfig
sh                        edosk7705_defconfig
arm                           h5000_defconfig
arm                         cm_x300_defconfig
powerpc                   microwatt_defconfig
arm                         s3c2410_defconfig
sh                           se7619_defconfig
arm                  randconfig-c002-20211202
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211129
i386                 randconfig-a002-20211129
i386                 randconfig-a006-20211129
i386                 randconfig-a005-20211129
i386                 randconfig-a004-20211129
i386                 randconfig-a003-20211129
x86_64               randconfig-a016-20211202
x86_64               randconfig-a011-20211202
x86_64               randconfig-a013-20211202
x86_64               randconfig-a014-20211202
x86_64               randconfig-a012-20211202
x86_64               randconfig-a015-20211202
i386                 randconfig-a016-20211202
i386                 randconfig-a013-20211202
i386                 randconfig-a011-20211202
i386                 randconfig-a014-20211202
i386                 randconfig-a012-20211202
i386                 randconfig-a015-20211202
arc                  randconfig-r043-20211129
arc                  randconfig-r043-20211128
s390                 randconfig-r044-20211128
riscv                randconfig-r042-20211128
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
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211202
x86_64               randconfig-c007-20211202
riscv                randconfig-c006-20211202
i386                 randconfig-c001-20211202
powerpc              randconfig-c003-20211202
s390                 randconfig-c005-20211202
x86_64               randconfig-a006-20211202
x86_64               randconfig-a005-20211202
x86_64               randconfig-a001-20211202
x86_64               randconfig-a002-20211202
x86_64               randconfig-a004-20211202
x86_64               randconfig-a003-20211202
i386                 randconfig-a001-20211128
i386                 randconfig-a002-20211128
i386                 randconfig-a006-20211128
i386                 randconfig-a005-20211128
i386                 randconfig-a004-20211128
i386                 randconfig-a003-20211128
i386                 randconfig-a001-20211202
i386                 randconfig-a005-20211202
i386                 randconfig-a002-20211202
i386                 randconfig-a003-20211202
i386                 randconfig-a006-20211202
i386                 randconfig-a004-20211202
x86_64               randconfig-a014-20211130
x86_64               randconfig-a013-20211130
x86_64               randconfig-a012-20211130
x86_64               randconfig-a015-20211130
x86_64               randconfig-a011-20211130
x86_64               randconfig-a016-20211130
i386                 randconfig-a013-20211201
i386                 randconfig-a016-20211201
i386                 randconfig-a011-20211201
i386                 randconfig-a014-20211201
i386                 randconfig-a012-20211201
i386                 randconfig-a015-20211201
hexagon              randconfig-r045-20211129
hexagon              randconfig-r041-20211129
s390                 randconfig-r044-20211129
riscv                randconfig-r042-20211129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
