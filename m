From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 22 Apr 2016 04:45:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 59b75213897f0bca9c037ccf0bdf1253e4b9cb0f BUILD DONE
Message-ID: <57193be2.hrnZ+k20IYymqKyI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
59b75213897f0bca9c037ccf0bdf1253e4b9cb0f  ixgbe: check EEPROM for WOL support for X540 and above

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1548:4-17: code aligned with following code on line 1554

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c:code-aligned-with-following-code-on-line

elapsed time: 60m

configs tested: 140

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201616
x86_64                 randconfig-a0-04212344
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
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
i386                             allyesconfig
arm                            lart_defconfig
mips                        maltaup_defconfig
powerpc                   currituck_defconfig
powerpc                   lite5200b_defconfig
x86_64                 randconfig-x010-201616
x86_64                 randconfig-x011-201616
x86_64                 randconfig-x018-201616
x86_64                 randconfig-x013-201616
x86_64                 randconfig-x012-201616
x86_64                 randconfig-x019-201616
x86_64                 randconfig-x016-201616
x86_64                 randconfig-x014-201616
x86_64                 randconfig-x015-201616
x86_64                 randconfig-x017-201616
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s0-04211939
i386                   randconfig-s1-04211939
x86_64                 randconfig-s0-04220351
x86_64                 randconfig-s1-04220351
x86_64                 randconfig-s2-04220351
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
blackfin                            defconfig
ia64                                defconfig
mips                                defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                 randconfig-i0-04220113
i386                   randconfig-b0-04220149
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                    mvme5100_defconfig
xtensa                            allnoconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-04220109
i386                   randconfig-i1-04220109
x86_64                              rhel_gcov
i386                   randconfig-x012-201616
i386                   randconfig-x013-201616
i386                   randconfig-x015-201616
i386                   randconfig-x019-201616
i386                   randconfig-x018-201616
i386                   randconfig-x011-201616
i386                   randconfig-x010-201616
i386                   randconfig-x016-201616
i386                   randconfig-x017-201616
i386                   randconfig-x014-201616
i386                     randconfig-n0-201616
ia64                             alldefconfig
ia64                              allnoconfig
x86_64                                   rhel
sh                             shx3_defconfig
x86_64               randconfig-x009-04220119
x86_64               randconfig-x006-04220119
x86_64               randconfig-x002-04220119
x86_64               randconfig-x004-04220119
x86_64               randconfig-x007-04220119
x86_64               randconfig-x008-04220119
x86_64               randconfig-x005-04220119
x86_64               randconfig-x000-04220119
x86_64               randconfig-x003-04220119
x86_64               randconfig-x001-04220119
i386                   randconfig-r0-04220119
x86_64                 randconfig-r0-04220119
i386                 randconfig-x007-04220119
i386                 randconfig-x001-04220119
i386                 randconfig-x002-04220119
i386                 randconfig-x009-04220119
i386                 randconfig-x000-04220119
i386                 randconfig-x005-04220119
i386                 randconfig-x006-04220119
i386                 randconfig-x003-04220119
i386                 randconfig-x008-04220119
i386                 randconfig-x004-04220119
i386                   randconfig-x000-201616
i386                   randconfig-x001-201616
i386                   randconfig-x002-201616
i386                   randconfig-x003-201616
i386                   randconfig-x004-201616
i386                   randconfig-x005-201616
i386                   randconfig-x006-201616
i386                   randconfig-x007-201616
i386                   randconfig-x008-201616
i386                   randconfig-x009-201616

Thanks,
Fengguang
