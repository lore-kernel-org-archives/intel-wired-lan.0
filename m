From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Date: Tue,  3 May 2022 09:13:39 -0700
Subject: [Intel-wired-lan] [PATCH net-next v2] ice: Expose RSS indirection
 tables for queue groups via ethtool
Message-ID: <20220503161339.2287738-1-sudheer.mogilappagari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

When ADQ queue groups (TCs) are created via tc mqprio command,
RSS contexts and associated RSS indirection tables are configured
automatically per TC based on the queue ranges specified for
each traffic class.

For ex:
tc qdisc add dev enp175s0f0 root mqprio num_tc 3 map 0 1 2 \
	queues 2 at 0 8 at 2 4 at 10 hw 1 mode channel

will create 3 queue groups (TC 0-2) with queue ranges 2, 8 and 4
in 3 queue groups. Each queue group is associated with its
own RSS context and RSS indirection table.

Add support to expose RSS indirection tables for all ADQ queue
groups using ethtool RSS contexts interface.
	ethtool -x enp175s0f0 context <tc-num>

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
---
v2:
-Updated commit message based on Paul's review comments.

---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 69 +++++++++++++++-----
 1 file changed, 51 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 476bd1c83c87..1e71b70f0e52 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3111,36 +3111,47 @@ static u32 ice_get_rxfh_indir_size(struct net_device *netdev)
 	return np->vsi->rss_table_size;
 }
 
-/**
- * ice_get_rxfh - get the Rx flow hash indirection table
- * @netdev: network interface device structure
- * @indir: indirection table
- * @key: hash key
- * @hfunc: hash function
- *
- * Reads the indirection table directly from the hardware.
- */
 static int
-ice_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc)
+ice_get_rxfh_context(struct net_device *netdev, u32 *indir,
+		     u8 *key, u8 *hfunc, u32 rss_context)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_pf *pf = vsi->back;
-	int err, i;
+	u16 qcount, offset;
+	int err, num_tc, i;
 	u8 *lut;
 
+	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
+		netdev_warn(netdev, "RSS is not supported on this VSI!\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (rss_context && !ice_is_adq_active(pf)) {
+		netdev_err(netdev, "RSS context cannot be non-zero when ADQ is not configured.\n");
+		return -EINVAL;
+	}
+
+	qcount = vsi->mqprio_qopt.qopt.count[rss_context];
+	offset = vsi->mqprio_qopt.qopt.offset[rss_context];
+
+	if (rss_context && ice_is_adq_active(pf)) {
+		num_tc = vsi->mqprio_qopt.qopt.num_tc;
+		if (rss_context >= num_tc) {
+			netdev_err(netdev, "RSS context:%d  > num_tc:%d\n",
+				   rss_context, num_tc);
+			return -EINVAL;
+		}
+		/* Use channel VSI of given TC */
+		vsi = vsi->tc_map_vsi[rss_context];
+	}
+
 	if (hfunc)
 		*hfunc = ETH_RSS_HASH_TOP;
 
 	if (!indir)
 		return 0;
 
-	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags)) {
-		/* RSS not supported return error here */
-		netdev_warn(netdev, "RSS is not configured on this VSI!\n");
-		return -EIO;
-	}
-
 	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
 	if (!lut)
 		return -ENOMEM;
@@ -3153,14 +3164,35 @@ ice_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc)
 	if (err)
 		goto out;
 
+	if (ice_is_adq_active(pf)) {
+		for (i = 0; i < vsi->rss_table_size; i++)
+			indir[i] = offset + lut[i] % qcount;
+		goto out;
+	}
+
 	for (i = 0; i < vsi->rss_table_size; i++)
-		indir[i] = (u32)(lut[i]);
+		indir[i] = lut[i];
 
 out:
 	kfree(lut);
 	return err;
 }
 
+/**
+ * ice_get_rxfh - get the Rx flow hash indirection table
+ * @netdev: network interface device structure
+ * @indir: indirection table
+ * @key: hash key
+ * @hfunc: hash function
+ *
+ * Reads the indirection table directly from the hardware.
+ */
+static int
+ice_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc)
+{
+	return ice_get_rxfh_context(netdev, indir, key, hfunc, 0);
+}
+
 /**
  * ice_set_rxfh - set the Rx flow hash indirection table
  * @netdev: network interface device structure
@@ -4102,6 +4134,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.set_pauseparam		= ice_set_pauseparam,
 	.get_rxfh_key_size	= ice_get_rxfh_key_size,
 	.get_rxfh_indir_size	= ice_get_rxfh_indir_size,
+	.get_rxfh_context	= ice_get_rxfh_context,
 	.get_rxfh		= ice_get_rxfh,
 	.set_rxfh		= ice_set_rxfh,
 	.get_channels		= ice_get_channels,
-- 
2.27.0

