From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 21 Jul 2017 20:40:25 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue] BUILD INCOMPLETE
 b3169d9bd384652f78ad8bcf43aebe471dfe5e77
Message-ID: <5971f639.tmDst9R2dSBikqGx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  dev-queue
b3169d9bd384652f78ad8bcf43aebe471dfe5e77  i40e: shutdown all IRQs and disable MSI-X when suspended

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 71

alpha                            allmodconfig
alpha                            allyesconfig
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
i386                             allmodconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                          multi_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                             allmodconfig
s390                             allyesconfig
s390                        default_defconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                  kexec
x86_64                          randconfig-i0
x86_64                        randconfig-x010
x86_64                        randconfig-x011
x86_64                        randconfig-x012
x86_64                        randconfig-x013
x86_64                        randconfig-x014
x86_64                        randconfig-x015
x86_64                        randconfig-x016
x86_64                        randconfig-x017
x86_64                        randconfig-x018
x86_64                        randconfig-x019
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 132

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
x86_64                 randconfig-a0-07211838
x86_64                 randconfig-a0-07211944
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-07211827
cris                                defconfig
mips                             alldefconfig
powerpc                     tqm8555_defconfig
x86_64                randconfig-it0-07211859
ia64                            zx1_defconfig
m68k                          atari_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-g0-07211901
parisc                         a500_defconfig
powerpc                     sbc8548_defconfig
powerpc                     sequoia_defconfig
sh                               allmodconfig
blackfin                BF533-STAMP_defconfig
m32r                              allnoconfig
m68k                       m5475evb_defconfig
openrisc                            defconfig
um                                allnoconfig
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                   randconfig-s0-07210904
i386                   randconfig-s1-07210904
x86_64                 randconfig-s3-07211830
x86_64                 randconfig-s4-07211830
x86_64                 randconfig-s5-07211830
x86_64                 randconfig-s3-07212003
x86_64                 randconfig-s4-07212003
x86_64                 randconfig-s5-07212003
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                 randconfig-b0-07211836
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
powerpc                      walnut_defconfig
sh                          polaris_defconfig
i386                               tinyconfig
arm                        shmobile_defconfig
powerpc                   currituck_defconfig
powerpc                      pcm030_defconfig
i386                 randconfig-x011-07211017
i386                 randconfig-x016-07211017
i386                 randconfig-x017-07211017
i386                 randconfig-x013-07211017
i386                 randconfig-x019-07211017
i386                 randconfig-x014-07211017
i386                 randconfig-x012-07211017
i386                 randconfig-x018-07211017
i386                 randconfig-x015-07211017
i386                 randconfig-x010-07211017
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                             allyesconfig
x86_64               randconfig-x005-07211155
x86_64               randconfig-x001-07211155
x86_64               randconfig-x002-07211155
x86_64               randconfig-x003-07211155
x86_64               randconfig-x009-07211155
x86_64               randconfig-x000-07211155
x86_64               randconfig-x006-07211155
x86_64               randconfig-x007-07211155
x86_64               randconfig-x008-07211155
x86_64               randconfig-x004-07211155
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        multi_v7_defconfig
i386                 randconfig-x075-07211033
i386                 randconfig-x071-07211033
i386                 randconfig-x078-07211033
i386                 randconfig-x077-07211033
i386                 randconfig-x072-07211033
i386                 randconfig-x070-07211033
i386                 randconfig-x076-07211033
i386                 randconfig-x079-07211033
i386                 randconfig-x074-07211033
i386                 randconfig-x073-07211033
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
frv                                 defconfig
tile                         tilegx_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                 randconfig-x005-07210940
i386                 randconfig-x003-07210940
i386                 randconfig-x000-07210940
i386                 randconfig-x006-07210940
i386                 randconfig-x007-07210940
i386                 randconfig-x008-07210940
i386                 randconfig-x001-07210940
i386                 randconfig-x004-07210940
i386                 randconfig-x009-07210940
i386                 randconfig-x002-07210940

Thanks,
Fengguang
