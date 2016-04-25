From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 25 Apr 2016 10:52:23 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 5f76ea4b66f8a78a7f57ecdef8c3cba4aaf08230 BUILD DONE
Message-ID: <571d8667.XfL6FRrCgrlsH7sE%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
5f76ea4b66f8a78a7f57ecdef8c3cba4aaf08230  ixgbevf: Use mac_ops instead of trying to identify NIC type

drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1548:4-17: code aligned with following code on line 1554

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_virtchnl_pf.c:code-aligned-with-following-code-on-line

elapsed time: 136m

configs tested: 119

i386                     randconfig-a0-201617
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
x86_64                           allmodconfig
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
x86_64                 randconfig-x010-201617
x86_64                 randconfig-x011-201617
x86_64                 randconfig-x018-201617
x86_64                 randconfig-x013-201617
x86_64                 randconfig-x019-201617
x86_64                 randconfig-x012-201617
x86_64                 randconfig-x016-201617
x86_64                 randconfig-x014-201617
x86_64                 randconfig-x015-201617
x86_64                 randconfig-x017-201617
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                     randconfig-s0-201617
i386                     randconfig-s1-201617
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201617
i386                   randconfig-i0-04242207
i386                   randconfig-i1-04242207
i386                             allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201617
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
x86_64                 randconfig-n0-04250844
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
arm                              allyesconfig
arm                        realview_defconfig
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
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
