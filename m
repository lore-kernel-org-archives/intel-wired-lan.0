From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 16 Jul 2021 15:16:37 -0700
Subject: [Intel-wired-lan] [PATCH net-next 1/1] iavf: Enable setting RSS
 hash key
Message-ID: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Driver support for changing the RSS hash key exists, however, checks
have caused it to be reported as unsupported. Remove the check and
allow the hash key to be specified.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index 01047786eabc..1aed5ade8682 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1893,7 +1893,7 @@ static int iavf_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
  * @key: hash key
  * @hfunc: hash function to use
  *
- * Returns -EINVAL if the table specifies an inavlid queue id, otherwise
+ * Returns -EINVAL if the table specifies an invalid queue id, otherwise
  * returns 0 after programming the table.
  **/
 static int iavf_set_rxfh(struct net_device *netdev, const u32 *indir,
@@ -1902,19 +1902,21 @@ static int iavf_set_rxfh(struct net_device *netdev, const u32 *indir,
 	struct iavf_adapter *adapter = netdev_priv(netdev);
 	u16 i;
 
-	/* We do not allow change in unsupported parameters */
-	if (key ||
-	    (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP))
+	/* Only support toeplitz hash function */
+	if (hfunc != ETH_RSS_HASH_NO_CHANGE && hfunc != ETH_RSS_HASH_TOP)
 		return -EOPNOTSUPP;
-	if (!indir)
+
+	if (!key && !indir)
 		return 0;
 
 	if (key)
 		memcpy(adapter->rss_key, key, adapter->rss_key_size);
 
-	/* Each 32 bits pointed by 'indir' is stored with a lut entry */
-	for (i = 0; i < adapter->rss_lut_size; i++)
-		adapter->rss_lut[i] = (u8)(indir[i]);
+	if (indir) {
+		/* Each 32 bits pointed by 'indir' is stored with a lut entry */
+		for (i = 0; i < adapter->rss_lut_size; i++)
+			adapter->rss_lut[i] = (u8)(indir[i]);
+	}
 
 	return iavf_config_rss(adapter);
 }
-- 
2.20.1

