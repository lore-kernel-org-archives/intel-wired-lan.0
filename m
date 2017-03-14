From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 14 Mar 2017 17:36:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 58f90b91f8d9ef78ec305e1d3db1f94a5f711ff3
Message-ID: <58c7b999.6terJY5+85Flc9Q7%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
58f90b91f8d9ef78ec305e1d3db1f94a5f711ff3  ixgbe: Add support for maximum headroom when using build_skb

drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:393:17: error: redeclaration of 'advertising' with no linkage
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:393:6: error: redeclaration of 'supported' with no linkage

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? i386-randconfig-b0-03141716
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? i386-randconfig-i0-201711
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? i386-randconfig-n0-201711
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? i386-randconfig-x0-03141454
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? i386-randconfig-x018-201711
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? mips-ip27_defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? powerpc-defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-kexec
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-randconfig-b0-03141444
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-randconfig-it0-03141417
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
??? ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-advertising-with-no-linkage
    ??? drivers-net-ethernet-intel-ixgbe-ixgbe_ethtool.c:error:redeclaration-of-supported-with-no-linkage

elapsed time: 64m

configs tested: 212

mips                           ip22_defconfig
powerpc                     tqm8540_defconfig
sh                          landisk_defconfig
arm                        shmobile_defconfig
blackfin                       IP0X_defconfig
m68k                                defconfig
i386                     randconfig-a0-201711
x86_64                 randconfig-a0-03141621
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-03141525
x86_64                randconfig-it0-03141417
mips                      bmips_stb_defconfig
powerpc                     ksi8560_defconfig
sh                           se7705_defconfig
x86_64                 randconfig-v0-03141630
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
blackfin                BF538-EZKIT_defconfig
frv                              alldefconfig
mips                          lasat_defconfig
powerpc64                        alldefconfig
sh                          r7785rp_defconfig
sh                           se7343_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-g0-03141531
x86_64                 randconfig-g0-03141709
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
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
i386                             allmodconfig
m68k                           sun3_defconfig
mips                              allnoconfig
powerpc                 linkstation_defconfig
xtensa                  nommu_kc705_defconfig
arm                         hackkit_defconfig
cris                                defconfig
h8300                     edosk2674_defconfig
mips                         tb0226_defconfig
xtensa                              defconfig
arm64                               defconfig
blackfin                BF533-STAMP_defconfig
m68k                         apollo_defconfig
powerpc                 mpc837x_mds_defconfig
x86_64                 randconfig-x015-201711
x86_64                 randconfig-x012-201711
x86_64                 randconfig-x017-201711
x86_64                 randconfig-x010-201711
x86_64                 randconfig-x018-201711
x86_64                 randconfig-x011-201711
x86_64                 randconfig-x019-201711
x86_64                 randconfig-x014-201711
x86_64                 randconfig-x013-201711
x86_64                 randconfig-x016-201711
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
i386                     randconfig-s0-201711
i386                     randconfig-s1-201711
x86_64                 randconfig-s0-03141633
x86_64                 randconfig-s1-03141633
x86_64                 randconfig-s2-03141633
x86_64                           allmodconfig
x86_64                 randconfig-s3-03141628
x86_64                 randconfig-s4-03141628
x86_64                 randconfig-s5-03141628
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201711
i386                   randconfig-b0-03141511
i386                   randconfig-b0-03141716
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                     randconfig-i0-201711
i386                     randconfig-i1-201711
x86_64                 randconfig-b0-03141444
mips                             allmodconfig
mips                       markeins_defconfig
x86_64                 randconfig-u0-03141545
i386                   randconfig-x014-201711
i386                   randconfig-x010-201711
i386                   randconfig-x016-201711
i386                   randconfig-x017-201711
i386                   randconfig-x013-201711
i386                   randconfig-x019-201711
i386                   randconfig-x015-201711
i386                   randconfig-x012-201711
i386                   randconfig-x011-201711
i386                   randconfig-x018-201711
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                randconfig-ne0-03141534
x86_64                randconfig-ne0-03141709
i386                               tinyconfig
i386                     randconfig-n0-201711
arm                         lpc32xx_defconfig
ia64                            sim_defconfig
sh                        edosk7705_defconfig
x86_64                 randconfig-h0-03141553
x86_64                 randconfig-h0-03141715
mips                           ip27_defconfig
powerpc                 mpc834x_mds_defconfig
parisc                generic-64bit_defconfig
i386                   randconfig-x077-201711
i386                   randconfig-x070-201711
i386                   randconfig-x073-201711
i386                   randconfig-x076-201711
i386                   randconfig-x072-201711
i386                   randconfig-x078-201711
i386                   randconfig-x074-201711
i386                   randconfig-x075-201711
i386                   randconfig-x079-201711
i386                   randconfig-x071-201711
x86_64                                  kexec
x86_64                 randconfig-n0-03141631
x86_64                 randconfig-n0-03141711
arm                               allnoconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
i386                  randconfig-sb0-03141427
x86_64                 randconfig-x000-201711
x86_64                 randconfig-x001-201711
x86_64                 randconfig-x002-201711
x86_64                 randconfig-x003-201711
x86_64                 randconfig-x004-201711
x86_64                 randconfig-x005-201711
x86_64                 randconfig-x006-201711
x86_64                 randconfig-x007-201711
x86_64                 randconfig-x008-201711
x86_64                 randconfig-x009-201711
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                randconfig-ws0-03141410
x86_64                randconfig-ws0-03141404
i386                     randconfig-r0-201711
x86_64                 randconfig-r0-03141511
blackfin                BF561-EZKIT_defconfig
arm                           h3600_defconfig
powerpc64                         allnoconfig
sparc                            alldefconfig
i386                   randconfig-x002-201711
i386                   randconfig-x005-201711
i386                   randconfig-x006-201711
i386                   randconfig-x003-201711
i386                   randconfig-x007-201711
i386                   randconfig-x008-201711
i386                   randconfig-x001-201711
i386                   randconfig-x000-201711
i386                   randconfig-x009-201711
i386                   randconfig-x004-201711
i386                   randconfig-x0-03141454

Thanks,
Fengguang
