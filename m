From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 25 Sep 2016 12:48:41 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue]
 764fe4538af6c9dd1317e2706fe7076769448711 BUILD SUCCESS
Message-ID: <57e75729.ttZeol8ckln+3BzM%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
764fe4538af6c9dd1317e2706fe7076769448711  ixgbe: fix panic when using macvlan with l2-fwd-offload enabled

elapsed time: 185m

The following configs have been built successfully. More configs may be tested in the coming days.
configs tested: 135

alpha                               defconfig
parisc                            allnoconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201639
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64       allyesdebian+CONFIG_DEBUG_INFO_REDUCED-CONFIG_DEBUG_INFO_REDUCED+CONFIG_DEBUG_INFO_REDUCED
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
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
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                                  kexec
x86_64                                   rhel
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                     mappi3.smp_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
parisc                         b180_defconfig
i386                             allmodconfig
x86_64                 randconfig-x015-201639
x86_64                 randconfig-x012-201639
x86_64                 randconfig-x013-201639
x86_64                 randconfig-x011-201639
x86_64                 randconfig-x017-201639
x86_64                 randconfig-x018-201639
x86_64                 randconfig-x014-201639
x86_64                 randconfig-x010-201639
x86_64                 randconfig-x019-201639
x86_64                 randconfig-x016-201639
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
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201639
i386                     randconfig-s1-201639
x86_64                           allmodconfig
i386                               tinyconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201639
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i1-201639
i386                     randconfig-i0-201639
i386                   randconfig-x010-201639
i386                   randconfig-x016-201639
i386                   randconfig-x014-201639
i386                   randconfig-x017-201639
i386                   randconfig-x018-201639
i386                   randconfig-x013-201639
i386                   randconfig-x012-201639
i386                   randconfig-x015-201639
i386                   randconfig-x011-201639
i386                   randconfig-x019-201639
i386                     randconfig-n0-201638
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                               rhel-7.2
x86_64                 randconfig-x002-201639
x86_64                 randconfig-x009-201639
x86_64                 randconfig-x008-201639
x86_64                 randconfig-x004-201639
x86_64                 randconfig-x007-201639
x86_64                 randconfig-x003-201639
x86_64                 randconfig-x005-201639
x86_64                 randconfig-x006-201639
x86_64                 randconfig-x001-201639
x86_64                 randconfig-x000-201639
i386                     randconfig-r0-201639
i386                   randconfig-x009-201639
i386                   randconfig-x002-201639
i386                   randconfig-x006-201639
i386                   randconfig-x007-201639
i386                   randconfig-x008-201639
i386                   randconfig-x001-201639
i386                   randconfig-x003-201639
i386                   randconfig-x000-201639
i386                   randconfig-x004-201639
i386                   randconfig-x005-201639

Thanks,
Fengguang
