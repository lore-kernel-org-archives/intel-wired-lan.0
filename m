From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 24 Sep 2015 15:43:02 -0400
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e: Move i40e_get_head into
	header file
Message-ID: <1443123783-86802-1-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

i40e_get_head needs to be called in multiple files in a further patch,
prepare by moving the function into a header file.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 13 -------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index d51b8ed..6b78df3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -601,19 +601,6 @@ void i40e_free_tx_resources(struct i40e_ring *tx_ring)
 	}
 }
 
-/**
- * i40e_get_head - Retrieve head from head writeback
- * @tx_ring:  tx ring to fetch head of
- *
- * Returns value of Tx ring head based on value stored
- * in head write-back location
- **/
-static inline u32 i40e_get_head(struct i40e_ring *tx_ring)
-{
-	void *head = (struct i40e_tx_desc *)tx_ring->desc + tx_ring->count;
-
-	return le32_to_cpu(*(volatile __le32 *)head);
-}
 
 /**
  * i40e_get_tx_pending - how many tx descriptors not processed
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index 073464e..f67f8cf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -328,4 +328,18 @@ int i40e_xmit_descriptor_count(struct sk_buff *skb, struct i40e_ring *tx_ring);
 int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 			       struct i40e_ring *tx_ring, u32 *flags);
 #endif
+
+/**
+ * i40e_get_head - Retrieve head from head writeback
+ * @tx_ring:  tx ring to fetch head of
+ *
+ * Returns value of Tx ring head based on value stored
+ * in head write-back location
+ **/
+static inline u32 i40e_get_head(struct i40e_ring *tx_ring)
+{
+	void *head = (struct i40e_tx_desc *)tx_ring->desc + tx_ring->count;
+
+	return le32_to_cpu(*(volatile __le32 *)head);
+}
 #endif /* _I40E_TXRX_H_ */
-- 
1.9.3

