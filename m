From: kbuild test robot <lkp@intel.com>
Date: Fri, 11 May 2018 06:06:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 9ecce51e67f49d48991c05ad9fba2b953c26ab3e
Message-ID: <5af4c26b.cHMufh5LND1ef49O%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 9ecce51e67f49d48991c05ad9fba2b953c26ab3e  Documentation: e1000: Update kernel documentation

Regressions in current branch:

block/blk-mq.h:115:9: error: implicit declaration of function 'cmpxchg64'; did you mean 'cmpxchg'? [-Werror=implicit-function-declaration]
kernel/trace/../../block/blk-mq.h:115:9: error: implicit declaration of function 'cmpxchg64'; did you mean 'cmpxchg'? [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? mips-jz4740
??? ??? block-blk-mq.h:error:implicit-declaration-of-function-cmpxchg64-did-you-mean-cmpxchg
??? mips-malta_kvm_defconfig
    ??? block-blk-mq.h:error:implicit-declaration-of-function-cmpxchg64-did-you-mean-cmpxchg
    ??? kernel-trace-..-..-block-blk-mq.h:error:implicit-declaration-of-function-cmpxchg64-did-you-mean-cmpxchg

elapsed time: 127m

configs tested: 139

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201818
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201818
i386                     randconfig-i1-201818
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
sh                           se7619_defconfig
x86_64                 randconfig-g0-05102359
i386                             allmodconfig
i386                     randconfig-a0-201818
i386                     randconfig-a1-201818
x86_64                 randconfig-s0-05101923
x86_64                 randconfig-s1-05101923
x86_64                 randconfig-s2-05101923
openrisc                         allmodconfig
powerpc                      mgcoge_defconfig
sparc                             allnoconfig
xtensa                       common_defconfig
x86_64                 randconfig-x010-201818
x86_64                 randconfig-x014-201818
x86_64                 randconfig-x013-201818
x86_64                 randconfig-x011-201818
x86_64                 randconfig-x015-201818
x86_64                 randconfig-x019-201818
x86_64                 randconfig-x016-201818
x86_64                 randconfig-x018-201818
x86_64                 randconfig-x012-201818
x86_64                 randconfig-x017-201818
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                              federa-25
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-s0-201818
i386                     randconfig-s1-201818
x86_64                 randconfig-s3-05110330
x86_64                 randconfig-s4-05110330
x86_64                 randconfig-s5-05110330
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                        multi_v7_defconfig
arm                           sunxi_defconfig
mips                           ip28_defconfig
x86_64                   randconfig-i0-201818
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-u0-05110101
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x013-201818
i386                   randconfig-x014-201818
i386                   randconfig-x019-201818
i386                   randconfig-x016-201818
i386                   randconfig-x015-201818
i386                   randconfig-x012-201818
i386                   randconfig-x018-201818
i386                   randconfig-x010-201818
i386                   randconfig-x011-201818
i386                   randconfig-x017-201818
i386                   randconfig-h0-05110044
i386                   randconfig-h1-05110044
x86_64                randconfig-ne0-05101904
arm                           corgi_defconfig
powerpc                     pq2fads_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        shmobile_defconfig
arm64                             allnoconfig
arm64                               defconfig
x86_64                randconfig-ws0-05102331
i386                   randconfig-x073-201818
i386                   randconfig-x075-201818
i386                   randconfig-x079-201818
i386                   randconfig-x071-201818
i386                   randconfig-x076-201818
i386                   randconfig-x074-201818
i386                   randconfig-x078-201818
i386                   randconfig-x077-201818
i386                   randconfig-x070-201818
i386                   randconfig-x072-201818
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-x002-201818
x86_64                 randconfig-x006-201818
x86_64                 randconfig-x005-201818
x86_64                 randconfig-x001-201818
x86_64                 randconfig-x009-201818
x86_64                 randconfig-x004-201818
x86_64                 randconfig-x003-201818
x86_64                 randconfig-x007-201818
x86_64                 randconfig-x000-201818
x86_64                 randconfig-x008-201818
i386                   randconfig-x008-201818
i386                   randconfig-x006-201818
i386                   randconfig-x000-201818
i386                   randconfig-x004-201818
i386                   randconfig-x009-201818
i386                   randconfig-x003-201818
i386                   randconfig-x001-201818
i386                   randconfig-x002-201818
i386                   randconfig-x005-201818
i386                   randconfig-x007-201818
i386                   randconfig-x0-05102354

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
