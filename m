From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 26 Jul 2017 16:06:58 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:master] BUILD INCOMPLETE
 783692558a60cd69d8d86900b33846263598ca6c
Message-ID: <59784da2.WSKmuW05qS3jPTOv%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git  master
783692558a60cd69d8d86900b33846263598ca6c  lib: test_rhashtable: Fix KASAN warning

net/ipv4/udp.c:1789:87: error: 'struct sk_buff' has no member named 'sp'; did you mean 'sk'?

Error ids grouped by kconfigs:

recent_errors
??? blackfin-BF526-EZBRD_defconfig
??? ??? net-ipv4-udp.c:error:struct-sk_buff-has-no-member-named-sp-did-you-mean-sk
??? blackfin-BF533-EZKIT_defconfig
??? ??? net-ipv4-udp.c:error:struct-sk_buff-has-no-member-named-sp-did-you-mean-sk
??? blackfin-BF561-EZKIT-SMP_defconfig
    ??? net-ipv4-udp.c:error:struct-sk_buff-has-no-member-named-sp-did-you-mean-sk

TIMEOUT after 740m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 95

alpha                            allmodconfig
alpha                            allyesconfig
arm64                             allnoconfig
arm64                          customconfig-0
arm64                          customconfig-1
arm64                          customconfig-2
arm64                               defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                            customconfig-0
arm                            customconfig-1
arm                            customconfig-2
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                           sunxi_defconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
frv                                 defconfig
i386                             allmodconfig
i386                           customconfig-0
i386                           customconfig-1
i386                           customconfig-2
i386                            randconfig-a0
i386                            randconfig-a1
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
i386                            randconfig-s0
i386                            randconfig-s1
i386                          randconfig-x000
i386                          randconfig-x001
i386                          randconfig-x002
i386                          randconfig-x003
i386                          randconfig-x004
i386                          randconfig-x005
i386                          randconfig-x006
i386                          randconfig-x007
i386                          randconfig-x008
i386                          randconfig-x009
i386                          randconfig-x070
i386                          randconfig-x071
i386                          randconfig-x072
i386                          randconfig-x073
i386                          randconfig-x074
i386                          randconfig-x075
i386                          randconfig-x076
i386                          randconfig-x077
i386                          randconfig-x078
i386                          randconfig-x079
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                             allmodconfig
mips                             allyesconfig
mn10300                     asb2364_defconfig
nios2                         10m50_defconfig
openrisc                    or1ksim_defconfig
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
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allmodconfig
x86_64                           allyesconfig
x86_64                         customconfig-0
x86_64                         customconfig-1
x86_64                         customconfig-2
x86_64                                  kexec
x86_64                                    lkp
x86_64                          randconfig-i0
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 91

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                               tinyconfig
i386                   randconfig-x019-201730
i386                   randconfig-x013-201730
i386                   randconfig-x016-201730
i386                   randconfig-x012-201730
i386                   randconfig-x018-201730
i386                   randconfig-x010-201730
i386                   randconfig-x015-201730
i386                   randconfig-x011-201730
i386                   randconfig-x017-201730
i386                   randconfig-x014-201730
x86_64                 randconfig-x007-201730
x86_64                 randconfig-x001-201730
x86_64                 randconfig-x000-201730
x86_64                 randconfig-x006-201730
x86_64                 randconfig-x003-201730
x86_64                 randconfig-x004-201730
x86_64                 randconfig-x009-201730
x86_64                 randconfig-x005-201730
x86_64                 randconfig-x008-201730
x86_64                 randconfig-x002-201730
x86_64                 randconfig-x016-201730
x86_64                 randconfig-x011-201730
x86_64                 randconfig-x019-201730
x86_64                 randconfig-x014-201730
x86_64                 randconfig-x012-201730
x86_64                 randconfig-x013-201730
x86_64                 randconfig-x018-201730
x86_64                 randconfig-x015-201730
x86_64                 randconfig-x010-201730
x86_64                 randconfig-x017-201730
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
score                      spct6600_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
h8300                    h8300h-sim_defconfig
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
