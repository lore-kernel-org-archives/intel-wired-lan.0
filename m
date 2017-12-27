From: Alice Michael <alice.michael@intel.com>
Date: Wed, 27 Dec 2017 07:32:32 -0500
Subject: [Intel-wired-lan] [next PATCH S84-V2 03/13] i40evf: Allow turning
 off offloads when the
In-Reply-To: <20171227123242.22356-1-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
Message-ID: <20171227123242.22356-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds back the capability to turn off offloads when VF has
VLAN set. The commit 0a3b4f702fb1 ("i40evf: enable support for VF VLAN
tag stripping control") adds the i40evf_set_features function and
changes the 'turn off' flow for offloads. This patch adds that
capability back by moving checking the VLAN option for VF to the
next statement.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 8934f78..d59bf06 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2344,13 +2344,19 @@ static int i40evf_set_features(struct net_device *netdev,
 {
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 
-	if (!VLAN_ALLOWED(adapter))
+	/* Don't allow changing VLAN_RX flag when VLAN is set for VF
+	 * and return an error in this case
+	 */
+	if (VLAN_ALLOWED(adapter)) {
+		if (features & NETIF_F_HW_VLAN_CTAG_RX)
+			adapter->aq_required |=
+				I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
+		else
+			adapter->aq_required |=
+				I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
+	} else if ((netdev->features ^ features) & NETIF_F_HW_VLAN_CTAG_RX) {
 		return -EINVAL;
-
-	if (features & NETIF_F_HW_VLAN_CTAG_RX)
-		adapter->aq_required |= I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
-	else
-		adapter->aq_required |= I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
+	}
 
 	return 0;
 }
-- 
2.9.5

