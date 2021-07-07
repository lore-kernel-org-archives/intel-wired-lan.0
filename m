From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Wed, 7 Jul 2021 22:59:48 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: remove redundant null check on
 key
In-Reply-To: <20210703092040.GX2040@kadam>
References: <20210702112720.16006-1-colin.king@canonical.com>
 <202107030209.xwGHO2JN-lkp@intel.com> <20210703092040.GX2040@kadam>
Message-ID: <e5f0d67fb0f278886fc4c4ac862b3c68533bd2c7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2021-07-03 at 12:49 +0300, Dan Carpenter wrote:
> On Sat, Jul 03, 2021 at 02:43:46AM +0800, kernel test robot wrote:
> > 129cf89e585676
> > drivers/net/ethernet/intel/iavf/i40evf_ethtool.c   Jesse Brandeburg
> > 2018-09-14  1899  static int iavf_set_rxfh(struct net_device
> > *netdev, const u32 *indir,
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1900  			 const u8 *key,
> > const u8 hfunc)
> > 4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Mitch A Williams 2014-04-01  1901  {
> > 129cf89e585676
> > drivers/net/ethernet/intel/iavf/i40evf_ethtool.c   Jesse Brandeburg
> > 2018-09-14  1902  	struct iavf_adapter *adapter =
> > netdev_priv(netdev);
> > 2c86ac3c70794f drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Helin Zhang      2015-10-27  1903  	u16 i;
> > 4e9dc31f696ae8 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Mitch A Williams 2014-04-01  1904  
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1905  	/* We do not allow change in
> > unsupported parameters */
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1906  	if (key ||
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1907  	    (hfunc !=
> > ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1908  		return -EOPNOTSUPP;
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1909  	if (!indir)
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1910  		return 0;
> > 892311f66f2411 drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Eyal Perry       2014-12-02  1911  
> > 43a3d9ba34c9ca drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
> > Mitch Williams   2016-04-12 @1912  	memcpy(adapter->rss_key, key,
> > adapter->rss_key_size);
> 
> Heh...  There have been a bunch of patches modifying the behavior if
> "key" is non-NULL and no one noticed that it's actually impossible.

We are capable of supporting a key change. We're working on a patch to
resolve the check and allow the key to be changed.

- Tony

> :P
> 
> regards,
> dan carpenter
> 
