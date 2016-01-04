From: Deepthi Kavalur <deepthi.kavalur@intel.com>
Date: Mon,  4 Jan 2016 10:33:04 -0800
Subject: [Intel-wired-lan] [next PATCH S26 04/12] i40e: do TSO only if
	CHECKSUM_PARTIAL is set
In-Reply-To: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <1451932392-15538-5-git-send-email-deepthi.kavalur@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Don't bother trying to set up a TSO if the skb->ip_summed is not
set to CHECKSUM_PARTIAL.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I6495b3568e404907a2965b48cf3e2effa7c9ab55
---
Testing-Hints:
I'm sure there's a better test available, but I found this by
inspection and then adding a debug printk to see what was happening.
For now, just verify that the code is inserted and compiles.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 +++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 7d81c1f..6537598 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2213,6 +2213,9 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	u32 l4len;
 	int err;
 
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
 	if (!skb_is_gso(skb))
 		return 0;
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index a1d907c..c21fcee 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1470,6 +1470,9 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	u32 l4len;
 	int err;
 
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
 	if (!skb_is_gso(skb))
 		return 0;
 
-- 
2.1.0

