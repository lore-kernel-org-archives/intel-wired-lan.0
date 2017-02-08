From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 08 Feb 2017 13:02:03 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 1d62113199c3131e122d289b1b71de9d4274938f
Message-ID: <589aa64b.PHtYrx+M9ZgQz1rb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
1d62113199c3131e122d289b1b71de9d4274938f  ethtool: stop the line wrapping madness

drivers/net/ethernet/aquantia/atlantic/aq_nic.c:747:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/aquantia/atlantic/aq_nic.c:778:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:347:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/ehea/ehea_ethtool.c:90:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/emac/core.c:2011:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/emac/core.c:2027:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
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
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
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
??? powerpc-canyonlands_defconfig
??? ??? drivers-net-ethernet-ibm-emac-core.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-emac-core.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
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
??? tile-tilegx_defconfig
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allyesdebian
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
??? x86_64-randconfig-r0-02080532
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-rhel
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-rhel-7.2
    ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
    ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
    ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
    ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs tested: 156

m32r                              allnoconfig
mips                             allyesconfig
sh                           se7722_defconfig
x86_64                 randconfig-a0-02081108
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc832x_mds_defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
i386                   randconfig-c0-02081054
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
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
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
blackfin                BF561-EZKIT_defconfig
mips                        bcm47xx_defconfig
s390                       zfcpdump_defconfig
sparc                       sparc32_defconfig
x86_64                 randconfig-x014-201706
x86_64                 randconfig-x017-201706
x86_64                 randconfig-x011-201706
x86_64                 randconfig-x016-201706
x86_64                 randconfig-x012-201706
x86_64                 randconfig-x010-201706
x86_64                 randconfig-x013-201706
x86_64                 randconfig-x019-201706
x86_64                 randconfig-x018-201706
x86_64                 randconfig-x015-201706
i386                              allnoconfig
i386                                defconfig
i386                             alldefconfig
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
x86_64                 randconfig-s0-02081103
x86_64                 randconfig-s1-02081103
x86_64                 randconfig-s2-02081103
x86_64                           allmodconfig
mips                      bmips_stb_defconfig
mips                      maltaaprp_defconfig
powerpc                 canyonlands_defconfig
powerpc                  storcenter_defconfig
x86_64                   randconfig-i0-201706
i386                   randconfig-b0-02080857
arm                          nuc910_defconfig
powerpc                     sbc8548_defconfig
sh                           se7206_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
x86_64                 randconfig-b0-02081114
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
x86_64                 randconfig-u0-02080931
m68k                        mvme147_defconfig
sh                        edosk7760_defconfig
x86_64                randconfig-ne0-02081100
arm                          pxa3xx_defconfig
mn10300                     asb2303_defconfig
powerpc                          alldefconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.2
i386                   randconfig-h0-02081040
i386                   randconfig-h1-02081040
i386                             allmodconfig
x86_64                 randconfig-h0-02081101
openrisc                    or1ksim_defconfig
x86_64                 randconfig-n0-02081058
x86_64                 randconfig-x008-201706
x86_64                 randconfig-x001-201706
x86_64                 randconfig-x009-201706
x86_64                 randconfig-x003-201706
x86_64                 randconfig-x000-201706
x86_64                 randconfig-x006-201706
x86_64                 randconfig-x007-201706
x86_64                 randconfig-x004-201706
x86_64                 randconfig-x002-201706
x86_64                 randconfig-x005-201706
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
x86_64                 randconfig-r0-02080532
i386                   randconfig-x004-201706
i386                   randconfig-x003-201706
i386                   randconfig-x001-201706
i386                   randconfig-x007-201706
i386                   randconfig-x006-201706
i386                   randconfig-x009-201706
i386                   randconfig-x002-201706
i386                   randconfig-x008-201706
i386                   randconfig-x005-201706
i386                   randconfig-x000-201706
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
i386                   randconfig-x0-02081100

Thanks,
Fengguang
