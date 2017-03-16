From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 16 Mar 2017 21:01:17 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 0feb71a7a0b62bd6952e2a6b981f6ab5efe5a50b
Message-ID: <58ca8c9d.FTNv4n8ONmY1lVUS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
0feb71a7a0b62bd6952e2a6b981f6ab5efe5a50b  ixgbe: Acquire PHY semaphore before device reset

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3119:32-37: ERROR: invalid reference to the index variable of the iterator on line 3073

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line

elapsed time: 218m

configs tested: 143

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201711
x86_64                 randconfig-a0-03161956
x86_64                           allmodconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
avr32        atngw100mkii_evklcd101_defconfig
avr32                               defconfig
cris                       artpec_3_defconfig
openrisc                         allmodconfig
powerpc                     asp8347_defconfig
x86_64                 randconfig-x015-201711
x86_64                 randconfig-x012-201711
x86_64                 randconfig-x017-201711
x86_64                 randconfig-x010-201711
x86_64                 randconfig-x018-201711
x86_64                 randconfig-x011-201711
x86_64                 randconfig-x019-201711
x86_64                 randconfig-x014-201711
x86_64                 randconfig-x013-201711
x86_64                 randconfig-x016-201711
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201711
i386                     randconfig-s1-201711
x86_64                 randconfig-s0-03161921
x86_64                 randconfig-s1-03161921
x86_64                 randconfig-s2-03161921
x86_64                 randconfig-s3-03161952
x86_64                 randconfig-s4-03161952
x86_64                 randconfig-s5-03161952
i386                               tinyconfig
x86_64                   randconfig-i0-201711
i386                     randconfig-i0-201711
i386                     randconfig-i1-201711
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x014-201711
i386                   randconfig-x010-201711
i386                   randconfig-x016-201711
i386                   randconfig-x017-201711
i386                   randconfig-x013-201711
i386                   randconfig-x019-201711
i386                   randconfig-x015-201711
i386                   randconfig-x012-201711
i386                   randconfig-x011-201711
i386                   randconfig-x018-201711
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-x077-201711
i386                   randconfig-x070-201711
i386                   randconfig-x073-201711
i386                   randconfig-x076-201711
i386                   randconfig-x072-201711
i386                   randconfig-x078-201711
i386                   randconfig-x074-201711
i386                   randconfig-x075-201711
i386                   randconfig-x079-201711
i386                   randconfig-x071-201711
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-x004-201711
x86_64                 randconfig-x009-201711
x86_64                 randconfig-x003-201711
x86_64                 randconfig-x008-201711
x86_64                 randconfig-x002-201711
x86_64                 randconfig-x007-201711
x86_64                 randconfig-x000-201711
x86_64                 randconfig-x005-201711
x86_64                 randconfig-x006-201711
x86_64                 randconfig-x001-201711
i386                     randconfig-r0-201711
i386                             allmodconfig
i386                   randconfig-x002-201711
i386                   randconfig-x005-201711
i386                   randconfig-x006-201711
i386                   randconfig-x003-201711
i386                   randconfig-x007-201711
i386                   randconfig-x008-201711
i386                   randconfig-x001-201711
i386                   randconfig-x000-201711
i386                   randconfig-x009-201711
i386                   randconfig-x004-201711
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
