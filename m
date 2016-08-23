From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 24 Aug 2016 03:57:21 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 b995b25c6b8fcd888e04e1c696573000356210a1 BUILD DONE
Message-ID: <57bcaaa1.60osbYVGbk9U5WTq%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
b995b25c6b8fcd888e04e1c696573000356210a1  ixgbe: make ixgbe_led_on/off_t_x550em static

drivers/net/ethernet/intel/igb/igb_main.c:8457:20-24: ERROR: adapter is NULL but dereferenced.

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-igb-igb_main.c:ERROR:adapter-is-NULL-but-dereferenced.

elapsed time: 152m

configs tested: 119

i386                   randconfig-a0-08220729
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
x86_64                 randconfig-x012-201634
x86_64                 randconfig-x015-201634
x86_64                 randconfig-x013-201634
x86_64                 randconfig-x011-201634
x86_64                 randconfig-x010-201634
x86_64                 randconfig-x014-201634
x86_64                 randconfig-x018-201634
x86_64                 randconfig-x017-201634
x86_64                 randconfig-x016-201634
x86_64                 randconfig-x019-201634
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
x86_64                            eywa-module
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                              rhel-pmem
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201634
i386                     randconfig-s1-201634
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
frv                                 defconfig
i386                             allmodconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201634
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-08220007
i386                   randconfig-i1-08220007
i386                   randconfig-x014-201634
i386                   randconfig-x016-201634
i386                   randconfig-x010-201634
i386                   randconfig-x017-201634
i386                   randconfig-x013-201634
i386                   randconfig-x012-201634
i386                   randconfig-x018-201634
i386                   randconfig-x019-201634
i386                   randconfig-x011-201634
i386                   randconfig-x015-201634
i386                     randconfig-n0-201634
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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
x86_64                 randconfig-x009-201634
x86_64                 randconfig-x008-201634
x86_64                 randconfig-x002-201634
x86_64                 randconfig-x003-201634
x86_64                 randconfig-x007-201634
x86_64                 randconfig-x004-201634
x86_64                 randconfig-x005-201634
x86_64                 randconfig-x001-201634
x86_64                 randconfig-x006-201634
x86_64                 randconfig-x000-201634
i386                     randconfig-r0-201634
i386                   randconfig-x006-201634
i386                   randconfig-x002-201634
i386                   randconfig-x009-201634
i386                   randconfig-x003-201634
i386                   randconfig-x001-201634
i386                   randconfig-x008-201634
i386                   randconfig-x007-201634
i386                   randconfig-x000-201634
i386                   randconfig-x004-201634
i386                   randconfig-x005-201634

Thanks,
Fengguang
