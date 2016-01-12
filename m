From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 12 Jan 2016 20:57:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 e25ea07c9001bc7fe498060ad16260fbe6743838 BUILD DONE
Message-ID: <5694f84b.ArFWOg46K6VL7t7T%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
e25ea07c9001bc7fe498060ad16260fbe6743838  i40e: add VEB stat control and remove L2 cloud filter

drivers/net/ethernet/intel/i40e/i40e_common.c:2451:7: error: 'i' undeclared (first use in this function)
drivers/net/ethernet/intel/i40e/i40e_common.c:2452:7: error: 'i' undeclared (first use in this function)
drivers/net/ethernet/intel/i40e/i40e_common.c:2485:6: warning: unused variable 'i' [-Wunused-variable]
drivers/net/ethernet/intel/i40e/i40e_common.c:2486:6: warning: unused variable 'i' [-Wunused-variable]
drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:error:i-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:unused-variable-i
??? i386-randconfig-i0-201602
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:error:i-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:unused-variable-i
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:error:i-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:unused-variable-i
??? x86_64-randconfig-x015-01110856
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:error:i-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:unused-variable-i
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:error:i-undeclared-(first-use-in-this-function)
    ??? drivers-net-ethernet-intel-i40e-i40e_common.c:warning:unused-variable-i

elapsed time: 48m

configs tested: 123

arm                        shmobile_defconfig
powerpc                          alldefconfig
sh                           se7705_defconfig
i386                   randconfig-a0-01120106
x86_64                 randconfig-a0-01121753
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-01121929
x86_64                           allmodconfig
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
arm                           efm32_defconfig
arm                           stm32_defconfig
avr32                     atstk1003_defconfig
mips                           ip28_defconfig
mips                  maltasmvp_eva_defconfig
x86_64               randconfig-x013-01110856
x86_64               randconfig-x011-01110856
x86_64               randconfig-x012-01110856
x86_64               randconfig-x010-01110856
x86_64               randconfig-x017-01110856
x86_64               randconfig-x015-01110856
x86_64               randconfig-x019-01110856
x86_64               randconfig-x018-01110856
x86_64               randconfig-x016-01110856
x86_64               randconfig-x014-01110856
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201602
i386                     randconfig-s1-201602
x86_64                 randconfig-s0-01121924
x86_64                 randconfig-s1-01121924
x86_64                 randconfig-s2-01121924
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
x86_64                   randconfig-i0-201602
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201602
i386                     randconfig-i1-201602
x86_64                 randconfig-b0-01121931
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201602
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                            dove_defconfig
powerpc                      chrp32_defconfig
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
x86_64                 randconfig-x002-201602
x86_64                 randconfig-x004-201602
x86_64                 randconfig-x000-201602
x86_64                 randconfig-x009-201602
x86_64                 randconfig-x003-201602
x86_64                 randconfig-x005-201602
x86_64                 randconfig-x006-201602
x86_64                 randconfig-x001-201602
x86_64                 randconfig-x008-201602
x86_64                 randconfig-x007-201602
i386                     randconfig-r0-201602
i386                   randconfig-x007-201602
i386                   randconfig-x001-201602
i386                   randconfig-x004-201602
i386                   randconfig-x008-201602
i386                   randconfig-x002-201602
i386                   randconfig-x006-201602
i386                   randconfig-x003-201602
i386                   randconfig-x005-201602
i386                   randconfig-x000-201602
i386                   randconfig-x009-201602

Thanks,
Fengguang
