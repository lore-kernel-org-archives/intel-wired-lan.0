From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 6 Feb 2017 05:09:57 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 94/94]
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225:2: error: implicit
 declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
Message-ID: <201702060553.w02B7mGT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   2eb02c2cc7ffa3146fb14aefe92fad7c7f132040
commit: 2eb02c2cc7ffa3146fb14aefe92fad7c7f132040 [94/94] ethtool: stop the line wrapping madness
config: x86_64-kexec (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 2eb02c2cc7ffa3146fb14aefe92fad7c7f132040
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c: In function 'bnx2x_get_vf_link_ksettings':
>> drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:225:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c: In function 'bnx2x_get_link_ksettings':
>> drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c:347:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/marvell/skge.c: In function 'skge_get_link_ksettings':
>> drivers/net/ethernet/marvell/skge.c:323:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/skge.c: In function 'skge_set_link_ksettings':
>> drivers/net/ethernet/marvell/skge.c:340:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&advertising,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_get_link_ksettings':
>> drivers/net/ethernet/marvell/sky2.c:3616:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_set_link_ksettings':
>> drivers/net/ethernet/marvell/sky2.c:3632:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&new_advertising,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ethtool_convert_link_mode_to_legacy_u32 +225 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c

8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  219  static int bnx2x_get_vf_link_ksettings(struct net_device *dev,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  220  				       struct ethtool_link_ksettings *cmd)
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  221  {
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  222  	struct bnx2x *bp = netdev_priv(dev);
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  223  	u32 supported, advertising;
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  224  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21 @225  	ethtool_convert_link_mode_to_legacy_u32(&supported,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  226  						cmd->link_modes.supported);
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  227  	ethtool_convert_link_mode_to_legacy_u32(&advertising,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  228  						cmd->link_modes.advertising);
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  229  
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  230  	if (bp->state == BNX2X_STATE_OPEN) {
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  231  		if (test_bit(BNX2X_LINK_REPORT_FD,
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  232  			     &bp->vf_link_vars.link_report_flags))
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  233  			cmd->base.duplex = DUPLEX_FULL;
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  234  		else
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  235  			cmd->base.duplex = DUPLEX_HALF;
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  236  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  237  		cmd->base.speed = bp->vf_link_vars.line_speed;
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  238  	} else {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  239  		cmd->base.duplex = DUPLEX_UNKNOWN;
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  240  		cmd->base.speed = SPEED_UNKNOWN;
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  241  	}
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  242  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  243  	cmd->base.port		= PORT_OTHER;
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  244  	cmd->base.phy_address	= 0;
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  245  	cmd->base.autoneg	= AUTONEG_DISABLE;
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  246  
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  247  	DP(BNX2X_MSG_ETHTOOL, "ethtool_cmd: cmd %d\n"
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  248  	   "  supported 0x%x  advertising 0x%x  speed %u\n"
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  249  	   "  duplex %d  port %d  phy_address %d\n"
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  250  	   "  autoneg %d\n",
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  251  	   cmd->base.cmd, supported, advertising,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  252  	   cmd->base.speed,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  253  	   cmd->base.duplex, cmd->base.port, cmd->base.phy_address,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  254  	   cmd->base.autoneg);
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  255  
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  256  	return 0;
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  257  }
6495d15a drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Dmitry Kravkov  2014-06-26  258  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  259  static int bnx2x_get_link_ksettings(struct net_device *dev,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  260  				    struct ethtool_link_ksettings *cmd)
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  261  {
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  262  	struct bnx2x *bp = netdev_priv(dev);
a22f0788 drivers/net/bnx2x/bnx2x_ethtool.c                   Yaniv Rosner    2010-09-07  263  	int cfg_idx = bnx2x_get_link_cfg_idx(bp);
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  264  	u32 media_type;
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  265  	u32 supported, advertising, lp_advertising;
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  266  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  267  	ethtool_convert_link_mode_to_legacy_u32(&lp_advertising,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  268  						cmd->link_modes.lp_advertising);
b3337e4c drivers/net/bnx2x/bnx2x_ethtool.c                   David Decotigny 2011-04-14  269  
a22f0788 drivers/net/bnx2x/bnx2x_ethtool.c                   Yaniv Rosner    2010-09-07  270  	/* Dual Media boards present all available port types */
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  271  	supported = bp->port.supported[cfg_idx] |
a22f0788 drivers/net/bnx2x/bnx2x_ethtool.c                   Yaniv Rosner    2010-09-07  272  		(bp->port.supported[cfg_idx ^ 1] &
a22f0788 drivers/net/bnx2x/bnx2x_ethtool.c                   Yaniv Rosner    2010-09-07  273  		 (SUPPORTED_TP | SUPPORTED_FIBRE));
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  274  	advertising = bp->port.advertising[cfg_idx];
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  275  	media_type = bp->link_params.phy[bnx2x_get_cur_phy_idx(bp)].media_type;
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  276  	if (media_type == ETH_PHY_SFP_1G_FIBER) {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  277  		supported &= ~(SUPPORTED_10000baseT_Full);
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  278  		advertising &= ~(ADVERTISED_10000baseT_Full);
dbef807e drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2012-06-20  279  	}
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  280  
59694f00 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2012-12-02  281  	if ((bp->state == BNX2X_STATE_OPEN) && bp->link_vars.link_up &&
59694f00 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2012-12-02  282  	    !(bp->flags & MF_FUNC_DIS)) {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  283  		cmd->base.duplex = bp->link_vars.duplex;
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  284  
38298461 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2012-03-12  285  		if (IS_MF(bp) && !BP_NOMCP(bp))
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  286  			cmd->base.speed = bnx2x_get_mf_speed(bp);
59694f00 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2012-12-02  287  		else
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  288  			cmd->base.speed = bp->link_vars.line_speed;
38298461 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2012-03-12  289  	} else {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  290  		cmd->base.duplex = DUPLEX_UNKNOWN;
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  291  		cmd->base.speed = SPEED_UNKNOWN;
38298461 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2012-03-12  292  	}
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  293  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  294  	cmd->base.port = bnx2x_get_port_type(bp);
a22f0788 drivers/net/bnx2x/bnx2x_ethtool.c                   Yaniv Rosner    2010-09-07  295  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  296  	cmd->base.phy_address = bp->mdio.prtad;
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  297  
a22f0788 drivers/net/bnx2x/bnx2x_ethtool.c                   Yaniv Rosner    2010-09-07  298  	if (bp->link_params.req_line_speed[cfg_idx] == SPEED_AUTO_NEG)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  299  		cmd->base.autoneg = AUTONEG_ENABLE;
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  300  	else
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  301  		cmd->base.autoneg = AUTONEG_DISABLE;
de0c62db drivers/net/bnx2x/bnx2x_ethtool.c                   Dmitry Kravkov  2010-07-27  302  
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  303  	/* Publish LP advertised speeds and FC */
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  304  	if (bp->link_vars.link_status & LINK_STATUS_AUTO_NEGOTIATE_COMPLETE) {
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  305  		u32 status = bp->link_vars.link_status;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  306  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  307  		lp_advertising |= ADVERTISED_Autoneg;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  308  		if (status & LINK_STATUS_LINK_PARTNER_SYMMETRIC_PAUSE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  309  			lp_advertising |= ADVERTISED_Pause;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  310  		if (status & LINK_STATUS_LINK_PARTNER_ASYMMETRIC_PAUSE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  311  			lp_advertising |= ADVERTISED_Asym_Pause;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  312  
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  313  		if (status & LINK_STATUS_LINK_PARTNER_10THD_CAPABLE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  314  			lp_advertising |= ADVERTISED_10baseT_Half;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  315  		if (status & LINK_STATUS_LINK_PARTNER_10TFD_CAPABLE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  316  			lp_advertising |= ADVERTISED_10baseT_Full;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  317  		if (status & LINK_STATUS_LINK_PARTNER_100TXHD_CAPABLE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  318  			lp_advertising |= ADVERTISED_100baseT_Half;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  319  		if (status & LINK_STATUS_LINK_PARTNER_100TXFD_CAPABLE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  320  			lp_advertising |= ADVERTISED_100baseT_Full;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  321  		if (status & LINK_STATUS_LINK_PARTNER_1000THD_CAPABLE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  322  			lp_advertising |= ADVERTISED_1000baseT_Half;
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  323  		if (status & LINK_STATUS_LINK_PARTNER_1000TFD_CAPABLE) {
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  324  			if (media_type == ETH_PHY_KR) {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  325  				lp_advertising |=
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  326  					ADVERTISED_1000baseKX_Full;
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  327  			} else {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  328  				lp_advertising |=
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  329  					ADVERTISED_1000baseT_Full;
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  330  			}
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  331  		}
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  332  		if (status & LINK_STATUS_LINK_PARTNER_2500XFD_CAPABLE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  333  			lp_advertising |= ADVERTISED_2500baseX_Full;
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  334  		if (status & LINK_STATUS_LINK_PARTNER_10GXFD_CAPABLE) {
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  335  			if (media_type == ETH_PHY_KR) {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  336  				lp_advertising |=
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  337  					ADVERTISED_10000baseKR_Full;
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  338  			} else {
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  339  				lp_advertising |=
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  340  					ADVERTISED_10000baseT_Full;
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  341  			}
5d67c1c5 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yuval Mintz     2015-06-25  342  		}
be94bea7 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Yaniv Rosner    2013-02-27  343  		if (status & LINK_STATUS_LINK_PARTNER_20GXFD_CAPABLE)
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  344  			lp_advertising |= ADVERTISED_20000baseKR2_Full;
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  345  	}
9e7e8399 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Mintz Yuval     2012-02-15  346  
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21 @347  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  348  						supported);
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  349  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
8b86b2c1 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c Philippe Reynes 2017-01-21  350  						advertising);

:::::: The code at line 225 was first introduced by commit
:::::: 8b86b2c1b83e3a3a9ac5192b4e9d4ee23d88b218 net: broadcom: bnx2x: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24457 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170206/9e84e986/attachment-0001.bin>
