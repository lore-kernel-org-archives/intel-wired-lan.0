From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 9 Feb 2017 21:58:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 87/89]
 drivers/net/ethernet/intel/e1000e/ethtool.c:205:2: error: implicit
 declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
Message-ID: <201702092102.a5T5ZdkO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   afa5e6b0818b54d7391a5b182ee8b3005fc03d1e
commit: 78130561e6430f3c63851e1fc8ea92dfca27ed87 [87/89] e1000e: use new api ethtool_{get|set}_link_ksettings
config: x86_64-randconfig-i0-201706 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 78130561e6430f3c63851e1fc8ea92dfca27ed87
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/ethtool.c: In function 'e1000_get_link_ksettings':
>> drivers/net/ethernet/intel/e1000e/ethtool.c:205:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^
   drivers/net/ethernet/intel/e1000e/ethtool.c: In function 'e1000_set_link_ksettings':
>> drivers/net/ethernet/intel/e1000e/ethtool.c:276:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&advertising,
     ^
   cc1: some warnings being treated as errors

vim +/ethtool_convert_legacy_u32_to_link_mode +205 drivers/net/ethernet/intel/e1000e/ethtool.c

   199		else
   200			cmd->base.eth_tp_mdix_ctrl = hw->phy.mdix;
   201	
   202		if (hw->phy.media_type != e1000_media_type_copper)
   203			cmd->base.eth_tp_mdix_ctrl = ETH_TP_MDI_INVALID;
   204	
 > 205		ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
   206							supported);
   207		ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
   208							advertising);
   209	
   210		return 0;
   211	}
   212	
   213	static int e1000_set_spd_dplx(struct e1000_adapter *adapter, u32 spd, u8 dplx)
   214	{
   215		struct e1000_mac_info *mac = &adapter->hw.mac;
   216	
   217		mac->autoneg = 0;
   218	
   219		/* Make sure dplx is at most 1 bit and lsb of speed is not set
   220		 * for the switch() below to work
   221		 */
   222		if ((spd & 1) || (dplx & ~1))
   223			goto err_inval;
   224	
   225		/* Fiber NICs only allow 1000 gbps Full duplex */
   226		if ((adapter->hw.phy.media_type == e1000_media_type_fiber) &&
   227		    (spd != SPEED_1000) && (dplx != DUPLEX_FULL)) {
   228			goto err_inval;
   229		}
   230	
   231		switch (spd + dplx) {
   232		case SPEED_10 + DUPLEX_HALF:
   233			mac->forced_speed_duplex = ADVERTISE_10_HALF;
   234			break;
   235		case SPEED_10 + DUPLEX_FULL:
   236			mac->forced_speed_duplex = ADVERTISE_10_FULL;
   237			break;
   238		case SPEED_100 + DUPLEX_HALF:
   239			mac->forced_speed_duplex = ADVERTISE_100_HALF;
   240			break;
   241		case SPEED_100 + DUPLEX_FULL:
   242			mac->forced_speed_duplex = ADVERTISE_100_FULL;
   243			break;
   244		case SPEED_1000 + DUPLEX_FULL:
   245			if (adapter->hw.phy.media_type == e1000_media_type_copper) {
   246				mac->autoneg = 1;
   247				adapter->hw.phy.autoneg_advertised =
   248					ADVERTISE_1000_FULL;
   249			} else {
   250				mac->forced_speed_duplex = ADVERTISE_1000_FULL;
   251			}
   252			break;
   253		case SPEED_1000 + DUPLEX_HALF:	/* not supported */
   254		default:
   255			goto err_inval;
   256		}
   257	
   258		/* clear MDI, MDI(-X) override is only allowed when autoneg enabled */
   259		adapter->hw.phy.mdix = AUTO_ALL_MODES;
   260	
   261		return 0;
   262	
   263	err_inval:
   264		e_err("Unsupported Speed/Duplex configuration\n");
   265		return -EINVAL;
   266	}
   267	
   268	static int e1000_set_link_ksettings(struct net_device *netdev,
   269					    const struct ethtool_link_ksettings *cmd)
   270	{
   271		struct e1000_adapter *adapter = netdev_priv(netdev);
   272		struct e1000_hw *hw = &adapter->hw;
   273		int ret_val = 0;
   274		u32 advertising;
   275	
 > 276		ethtool_convert_link_mode_to_legacy_u32(&advertising,
   277							cmd->link_modes.advertising);
   278	
   279		pm_runtime_get_sync(netdev->dev.parent);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26853 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170209/059e339e/attachment-0001.bin>
