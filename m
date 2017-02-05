From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 06 Feb 2017 06:47:25 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 2eb02c2cc7ffa3146fb14aefe92fad7c7f132040
Message-ID: <5897ab7d.vSfkftfyBYrnVTgL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
2eb02c2cc7ffa3146fb14aefe92fad7c7f132040  ethtool: stop the line wrapping madness

drivers/net/ethernet/aquantia/atlantic/aq_nic.c:747:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/aquantia/atlantic/aq_nic.c:778:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:347:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:347:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/ehea/ehea_ethtool.c:90:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/ibmveth.c:747:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/marvell/skge.c:323:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/marvell/skge.c:340:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/marvell/sky2.c:3616:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/marvell/sky2.c:3616:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/marvell/sky2.c:3632:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/marvell/sky2.c:3632:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]

Error ids grouped by kconfigs:

recent_errors
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? arm64-defconfig
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? arm-allmodconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-allmodconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-defconfig
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-defconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-ibm-ehea-ehea_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmveth.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-ibm-ehea-ehea_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmveth.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? s390-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-tilegx_defconfig
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-kexec
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-lkp
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-i0-201706
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-rhel
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
    ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32

elapsed time: 135m

configs tested: 121

x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
x86_64                           allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
i386                             allmodconfig
x86_64                 randconfig-x010-201706
x86_64                 randconfig-x011-201706
x86_64                 randconfig-x012-201706
x86_64                 randconfig-x013-201706
x86_64                 randconfig-x014-201706
x86_64                 randconfig-x015-201706
x86_64                 randconfig-x016-201706
x86_64                 randconfig-x017-201706
x86_64                 randconfig-x018-201706
x86_64                 randconfig-x019-201706
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
i386                               tinyconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201706
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
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
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
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
x86_64                 randconfig-x000-201706
x86_64                 randconfig-x001-201706
x86_64                 randconfig-x002-201706
x86_64                 randconfig-x003-201706
x86_64                 randconfig-x004-201706
x86_64                 randconfig-x005-201706
x86_64                 randconfig-x006-201706
x86_64                 randconfig-x007-201706
x86_64                 randconfig-x008-201706
x86_64                 randconfig-x009-201706
i386                   randconfig-x000-201706
i386                   randconfig-x001-201706
i386                   randconfig-x002-201706
i386                   randconfig-x003-201706
i386                   randconfig-x004-201706
i386                   randconfig-x005-201706
i386                   randconfig-x006-201706
i386                   randconfig-x007-201706
i386                   randconfig-x008-201706
i386                   randconfig-x009-201706

Thanks,
Fengguang
