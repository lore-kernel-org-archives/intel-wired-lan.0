From: kbuild test robot <lkp@intel.com>
Date: Tue, 24 Jul 2018 02:49:19 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD SUCCESS
 4518264e4c304d1e5a8c0dd081fe723430aaaa65
Message-ID: <5b56232f.bg6Gi0k8QhFi9ahZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
branch HEAD: 4518264e4c304d1e5a8c0dd081fe723430aaaa65  ixgb: use dma_zalloc_coherent instead of allocator/memset

elapsed time: 83m

configs tested: 140

The following configs have been built successfully.
More configs may be tested in the coming days.

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                           allmodconfig
powerpc                 mpc8560_ads_defconfig
x86_64                 randconfig-a0-07232124
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-07231120
powerpc                     mpc5200_defconfig
sh                     magicpanelr2_defconfig
i386                     randconfig-n0-201829
x86_64                 randconfig-x007-201829
x86_64                 randconfig-x003-201829
x86_64                 randconfig-x000-201829
x86_64                 randconfig-x005-201829
x86_64                 randconfig-x004-201829
x86_64                 randconfig-x008-201829
x86_64                 randconfig-x001-201829
x86_64                 randconfig-x009-201829
x86_64                 randconfig-x002-201829
x86_64                 randconfig-x006-201829
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
i386                     randconfig-i0-201829
i386                     randconfig-i1-201829
i386                                defconfig
arm                         vf610m4_defconfig
x86_64                 randconfig-v0-07232238
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                             allmodconfig
x86_64                 randconfig-x018-201829
x86_64                 randconfig-x011-201829
x86_64                 randconfig-x015-201829
x86_64                 randconfig-x019-201829
x86_64                 randconfig-x014-201829
x86_64                 randconfig-x010-201829
x86_64                 randconfig-x013-201829
x86_64                 randconfig-x016-201829
x86_64                 randconfig-x017-201829
x86_64                 randconfig-x012-201829
i386                     randconfig-a0-201829
i386                     randconfig-a1-201829
x86_64                 randconfig-s0-07231842
x86_64                 randconfig-s1-07231842
x86_64                 randconfig-s2-07231842
arm                          pxa3xx_defconfig
ia64                      gensparse_defconfig
mips                         db1xxx_defconfig
sh                   secureedge5410_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201829
i386                     randconfig-s1-201829
x86_64                 randconfig-s3-07232252
x86_64                 randconfig-s4-07232252
x86_64                 randconfig-s5-07232252
x86_64                   randconfig-i0-201829
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc                      pcm030_defconfig
powerpc                     tqm8548_defconfig
sh                            hp6xx_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                      ppc6xx_defconfig
powerpc64                        allmodconfig
x86_64                 randconfig-u0-07240101
s390                    performance_defconfig
sh                               allyesconfig
x86_64                randconfig-ne0-07232115
i386                   randconfig-x012-201829
i386                   randconfig-x017-201829
i386                   randconfig-x014-201829
i386                   randconfig-x016-201829
i386                   randconfig-x013-201829
i386                   randconfig-x011-201829
i386                   randconfig-x018-201829
i386                   randconfig-x010-201829
i386                   randconfig-x015-201829
i386                   randconfig-x019-201829
i386                  randconfig-sb0-07231305
x86_64                randconfig-ws0-07230849
i386                   randconfig-x078-201829
i386                   randconfig-x070-201829
i386                   randconfig-x075-201829
i386                   randconfig-x076-201829
i386                   randconfig-x074-201829
i386                   randconfig-x079-201829
i386                   randconfig-x071-201829
i386                   randconfig-x073-201829
i386                   randconfig-x072-201829
i386                   randconfig-x077-201829
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
openrisc                    or1ksim_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                         shannon_defconfig
mips                           ip28_defconfig
x86_64                 randconfig-r0-07231315
i386                   randconfig-x008-201829
i386                   randconfig-x009-201829
i386                   randconfig-x005-201829
i386                   randconfig-x000-201829
i386                   randconfig-x003-201829
i386                   randconfig-x001-201829
i386                   randconfig-x004-201829
i386                   randconfig-x006-201829
i386                   randconfig-x007-201829
i386                   randconfig-x002-201829
i386                             alldefconfig
i386                              allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
