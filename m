From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed,  7 Mar 2018 16:37:12 -0800
Subject: [Intel-wired-lan] [next-queue PATCH v4 7/8] igb: Add the skeletons
 for tc-flower offloading
In-Reply-To: <20180308003713.29195-1-vinicius.gomes@intel.com>
References: <20180308003713.29195-1-vinicius.gomes@intel.com>
Message-ID: <20180308003713.29195-8-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This adds basic functions needed to implement offloading for filters
created by tc-flower.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 04307ef07e5a..7762dd5f270d 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -35,6 +35,7 @@
 #include <net/checksum.h>
 #include <net/ip6_checksum.h>
 #include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
 #include <linux/net_tstamp.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
@@ -2497,6 +2498,69 @@ static int igb_offload_cbs(struct igb_adapter *adapter,
 	return 0;
 }
 
+static int igb_configure_clsflower(struct igb_adapter *adapter,
+				   struct tc_cls_flower_offload *cls_flower)
+{
+	return -EOPNOTSUPP;
+}
+
+static int igb_delete_clsflower(struct igb_adapter *adapter,
+				struct tc_cls_flower_offload *cls_flower)
+{
+	return -EOPNOTSUPP;
+}
+
+static int igb_setup_tc_cls_flower(struct igb_adapter *adapter,
+				   struct tc_cls_flower_offload *cls_flower)
+{
+	switch (cls_flower->command) {
+	case TC_CLSFLOWER_REPLACE:
+		return igb_configure_clsflower(adapter, cls_flower);
+	case TC_CLSFLOWER_DESTROY:
+		return igb_delete_clsflower(adapter, cls_flower);
+	case TC_CLSFLOWER_STATS:
+		return -EOPNOTSUPP;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int igb_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+				 void *cb_priv)
+{
+	struct igb_adapter *adapter = cb_priv;
+
+	if (!tc_cls_can_offload_and_chain0(adapter->netdev, type_data))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case TC_SETUP_CLSFLOWER:
+		return igb_setup_tc_cls_flower(adapter, type_data);
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int igb_setup_tc_block(struct igb_adapter *adapter,
+			      struct tc_block_offload *f)
+{
+	if (f->binder_type != TCF_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
+		return -EOPNOTSUPP;
+
+	switch (f->command) {
+	case TC_BLOCK_BIND:
+		return tcf_block_cb_register(f->block, igb_setup_tc_block_cb,
+					     adapter, adapter);
+	case TC_BLOCK_UNBIND:
+		tcf_block_cb_unregister(f->block, igb_setup_tc_block_cb,
+					adapter);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static int igb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 			void *type_data)
 {
@@ -2505,6 +2569,8 @@ static int igb_setup_tc(struct net_device *dev, enum tc_setup_type type,
 	switch (type) {
 	case TC_SETUP_QDISC_CBS:
 		return igb_offload_cbs(adapter, type_data);
+	case TC_SETUP_BLOCK:
+		return igb_setup_tc_block(adapter, type_data);
 
 	default:
 		return -EOPNOTSUPP;
-- 
2.16.2

