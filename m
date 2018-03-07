From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Tue,  6 Mar 2018 17:12:29 -0800
Subject: [Intel-wired-lan] [RFC v3 net-next 17/18] igb: Refactor
 igb_offload_cbs()
In-Reply-To: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
References: <20180307011230.24001-1-jesus.sanchez-palencia@intel.com>
Message-ID: <20180307011230.24001-18-jesus.sanchez-palencia@intel.com>
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
index 9c33f2d18d8c..10d7809a85d7 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2476,6 +2476,19 @@ igb_features_check(struct sk_buff *skb, struct net_device *dev,
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
@@ -2496,15 +2509,7 @@ static int igb_offload_cbs(struct igb_adapter *adapter,
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
2.16.2

