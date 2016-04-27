From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 28 Apr 2016 05:32:06 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 c0cc53162a0644dd57dce5e2fbb9bbafdc57d183 BUILD DONE
Message-ID: <57212fd6.8bPaPj8IoFq142o3%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
c0cc53162a0644dd57dce5e2fbb9bbafdc57d183  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net

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

elapsed time: 72m

configs tested: 118

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201617
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
i386                             alldefconfig
arm                         axm55xx_defconfig
xtensa                generic_kc705_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04280415
x86_64                           allmodconfig
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
i386                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                 randconfig-i0-04271530
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201617
i386                     randconfig-i1-201617
x86_64                 randconfig-b0-04280406
s390                             alldefconfig
sh                         microdev_defconfig
x86_64                              rhel_gcov
x86_64                 randconfig-n0-04280439
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
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201617
i386                   randconfig-h0-04280444
i386                   randconfig-h1-04280444
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                        nlm_xlp_defconfig
powerpc               mpc86xx_basic_defconfig
powerpc64                        alldefconfig
arm                       netwinder_defconfig
powerpc                    mvme5100_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                 randconfig-x000-201617
x86_64                 randconfig-x001-201617
x86_64                 randconfig-x005-201617
x86_64                 randconfig-x007-201617
x86_64                 randconfig-x006-201617
x86_64                 randconfig-x004-201617
x86_64                 randconfig-x008-201617
x86_64                 randconfig-x009-201617
x86_64                 randconfig-x003-201617
x86_64                 randconfig-x002-201617
i386                   randconfig-r0-04271733
i386                   randconfig-x000-201617
i386                   randconfig-x003-201617
i386                   randconfig-x009-201617
i386                   randconfig-x005-201617
i386                   randconfig-x004-201617
i386                   randconfig-x002-201617
i386                   randconfig-x006-201617
i386                   randconfig-x007-201617
i386                   randconfig-x008-201617
i386                   randconfig-x001-201617
i386                              allnoconfig
i386                                defconfig

Thanks,
Fengguang
