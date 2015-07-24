From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 25 Jul 2015 04:30:57 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 2307678add0e6cea39bbd474ebedcabb3c611e37 BUILD DONE
Message-ID: <55b2a081.ZBLqSw4IugcVKIJ2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
2307678add0e6cea39bbd474ebedcabb3c611e37  Subject: e1000: make eeprom read/write scheduler friendly

drivers/net/ethernet/intel/i40e/i40e_debugfs.c:1499:4: warning: format '%lx' expects argument of type 'long unsigned int', but argument 4 has type 'u32' [-Wformat=]

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_debugfs.c:warning:format-lx-expects-argument-of-type-long-unsigned-int-but-argument-has-type-u32

elapsed time: 59m

configs tested: 86

i386                     randconfig-a0-201529
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                             allyesconfig
arm                                    sa1100
arm                         at91_dt_defconfig
arm                               allnoconfig
arm                                   samsung
arm                                  iop-adma
arm                                  at_hdmac
arm                                    ep93xx
arm                                        sh
x86_64                            allnoconfig
i386                              allnoconfig
i386                                defconfig
i386                             allmodconfig
i386                             alldefconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
x86_64                   randconfig-i0-201529
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201529
i386                     randconfig-n0-201529
i386                     randconfig-n1-201529
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
avr32                      atngw100_defconfig
frv                                 defconfig
avr32                     atstk1006_defconfig
tile                         tilegx_defconfig
x86_64                           allmodconfig
x86_64               randconfig-x004-07200849
x86_64               randconfig-x002-07200849
x86_64               randconfig-x001-07200849
x86_64               randconfig-x008-07200849
x86_64               randconfig-x005-07200849
x86_64               randconfig-x007-07200849
x86_64               randconfig-x000-07200849
x86_64               randconfig-x006-07200849
x86_64               randconfig-x003-07200849
x86_64               randconfig-x009-07200849
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-r0-201529
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
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
m68k                          amiga_defconfig
i386                 randconfig-x007-07200849
i386                 randconfig-x005-07200849
i386                 randconfig-x008-07200849
i386                 randconfig-x003-07200849
i386                 randconfig-x004-07200849
i386                 randconfig-x000-07200849
i386                 randconfig-x006-07200849
i386                 randconfig-x009-07200849
i386                 randconfig-x002-07200849
i386                 randconfig-x001-07200849
mips                                   jz4740
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9

Thanks,
Fengguang
