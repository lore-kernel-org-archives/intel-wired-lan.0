From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 04 May 2016 05:46:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 26879da58711aa604a1b866cbeedd7e0f78f90ad BUILD DONE
Message-ID: <57291c36.rupuIpQMNfp/ya0A%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
26879da58711aa604a1b866cbeedd7e0f78f90ad  ipv6: add new struct ipcm6_cookie

include/net/sock.h:442: warning: No description found for parameter 'sk_rcu'

Error ids grouped by kconfigs:

recent_errors
??? i386-allnoconfig
    ??? include-net-sock.h:warning:No-description-found-for-parameter-sk_rcu

elapsed time: 84m

configs tested: 119

i386                     randconfig-a0-201618
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64       allyesdebian+CONFIG_DEBUG_INFO_REDUCED
x86_64                                nfsroot
i386                               tinyconfig
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                          iop33x_defconfig
arm                        multi_v5_defconfig
sparc                            allyesconfig
um                             i386_defconfig
x86_64                 randconfig-x018-201618
x86_64                 randconfig-x011-201618
x86_64                 randconfig-x010-201618
x86_64                 randconfig-x014-201618
x86_64                 randconfig-x016-201618
x86_64                 randconfig-x012-201618
x86_64                 randconfig-x019-201618
x86_64                 randconfig-x013-201618
x86_64                 randconfig-x015-201618
x86_64                 randconfig-x017-201618
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201618
i386                     randconfig-s1-201618
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                           x86_64_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201618
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201618
i386                     randconfig-i1-201618
x86_64                         customconfig-0
x86_64                         customconfig-1
i386                   randconfig-x013-201618
i386                   randconfig-x012-201618
i386                   randconfig-x011-201618
i386                   randconfig-x018-201618
i386                   randconfig-x019-201618
i386                   randconfig-x015-201618
i386                   randconfig-x016-201618
i386                   randconfig-x010-201618
i386                   randconfig-x014-201618
i386                   randconfig-x017-201618
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201618
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                 randconfig-x007-201618
x86_64                 randconfig-x005-201618
x86_64                 randconfig-x001-201618
x86_64                 randconfig-x000-201618
x86_64                 randconfig-x006-201618
x86_64                 randconfig-x009-201618
x86_64                 randconfig-x008-201618
x86_64                 randconfig-x004-201618
x86_64                 randconfig-x002-201618
x86_64                 randconfig-x003-201618
i386                     randconfig-r0-201618
i386                   randconfig-x003-201618
i386                   randconfig-x000-201618
i386                   randconfig-x004-201618
i386                   randconfig-x005-201618
i386                   randconfig-x009-201618
i386                   randconfig-x006-201618
i386                   randconfig-x002-201618
i386                   randconfig-x001-201618
i386                   randconfig-x008-201618
i386                   randconfig-x007-201618

Thanks,
Fengguang
