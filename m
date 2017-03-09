From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 09 Mar 2017 12:57:42 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 873994391020bcef3e21a55e4fa02455d04680a3
Message-ID: <58c0e0c6.hHQW6cE6GKX1laPn%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
873994391020bcef3e21a55e4fa02455d04680a3  ixgbe: Add support for maximum headroom when using build_skb

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:3098:32-37: ERROR: invalid reference to the index variable of the iterator on line 3052

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:ERROR:invalid-reference-to-the-index-variable-of-the-iterator-on-line

elapsed time: 220m

configs tested: 128

i386                     randconfig-a0-201710
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
x86_64                           allmodconfig
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
x86_64                 randconfig-x015-201710
x86_64                 randconfig-x012-201710
x86_64                 randconfig-x017-201710
x86_64                 randconfig-x010-201710
x86_64                 randconfig-x018-201710
x86_64                 randconfig-x011-201710
x86_64                 randconfig-x019-201710
x86_64                 randconfig-x013-201710
x86_64                 randconfig-x014-201710
x86_64                 randconfig-x016-201710
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201710
i386                     randconfig-s1-201710
i386                               tinyconfig
i386                             allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201710
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-x014-201710
i386                   randconfig-x010-201710
i386                   randconfig-x016-201710
i386                   randconfig-x017-201710
i386                   randconfig-x013-201710
i386                   randconfig-x019-201710
i386                   randconfig-x012-201710
i386                   randconfig-x015-201710
i386                   randconfig-x011-201710
i386                   randconfig-x018-201710
i386                     randconfig-n0-201710
x86_64                                   rhel
i386                   randconfig-x070-201710
i386                   randconfig-x077-201710
i386                   randconfig-x073-201710
i386                   randconfig-x076-201710
i386                   randconfig-x072-201710
i386                   randconfig-x078-201710
i386                   randconfig-x074-201710
i386                   randconfig-x075-201710
i386                   randconfig-x079-201710
i386                   randconfig-x071-201710
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64       acpi-redef+CONFIG_DEBUG_INFO_REDUCED
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-x004-201710
x86_64                 randconfig-x009-201710
x86_64                 randconfig-x003-201710
x86_64                 randconfig-x008-201710
x86_64                 randconfig-x002-201710
x86_64                 randconfig-x000-201710
x86_64                 randconfig-x007-201710
x86_64                 randconfig-x005-201710
x86_64                 randconfig-x006-201710
x86_64                 randconfig-x001-201710
i386                     randconfig-r0-201710
i386                   randconfig-x005-201710
i386                   randconfig-x002-201710
i386                   randconfig-x006-201710
i386                   randconfig-x003-201710
i386                   randconfig-x007-201710
i386                   randconfig-x008-201710
i386                   randconfig-x001-201710
i386                   randconfig-x000-201710
i386                   randconfig-x009-201710
i386                   randconfig-x004-201710

Thanks,
Fengguang
