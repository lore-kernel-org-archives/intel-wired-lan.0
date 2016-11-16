From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 16 Nov 2016 10:17:04 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 746/792]
 drivers/net/ethernet/broadcom/bcm63xx_enet.c:1440:2: error: expected
 expression before 'return'
Message-ID: <201611161053.eVal2Hwm%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6f468519415e5e9df0cdd460ecdc46f871066137
commit: 42469bf5d9bb9fe5e2ab28f18a5d39776797f026 [746/792] net: bcm63xx_enet: Utilize phy_ethtool_nway_reset
config: mips-bcm63xx_defconfig (attached as .config)
compiler: mips-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 42469bf5d9bb9fe5e2ab28f18a5d39776797f026
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/broadcom/bcm63xx_enet.c: In function 'bcm_enet_nway_reset':
>> drivers/net/ethernet/broadcom/bcm63xx_enet.c:1440:2: error: expected expression before 'return'
     return -EOPNOTSUPP;
     ^~~~~~
>> drivers/net/ethernet/broadcom/bcm63xx_enet.c:1441:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +/return +1440 drivers/net/ethernet/broadcom/bcm63xx_enet.c

7260aac9 Maxime Bizon     2013-06-04  1434  	struct bcm_enet_priv *priv;
7260aac9 Maxime Bizon     2013-06-04  1435  
7260aac9 Maxime Bizon     2013-06-04  1436  	priv = netdev_priv(dev);
42469bf5 Florian Fainelli 2016-11-15  1437  	if (priv->has_phy)
42469bf5 Florian Fainelli 2016-11-15  1438  		return phy_ethtool_nway_reset(dev),
7260aac9 Maxime Bizon     2013-06-04  1439  
7260aac9 Maxime Bizon     2013-06-04 @1440  	return -EOPNOTSUPP;
7260aac9 Maxime Bizon     2013-06-04 @1441  }
7260aac9 Maxime Bizon     2013-06-04  1442  
639cfa9e Philippe Reynes  2016-09-18  1443  static int bcm_enet_get_link_ksettings(struct net_device *dev,
639cfa9e Philippe Reynes  2016-09-18  1444  				       struct ethtool_link_ksettings *cmd)

:::::: The code at line 1440 was first introduced by commit
:::::: 7260aac97447a2b2cb9e8684d1162118c4426354 bcm63xx_enet: implement reset autoneg ethtool callback

:::::: TO: Maxime Bizon <mbizon@freebox.fr>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 11975 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161116/6df84ed9/attachment-0001.bin>
