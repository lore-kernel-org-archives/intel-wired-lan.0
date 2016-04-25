From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 26 Apr 2016 05:53:19 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 6a025a50b523478b7c8112643cc94f5fd3d312ce BUILD DONE
Message-ID: <571e91cf.IleI5NgEAph9D9vD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
6a025a50b523478b7c8112643cc94f5fd3d312ce  Merge branch 'qed-next'

include/net/sock.h:442: warning: No description found for parameter 'sk_rcu'
net/ipv4/udp.c:1705:9: sparse: incompatible types in comparison expression (different address spaces)
net/ipv6/udp.c:758:9: sparse: incompatible types in comparison expression (different address spaces)
net/tipc/bearer.c:560:48: sparse: incompatible types in comparison expression (different base types)

Error ids grouped by kconfigs:

recent_errors
??? i386-allnoconfig
??? ??? include-net-sock.h:warning:No-description-found-for-parameter-sk_rcu
??? x86_64-allmodconfig
    ??? net-ipv4-udp.c:sparse:incompatible-types-in-comparison-expression-(different-address-spaces)
    ??? net-ipv6-udp.c:sparse:incompatible-types-in-comparison-expression-(different-address-spaces)
    ??? net-tipc-bearer.c:sparse:incompatible-types-in-comparison-expression-(different-base-types)

elapsed time: 91m

configs tested: 124

i386                   randconfig-a0-04260434
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
sh                                  defconfig
x86_64               randconfig-x010-04260410
x86_64               randconfig-x011-04260410
x86_64               randconfig-x012-04260410
x86_64               randconfig-x013-04260410
x86_64               randconfig-x014-04260410
x86_64               randconfig-x015-04260410
x86_64               randconfig-x016-04260410
x86_64               randconfig-x017-04260410
x86_64               randconfig-x018-04260410
x86_64               randconfig-x019-04260410
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-04260410
i386                   randconfig-s1-04260410
x86_64                 randconfig-s0-04260410
x86_64                 randconfig-s1-04260410
x86_64                 randconfig-s2-04260410
x86_64                           allmodconfig
x86_64                 randconfig-s3-04260410
x86_64                 randconfig-s4-04260410
x86_64                 randconfig-s5-04260410
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                 randconfig-i0-04260434
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                              rhel_gcov
i386                   randconfig-x012-201617
i386                   randconfig-x013-201617
i386                   randconfig-x015-201617
i386                   randconfig-x019-201617
i386                   randconfig-x018-201617
i386                   randconfig-x011-201617
i386                   randconfig-x010-201617
i386                   randconfig-x016-201617
i386                   randconfig-x017-201617
i386                   randconfig-x014-201617
i386                   randconfig-n0-04260436
x86_64                                   rhel
ia64                             alldefconfig
ia64                              allnoconfig
i386                   randconfig-r0-04260431
x86_64                 randconfig-r0-04260431
i386                 randconfig-x008-04260201
i386                 randconfig-x007-04260201
i386                 randconfig-x004-04260201
i386                 randconfig-x006-04260201
i386                 randconfig-x000-04260201
i386                 randconfig-x005-04260201
i386                 randconfig-x009-04260201
i386                 randconfig-x002-04260201
i386                 randconfig-x001-04260201
i386                 randconfig-x003-04260201
i386                 randconfig-x000-04260434
i386                 randconfig-x001-04260434
i386                 randconfig-x002-04260434
i386                 randconfig-x003-04260434
i386                 randconfig-x004-04260434
i386                 randconfig-x005-04260434
i386                 randconfig-x006-04260434
i386                 randconfig-x007-04260434
i386                 randconfig-x008-04260434
i386                 randconfig-x009-04260434

Thanks,
Fengguang
