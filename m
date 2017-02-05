From: kbuild test robot <fengguang.wu@intel.com>
Date: Mon, 6 Feb 2017 05:31:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 94/94]
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c:747:2: error: implicit
 declaration of function 'ethtool_convert_link_mode_to_legacy_u32'
Message-ID: <201702060537.r6NUOEjR%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   2eb02c2cc7ffa3146fb14aefe92fad7c7f132040
commit: 2eb02c2cc7ffa3146fb14aefe92fad7c7f132040 [94/94] ethtool: stop the line wrapping madness
config: x86_64-randconfig-i0-201706 (attached as .config)
compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
reproduce:
        git checkout 2eb02c2cc7ffa3146fb14aefe92fad7c7f132040
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/aquantia/atlantic/aq_nic.c: In function 'aq_nic_get_link_ksettings':
>> drivers/net/ethernet/aquantia/atlantic/aq_nic.c:747:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&supported,
     ^
>> drivers/net/ethernet/aquantia/atlantic/aq_nic.c:778:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^
   cc1: some warnings being treated as errors

vim +/ethtool_convert_link_mode_to_legacy_u32 +747 drivers/net/ethernet/aquantia/atlantic/aq_nic.c

f8244ab5 Philippe Reynes 2017-01-30  741  
f8244ab5 Philippe Reynes 2017-01-30  742  	cmd->base.port = PORT_TP;
97bde5c4 David VomLehn   2017-01-23  743  	/* This driver supports only 10G capable adapters, so DUPLEX_FULL */
f8244ab5 Philippe Reynes 2017-01-30  744  	cmd->base.duplex = DUPLEX_FULL;
f8244ab5 Philippe Reynes 2017-01-30  745  	cmd->base.autoneg = self->aq_nic_cfg.is_autoneg;
f8244ab5 Philippe Reynes 2017-01-30  746  
f8244ab5 Philippe Reynes 2017-01-30 @747  	ethtool_convert_link_mode_to_legacy_u32(&supported,
f8244ab5 Philippe Reynes 2017-01-30  748  						cmd->link_modes.supported);
f8244ab5 Philippe Reynes 2017-01-30  749  	ethtool_convert_link_mode_to_legacy_u32(&advertising,
f8244ab5 Philippe Reynes 2017-01-30  750  						cmd->link_modes.advertising);
97bde5c4 David VomLehn   2017-01-23  751  
f8244ab5 Philippe Reynes 2017-01-30  752  	supported |= (self->aq_hw_caps.link_speed_msk & AQ_NIC_RATE_10G) ?
97bde5c4 David VomLehn   2017-01-23  753  				ADVERTISED_10000baseT_Full : 0U;
f8244ab5 Philippe Reynes 2017-01-30  754  	supported |= (self->aq_hw_caps.link_speed_msk & AQ_NIC_RATE_1G) ?
97bde5c4 David VomLehn   2017-01-23  755  				ADVERTISED_1000baseT_Full : 0U;
f8244ab5 Philippe Reynes 2017-01-30  756  	supported |= (self->aq_hw_caps.link_speed_msk & AQ_NIC_RATE_100M) ?
97bde5c4 David VomLehn   2017-01-23  757  				ADVERTISED_100baseT_Full : 0U;
f8244ab5 Philippe Reynes 2017-01-30  758  	supported |= self->aq_hw_caps.flow_control ? SUPPORTED_Pause : 0;
f8244ab5 Philippe Reynes 2017-01-30  759  	supported |= SUPPORTED_Autoneg;
f8244ab5 Philippe Reynes 2017-01-30  760  	supported |= SUPPORTED_TP;
97bde5c4 David VomLehn   2017-01-23  761  
f8244ab5 Philippe Reynes 2017-01-30  762  	advertising = (self->aq_nic_cfg.is_autoneg) ?
97bde5c4 David VomLehn   2017-01-23  763  							ADVERTISED_Autoneg : 0U;
f8244ab5 Philippe Reynes 2017-01-30  764  	advertising |=
97bde5c4 David VomLehn   2017-01-23  765  			(self->aq_nic_cfg.link_speed_msk & AQ_NIC_RATE_10G) ?
97bde5c4 David VomLehn   2017-01-23  766  			ADVERTISED_10000baseT_Full : 0U;
f8244ab5 Philippe Reynes 2017-01-30  767  	advertising |=
97bde5c4 David VomLehn   2017-01-23  768  			(self->aq_nic_cfg.link_speed_msk & AQ_NIC_RATE_1G) ?
97bde5c4 David VomLehn   2017-01-23  769  			ADVERTISED_1000baseT_Full : 0U;
97bde5c4 David VomLehn   2017-01-23  770  
f8244ab5 Philippe Reynes 2017-01-30  771  	advertising |=
97bde5c4 David VomLehn   2017-01-23  772  			(self->aq_nic_cfg.link_speed_msk & AQ_NIC_RATE_100M) ?
97bde5c4 David VomLehn   2017-01-23  773  			ADVERTISED_100baseT_Full : 0U;
f8244ab5 Philippe Reynes 2017-01-30  774  	advertising |= (self->aq_nic_cfg.flow_control) ?
97bde5c4 David VomLehn   2017-01-23  775  				ADVERTISED_Pause : 0U;
f8244ab5 Philippe Reynes 2017-01-30  776  	advertising |= ADVERTISED_TP;
f8244ab5 Philippe Reynes 2017-01-30  777  
f8244ab5 Philippe Reynes 2017-01-30 @778  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
f8244ab5 Philippe Reynes 2017-01-30  779  						supported);
f8244ab5 Philippe Reynes 2017-01-30  780  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
f8244ab5 Philippe Reynes 2017-01-30  781  						advertising);

:::::: The code at line 747 was first introduced by commit
:::::: f8244ab55200dbe074380c3388804adff03a8a19 net: aquantia: atlantic: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 26847 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170206/107168b3/attachment-0001.bin>
