From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 16 Dec 2015 09:15:26 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 9e428cca38442ac3727d852d247c983d25b38b4c BUILD DONE
Message-ID: <5670bb2e.6vmNamGJduD/kL9o%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
9e428cca38442ac3727d852d247c983d25b38b4c  ixgbevf: Fix handling of napi budget when multiple queues are enabled per vector

drivers/net/ethernet/intel/i40e/i40e_main.c:8852:8: error: 'NETIF_F_SCTP_CSUM' undeclared (first use in this function)
drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? i386-randconfig-a0-201550
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? x86_64-randconfig-x017-12141150
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_main.c:error:NETIF_F_SCTP_CSUM-undeclared-(first-use-in-this-function)

elapsed time: 56m

configs tested: 107

i386                     randconfig-a0-201550
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
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
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64               randconfig-x011-12141150
x86_64               randconfig-x016-12141150
x86_64               randconfig-x013-12141150
x86_64               randconfig-x019-12141150
x86_64               randconfig-x017-12141150
x86_64               randconfig-x012-12141150
x86_64               randconfig-x014-12141150
x86_64               randconfig-x010-12141150
x86_64               randconfig-x018-12141150
x86_64               randconfig-x015-12141150
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201550
i386                     randconfig-s1-201550
x86_64                           allmodconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201550
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201550
i386                     randconfig-i1-201550
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                               tinyconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201550
i386                             allmodconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64               randconfig-x005-12141102
x86_64               randconfig-x003-12141102
x86_64               randconfig-x000-12141102
x86_64               randconfig-x001-12141102
x86_64               randconfig-x007-12141102
x86_64               randconfig-x004-12141102
x86_64               randconfig-x009-12141102
x86_64               randconfig-x006-12141102
x86_64               randconfig-x002-12141102
x86_64               randconfig-x008-12141102
i386                     randconfig-r0-201550
i386                 randconfig-x000-12141102
i386                 randconfig-x007-12141102
i386                 randconfig-x009-12141102
i386                 randconfig-x004-12141102
i386                 randconfig-x003-12141102
i386                 randconfig-x006-12141102
i386                 randconfig-x005-12141102
i386                 randconfig-x002-12141102
i386                 randconfig-x008-12141102
i386                 randconfig-x001-12141102
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
