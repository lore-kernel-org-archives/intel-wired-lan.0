From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 15 Feb 2017 18:38:26 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD INCOMPLETE
 39877a07fd355416a6f44dfe20832dfdd4b8bdbf
Message-ID: <58a42fa2.wAf5Y0jrszzf+LHT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
39877a07fd355416a6f44dfe20832dfdd4b8bdbf  ethtool: stop the line wrapping madness

drivers/net/ethernet/amd/pcnet32.c:753:3: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/amd/pcnet32.c:753: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:347:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:347: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/ibm/ehea/ehea_ethtool.c:90:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/ibmveth.c:747:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/ibm/ibmvnic.c:1043:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:176:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:176:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:176: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:191:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:191:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000/e1000_ethtool.c:191: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/intel/e1000e/ethtool.c:205:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/intel/e1000e/ethtool.c:205:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000e/ethtool.c:205: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/intel/e1000e/ethtool.c:276:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/intel/e1000e/ethtool.c:276:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/intel/e1000e/ethtool.c:276: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/marvell/skge.c:323:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/marvell/skge.c:340:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/marvell/sky2.c:3616:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
drivers/net/ethernet/marvell/sky2.c:3616:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/marvell/sky2.c:3632:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
drivers/net/ethernet/marvell/sky2.c:3632:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
drivers/net/ethernet/neterion/s2io.c:5351:62: sparse: constant 10000baseT_Full is not a valid number
drivers/net/ethernet/neterion/vxge/vxge-ethtool.c:78:62: sparse: constant 10000baseT_Full is not a valid number

Error ids grouped by kconfigs:

recent_errors
??? alpha-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? alpha-allyesconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? arm64-allmodconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? arm-allmodconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? arm-multi_v7_defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-allmodconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? i386-allyesconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? i386-randconfig-b0-02151146
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-i0-02120926
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-s1-201707
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-sb0-02151150
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x001-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x0-02151145
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x002-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x006-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x007-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x009-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x018-02130125
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x070-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x072-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x076-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ia64-allmodconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? ia64-generic_defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? mips-malta_kvm_defconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? parisc-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? parisc-allyesconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-ibm-ehea-ehea_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmveth.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmvnic.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-defconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-ibm-ehea-ehea_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmveth.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-mpc832x_rdb_defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-powernv_defconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-ppc64_defconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-ibm-ehea-ehea_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-ibm-ibmveth.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-xes_mpc85xx_defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? s390-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? s390-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? sparc64-allmodconfig
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
??? sparc-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? sparc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-defconfig
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? tile-tilegx_defconfig
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-acpi-redef
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allmodconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? ??? drivers-net-ethernet-neterion-s2io.c:sparse:constant-10000baseT_Full-is-not-a-valid-number
??? ??? drivers-net-ethernet-neterion-vxge-vxge-ethtool.c:sparse:constant-10000baseT_Full-is-not-a-valid-number
??? x86_64-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-allyesdebian
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? x86_64-kexec-smp
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? x86_64-nfsroot
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-a0-02151145
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-b0-02151030
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-in0-02151038
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-ne0-02151233
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-r0-02151038
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-s5-02151336
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-u0-02151136
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-x001-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-x002-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-x006-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-x008-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-x009-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-x014-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-x019-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-rhel
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? xtensa-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
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

configs timed out: 40

alpha                            allmodconfig
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
x86_64                                    lkp
xtensa                           allmodconfig
xtensa                           allyesconfig

configs tested: 238

parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
alpha                               defconfig
parisc                            allnoconfig
i386                                defconfig
arm                         cm_x300_defconfig
powerpc                        warp_defconfig
avr32                             allnoconfig
blackfin                       IP0X_defconfig
sh                           se7343_defconfig
i386                   randconfig-a0-02131010
x86_64                 randconfig-a0-02151145
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
cris                 etrax-100lx_v2_defconfig
blackfin                  TCM-BF537_defconfig
blackfin            BF561-EZKIT-SMP_defconfig
blackfin                BF533-EZKIT_defconfig
blackfin                BF526-EZBRD_defconfig
mips                        workpad_defconfig
nios2                         10m50_defconfig
blackfin                  CM-BF537E_defconfig
blackfin                      H8606_defconfig
m32r                           usrv_defconfig
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-02151114
i386                   randconfig-c0-02151434
x86_64                           allmodconfig
x86_64                randconfig-in0-02151038
x86_64                randconfig-it0-02151138
x86_64                randconfig-it0-02151537
powerpc                             defconfig
s390                        default_defconfig
powerpc                       ppc64_defconfig
powerpc                           allnoconfig
i386                             allyesconfig
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
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.2
x86_64                 randconfig-g0-02151001
avr32                      atngw100_defconfig
avr32                     atstk1006_defconfig
frv                                 defconfig
mn10300                     asb2364_defconfig
openrisc                    or1ksim_defconfig
tile                         tilegx_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
i386                             allmodconfig
m68k                       m5249evb_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                            shmin_defconfig
tile                                defconfig
arm                         palmz72_defconfig
mips                        generic_defconfig
mips                      malta_kvm_defconfig
sparc64                          alldefconfig
x86_64                 randconfig-x017-201707
x86_64                 randconfig-x014-201707
x86_64                 randconfig-x011-201707
x86_64                 randconfig-x016-201707
x86_64                 randconfig-x012-201707
x86_64                 randconfig-x013-201707
x86_64                 randconfig-x010-201707
x86_64                 randconfig-x019-201707
x86_64                 randconfig-x018-201707
x86_64                 randconfig-x015-201707
i386                             alldefconfig
i386                              allnoconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                   randconfig-s0-02131304
i386                   randconfig-s1-02131304
i386                     randconfig-s0-201707
i386                     randconfig-s1-201707
x86_64                 randconfig-s0-02151127
x86_64                 randconfig-s1-02151127
x86_64                 randconfig-s2-02151127
x86_64                 randconfig-s0-02151518
x86_64                 randconfig-s1-02151518
x86_64                 randconfig-s2-02151518
x86_64                 randconfig-s3-02151143
x86_64                 randconfig-s4-02151143
x86_64                 randconfig-s5-02151143
x86_64                 randconfig-s3-02151336
x86_64                 randconfig-s4-02151336
x86_64                 randconfig-s5-02151336
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                   jz4740
mips                                     txx9
x86_64                   randconfig-i0-201707
i386                   randconfig-b0-02151146
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
m32r                              allnoconfig
m68k                          atari_defconfig
mips                        bcm47xx_defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-02120926
i386                   randconfig-i1-02120926
x86_64                 randconfig-b0-02151030
c6x                        evmc6678_defconfig
xtensa                       common_defconfig
m32r                       m32104ut_defconfig
xtensa                          iss_defconfig
m32r                         opsput_defconfig
m32r                     mappi3.smp_defconfig
h8300                    h8300h-sim_defconfig
score                      spct6600_defconfig
x86_64                 randconfig-u0-02151136
x86_64                 randconfig-u0-02151544
i386                   randconfig-x010-201707
i386                   randconfig-x011-201707
i386                   randconfig-x012-201707
i386                   randconfig-x013-201707
i386                   randconfig-x014-201707
i386                   randconfig-x015-201707
i386                   randconfig-x016-201707
i386                   randconfig-x017-201707
i386                   randconfig-x018-201707
i386                   randconfig-x019-201707
arm                      acs5k_tiny_defconfig
m68k                       bvme6000_defconfig
powerpc                     asp8347_defconfig
powerpc                 xes_mpc85xx_defconfig
x86_64                randconfig-ne0-02151233
x86_64                randconfig-ne0-02151530
i386                 randconfig-x016-02130125
i386                 randconfig-x017-02130125
i386                 randconfig-x013-02130125
i386                 randconfig-x019-02130125
i386                 randconfig-x011-02130125
i386                 randconfig-x014-02130125
i386                 randconfig-x015-02130125
i386                 randconfig-x018-02130125
i386                 randconfig-x012-02130125
i386                 randconfig-x010-02130125
i386                     randconfig-n0-201707
i386                   randconfig-h0-02151126
i386                   randconfig-h1-02151126
i386                   randconfig-h0-02151543
i386                   randconfig-h1-02151543
alpha                            allyesconfig
ia64                             alldefconfig
ia64                              allnoconfig
ia64                                defconfig
x86_64                 randconfig-h0-02151136
x86_64                 randconfig-h0-02151539
ia64                        generic_defconfig
powerpc64                           defconfig
mips                           jazz_defconfig
s390                           gcov_defconfig
i386                   randconfig-x076-201707
i386                   randconfig-x071-201707
i386                   randconfig-x074-201707
i386                   randconfig-x078-201707
i386                   randconfig-x072-201707
i386                   randconfig-x073-201707
i386                   randconfig-x077-201707
i386                   randconfig-x070-201707
i386                   randconfig-x075-201707
i386                   randconfig-x079-201707
x86_64                 randconfig-n0-02151158
x86_64                 randconfig-n0-02151456
i386                  randconfig-sb0-02151150
x86_64                randconfig-ws0-02151029
x86_64                randconfig-ws0-02151343
openrisc                         allmodconfig
sh                          rsk7203_defconfig
x86_64                randconfig-ws0-02151155
xtensa                  audio_kc705_defconfig
x86_64                 randconfig-x008-201707
x86_64                 randconfig-x001-201707
x86_64                 randconfig-x009-201707
x86_64                 randconfig-x000-201707
x86_64                 randconfig-x003-201707
x86_64                 randconfig-x006-201707
x86_64                 randconfig-x004-201707
x86_64                 randconfig-x007-201707
x86_64                 randconfig-x002-201707
x86_64                 randconfig-x005-201707
x86_64                              kexec-smp
i386                   randconfig-r0-02121959
x86_64                 randconfig-r0-02151038
x86_64                 randconfig-r0-02151345
m68k                                defconfig
ia64                         bigsur_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
powerpc                     kmeter1_defconfig
powerpc                      tqm8xx_defconfig
sh                          sdk7786_defconfig
i386                   randconfig-x003-201707
i386                   randconfig-x004-201707
i386                   randconfig-x001-201707
i386                   randconfig-x007-201707
i386                   randconfig-x006-201707
i386                   randconfig-x009-201707
i386                   randconfig-x002-201707
i386                   randconfig-x008-201707
i386                   randconfig-x005-201707
i386                   randconfig-x000-201707
i386                   randconfig-x0-02151145
i386                   randconfig-x0-02151552

Thanks,
Fengguang
