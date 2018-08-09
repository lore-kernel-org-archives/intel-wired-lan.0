From: Sebastian Basierski <sebastianx.basierski@intel.com>
Date: Thu,  9 Aug 2018 11:45:40 +0200
Subject: [Intel-wired-lan] [PATCH] ixgbevf: VF2VF TCP RSS
Message-ID: <20180809094540.29745-1-sebastianx.basierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

While VF2VF with RSS communication, RSS Type were wrongly recognized
and RSS hash was not calculated as it should be. Packets was
distributed on various queues by accident.
This commit fixes that behaviour and causes proper RSS Type recognition.

Signed-off-by: Sebastian Basierski <sebastianx.basierski@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index d86446d202d5..15deac07fd92 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -3849,6 +3849,10 @@ static void ixgbevf_tx_csum(struct ixgbevf_ring *tx_ring,
 		skb_checksum_help(skb);
 		goto no_csum;
 	}
+
+	if (first->protocol == htons(ETH_P_IP))
+		type_tucmd |= IXGBE_ADVTXD_TUCMD_IPV4;
+
 	/* update TX checksum flag */
 	first->tx_flags |= IXGBE_TX_FLAGS_CSUM;
 	vlan_macip_lens = skb_checksum_start_offset(skb) -
-- 
2.17.1

