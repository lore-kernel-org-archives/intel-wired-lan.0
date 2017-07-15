From: kbuild test robot <lkp@intel.com>
Date: Sat, 15 Jul 2017 18:26:11 +0800
Subject: [Intel-wired-lan] [next PATCH S76-V2 11/13] i40e: Fix
 unrecognized PHY type warning message for 25G AOC/ACC
In-Reply-To: <20170714131019.52530-11-alice.michael@intel.com>
Message-ID: <201707151854.Yyd8Yizi%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sudheer,

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.12 next-20170714]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alice-Michael/i40e-Fix-for-unused-value-issue-found-by-static-analysis/20170715-162444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:260:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:14: sparse: undefined identifier 'I40E_PHY_TYPE_25GBASE_AOC'
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:669:14: sparse: undefined identifier 'I40E_PHY_TYPE_25GBASE_ACC'
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:670:17: sparse: undefined identifier 'ks'
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:671:17: sparse: undefined identifier 'ks'
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:672:17: sparse: undefined identifier 'ks'
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:674:17: sparse: undefined identifier 'ks'
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:14: sparse: incompatible types for 'case' statement
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:669:14: sparse: incompatible types for 'case' statement
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:14: sparse: Expected constant expression in case statement
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:669:14: sparse: Expected constant expression in case statement
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function 'i40e_get_link_ksettings':
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:7: error: 'I40E_PHY_TYPE_25GBASE_AOC' undeclared (first use in this function)
     case I40E_PHY_TYPE_25GBASE_AOC:
          ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:668:7: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:669:7: error: 'I40E_PHY_TYPE_25GBASE_ACC' undeclared (first use in this function)
     case I40E_PHY_TYPE_25GBASE_ACC:
          ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/netdevice.h:42:0,
                    from include/net/sock.h:51,
                    from include/linux/tcp.h:23,
                    from include/net/tcp.h:24,
                    from drivers/net/ethernet/intel/i40e/i40e.h:30,
                    from drivers/net/ethernet/intel/i40e/i40e_ethtool.c:29:
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:670:40: error: 'ks' undeclared (first use in this function)
      ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
                                           ^
   include/linux/ethtool.h:137:49: note: in definition of macro 'ethtool_link_ksettings_add_link_mode'
     __set_bit(ETHTOOL_LINK_MODE_ ## mode ## _BIT, (ptr)->link_modes.name)
                                                    ^~~

vim +/case +668 drivers/net/ethernet/intel/i40e/i40e_ethtool.c

   589	
   590	/**
   591	 * i40e_get_settings - Get Link Speed and Duplex settings
   592	 * @netdev: network interface device structure
   593	 * @ecmd: ethtool command
   594	 *
   595	 * Reports speed/duplex settings based on media_type
   596	 **/
   597	static int i40e_get_link_ksettings(struct net_device *netdev,
   598					   struct ethtool_link_ksettings *cmd)
   599	{
   600		struct i40e_netdev_priv *np = netdev_priv(netdev);
   601		struct i40e_pf *pf = np->vsi->back;
   602		struct i40e_hw *hw = &pf->hw;
   603		struct i40e_link_status *hw_link_info = &hw->phy.link_info;
   604		bool link_up = hw_link_info->link_info & I40E_AQ_LINK_UP;
   605		u32 advertising;
   606	
   607		if (link_up)
   608			i40e_get_settings_link_up(hw, cmd, netdev, pf);
   609		else
   610			i40e_get_settings_link_down(hw, cmd, pf);
   611	
   612		/* Now set the settings that don't rely on link being up/down */
   613		/* Set autoneg settings */
   614		cmd->base.autoneg = ((hw_link_info->an_info & I40E_AQ_AN_COMPLETED) ?
   615				  AUTONEG_ENABLE : AUTONEG_DISABLE);
   616	
   617		switch (hw->phy.media_type) {
   618		case I40E_MEDIA_TYPE_BACKPLANE:
   619			ethtool_link_ksettings_add_link_mode(cmd, supported,
   620							     Autoneg);
   621			ethtool_link_ksettings_add_link_mode(cmd, supported,
   622							     Backplane);
   623			ethtool_link_ksettings_add_link_mode(cmd, advertising,
   624							     Autoneg);
   625			ethtool_link_ksettings_add_link_mode(cmd, advertising,
   626							     Backplane);
   627			cmd->base.port = PORT_NONE;
   628			break;
   629		case I40E_MEDIA_TYPE_BASET:
   630			ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
   631			ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
   632			cmd->base.port = PORT_TP;
   633			break;
   634		case I40E_MEDIA_TYPE_DA:
   635		case I40E_MEDIA_TYPE_CX4:
   636			ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
   637			ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
   638			cmd->base.port = PORT_DA;
   639			break;
   640		case I40E_MEDIA_TYPE_FIBER:
   641			ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
   642			cmd->base.port = PORT_FIBRE;
   643			break;
   644		case I40E_MEDIA_TYPE_UNKNOWN:
   645		default:
   646			cmd->base.port = PORT_OTHER;
   647			break;
   648		}
   649	
   650		/* Set flow control settings */
   651		ethtool_link_ksettings_add_link_mode(cmd, supported, Pause);
   652	
   653		switch (hw->fc.requested_mode) {
   654		case I40E_FC_FULL:
   655			ethtool_link_ksettings_add_link_mode(cmd, advertising,
   656							     Pause);
   657			break;
   658		case I40E_FC_TX_PAUSE:
   659			ethtool_link_ksettings_add_link_mode(cmd, advertising,
   660							     Asym_Pause);
   661			break;
   662		case I40E_FC_RX_PAUSE:
   663			ethtool_link_ksettings_add_link_mode(cmd, advertising,
   664							     Pause);
   665			ethtool_link_ksettings_add_link_mode(cmd, advertising,
   666							     Asym_Pause);
   667			break;
 > 668		case I40E_PHY_TYPE_25GBASE_AOC:
   669		case I40E_PHY_TYPE_25GBASE_ACC:
   670			ethtool_link_ksettings_add_link_mode(ks, supported, Autoneg);
   671			ethtool_link_ksettings_add_link_mode(ks, advertising, Autoneg);
   672			ethtool_link_ksettings_add_link_mode(ks, supported,
   673							     25000baseCR_Full);
   674			ethtool_link_ksettings_add_link_mode(ks, advertising,
   675							     25000baseCR_Full);
   676			break;
   677		default:
   678			ethtool_convert_link_mode_to_legacy_u32(
   679				&advertising, cmd->link_modes.advertising);
   680	
   681			advertising &= ~(ADVERTISED_Pause | ADVERTISED_Asym_Pause);
   682	
   683			ethtool_convert_legacy_u32_to_link_mode(
   684				cmd->link_modes.advertising, advertising);
   685			break;
   686		}
   687	
   688		return 0;
   689	}
   690	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
