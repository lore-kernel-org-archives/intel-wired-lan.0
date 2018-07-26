From: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
Date: Thu, 26 Jul 2018 10:20:38 -0700
Subject: [Intel-wired-lan] [PATCH v1 net-next] igb: Use an advanced ctx
 descriptor for launchtime
Message-ID: <20180726172038.11330-1-jesus.sanchez-palencia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On i210, Launchtime (TxTime) requires the usage of an "Advanced
Transmit Context Descriptor" for retrieving the timestamp of a packet.

The igb driver correctly builds such descriptor on the segmentation
flow (i.e. igb_tso()) or on the checksum one (i.e. igb_tx_csum()), but the
feature is broken for AF_PACKET if the IGB_TX_FLAGS_VLAN is not set,
which happens due to an early return on igb_tx_csum().

This flag is only set by the kernel when a VLAN interface is used,
thus we can't just rely on it. Here we are fixing this issue by checking
if launchtime is enabled for the current tx_ring before performing the
early return.

Signed-off-by: Jesus Sanchez-Palencia <jesus.sanchez-palencia@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index e3a0c02721c9..fa1089defcd5 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -5816,7 +5816,8 @@ static void igb_tx_csum(struct igb_ring *tx_ring, struct igb_tx_buffer *first)
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL) {
 csum_failed:
-		if (!(first->tx_flags & IGB_TX_FLAGS_VLAN))
+		if (!(first->tx_flags & IGB_TX_FLAGS_VLAN)
+		    && !tx_ring->launchtime_enable)
 			return;
 		goto no_csum;
 	}
-- 
2.18.0

