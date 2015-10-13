From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 13 Oct 2015 16:05:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 169d0610316f55ca24ebd75bed7c4febf264a4ff BUILD DONE
Message-ID: <561cbb45.JXWim91IWfyxVX3a%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
169d0610316f55ca24ebd75bed7c4febf264a4ff  i40e: fix unconditional execution of cpu_to_le16()

drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:17: warning: 'oudph' may be used uninitialized in this function [-Wuninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:20: warning: 'oiph' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/net/ethernet/intel/i40e/i40e_txrx.c:2357:37: warning: 'oiph' may be used uninitialized in this function [-Wuninitialized]

Error ids grouped by kconfigs:

recent_errors
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
??? ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function
??? x86_64-rhel
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oiph-may-be-used-uninitialized-in-this-function
    ??? drivers-net-ethernet-intel-i40e-i40e_txrx.c:warning:oudph-may-be-used-uninitialized-in-this-function

elapsed time: 28m

configs tested: 137

blackfin                    PNAV-10_defconfig
powerpc                     tqm5200_defconfig
sh                          landisk_defconfig
i386                     randconfig-a0-201541
x86_64                 randconfig-a0-10131521
arm                           acs5k_defconfig
arm                     davinci_all_defconfig
i386                   randconfig-c0-10131512
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
avr32                       mimc200_defconfig
microblaze                       allyesconfig
mips                           mtx1_defconfig
powerpc                      mgcoge_defconfig
xtensa                            allnoconfig
x86_64               randconfig-x010-10130227
x86_64               randconfig-x015-10130227
x86_64               randconfig-x017-10130227
x86_64               randconfig-x019-10130227
x86_64               randconfig-x012-10130227
x86_64               randconfig-x018-10130227
x86_64               randconfig-x011-10130227
x86_64               randconfig-x016-10130227
x86_64               randconfig-x014-10130227
x86_64               randconfig-x013-10130227
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s1-201541
i386                     randconfig-s0-201541
x86_64                 randconfig-s0-10131455
x86_64                 randconfig-s1-10131455
x86_64                 randconfig-s2-10131455
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                            allnoconfig
arm                         axm55xx_defconfig
arm                         em_x270_defconfig
arm                      footbridge_defconfig
frv                              allmodconfig
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201541
i386                   randconfig-b0-10131521
i386                     randconfig-i1-201541
i386                     randconfig-i0-201541
x86_64                 randconfig-b0-10131502
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
x86_64                                    lkp
x86_64                                   rhel
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201541
i386                   randconfig-h0-10131329
i386                   randconfig-h1-10131329
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-h0-10131455
x86_64                 randconfig-n0-10131513
arm                        mvebu_v5_defconfig
blackfin                         allmodconfig
sh                              ul2_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                  randconfig-sb0-10131315
x86_64                 randconfig-x002-201541
x86_64                 randconfig-x009-201541
x86_64                 randconfig-x000-201541
x86_64                 randconfig-x003-201541
x86_64                 randconfig-x004-201541
x86_64                 randconfig-x001-201541
x86_64                 randconfig-x006-201541
x86_64                 randconfig-x007-201541
x86_64                 randconfig-x008-201541
x86_64                 randconfig-x005-201541
i386                     randconfig-r0-201541
i386                 randconfig-x008-10121721
i386                 randconfig-x009-10121721
i386                 randconfig-x001-10121721
i386                 randconfig-x002-10121721
i386                 randconfig-x003-10121721
i386                 randconfig-x007-10121721
i386                 randconfig-x006-10121721
i386                 randconfig-x000-10121721
i386                 randconfig-x004-10121721
i386                 randconfig-x005-10121721
i386                   randconfig-x0-10131155

Thanks,
Fengguang
