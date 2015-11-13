From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 14 Nov 2015 05:40:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 7c2cae61768b0da68519e4c45a86aafab84dda28 BUILD DONE
Message-ID: <564658e0.GGczFCsGivDQF0dR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
7c2cae61768b0da68519e4c45a86aafab84dda28  net: Add a generic udp_offload_get_port function

drivers/net/ethernet/intel/i40e/i40e_main.c:8477:14: error: 'UDP_TUNNEL_VXLAN' undeclared (first use in this function)
drivers/net/ethernet/intel/i40e/i40e_main.c:8579:2: sparse: unmatched #endif in stream
include/net/udp_tunnel.h:111:9: error: implicit declaration of function 'iptunnel_handle_offloads' [-Werror=implicit-function-declaration]
include/net/udp_tunnel.h:111:9: warning: return makes pointer from integer without a cast [-Wint-conversion]

Error ids grouped by kconfigs:

recent_errors
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:sparse:unmatched-endif-in-stream
??? x86_64-randconfig-s3-11140431
??? ??? include-net-udp_tunnel.h:error:implicit-declaration-of-function-iptunnel_handle_offloads
??? ??? include-net-udp_tunnel.h:warning:return-makes-pointer-from-integer-without-a-cast
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:UDP_TUNNEL_VXLAN-undeclared-(first-use-in-this-function)

elapsed time: 57m

configs tested: 111

i386                     randconfig-a0-201545
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
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
i386                             allmodconfig
x86_64               randconfig-x017-11131844
x86_64               randconfig-x010-11131844
x86_64               randconfig-x015-11131844
x86_64               randconfig-x012-11131844
x86_64               randconfig-x011-11131844
x86_64               randconfig-x014-11131844
x86_64               randconfig-x018-11131844
x86_64               randconfig-x013-11131844
x86_64               randconfig-x019-11131844
x86_64               randconfig-x016-11131844
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s1-201545
i386                     randconfig-s0-201545
x86_64                           allmodconfig
x86_64                 randconfig-s3-11140431
x86_64                 randconfig-s4-11140431
x86_64                 randconfig-s5-11140431
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201545
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201545
i386                     randconfig-i1-201545
i386                     randconfig-n0-201545
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                 randconfig-n0-11140426
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
x86_64                 randconfig-x002-201545
x86_64                 randconfig-x000-201545
x86_64                 randconfig-x003-201545
x86_64                 randconfig-x009-201545
x86_64                 randconfig-x004-201545
x86_64                 randconfig-x001-201545
x86_64                 randconfig-x006-201545
x86_64                 randconfig-x008-201545
x86_64                 randconfig-x005-201545
x86_64                 randconfig-x007-201545
x86_64                                    lkp
i386                     randconfig-r0-201545
i386                   randconfig-x004-201545
i386                   randconfig-x009-201545
i386                   randconfig-x003-201545
i386                   randconfig-x007-201545
i386                   randconfig-x005-201545
i386                   randconfig-x006-201545
i386                   randconfig-x008-201545
i386                   randconfig-x000-201545
i386                   randconfig-x001-201545
i386                   randconfig-x002-201545

Thanks,
Fengguang
