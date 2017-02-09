From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 10 Feb 2017 04:53:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 afa5e6b0818b54d7391a5b182ee8b3005fc03d1e
Message-ID: <589cd6c0.p64n175BiHitpVza%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
afa5e6b0818b54d7391a5b182ee8b3005fc03d1e  ixgbe: Limit use of 2K buffers on architectures with 256B or larger cache lines

drivers/net/ethernet/aquantia/atlantic/aq_nic.c:747:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/aquantia/atlantic/aq_nic.c:778:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:347:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/ehea/ehea_ethtool.c:90:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/ibmveth.c:747:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:176:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:176:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:191:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:191:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000e/ethtool.c:205:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/intel/e1000e/ethtool.c:205:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000e/ethtool.c:276:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/intel/e1000e/ethtool.c:276:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
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
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? arm64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? arm-multi_v7_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-allmodconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x000-201706
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x004-201706
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x006-201706
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x009-201706
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ia64-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ia64-defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? parisc-c3000_defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-defconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-ibm-ehea-ehea_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmveth.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-ibm-ehea-ehea_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmveth.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? sparc64-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? sparc64-defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-tilegx_defconfig
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-kexec
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-kexec+CONFIG_DEBUG_INFO_REDUCED
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-i0-201706
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-aquantia-atlantic-aq_nic.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? xtensa-allyesconfig
    ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
    ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
    ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
    ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32

TIMEOUT after 607m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 69

alpha                            allmodconfig
alpha                            allyesconfig
blackfin                         allmodconfig
blackfin                         allyesconfig
cris                             allmodconfig
cris                             allyesconfig
customconfig                                0
customconfig                                1
customconfig                                2
customconfig                                3
customconfig                                4
customconfig                                5
customconfig                                6
customconfig                                7
customconfig                                8
customconfig                                9
i386                            randconfig-a0
i386                            randconfig-i0
i386                            randconfig-i1
i386                            randconfig-n0
i386                            randconfig-r0
i386                            randconfig-s0
i386                            randconfig-s1
i386                          randconfig-x010
i386                          randconfig-x011
i386                          randconfig-x012
i386                          randconfig-x013
i386                          randconfig-x014
i386                          randconfig-x015
i386                          randconfig-x016
i386                          randconfig-x017
i386                          randconfig-x018
i386                          randconfig-x019
i386                          randconfig-x070
i386                          randconfig-x071
i386                          randconfig-x072
i386                          randconfig-x073
i386                          randconfig-x074
i386                          randconfig-x075
i386                          randconfig-x076
i386                          randconfig-x077
i386                          randconfig-x078
i386                          randconfig-x079
i386                               tinyconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
mips                             allmodconfig
mips                             allyesconfig
parisc                           allmodconfig
parisc                           allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sh                               allmodconfig
sh                               allyesconfig
sparc64                          allmodconfig
sparc64                          allyesconfig
sparc                            allmodconfig
sparc                            allyesconfig
tile                             allmodconfig
tile                             allyesconfig
x86_64                           allyesconfig
x86_64                            eywa-module
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 106

alpha                               defconfig
parisc                            allnoconfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
blackfin                BF526-EZBRD_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                  TCM-BF537_defconfig
cris                 etrax-100lx_v2_defconfig
x86_64                                  kexec
x86_64        kexec+CONFIG_DEBUG_INFO_REDUCED
x86_64                                   rhel
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
x86_64                           allmodconfig
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201706
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                           usrv_defconfig
m32r                     mappi3.smp_defconfig
nios2                         10m50_defconfig
h8300                    h8300h-sim_defconfig
score                      spct6600_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                             allmodconfig
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
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
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

Thanks,
Fengguang

