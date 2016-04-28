From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 28 Apr 2016 11:32:18 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 2995aea5b68b6850e76aadd95be777cb36949e62 BUILD DONE
Message-ID: <57218442.edkbLzOFX5qvuzqG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
2995aea5b68b6850e76aadd95be777cb36949e62  Merge branch '40GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue

include/net/sock.h:442: warning: No description found for parameter 'sk_rcu'
net/ipv4/udp.c:1705:9: sparse: incompatible types in comparison expression (different address spaces)

Error ids grouped by kconfigs:

recent_errors
??? i386-allnoconfig
??? ??? include-net-sock.h:warning:No-description-found-for-parameter-sk_rcu
??? x86_64-allmodconfig
    ??? net-ipv4-udp.c:sparse:incompatible-types-in-comparison-expression-(different-address-spaces)

elapsed time: 73m

configs tested: 97

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-04280940
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
avr32                      atngw100_defconfig
blackfin              BF561-ACVILON_defconfig
ia64                         bigsur_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-04281032
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
x86_64                 randconfig-i0-04271530
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201617
i386                     randconfig-i1-201617
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
mips                  mips_paravirt_defconfig
powerpc                      acadia_defconfig
x86_64                              rhel_gcov
x86_64                 randconfig-n0-04281018
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
i386                   randconfig-h0-04280930
i386                   randconfig-h1-04280930
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
i386                     randconfig-r0-201617
x86_64                 randconfig-r0-04281017
i386                             allmodconfig
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
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
