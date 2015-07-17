From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 17 Jul 2015 18:22:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 2907fc9defa5b4f18d388f8e8ba32878dc6f1dae BUILD DONE
Message-ID: <55a8d768.KgnOqRpEJ8ATxgdw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
2907fc9defa5b4f18d388f8e8ba32878dc6f1dae  e1000e: Fix incorrect ASPM locking

drivers/net/ethernet/intel/i40evf/i40e_txrx.c:1328:20: error: redefinition of 'i40e_update_enable_itr'
drivers/net/ethernet/intel/i40evf/i40e_txrx.c:1345:20: error: redefinition of 'i40e_update_enable_itr'
drivers/net/ethernet/intel/i40evf/i40e_txrx.c:1345:60: error: redefinition of 'i40e_update_enable_itr'

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40evf-i40e_txrx.c:error:redefinition-of-i40e_update_enable_itr
??? i386-allyesconfig
??? ??? drivers-net-ethernet-intel-i40evf-i40e_txrx.c:error:redefinition-of-i40e_update_enable_itr
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40evf-i40e_txrx.c:error:redefinition-of-i40e_update_enable_itr
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40evf-i40e_txrx.c:error:redefinition-of-i40e_update_enable_itr

elapsed time: 62m

configs tested: 83

parisc                        c3000_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                     randconfig-a0-201528
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                            allnoconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201528
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201528
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
i386                             allyesconfig
x86_64                                    lkp
x86_64                                   rhel
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
x86_64                 randconfig-x007-201528
x86_64                 randconfig-x003-201528
x86_64                 randconfig-x009-201528
x86_64                 randconfig-x000-201528
x86_64                 randconfig-x005-201528
x86_64                 randconfig-x006-201528
x86_64                 randconfig-x001-201528
x86_64                 randconfig-x002-201528
x86_64                 randconfig-x008-201528
x86_64                 randconfig-x004-201528
i386                     randconfig-r0-201528
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
i386                   randconfig-x007-201528
i386                   randconfig-x002-201528
i386                   randconfig-x006-201528
i386                   randconfig-x005-201528
i386                   randconfig-x000-201528
i386                   randconfig-x003-201528
i386                   randconfig-x001-201528
i386                   randconfig-x009-201528
i386                   randconfig-x004-201528
i386                   randconfig-x008-201528

Thanks,
Fengguang
