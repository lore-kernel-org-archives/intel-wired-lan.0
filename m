From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 28 Oct 2015 10:46:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 00b33fb768d95bca1098c5ccc5ed87fb49e73f21 BUILD DONE
Message-ID: <563036ec.2Pk40XIf7a0zGwHK%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
00b33fb768d95bca1098c5ccc5ed87fb49e73f21  i40e/i40evf: Bump i40e version to 1.4.4 and i40evf to 1.4.1

drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:12: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:2: error: implicit declaration of function 'CLOCKSOURCE_MASK'
drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c:1067:2: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x008-10252017
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x013-201543
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x018-201543
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? x86_64-randconfig-x019-201543
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ptp.c:error:implicit-declaration-of-function-CLOCKSOURCE_MASK


i386-tinyconfig vmlinux size:

+-------+-------+-------+-----+-------------------------------------------------------------------------+
| TOTAL | TEXT  | DATA  | BSS |                                                                         |
+-------+-------+-------+-----+-------------------------------------------------------------------------+
| +6940 | +2820 | +4096 |   0 | ac511a690b05 i40evf: allocate queue vectors dynamically                 |
| -6940 | -2820 | -4096 |   0 | aeda772236e3 i40evf: add new fields to store user configuration of RSS  |
| +6940 | +2820 | +4096 |   0 | eefec150ecaa i40evf: create a generic config rss function               |
| -6940 | -2820 | -4096 |   0 | b66584086290 i40evf: rename vf adapter specific rss function            |
| +6940 | +2820 | +4096 |   0 | 6511ccf5c657 i40e/i40evf: prefetch skb data on transmit                 |
| -6940 | -2820 | -4096 |   0 | 6f7db05130ee fm10k: consistently refer to VLANs and VLAN IDs            |
| +6940 | +2820 | +4096 |   0 | 4a6f568457d0 fm10k: remove namespace pollution of fm10k_iov_msg_data_pf |
| -6940 | -2820 | -4096 |   0 | 472c09199999 fm10k: use ether_addr_equal instead of memcmp              |
| +6940 | +2820 | +4096 |   0 | 1540da87979e fm10k: use ether_addr_copy to copy MAC address             |
| +6940 | +2820 | +4096 |   0 | ALL COMMITS                                                             |
+-------+-------+-------+-----+-------------------------------------------------------------------------+

elapsed time: 73m

configs tested: 113

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                   randconfig-a0-10252128
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
parisc                         b180_defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201543
x86_64                 randconfig-x019-201543
x86_64                 randconfig-x014-201543
x86_64                 randconfig-x016-201543
x86_64                 randconfig-x018-201543
x86_64                 randconfig-x011-201543
x86_64                 randconfig-x013-201543
x86_64                 randconfig-x010-201543
x86_64                 randconfig-x017-201543
x86_64                 randconfig-x012-201543
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201543
i386                     randconfig-s1-201543
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201543
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm                          ks8695_defconfig
avr32                    hammerhead_defconfig
sparc64                          alldefconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201543
i386                     randconfig-i1-201543
x86_64                 randconfig-b0-10280932
x86_64                           allmodconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                   randconfig-n0-10260618
m68k                        mvme147_defconfig
powerpc                  storcenter_defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                                  at_hdmac
arm                                    ep93xx
arm                       imx_v6_v7_defconfig
arm                                  iop-adma
arm                          marzen_defconfig
arm                          prima2_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                       spear13xx_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-x008-10252017
x86_64               randconfig-x007-10252017
x86_64               randconfig-x001-10252017
x86_64               randconfig-x005-10252017
x86_64               randconfig-x004-10252017
x86_64               randconfig-x000-10252017
x86_64               randconfig-x002-10252017
x86_64               randconfig-x006-10252017
x86_64               randconfig-x009-10252017
x86_64               randconfig-x003-10252017
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                   randconfig-r0-10252017
i386                   randconfig-x000-201543
i386                   randconfig-x001-201543
i386                   randconfig-x002-201543
i386                   randconfig-x003-201543
i386                   randconfig-x004-201543
i386                   randconfig-x005-201543
i386                   randconfig-x006-201543
i386                   randconfig-x007-201543
i386                   randconfig-x008-201543
i386                   randconfig-x009-201543

Thanks,
Fengguang
