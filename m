From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 10 Aug 2017 11:55:42 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 eddefb1696776190ebf23d15fe3dcbafd01f651a
Message-ID: <598bd93e.OznnlPW7mnLVQPbB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
eddefb1696776190ebf23d15fe3dcbafd01f651a  e1000e: fix buffer overrun while the I219 is processing DMA transactions

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:2: warning: case value '35' not in enumerated type 'enum i40e_fc_mode' [-Wswitch]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? arm-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? i386-randconfig-x018-201732
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-i40e-i40e_ethtool.c:warning:case-value-not-in-enumerated-type-enum-i40e_fc_mode

elapsed time: 121m

configs tested: 193

arm                     eseries_pxa_defconfig
arm                           h3600_defconfig
cris                        etraxfs_defconfig
arm                            dove_defconfig
microblaze                          defconfig
powerpc                     ppa8548_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-08101056
x86_64                randconfig-it0-08101030
i386                               tinyconfig
i386                   randconfig-x019-201732
i386                   randconfig-x013-201732
i386                   randconfig-x016-201732
i386                   randconfig-x012-201732
i386                   randconfig-x018-201732
i386                   randconfig-x010-201732
i386                   randconfig-x015-201732
i386                   randconfig-x011-201732
i386                   randconfig-x017-201732
i386                   randconfig-x014-201732
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                     randconfig-n0-201732
x86_64                 randconfig-x007-201732
x86_64                 randconfig-x001-201732
x86_64                 randconfig-x000-201732
x86_64                 randconfig-x006-201732
x86_64                 randconfig-x003-201732
x86_64                 randconfig-x004-201732
x86_64                 randconfig-x009-201732
x86_64                 randconfig-x005-201732
x86_64                 randconfig-x008-201732
x86_64                 randconfig-x002-201732
x86_64                                  kexec
arm                               allnoconfig
arm                            hisi_defconfig
arm                           sama5_defconfig
x86_64                 randconfig-v0-08101007
arm                         axm55xx_defconfig
m68k                            q40_defconfig
powerpc                      acadia_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
arm                       omap2plus_defconfig
arm                                    sa1100
arm                              allmodconfig
arm                                   samsung
arm                        mvebu_v7_defconfig
arm                          ixp4xx_defconfig
arm                       imx_v6_v7_defconfig
arm64                            allmodconfig
arm                           tegra_defconfig
arm                                      arm5
arm64                            alldefconfig
arm                                        sh
arm                                     arm67
i386                     randconfig-a0-201732
i386                     randconfig-a1-201732
x86_64                 randconfig-s0-08101052
x86_64                 randconfig-s1-08101052
x86_64                 randconfig-s2-08101052
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
mips                           ci20_defconfig
mips                           ip28_defconfig
powerpc               mpc85xx_basic_defconfig
s390                           gcov_defconfig
s390                    performance_defconfig
x86_64                 randconfig-x016-201732
x86_64                 randconfig-x011-201732
x86_64                 randconfig-x014-201732
x86_64                 randconfig-x019-201732
x86_64                 randconfig-x012-201732
x86_64                 randconfig-x013-201732
x86_64                 randconfig-x018-201732
x86_64                 randconfig-x015-201732
x86_64                 randconfig-x010-201732
x86_64                 randconfig-x017-201732
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
i386                     randconfig-s0-201732
i386                     randconfig-s1-201732
x86_64                 randconfig-s3-08101103
x86_64                 randconfig-s4-08101103
x86_64                 randconfig-s5-08101103
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                   randconfig-i0-201732
i386                   randconfig-b0-08101113
blackfin                  CM-BF537E_defconfig
powerpc                 mpc834x_itx_defconfig
s390                       zfcpdump_defconfig
sh                           sh2007_defconfig
i386                     randconfig-i1-201732
i386                     randconfig-i0-201732
x86_64                 randconfig-b0-08101059
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
x86_64                           allmodconfig
arm                            lart_defconfig
arm                           viper_defconfig
m68k                          sun3x_defconfig
x86_64                randconfig-ne0-08101016
arm                         at91_dt_defconfig
arm                          gemini_defconfig
mips                          rm200_defconfig
sh                        sh7757lcr_defconfig
i386                   randconfig-h0-08101053
i386                   randconfig-h1-08101053
i386                   randconfig-x075-201732
i386                   randconfig-x076-201732
i386                   randconfig-x071-201732
i386                   randconfig-x074-201732
i386                   randconfig-x070-201732
i386                   randconfig-x072-201732
i386                   randconfig-x079-201732
i386                   randconfig-x077-201732
i386                   randconfig-x078-201732
i386                   randconfig-x073-201732
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
arm                          moxart_defconfig
powerpc                  mpc885_ads_defconfig
sparc64                          alldefconfig
x86_64                randconfig-ws0-08101028
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                               defconfig
x86_64                 randconfig-r0-08101100
i386                             allmodconfig
sh                          lboxre2_defconfig
sparc64                          allyesconfig
i386                   randconfig-x000-201732
i386                   randconfig-x003-201732
i386                   randconfig-x009-201732
i386                   randconfig-x004-201732
i386                   randconfig-x001-201732
i386                   randconfig-x008-201732
i386                   randconfig-x005-201732
i386                   randconfig-x007-201732
i386                   randconfig-x002-201732
i386                   randconfig-x006-201732
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig

Thanks,
Fengguang
