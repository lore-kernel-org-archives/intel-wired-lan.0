From: Alice Michael <alice.michael@intel.com>
Date: Thu,  6 Apr 2017 05:59:34 -0400
Subject: [Intel-wired-lan] [next S68 01/01] i40e/i40evf: Remove VF Rx csum
	offload for tunneled packets.
Message-ID: <20170406095934.70094-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Rx checksum offload for tunneled packets was never being negotiated or
requested by VF. This capability was assumed by default and enabled in
current hardware for VF. Going forward, this feature needs to be disabled
or advanced ptypes should be negotiated with PF in the future.

Signed-off-by: Preethi Banala <preethi.banala@intel.com>
Change-ID: I9e54cfa8a90e03ab6956db4412f1e337ccd2c2e0
---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 163b42b..b3fb0d08 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -835,13 +835,6 @@ static inline void i40e_rx_checksum(struct i40e_vsi *vsi,
 	if (rx_error & BIT(I40E_RX_DESC_ERROR_PPRS_SHIFT))
 		return;
 
-	/* If there is an outer header present that might contain a checksum
-	 * we need to bump the checksum level by 1 to reflect the fact that
-	 * we are indicating we validated the inner checksum.
-	 */
-	if (decoded.tunnel_type >= I40E_RX_PTYPE_TUNNEL_IP_GRENAT)
-		skb->csum_level = 1;
-
 	/* Only report checksum unnecessary for TCP, UDP, or SCTP */
 	switch (decoded.inner_prot) {
 	case I40E_RX_PTYPE_INNER_PROT_TCP:
-- 
2.9.3

