From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Fri, 23 Feb 2018 17:20:36 -0800
Subject: [Intel-wired-lan] [next-queue PATCH 8/8] igb: Add support for
 removing offloaded tc-flower filters
In-Reply-To: <20180224012036.5834-1-vinicius.gomes@intel.com>
References: <20180224012036.5834-1-vinicius.gomes@intel.com>
Message-ID: <20180224012036.5834-9-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This allows tc-flower filters that were offloaded to be removed.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 32 ++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index b1d401e77d62..5e0e1df0e941 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2641,10 +2641,40 @@ static int igb_configure_clsflower(struct igb_adapter *adapter,
 	return err;
 }
 
+static int igb_delete_filter_by_cookie(struct igb_adapter *adapter,
+				       unsigned long cookie)
+{
+	struct igb_nfc_filter *filter;
+	int err;
+
+	spin_lock(&adapter->nfc_lock);
+
+	hlist_for_each_entry(filter, &adapter->nfc_filter_list, nfc_node) {
+		if (filter->cookie == cookie)
+			break;
+	}
+
+	if (!filter) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	err = igb_erase_filter(adapter, filter);
+
+	hlist_del(&filter->nfc_node);
+	kfree(filter);
+	adapter->nfc_filter_count--;
+
+out:
+	spin_unlock(&adapter->nfc_lock);
+
+	return err;
+}
+
 static int igb_delete_clsflower(struct igb_adapter *adapter,
 				struct tc_cls_flower_offload *cls_flower)
 {
-	return -EOPNOTSUPP;
+	return igb_delete_filter_by_cookie(adapter, cls_flower->cookie);
 }
 
 static int igb_setup_tc_cls_flower(struct igb_adapter *adapter,
-- 
2.16.2

