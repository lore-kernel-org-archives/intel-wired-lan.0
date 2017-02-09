From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 9 Feb 2017 21:44:21 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 86/89]
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c:176:2: error: implicit
 declaration of function 'ethtool_convert_legacy_u32_to_link_mode'
Message-ID: <201702092119.eg1AR4qp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   afa5e6b0818b54d7391a5b182ee8b3005fc03d1e
commit: d31b4d7d6fc3aefdc93f795c6e57988c691521c9 [86/89] e1000: use new api ethtool_{get|set}_link_ksettings
config: x86_64-randconfig-i0-201706 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout d31b4d7d6fc3aefdc93f795c6e57988c691521c9
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000/e1000_ethtool.c: In function 'e1000_get_link_ksettings':
>> drivers/net/ethernet/intel/e1000/e1000_ethtool.c:176:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^
   drivers/net/ethernet/intel/e1000/e1000_ethtool.c: In function 'e1000_set_link_ksettings':
>> drivers/net/ethernet/intel/e1000/e1000_ethtool.c:191:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&advertising,
     ^
   cc1: some warnings being treated as errors

vim +/ethtool_convert_legacy_u32_to_link_mode +176 drivers/net/ethernet/intel/e1000/e1000_ethtool.c

   170	
   171		if (hw->mdix == AUTO_ALL_MODES)
   172			cmd->base.eth_tp_mdix_ctrl = ETH_TP_MDI_AUTO;
   173		else
   174			cmd->base.eth_tp_mdix_ctrl = hw->mdix;
   175	
 > 176		ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
   177							supported);
   178		ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
   179							advertising);
   180	
   181		return 0;
   182	}
   183	
   184	static int e1000_set_link_ksettings(struct net_device *netdev,
   185					    const struct ethtool_link_ksettings *cmd)
   186	{
   187		struct e1000_adapter *adapter = netdev_priv(netdev);
   188		struct e1000_hw *hw = &adapter->hw;
   189		u32 advertising;
   190	
 > 191		ethtool_convert_link_mode_to_legacy_u32(&advertising,
   192							cmd->link_modes.advertising);
   193	
   194		/* MDI setting is only allowed when autoneg enabled because

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26853 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170209/56e6d6e0/attachment-0001.bin>
