From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 21 Aug 2016 11:46:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 5baaee6227ce9019498fd36169b66064392718ff BUILD DONE
Message-ID: <57b9242d.W3J1ccy9J77ZOWHl%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
5baaee6227ce9019498fd36169b66064392718ff  i40e: Add support for switchdev API for Switch ID

drivers/net/ethernet/intel/igb/igb_main.c:8457:20-24: ERROR: adapter is NULL but dereferenced.

Error ids grouped by kconfigs:

recent_errors
??? i386-allmodconfig
    ??? drivers-net-ethernet-intel-igb-igb_main.c:ERROR:adapter-is-NULL-but-dereferenced.

elapsed time: 73m

configs tested: 131

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201634
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
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
parisc                         b180_defconfig
i386                             allmodconfig
x86_64                 randconfig-x012-201634
x86_64                 randconfig-x015-201634
x86_64                 randconfig-x013-201634
x86_64                 randconfig-x011-201634
x86_64                 randconfig-x010-201634
x86_64                 randconfig-x014-201634
x86_64                 randconfig-x018-201634
x86_64                 randconfig-x017-201634
x86_64                 randconfig-x016-201634
x86_64                 randconfig-x019-201634
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
arm                              allmodconfig
arm                                      arm5
arm                                     arm67
arm                       imx_v6_v7_defconfig
arm                          ixp4xx_defconfig
arm                        mvebu_v7_defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                                   samsung
arm                                        sh
arm                           tegra_defconfig
arm64                            alldefconfig
arm64                            allmodconfig
x86_64                            eywa-module
x86_64                                   rhel
x86_64                               rhel-7.2
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201634
i386                     randconfig-s1-201634
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
s390                        default_defconfig
x86_64                   randconfig-i0-201634
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
i386                     randconfig-i0-201634
i386                     randconfig-i1-201634
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x014-201634
i386                   randconfig-x016-201634
i386                   randconfig-x010-201634
i386                   randconfig-x017-201634
i386                   randconfig-x013-201634
i386                   randconfig-x012-201634
i386                   randconfig-x018-201634
i386                   randconfig-x019-201634
i386                   randconfig-x011-201634
i386                   randconfig-x015-201634
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-n0-201634
x86_64                 randconfig-x009-201634
x86_64                 randconfig-x008-201634
x86_64                 randconfig-x002-201634
x86_64                 randconfig-x003-201634
x86_64                 randconfig-x007-201634
x86_64                 randconfig-x004-201634
x86_64                 randconfig-x005-201634
x86_64                 randconfig-x001-201634
x86_64                 randconfig-x006-201634
x86_64                 randconfig-x000-201634
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                                  kexec
i386                     randconfig-r0-201634
i386                 randconfig-x004-08211011
i386                 randconfig-x000-08211011
i386                 randconfig-x008-08211011
i386                 randconfig-x002-08211011
i386                 randconfig-x009-08211011
i386                 randconfig-x003-08211011
i386                 randconfig-x005-08211011
i386                 randconfig-x006-08211011
i386                 randconfig-x001-08211011
i386                 randconfig-x007-08211011

Thanks,
Fengguang
