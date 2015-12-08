From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 09 Dec 2015 03:07:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master]
 e370abd95675cb19f10a1594415cbf71d96a181c BUILD SUCCESS
Message-ID: <56672a78.riIB8FQ6rDYyi8EH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  master
e370abd95675cb19f10a1594415cbf71d96a181c  Merge tag 'wireless-drivers-next-for-davem-2015-12-07' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next

i386-tinyconfig vmlinux size:

+-------+------+------+-----+----------------------------------------------------------------------------+
| TOTAL | TEXT | DATA | BSS |                                                                            |
+-------+------+------+-----+----------------------------------------------------------------------------+
|  +128 | +128 |    0 |   0 | f188b951f33a Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net |
|  +128 | +128 |    0 |   0 | ALL COMMITS                                                                |
+-------+------+------+-----+----------------------------------------------------------------------------+

elapsed time: 59m

configs tested: 91

i386                     randconfig-a0-201549
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
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
x86_64                 randconfig-x014-201549
x86_64                 randconfig-x018-201549
x86_64                 randconfig-x016-201549
x86_64                 randconfig-x015-201549
x86_64                 randconfig-x019-201549
x86_64                 randconfig-x011-201549
x86_64                 randconfig-x017-201549
x86_64                 randconfig-x013-201549
x86_64                 randconfig-x010-201549
x86_64                 randconfig-x012-201549
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201549
i386                     randconfig-s1-201549
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
x86_64                   randconfig-i0-201549
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201549
i386                     randconfig-i1-201549
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                     randconfig-n0-201549
arm                     davinci_all_defconfig
mips                          rm200_defconfig
x86_64               randconfig-x008-12070929
x86_64               randconfig-x001-12070929
x86_64               randconfig-x006-12070929
x86_64               randconfig-x002-12070929
x86_64               randconfig-x000-12070929
x86_64               randconfig-x005-12070929
x86_64               randconfig-x007-12070929
x86_64               randconfig-x003-12070929
x86_64               randconfig-x004-12070929
x86_64               randconfig-x009-12070929
i386                     randconfig-r0-201549
i386                 randconfig-x000-12070758
i386                 randconfig-x001-12070758
i386                 randconfig-x002-12070758
i386                 randconfig-x003-12070758
i386                 randconfig-x004-12070758
i386                 randconfig-x005-12070758
i386                 randconfig-x006-12070758
i386                 randconfig-x007-12070758
i386                 randconfig-x008-12070758
i386                 randconfig-x009-12070758
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9

Thanks,
Fengguang
