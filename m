From: Alexander Duyck <aduyck@mirantis.com>
Date: Sun, 24 Jan 2016 21:16:20 -0800
Subject: [Intel-wired-lan] [next PATCH v3 02/15] i40e/i40evf: Use u64 values
 instead of casting them in TSO function
In-Reply-To: <20160125050602.12004.38884.stgit@localhost.localdomain>
References: <20160125050602.12004.38884.stgit@localhost.localdomain>
Message-ID: <20160125051620.12004.2775.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of casing u32 values to u64 it makes more sense to just start out
with u64 values in the first place.  This way we don't need to create a
mess with all of the casts needed to populate a 64b value.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    9 ++++-----
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    9 ++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index c92198e7f5bc..d201bedaca27 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2267,7 +2267,7 @@ out:
 static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
-	u32 cd_cmd, cd_tso_len, cd_mss;
+	u64 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
 	struct tcphdr *tcph;
 	struct iphdr *iph;
@@ -2309,10 +2309,9 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	cd_cmd = I40E_TX_CTX_DESC_TSO;
 	cd_tso_len = skb->len - *hdr_len;
 	cd_mss = skb_shinfo(skb)->gso_size;
-	*cd_type_cmd_tso_mss |= ((u64)cd_cmd << I40E_TXD_CTX_QW1_CMD_SHIFT) |
-				((u64)cd_tso_len <<
-				 I40E_TXD_CTX_QW1_TSO_LEN_SHIFT) |
-				((u64)cd_mss << I40E_TXD_CTX_QW1_MSS_SHIFT);
+	*cd_type_cmd_tso_mss |= (cd_cmd << I40E_TXD_CTX_QW1_CMD_SHIFT) |
+				(cd_tso_len << I40E_TXD_CTX_QW1_TSO_LEN_SHIFT) |
+				(cd_mss << I40E_TXD_CTX_QW1_MSS_SHIFT);
 	return 1;
 }
 
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index f7ac254b79f0..07d6b5d5a2ae 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1527,7 +1527,7 @@ out:
 static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		    u8 *hdr_len, u64 *cd_type_cmd_tso_mss)
 {
-	u32 cd_cmd, cd_tso_len, cd_mss;
+	u64 cd_cmd, cd_tso_len, cd_mss;
 	struct ipv6hdr *ipv6h;
 	struct tcphdr *tcph;
 	struct iphdr *iph;
@@ -1569,10 +1569,9 @@ static int i40e_tso(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	cd_cmd = I40E_TX_CTX_DESC_TSO;
 	cd_tso_len = skb->len - *hdr_len;
 	cd_mss = skb_shinfo(skb)->gso_size;
-	*cd_type_cmd_tso_mss |= ((u64)cd_cmd << I40E_TXD_CTX_QW1_CMD_SHIFT) |
-				((u64)cd_tso_len <<
-				 I40E_TXD_CTX_QW1_TSO_LEN_SHIFT) |
-				((u64)cd_mss << I40E_TXD_CTX_QW1_MSS_SHIFT);
+	*cd_type_cmd_tso_mss |= (cd_cmd << I40E_TXD_CTX_QW1_CMD_SHIFT) |
+				(cd_tso_len << I40E_TXD_CTX_QW1_TSO_LEN_SHIFT) |
+				(cd_mss << I40E_TXD_CTX_QW1_MSS_SHIFT);
 	return 1;
 }
 

