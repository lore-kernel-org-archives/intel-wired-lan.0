From: kbuild test robot <fengguang.wu@intel.com>
Date: Sun, 15 Jan 2017 08:15:41 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 65/85]
 drivers/net/ethernet/ibm/emac/core.c:2011:2: error: implicit declaration of
 function 'ethtool_convert_legacy_u32_to_link_mode'
Message-ID: <201701150836.XHHiaMc0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   25758d6a51d92584debd9a863b4acd91193238f3
commit: c4da46aa003bb0e58cbcc80914affed8db0dc745 [65/85] ethtool: stop the line wrapping madness
config: powerpc-ep405_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c4da46aa003bb0e58cbcc80914affed8db0dc745
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/ibm/emac/core.c: In function 'emac_ethtool_get_link_ksettings':
>> drivers/net/ethernet/ibm/emac/core.c:2011:2: error: implicit declaration of function 'ethtool_convert_legacy_u32_to_link_mode' [-Werror=implicit-function-declaration]
     ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/ibm/emac/core.c: In function 'emac_ethtool_set_link_ksettings':
>> drivers/net/ethernet/ibm/emac/core.c:2027:2: error: implicit declaration of function 'ethtool_convert_link_mode_to_legacy_u32' [-Werror=implicit-function-declaration]
     ethtool_convert_link_mode_to_legacy_u32(&advertising,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/ethtool_convert_legacy_u32_to_link_mode +2011 drivers/net/ethernet/ibm/emac/core.c

e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2005  	advertising = dev->phy.advertising;
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2006  	cmd->base.autoneg = dev->phy.autoneg;
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2007  	cmd->base.speed = dev->phy.speed;
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2008  	cmd->base.duplex = dev->phy.duplex;
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2009  	mutex_unlock(&dev->link_lock);
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2010  
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07 @2011  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2012  						supported);
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2013  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2014  						advertising);
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2015  
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2016  	return 0;
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2017  }
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2018  
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2019  static int
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2020  emac_ethtool_set_link_ksettings(struct net_device *ndev,
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2021  				const struct ethtool_link_ksettings *cmd)
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2022  {
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2023  	struct emac_instance *dev = netdev_priv(ndev);
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2024  	u32 f = dev->phy.features;
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2025  	u32 advertising;
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2026  
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07 @2027  	ethtool_convert_link_mode_to_legacy_u32(&advertising,
e4ccf7644 drivers/net/ethernet/ibm/emac/core.c Philippe Reynes 2017-01-07  2028  						cmd->link_modes.advertising);
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2029  
1d3bb9964 drivers/net/ibm_newemac/core.c       David Gibson    2007-08-23  2030  	DBG(dev, "set_settings(%d, %d, %d, 0x%08x)" NL,

:::::: The code at line 2011 was first introduced by commit
:::::: e4ccf764488adbd072e78f416ef0b5bd0044c899 net: ibm: emac: use new api ethtool_{get|set}_link_ksettings

:::::: TO: Philippe Reynes <tremyfr@gmail.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12273 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170115/77434b2c/attachment.bin>
