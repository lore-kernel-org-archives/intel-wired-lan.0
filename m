From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 09 Jun 2016 08:59:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 6011c26042a941a9527d3289300eeb22ad73f9c9 BUILD DONE
Message-ID: <5758bf77.dTGnGwssAO9Js383%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
6011c26042a941a9527d3289300eeb22ad73f9c9  fm10k: bump version number

drivers/net/ethernet/qlogic/qede/qede_dcbnl.c:304:50-51: getdcbx: first occurrence line 311, second occurrence line 327

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-qlogic-qede-qede_dcbnl.c:getdcbx:first-occurrence-line-second-occurrence-line

elapsed time: 65m

configs tested: 122

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201623
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                 randconfig-x010-201623
x86_64                 randconfig-x011-201623
x86_64                 randconfig-x012-201623
x86_64                 randconfig-x013-201623
x86_64                 randconfig-x014-201623
x86_64                 randconfig-x015-201623
x86_64                 randconfig-x016-201623
x86_64                 randconfig-x017-201623
x86_64                 randconfig-x018-201623
x86_64                 randconfig-x019-201623
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201623
i386                     randconfig-s1-201623
x86_64                 randconfig-s0-06090639
x86_64                 randconfig-s1-06090639
x86_64                 randconfig-s2-06090639
x86_64                 randconfig-s3-06090533
x86_64                 randconfig-s4-06090533
x86_64                 randconfig-s5-06090533
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
i386                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                   randconfig-i0-201623
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-i0-06080914
i386                   randconfig-i1-06080914
i386                   randconfig-x017-201623
i386                   randconfig-x018-201623
i386                   randconfig-x014-201623
i386                   randconfig-x011-201623
i386                   randconfig-x016-201623
i386                   randconfig-x013-201623
i386                   randconfig-x010-201623
i386                   randconfig-x019-201623
i386                   randconfig-x015-201623
i386                   randconfig-x012-201623
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201623
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
x86_64                 randconfig-x007-201623
x86_64                 randconfig-x006-201623
x86_64                 randconfig-x003-201623
x86_64                 randconfig-x000-201623
x86_64                 randconfig-x008-201623
x86_64                 randconfig-x005-201623
x86_64                 randconfig-x004-201623
x86_64                 randconfig-x001-201623
x86_64                 randconfig-x002-201623
x86_64                 randconfig-x009-201623
i386                     randconfig-r0-201623
i386                   randconfig-x005-201623
i386                   randconfig-x008-201623
i386                   randconfig-x000-201623
i386                   randconfig-x009-201623
i386                   randconfig-x003-201623
i386                   randconfig-x006-201623
i386                   randconfig-x001-201623
i386                   randconfig-x004-201623
i386                   randconfig-x007-201623
i386                   randconfig-x002-201623

Thanks,
Fengguang
