From: kernel test robot <lkp@intel.com>
Date: Thu, 06 Aug 2020 16:02:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 b9721e471d8836b587b16ade9484087e2ef7bb8d
Message-ID: <5f2bb932.ceyHmcqzXVoo9Uj+%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: b9721e471d8836b587b16ade9484087e2ef7bb8d  i40e: Fix MAC address setting for a VF via Host/VM

Error/Warning in current branch:

net/ipv4/udp_tunnel_nic.c:849:6-10: ERROR: invalid reference to the index variable of the iterator on line 846

Error/Warning ids grouped by kconfigs:

recent_errors
|-- c6x-randconfig-c003-20200805
|   `-- net-ipv4-udp_tunnel_nic.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line
`-- i386-randconfig-c001-20200805
    `-- net-ipv4-udp_tunnel_nic.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line

elapsed time: 724m

configs tested: 105
configs skipped: 6

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       mainstone_defconfig
sh                   sh7770_generic_defconfig
mips                       rbtx49xx_defconfig
ia64                         bigsur_defconfig
arm                          simpad_defconfig
powerpc                      mgcoge_defconfig
powerpc64                        alldefconfig
mips                      maltasmvp_defconfig
mips                      fuloong2e_defconfig
mips                     loongson1c_defconfig
arm                          lpd270_defconfig
m68k                       m5249evb_defconfig
sh                        dreamcast_defconfig
powerpc                    amigaone_defconfig
powerpc                      pasemi_defconfig
arm                             rpc_defconfig
m68k                        mvme147_defconfig
m68k                          multi_defconfig
powerpc                  mpc885_ads_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
microblaze                      mmu_defconfig
s390                          debug_defconfig
powerpc                     powernv_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
sh                         apsh4a3a_defconfig
mips                            gpr_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
arm                            pleb_defconfig
arm                        keystone_defconfig
arm                          collie_defconfig
arc                        vdk_hs38_defconfig
arm                      tct_hammer_defconfig
mips                     loongson1b_defconfig
powerpc                       ppc64_defconfig
arm                             ezx_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200805
i386                 randconfig-a001-20200805
i386                 randconfig-a003-20200805
i386                 randconfig-a002-20200805
i386                 randconfig-a005-20200805
i386                 randconfig-a006-20200805
x86_64               randconfig-a013-20200805
x86_64               randconfig-a011-20200805
x86_64               randconfig-a012-20200805
x86_64               randconfig-a016-20200805
x86_64               randconfig-a015-20200805
x86_64               randconfig-a014-20200805
i386                 randconfig-a011-20200805
i386                 randconfig-a012-20200805
i386                 randconfig-a013-20200805
i386                 randconfig-a014-20200805
i386                 randconfig-a015-20200805
i386                 randconfig-a016-20200805
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
