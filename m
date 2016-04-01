From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Fri,  1 Apr 2016 03:56:04 -0700
Subject: [Intel-wired-lan] [v3 next PATCH S32 04/13] i40e/i40evf: Move stack
	var deeper
In-Reply-To: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459508173-22777-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459508173-22777-5-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

A local variable could move down inside the context where it is used.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: I9caba9e1eacf921037077f2665cbce83fd8e95d6
---
Testing Hints : Compile test, no functional change.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 ++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5d5fa53..76a48e9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2408,7 +2408,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		unsigned char *hdr;
 	} l4;
 	unsigned char *exthdr;
-	u32 offset, cmd = 0, tunnel = 0;
+	u32 offset, cmd = 0;
 	__be16 frag_off;
 	u8 l4_proto = 0;
 
@@ -2422,6 +2422,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 	offset = ((ip.hdr - skb->data) / 2) << I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
 
 	if (skb->encapsulation) {
+		u32 tunnel = 0;
 		/* define outer network header type */
 		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
 			tunnel |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 04aabc5..d633dcf 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1633,7 +1633,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 		unsigned char *hdr;
 	} l4;
 	unsigned char *exthdr;
-	u32 offset, cmd = 0, tunnel = 0;
+	u32 offset, cmd = 0;
 	__be16 frag_off;
 	u8 l4_proto = 0;
 
@@ -1647,6 +1647,7 @@ static int i40e_tx_enable_csum(struct sk_buff *skb, u32 *tx_flags,
 	offset = ((ip.hdr - skb->data) / 2) << I40E_TX_DESC_LENGTH_MACLEN_SHIFT;
 
 	if (skb->encapsulation) {
+		u32 tunnel = 0;
 		/* define outer network header type */
 		if (*tx_flags & I40E_TX_FLAGS_IPV4) {
 			tunnel |= (*tx_flags & I40E_TX_FLAGS_TSO) ?
-- 
2.4.3

