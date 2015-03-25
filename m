From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:18 -0700
Subject: [Intel-wired-lan] [next-queue S2 08/15] i40e/i40evf: Set Ethernet
	protocol correctly when Tx VLAN offloads are disabled
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-8-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

If transmit VLAN HW offloads are disabled then the network stack sends up
an skb with the protocol set to 8021q. In that case to get the correct
checksum offloads we have to reset the skb protocol to the encapsulated
ethertype.

Change-ID: I903d78533de09b1c5d3ec695ee1990dd0fa5dd0d
Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 13 +++++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 14 ++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 5a1a677..d8989f9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2057,6 +2057,19 @@ static int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 	__be16 protocol = skb->protocol;
 	u32  tx_flags = 0;
 
+	if (protocol == htons(ETH_P_8021Q) &&
+	    !(tx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_TX)) {
+		/* When HW VLAN acceleration is turned off by the user the
+		 * stack sets the protocol to 8021q so that the driver
+		 * can take any steps required to support the SW only
+		 * VLAN handling.  In our case the driver doesn't need
+		 * to take any further steps so just set the protocol
+		 * to the encapsulated ethertype.
+		 */
+		skb->protocol = vlan_get_protocol(skb);
+		goto out;
+	}
+
 	/* if we have a HW VLAN tag being added, default to the HW one */
 	if (skb_vlan_tag_present(skb)) {
 		tx_flags |= skb_vlan_tag_get(skb) << I40E_TX_FLAGS_VLAN_SHIFT;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 2be50a8..e2ddb30 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -1370,6 +1370,19 @@ static int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 	__be16 protocol = skb->protocol;
 	u32  tx_flags = 0;
 
+	if (protocol == htons(ETH_P_8021Q) &&
+	    !(tx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_TX)) {
+		/* When HW VLAN acceleration is turned off by the user the
+		 * stack sets the protocol to 8021q so that the driver
+		 * can take any steps required to support the SW only
+		 * VLAN handling.  In our case the driver doesn't need
+		 * to take any further steps so just set the protocol
+		 * to the encapsulated ethertype.
+		 */
+		skb->protocol = vlan_get_protocol(skb);
+		goto out;
+	}
+
 	/* if we have a HW VLAN tag being added, default to the HW one */
 	if (skb_vlan_tag_present(skb)) {
 		tx_flags |= skb_vlan_tag_get(skb) << I40E_TX_FLAGS_VLAN_SHIFT;
@@ -1386,6 +1399,7 @@ static int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
 		tx_flags |= I40E_TX_FLAGS_SW_VLAN;
 	}
 
+out:
 	*flags = tx_flags;
 	return 0;
 }
-- 
1.9.3

