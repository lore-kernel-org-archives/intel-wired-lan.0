From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 17 May 2016 09:52:35 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 023818611c465ce3e8f7f1895730bf027782c621 BUILD DONE
Message-ID: <573a7963.xkJQjEcLuyzS1ydI%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
023818611c465ce3e8f7f1895730bf027782c621  i40e/i40evf: Bump version from 1.5.16 to 1.6.4

drivers/net/ethernet/intel/i40evf/i40evf_main.c:2236:7-21: duplicated argument to & or |

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40evf-i40evf_main.c:duplicated-argument-to-or

elapsed time: 136m

configs tested: 122

blackfin                BF537-STAMP_defconfig
mips                malta_qemu_32r6_defconfig
xtensa                           allyesconfig
i386                   randconfig-a0-05161856
i386                               tinyconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
arm                         lubbock_defconfig
avr32                     atstk1004_defconfig
powerpc                    adder875_defconfig
s390                       zfcpdump_defconfig
sh                          kfr2r09_defconfig
x86_64                 randconfig-x018-201620
x86_64                 randconfig-x019-201620
x86_64                 randconfig-x014-201620
x86_64                 randconfig-x010-201620
x86_64                 randconfig-x015-201620
x86_64                 randconfig-x013-201620
x86_64                 randconfig-x016-201620
x86_64                 randconfig-x017-201620
x86_64                 randconfig-x011-201620
x86_64                 randconfig-x012-201620
i386                   randconfig-s0-05161922
i386                   randconfig-s1-05161922
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                             allmodconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201620
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
i386                   randconfig-x017-201620
i386                   randconfig-x018-201620
i386                   randconfig-x016-201620
i386                   randconfig-x011-201620
i386                   randconfig-x014-201620
i386                   randconfig-x010-201620
i386                   randconfig-x013-201620
i386                   randconfig-x019-201620
i386                   randconfig-x015-201620
i386                   randconfig-x012-201620
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201620
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
x86_64                 randconfig-x007-201620
x86_64                 randconfig-x003-201620
x86_64                 randconfig-x006-201620
x86_64                 randconfig-x000-201620
x86_64                 randconfig-x008-201620
x86_64                 randconfig-x005-201620
x86_64                 randconfig-x004-201620
x86_64                 randconfig-x002-201620
x86_64                 randconfig-x001-201620
x86_64                 randconfig-x009-201620
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201620
x86_64                 randconfig-r0-05170703
i386                   randconfig-x005-201620
i386                   randconfig-x008-201620
i386                   randconfig-x000-201620
i386                   randconfig-x009-201620
i386                   randconfig-x001-201620
i386                   randconfig-x006-201620
i386                   randconfig-x003-201620
i386                   randconfig-x007-201620
i386                   randconfig-x004-201620
i386                   randconfig-x002-201620
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
