From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 30 Dec 2015 11:12:05 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 478650c5603a868a341a17fc35024ce4e374cf56 BUILD DONE
Message-ID: <56834b85.I58taFqYURqIAEL6%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
478650c5603a868a341a17fc35024ce4e374cf56  i40e/i40evf: Bump i40e to 1.4.11 and i40evf to 1.4.7

drivers/net/ethernet/intel/igb/igb_cdev.c:150:2: error: implicit declaration of function 'set_pages_uc' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:186:20-24: ERROR: adapter is NULL but dereferenced.
drivers/net/ethernet/intel/igb/igb_cdev.c:275:2: error: implicit declaration of function 'set_pages_wb' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/igb/igb_cdev.c:364:2-3: Unneeded semicolon
drivers/net/ethernet/intel/igb/igb_cdev.c:414:7-15: ERROR: iterator variable bound on line 412 cannot be NULL
drivers/net/ethernet/intel/igb/igb_cdev.c:95:5-9: Move constant to right.
drivers/net/ethernet/intel/igb/igb_main.c:8276:5-9: Move constant to right.
drivers/net/ethernet/intel/igb/igb_main.c:8277:20-24: ERROR: adapter is NULL but dereferenced.

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:ERROR:adapter-is-NULL-but-dereferenced.
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:ERROR:iterator-variable-bound-on-line-cannot-be-NULL
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:Move-constant-to-right.
??? ??? drivers-net-ethernet-intel-igb-igb_cdev.c:Unneeded-semicolon
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:ERROR:adapter-is-NULL-but-dereferenced.
??? ??? drivers-net-ethernet-intel-igb-igb_main.c:Move-constant-to-right.
??? ia64-defconfig
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_uc
    ??? drivers-net-ethernet-intel-igb-igb_cdev.c:error:implicit-declaration-of-function-set_pages_wb

elapsed time: 68m

configs tested: 107

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
x86_64               randconfig-x017-12300436
x86_64               randconfig-x011-12300436
x86_64               randconfig-x010-12300436
x86_64               randconfig-x019-12300436
x86_64               randconfig-x012-12300436
x86_64               randconfig-x013-12300436
x86_64               randconfig-x014-12300436
x86_64               randconfig-x015-12300436
x86_64               randconfig-x016-12300436
x86_64               randconfig-x018-12300436
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201552
i386                     randconfig-s1-201552
x86_64                           allmodconfig
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
x86_64                 randconfig-i0-12300010
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201552
i386                     randconfig-i1-201552
i386                             allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                   randconfig-n0-12292007
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                   rhel
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64               randconfig-x007-12291635
x86_64               randconfig-x005-12291635
x86_64               randconfig-x008-12291635
x86_64               randconfig-x006-12291635
x86_64               randconfig-x001-12291635
x86_64               randconfig-x000-12291635
x86_64               randconfig-x004-12291635
x86_64               randconfig-x002-12291635
x86_64               randconfig-x009-12291635
x86_64               randconfig-x003-12291635
x86_64                                    lkp
i386                     randconfig-r0-201552
i386                 randconfig-x000-12300610
i386                 randconfig-x001-12300610
i386                 randconfig-x002-12300610
i386                 randconfig-x003-12300610
i386                 randconfig-x004-12300610
i386                 randconfig-x005-12300610
i386                 randconfig-x006-12300610
i386                 randconfig-x007-12300610
i386                 randconfig-x008-12300610
i386                 randconfig-x009-12300610

Thanks,
Fengguang
