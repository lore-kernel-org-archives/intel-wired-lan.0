From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Wed, 17 Jan 2018 15:06:20 -0800
Subject: [Intel-wired-lan] [RFC v2 net-next 09/10] igb: Refactor
 igb_offload_cbs()
In-Reply-To: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
References: <20180117230621.26074-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180117230621.26074-10-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Split code into a separate function (igb_offload_apply()) that will be
used by TBS offload implementation.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a955e1723ed5..fc2fc571b87b 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2462,6 +2462,19 @@ igb_features_check(struct sk_buff *skb, struct net_device *dev,
 	return features;
 }
 
+static void igb_offload_apply(struct igb_adapter *adapter, s32 queue)
+{
+	if (!is_fqtss_enabled(adapter)) {
+		enable_fqtss(adapter, true);
+		return;
+	}
+
+	igb_config_tx_modes(adapter, queue);
+
+	if (!is_any_cbs_enabled(adapter))
+		enable_fqtss(adapter, false);
+}
+
 static int igb_offload_cbs(struct igb_adapter *adapter,
 			   struct tc_cbs_qopt_offload *qopt)
 {
@@ -2482,15 +2495,7 @@ static int igb_offload_cbs(struct igb_adapter *adapter,
 	if (err)
 		return err;
 
-	if (is_fqtss_enabled(adapter)) {
-		igb_config_tx_modes(adapter, qopt->queue);
-
-		if (!is_any_cbs_enabled(adapter))
-			enable_fqtss(adapter, false);
-
-	} else {
-		enable_fqtss(adapter, true);
-	}
+	igb_offload_apply(adapter, qopt->queue);
 
 	return 0;
 }
-- 
2.15.1

