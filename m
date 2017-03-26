From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 26 Mar 2017 11:40:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 122772357f8f4408035cce9bee6528e6d53ce005
Message-ID: <58d73838.LTq0MHGOxeA/yY2D%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
122772357f8f4408035cce9bee6528e6d53ce005  ixgbe: add support for XDP_TX action

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3125:32-37: ERROR: invalid reference to the index variable of the iterator on line 3079
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)

elapsed time: 147m

configs tested: 145

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                         ebsa110_defconfig
arm                         iop13xx_defconfig
arm                        vexpress_defconfig
i386                     randconfig-a0-201713
x86_64                 randconfig-a0-03260957
i386                               tinyconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
m32r                         opsput_defconfig
sh                               allyesconfig
x86_64                 randconfig-x015-201713
x86_64                 randconfig-x012-201713
x86_64                 randconfig-x017-201713
x86_64                 randconfig-x010-201713
x86_64                 randconfig-x018-201713
x86_64                 randconfig-x011-201713
x86_64                 randconfig-x019-201713
x86_64                 randconfig-x016-201713
x86_64                 randconfig-x014-201713
x86_64                 randconfig-x013-201713
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201713
i386                     randconfig-s1-201713
i386         randconfig-s0-201713+CONFIG_DEBUG_INFO_REDUCED
x86_64                           allmodconfig
x86_64                 randconfig-s3-03261005
x86_64                 randconfig-s4-03261005
x86_64                 randconfig-s5-03261005
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-i0-03260756
i386                   randconfig-b0-03260943
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x010-201713
i386                   randconfig-x011-201713
i386                   randconfig-x012-201713
i386                   randconfig-x013-201713
i386                   randconfig-x014-201713
i386                   randconfig-x015-201713
i386                   randconfig-x016-201713
i386                   randconfig-x017-201713
i386                   randconfig-x018-201713
i386                   randconfig-x019-201713
arm                          pcm027_defconfig
mips                     decstation_defconfig
x86_64                randconfig-ne0-03261053
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
x86_64                               rhel-7.2
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
i386                   randconfig-x077-201713
i386                   randconfig-x070-201713
i386                   randconfig-x073-201713
i386                   randconfig-x076-201713
i386                   randconfig-x072-201713
i386                   randconfig-x078-201713
i386                   randconfig-x074-201713
i386                   randconfig-x075-201713
i386                   randconfig-x079-201713
i386                   randconfig-x071-201713
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-x009-201713
x86_64                 randconfig-x004-201713
x86_64                 randconfig-x003-201713
x86_64                 randconfig-x008-201713
x86_64                 randconfig-x002-201713
x86_64                 randconfig-x005-201713
x86_64                 randconfig-x007-201713
x86_64                 randconfig-x000-201713
x86_64                 randconfig-x006-201713
x86_64                 randconfig-x001-201713
x86_64                                   rhel
i386                     randconfig-r0-201713
x86_64                 randconfig-r0-03260942
i386                   randconfig-x002-201713
i386                   randconfig-x005-201713
i386                   randconfig-x006-201713
i386                   randconfig-x003-201713
i386                   randconfig-x007-201713
i386                   randconfig-x008-201713
i386                   randconfig-x001-201713
i386                   randconfig-x000-201713
i386                   randconfig-x004-201713
i386                   randconfig-x009-201713
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
