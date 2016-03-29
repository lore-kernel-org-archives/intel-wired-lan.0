From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 29 Mar 2016 13:39:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 e4210bf78a6110de77b5281610f188822f9e18d7 BUILD DONE
Message-ID: <56fa1518.8SIoldD9TOUCqnoz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
e4210bf78a6110de77b5281610f188822f9e18d7  i40e: Move NVM variable out of AQ struct

drivers/net/ethernet/intel/i40e/i40e_fcoe.c:44:20: error: redefinition of 'i40e_rx_is_fcoe'

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_fcoe.c:error:redefinition-of-i40e_rx_is_fcoe
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_fcoe.c:error:redefinition-of-i40e_rx_is_fcoe
??? x86_64-allmodconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_fcoe.c:error:redefinition-of-i40e_rx_is_fcoe

elapsed time: 72m

configs tested: 126

i386                     randconfig-a0-201613
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
x86_64                 randconfig-x010-201613
x86_64                 randconfig-x011-201613
x86_64                 randconfig-x018-201613
x86_64                 randconfig-x019-201613
x86_64                 randconfig-x012-201613
x86_64                 randconfig-x013-201613
x86_64                 randconfig-x016-201613
x86_64                 randconfig-x014-201613
x86_64                 randconfig-x015-201613
x86_64                 randconfig-x017-201613
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                   randconfig-s1-03290854
i386                   randconfig-s0-03290854
i386                     randconfig-s0-201613
i386                     randconfig-s1-201613
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
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                 randconfig-i0-03291158
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201613
i386                     randconfig-i0-201613
x86_64                              rhel_gcov
i386                   randconfig-x013-201613
i386                   randconfig-x012-201613
i386                   randconfig-x019-201613
i386                   randconfig-x015-201613
i386                   randconfig-x018-201613
i386                   randconfig-x011-201613
i386                   randconfig-x010-201613
i386                   randconfig-x016-201613
i386                   randconfig-x017-201613
i386                   randconfig-x014-201613
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201613
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
x86_64                 randconfig-x001-201613
x86_64                 randconfig-x000-201613
x86_64                 randconfig-x005-201613
x86_64                 randconfig-x007-201613
x86_64                 randconfig-x006-201613
x86_64                 randconfig-x004-201613
x86_64                 randconfig-x009-201613
x86_64                 randconfig-x008-201613
x86_64                 randconfig-x003-201613
x86_64                 randconfig-x002-201613
i386                     randconfig-r0-201613
i386                 randconfig-x000-03291152
i386                 randconfig-x001-03291152
i386                 randconfig-x002-03291152
i386                 randconfig-x003-03291152
i386                 randconfig-x004-03291152
i386                 randconfig-x005-03291152
i386                 randconfig-x006-03291152
i386                 randconfig-x007-03291152
i386                 randconfig-x008-03291152
i386                 randconfig-x009-03291152
i386                   randconfig-x000-201613
i386                   randconfig-x001-201613
i386                   randconfig-x002-201613
i386                   randconfig-x003-201613
i386                   randconfig-x004-201613
i386                   randconfig-x005-201613
i386                   randconfig-x006-201613
i386                   randconfig-x007-201613
i386                   randconfig-x008-201613
i386                   randconfig-x009-201613

Thanks,
Fengguang
