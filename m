From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 8 Dec 2015 22:42:03 +0300
Subject: [Intel-wired-lan] i40evf: create a generic config RSS function
Message-ID: <20151208194203.GA1469@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Helin Zhang,

The patch 2c86ac3c7079: "i40evf: create a generic config RSS
function" from Oct 27, 2015, leads to the following static checker
warning:

	drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c:691 i40evf_set_rxfh()
	warn: we tested 'key' before and it was 'false'

drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c
   676  static int i40evf_set_rxfh(struct net_device *netdev, const u32 *indir,
   677                             const u8 *key, const u8 hfunc)
   678  {
   679          struct i40evf_adapter *adapter = netdev_priv(netdev);
   680          struct i40e_vsi *vsi = &adapter->vsi;
   681          u8 *seed = NULL;
   682          u16 i;
   683  
   684          /* We do not allow change in unsupported parameters */
   685          if (key ||
                    ^^^
If key is non-NULL then we return.  Maybe this is a || vs && typo?

   686              (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
   687                  return -EOPNOTSUPP;
   688          if (!indir)
   689                  return 0;
   690  
   691          if (key) {

Since we know key is NULL that means this is dead code.

   692                  if (!vsi->rss_hkey_user) {
   693                          vsi->rss_hkey_user = kzalloc(I40EVF_HKEY_ARRAY_SIZE,
   694                                                       GFP_KERNEL);
   695                          if (!vsi->rss_hkey_user)
   696                                  return -ENOMEM;
   697                  }
   698                  memcpy(vsi->rss_hkey_user, key, I40EVF_HKEY_ARRAY_SIZE);
   699                  seed = vsi->rss_hkey_user;
   700          }

regards,
dan carpenter
