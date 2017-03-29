From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 29 Mar 2017 20:15:26 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 ec82465448bc6eab18b3e42acfc343f6da68fdfe
Message-ID: <58dba55e.dkONREIIycF6tZOR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
ec82465448bc6eab18b3e42acfc343f6da68fdfe  i40e: fix for queue timing delays

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3125:32-37: ERROR: invalid reference to the index variable of the iterator on line 3079
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)

elapsed time: 185m

configs tested: 127

i386                     randconfig-a0-201713
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
i386                             allmodconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201713
i386                     randconfig-s1-201713
x86_64                           allmodconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201713
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x014-201713
i386                   randconfig-x010-201713
i386                   randconfig-x016-201713
i386                   randconfig-x017-201713
i386                   randconfig-x013-201713
i386                   randconfig-x019-201713
i386                   randconfig-x015-201713
i386                   randconfig-x012-201713
i386                   randconfig-x011-201713
i386                   randconfig-x018-201713
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
x86_64                                  kexec
x86_64                                   rhel
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
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201713
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
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
