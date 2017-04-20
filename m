From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 20 Apr 2017 13:16:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 d730127730c53a2763dcc7efb11ee8440e7fd4e8
Message-ID: <58f84435.tvlIjv5sZeub9v96%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
d730127730c53a2763dcc7efb11ee8440e7fd4e8  i40evf: hide unused variable

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2173:36: error: 'size' undeclared (first use in this function)
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:2173:5: error: 'size' undeclared (first use in this function)

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)
??? tile-allmodconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_main.c:error:size-undeclared-(first-use-in-this-function)

elapsed time: 155m

configs tested: 201

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                          allnoconfig
powerpc                          allyesconfig
sh                     sh7710voipgw_defconfig
i386                     randconfig-a0-201716
x86_64                 randconfig-a0-04201036
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                         bcm2835_defconfig
avr32        atngw100mkii_evklcd100_defconfig
m32r                      mappi.smp_defconfig
i386                   randconfig-c0-04200703
x86_64                randconfig-it0-04200923
m32r                     mappi3.smp_defconfig
m32r                           usrv_defconfig
sh                          rsk7269_defconfig
x86_64                 randconfig-v0-04201053
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
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
sparc                            allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-04201032
i386                             allmodconfig
arm                         ebsa110_defconfig
arm                           sama5_defconfig
m32r                   m32700ut.smp_defconfig
powerpc                      virtex_defconfig
sh                   rts7751r2dplus_defconfig
x86_64                 randconfig-x012-201716
x86_64                 randconfig-x015-201716
x86_64                 randconfig-x017-201716
x86_64                 randconfig-x010-201716
x86_64                 randconfig-x018-201716
x86_64                 randconfig-x011-201716
x86_64                 randconfig-x019-201716
x86_64                 randconfig-x016-201716
x86_64                 randconfig-x013-201716
x86_64                 randconfig-x014-201716
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
i386                     randconfig-s0-201716
i386                     randconfig-s1-201716
x86_64                 randconfig-s0-04201010
x86_64                 randconfig-s1-04201010
x86_64                 randconfig-s2-04201010
x86_64                 randconfig-s3-04201040
x86_64                 randconfig-s4-04201040
x86_64                 randconfig-s5-04201040
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                               tinyconfig
blackfin                 BlackStamp_defconfig
h8300                       h8s-sim_defconfig
powerpc                       holly_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201716
i386                   randconfig-b0-04201100
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
mips                       markeins_defconfig
mips                        xilfpga_defconfig
powerpc                 canyonlands_defconfig
i386                     randconfig-i0-201716
i386                     randconfig-i1-201716
x86_64                 randconfig-b0-04201047
x86_64                           allmodconfig
arm                              alldefconfig
arm                         socfpga_defconfig
powerpc                  mpc866_ads_defconfig
x86_64                 randconfig-u0-04201015
c6x                        evmc6678_defconfig
h8300                    h8300h-sim_defconfig
m32r                       m32104ut_defconfig
m32r                         opsput_defconfig
nios2                         10m50_defconfig
score                      spct6600_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
i386                   randconfig-x010-201716
i386                   randconfig-x011-201716
i386                   randconfig-x012-201716
i386                   randconfig-x013-201716
i386                   randconfig-x014-201716
i386                   randconfig-x015-201716
i386                   randconfig-x016-201716
i386                   randconfig-x017-201716
i386                   randconfig-x018-201716
i386                   randconfig-x019-201716
x86_64                                    lkp
x86_64                                   rhel
i386                     randconfig-n0-201716
s390                                defconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h0-04201020
x86_64                 randconfig-n0-04201029
sh                                allnoconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
arm                         lpc18xx_defconfig
s390                             allyesconfig
sh                        sh7757lcr_defconfig
x86_64                randconfig-ws0-04200857
x86_64                randconfig-ws0-04200814
i386                   randconfig-x073-201716
i386                   randconfig-x070-201716
i386                   randconfig-x077-201716
i386                   randconfig-x072-201716
i386                   randconfig-x076-201716
i386                   randconfig-x074-201716
i386                   randconfig-x078-201716
i386                   randconfig-x075-201716
i386                   randconfig-x079-201716
i386                   randconfig-x071-201716
x86_64                                  kexec
x86_64                               rhel-7.2
arm                        neponset_defconfig
m68k                            q40_defconfig
parisc                         a500_defconfig
x86_64                 randconfig-x009-201716
x86_64                 randconfig-x004-201716
x86_64                 randconfig-x003-201716
x86_64                 randconfig-x008-201716
x86_64                 randconfig-x002-201716
x86_64                 randconfig-x005-201716
x86_64                 randconfig-x000-201716
x86_64                 randconfig-x007-201716
x86_64                 randconfig-x001-201716
x86_64                 randconfig-x006-201716
i386                     randconfig-r0-201716
x86_64                 randconfig-r0-04200900
blackfin                       SRV1_defconfig
sh                           cayman_defconfig
xtensa                           allyesconfig
i386                   randconfig-x006-201716
i386                   randconfig-x005-201716
i386                   randconfig-x002-201716
i386                   randconfig-x007-201716
i386                   randconfig-x003-201716
i386                   randconfig-x001-201716
i386                   randconfig-x008-201716
i386                   randconfig-x000-201716
i386                   randconfig-x004-201716
i386                   randconfig-x009-201716
i386                   randconfig-x0-04201034

Thanks,
Fengguang
