From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Tue, 12 Apr 2016 08:30:49 -0700
Subject: [Intel-wired-lan] [next PATCH S33 10/13] i40e/i40evf: Only offload
	vlan tag if enabled
In-Reply-To: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1460475052-6348-11-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

The driver was offloading the vlan tag into the skb
any time there was a vlan tag and the hardware stripping was
enabled.  Just check to make sure it's enabled before put_tag.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-Id: Ife95290c06edd9a616393b38679923938b382241
---
Testing Hints : Make sure ethtool control
over RX vlan tag insertion/removal still works.

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 ++-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index f4af60c..05293f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -1370,7 +1370,8 @@ static void i40e_receive_skb(struct i40e_ring *rx_ring,
 {
 	struct i40e_q_vector *q_vector = rx_ring->q_vector;
 
-	if (vlan_tag & VLAN_VID_MASK)
+	if ((rx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    (vlan_tag & VLAN_VID_MASK))
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
 
 	napi_gro_receive(&q_vector->napi, skb);
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
index 3eb39a1..e18d9d9 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -842,7 +842,8 @@ static void i40e_receive_skb(struct i40e_ring *rx_ring,
 {
 	struct i40e_q_vector *q_vector = rx_ring->q_vector;
 
-	if (vlan_tag & VLAN_VID_MASK)
+	if ((rx_ring->netdev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    (vlan_tag & VLAN_VID_MASK))
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
 
 	napi_gro_receive(&q_vector->napi, skb);
-- 
2.4.3

