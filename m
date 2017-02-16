From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 16 Feb 2017 23:22:23 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue] BUILD REGRESSION
 c6d161ada47f3151736ccd3de5df120b4883931a
Message-ID: <58a5c3af.KCtmd7wLPHGXWVl9%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git  dev-queue
c6d161ada47f3151736ccd3de5df120b4883931a  ethtool: stop the line wrapping madness

drivers/net/ethernet/amd/pcnet32.c:753:3: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
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
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1648:3: error: implicit declaration of function 'ethtool_link_ksettings_add_link_mode' [-Werror=implicit-function-declaration]
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1648:45: error: 'supported' undeclared (first use in this function)
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1648:56: error: 'FIBRE' undeclared (first use in this function)
drivers/net/ethernet/myricom/myri10ge/myri10ge.c:1649:45: error: 'advertising' undeclared (first use in this function)
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
??? arm64-defconfig
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? arm-iop32x_defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
??? i386-defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-b0-02161743
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-h0-02162206
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-h1-02162206
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
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
??? i386-randconfig-x001-201707
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
??? i386-randconfig-x014-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x015-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x016-201707
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? i386-randconfig-x018-201707
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
??? ia64-defconfig
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
??? parisc-c3000_defconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-allmodconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-allyesconfig
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? powerpc-chrp32_defconfig
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
??? x86_64-lkp
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
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
??? x86_64-randconfig-it0-02162024
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
??? x86_64-randconfig-n0-02162231
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-r0-02161708
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? x86_64-randconfig-s5-02161746
??? ??? drivers-net-ethernet-amd-pcnet32.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-broadcom-bnx2x-bnx2x_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
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
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
??? x86_64-rhel-7.2
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000-e1000_ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-intel-e1000e-ethtool.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-skge.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_legacy_u32_to_link_mode
??? ??? drivers-net-ethernet-marvell-sky2.c:error:implicit-declaration-of-function-ethtool_convert_link_mode_to_legacy_u32
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:advertising-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:FIBRE-undeclared-(first-use-in-this-function)
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:implicit-declaration-of-function-ethtool_link_ksettings_add_link_mode
??? ??? drivers-net-ethernet-myricom-myri10ge-myri10ge.c:error:supported-undeclared-(first-use-in-this-function)
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

elapsed time: 165m

configs tested: 166

mips                     decstation_defconfig
s390                                defconfig
um                           x86_64_defconfig
i386                   randconfig-a0-02131010
x86_64                 randconfig-a0-02161952
x86_64                             acpi-redef
x86_64                           allyesdebian
x86_64                                nfsroot
sh                            titan_defconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
i386                   randconfig-c0-02162120
x86_64                           allmodconfig
x86_64                randconfig-it0-02162024
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                        default_defconfig
x86_64                 randconfig-v0-02161426
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
i386                                defconfig
arm                          iop32x_defconfig
m68k                            q40_defconfig
powerpc               mpc85xx_basic_defconfig
sparc64                           allnoconfig
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
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
i386                     randconfig-s0-201707
i386                     randconfig-s1-201707
x86_64                 randconfig-s0-02162119
x86_64                 randconfig-s1-02162119
x86_64                 randconfig-s2-02162119
x86_64                 randconfig-s3-02161746
x86_64                 randconfig-s4-02161746
x86_64                 randconfig-s5-02161746
mips                                   jz4740
mips                      malta_kvm_defconfig
mips                         64r6el_defconfig
mips                           32r2_defconfig
mips                              allnoconfig
mips                      fuloong2e_defconfig
mips                                     txx9
x86_64                   randconfig-i0-201707
i386                   randconfig-b0-02161743
sparc                               defconfig
sparc64                             defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
i386                   randconfig-i0-02120926
i386                   randconfig-i1-02120926
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
i386                               tinyconfig
i386                   randconfig-x011-201707
i386                   randconfig-x018-201707
i386                   randconfig-x015-201707
i386                   randconfig-x012-201707
i386                   randconfig-x017-201707
i386                   randconfig-x014-201707
i386                   randconfig-x013-201707
i386                   randconfig-x016-201707
i386                   randconfig-x019-201707
i386                   randconfig-x010-201707
i386                     randconfig-n0-201707
i386         randconfig-n0-201707+CONFIG_DEBUG_INFO_REDUCED
i386                   randconfig-h0-02162206
i386                   randconfig-h1-02162206
cris                              allnoconfig
powerpc               corenet_basic_defconfig
x86_64                 randconfig-h0-02162120
powerpc                       ep405_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      chrp32_defconfig
sh                           cayman_defconfig
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
x86_64                 randconfig-n0-02162206
x86_64                 randconfig-n0-02162231
i386                  randconfig-sb0-02161535
x86_64                                  kexec
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
ia64                              allnoconfig
ia64                                defconfig
ia64                             alldefconfig
i386                     randconfig-r0-201707
x86_64                 randconfig-r0-02161708
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
i386                   randconfig-x0-02161942

Thanks,
Fengguang
