From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 28 Mar 2017 10:49:53 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 d612c7992fb25dde62d7750f9bb38be7a64a6058
Message-ID: <58d9cf51.7r5MRC1KmnDm64RB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
d612c7992fb25dde62d7750f9bb38be7a64a6058  i40e: fix for queue timing delays

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2171:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)

elapsed time: 94m

configs tested: 161

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                     randconfig-a0-201713
x86_64                 randconfig-a0-03280952
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
x86_64                 randconfig-g0-03280811
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                 randconfig-x015-201713
x86_64                 randconfig-x012-201713
x86_64                 randconfig-x017-201713
x86_64                 randconfig-x010-201713
x86_64                 randconfig-x018-201713
x86_64                 randconfig-x011-201713
x86_64                 randconfig-x019-201713
x86_64                 randconfig-x016-201713
x86_64                 randconfig-x014-201713
x86_64                 randconfig-x013-201713
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
i386                     randconfig-s0-201713
i386                     randconfig-s1-201713
x86_64                 randconfig-s0-03280956
x86_64                 randconfig-s1-03280956
x86_64                 randconfig-s2-03280956
x86_64                           allmodconfig
x86_64                 randconfig-s3-03280945
x86_64                 randconfig-s4-03280945
x86_64                 randconfig-s5-03280945
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                           corgi_defconfig
blackfin                BF537-STAMP_defconfig
powerpc                  mpc866_ads_defconfig
sh                          rsk7203_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201713
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-03270128
i386                   randconfig-i1-03270128
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
tile                             allmodconfig
i386                               tinyconfig
i386                   randconfig-x014-201713
i386                   randconfig-x010-201713
i386                   randconfig-x016-201713
i386                   randconfig-x017-201713
i386                   randconfig-x013-201713
i386                   randconfig-x019-201713
i386                   randconfig-x015-201713
i386                   randconfig-x012-201713
i386                   randconfig-x011-201713
i386                   randconfig-x018-201713
i386                             allmodconfig
m68k                          sun3x_defconfig
sh                           se7751_defconfig
x86_64                 randconfig-n0-03280947
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64                                  kexec
x86_64                                   rhel
i386                   randconfig-x077-201713
i386                   randconfig-x070-201713
i386                   randconfig-x073-201713
i386                   randconfig-x076-201713
i386                   randconfig-x072-201713
i386                   randconfig-x078-201713
i386                   randconfig-x074-201713
i386                   randconfig-x075-201713
i386                   randconfig-x079-201713
i386                   randconfig-x071-201713
i386                             alldefconfig
i386                              allnoconfig
i386                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
x86_64                 randconfig-x009-201713
x86_64                 randconfig-x004-201713
x86_64                 randconfig-x003-201713
x86_64                 randconfig-x008-201713
x86_64                 randconfig-x002-201713
x86_64                 randconfig-x005-201713
x86_64                 randconfig-x007-201713
x86_64                 randconfig-x000-201713
x86_64                 randconfig-x006-201713
x86_64                 randconfig-x001-201713
i386                     randconfig-r0-201713
i386                   randconfig-x002-201713
i386                   randconfig-x005-201713
i386                   randconfig-x006-201713
i386                   randconfig-x003-201713
i386                   randconfig-x007-201713
i386                   randconfig-x008-201713
i386                   randconfig-x001-201713
i386                   randconfig-x000-201713
i386                   randconfig-x004-201713
i386                   randconfig-x009-201713

Thanks,
Fengguang
