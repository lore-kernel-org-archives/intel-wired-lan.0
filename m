From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  5 May 2021 14:17:59 -0700
Subject: [Intel-wired-lan] [PATCH net 3/4] ice: Allow all LLDP packets from
 PF to Tx
In-Reply-To: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
References: <20210505211800.11908-1-anthony.l.nguyen@intel.com>
Message-ID: <20210505211800.11908-3-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Ertman <david.m.ertman@intel.com>

Currently in the ice driver, the check whether to
allow a LLDP packet to egress the interface from the
PF_VSI is being based on the SKB's priority field.
It checks to see if the packets priority is equal to
TC_PRIO_CONTROL.  Injected LLDP packets do not always
meet this condition.

SCAPY defaults to a sk_buff->protocol value of ETH_P_ALL
(0x0003) and does not set the priority field.  There will
be other injection methods (even ones used by end users)
that will not correctly configure the socket so that
SKB fields are correctly populated.

Then ethernet header has to have to correct value for
the protocol though.

Add a check to also allow packets whose ethhdr->h_proto
matches ETH_P_LLDP (0x88CC).

Fixes: 0c3a6101ff2d ("ice: Allow egress control packets from PF_VSI")
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_txrx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index e2b4b29ea207..dd06d25850aa 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2143,6 +2143,7 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_ring *tx_ring)
 	struct ice_tx_offload_params offload = { 0 };
 	struct ice_vsi *vsi = tx_ring->vsi;
 	struct ice_tx_buf *first;
+	struct ethhdr *eth;
 	unsigned int count;
 	int tso, csum;
 
@@ -2189,7 +2190,9 @@ ice_xmit_frame_ring(struct sk_buff *skb, struct ice_ring *tx_ring)
 		goto out_drop;
 
 	/* allow CONTROL frames egress from main VSI if FW LLDP disabled */
-	if (unlikely(skb->priority == TC_PRIO_CONTROL &&
+	eth = (struct ethhdr *)skb_mac_header(skb);
+	if (unlikely((skb->priority == TC_PRIO_CONTROL ||
+		      eth->h_proto == htons(ETH_P_LLDP)) &&
 		     vsi->type == ICE_VSI_PF &&
 		     vsi->port_info->qos_cfg.is_sw_lldp))
 		offload.cd_qw1 |= (u64)(ICE_TX_DESC_DTYPE_CTX |
-- 
2.20.1

