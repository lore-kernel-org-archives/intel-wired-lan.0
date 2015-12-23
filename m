From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 24 Dec 2015 06:07:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 2e4c8baa66b3d3272ff82dfb5c8585cf1be88685 BUILD SUCCESS
Message-ID: <567b1b33.gnijjSn7Nk1orw8a%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
2e4c8baa66b3d3272ff82dfb5c8585cf1be88685  Merge branch 'cxgb4-next'

i386-tinyconfig vmlinux size:

+-------+------+-------+-----+----------------------------------------------------------------------------+
| TOTAL | TEXT | DATA  | BSS |                                                                            |
+-------+------+-------+-----+----------------------------------------------------------------------------+
| +4372 | +256 | +4096 |   0 | b3e0d3d7bab1 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net |
|  +128 | +128 |     0 |   0 | f188b951f33a Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net |
| +4500 | +384 | +4096 |   0 | ALL COMMITS                                                                |
+-------+------+-------+-----+----------------------------------------------------------------------------+

elapsed time: 60m

configs tested: 105

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201551
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201551
x86_64                 randconfig-x019-201551
x86_64                 randconfig-x010-201551
x86_64                 randconfig-x016-201551
x86_64                 randconfig-x012-201551
x86_64                 randconfig-x011-201551
x86_64                 randconfig-x013-201551
x86_64                 randconfig-x017-201551
x86_64                 randconfig-x014-201551
x86_64                 randconfig-x018-201551
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201551
i386                     randconfig-s1-201551
x86_64                           allmodconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
x86_64                   randconfig-i0-201551
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201551
i386                     randconfig-i1-201551
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201551
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
x86_64                 randconfig-x006-201551
x86_64                 randconfig-x009-201551
x86_64                 randconfig-x003-201551
x86_64                 randconfig-x008-201551
x86_64                 randconfig-x005-201551
x86_64                 randconfig-x001-201551
x86_64                 randconfig-x002-201551
x86_64                 randconfig-x000-201551
x86_64                 randconfig-x004-201551
x86_64                 randconfig-x007-201551
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
i386                     randconfig-r0-201551
i386                 randconfig-x005-12222106
i386                 randconfig-x004-12222106
i386                 randconfig-x002-12222106
i386                 randconfig-x006-12222106
i386                 randconfig-x007-12222106
i386                 randconfig-x003-12222106
i386                 randconfig-x009-12222106
i386                 randconfig-x008-12222106
i386                 randconfig-x001-12222106
i386                 randconfig-x000-12222106
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig

Thanks,
Fengguang
