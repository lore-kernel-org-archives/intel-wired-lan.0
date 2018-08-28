From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 Aug 2018 10:16:02 -0700
Subject: [Intel-wired-lan] [next PATCH S96 2/9] i40evf: Don't enable vlan
 stripping when rx offload is turned on
In-Reply-To: <20180828171609.78242-1-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
Message-ID: <20180828171609.78242-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

With current implementation of i40evf_set_features when user sets
any offload via ethtool we set I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING
as a required aq which triggers driver to call
i40evf_enable_vlan_stripping. This shouldn't take place.
This patches fixes it by setting the flag only when vlan offload
is turned on.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 07f187b..c7048cf 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -3120,18 +3120,19 @@ static int i40evf_set_features(struct net_device *netdev,
 {
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
 
-	/* Don't allow changing VLAN_RX flag when VLAN is set for VF
-	 * and return an error in this case
+	/* Don't allow changing VLAN_RX flag when adapter is not capable
+	 * of VLAN offload
 	 */
-	if (VLAN_ALLOWED(adapter)) {
+	if (!VLAN_ALLOWED(adapter)) {
+		if ((netdev->features ^ features) & NETIF_F_HW_VLAN_CTAG_RX)
+			return -EINVAL;
+	} else if ((netdev->features ^ features) & NETIF_F_HW_VLAN_CTAG_RX) {
 		if (features & NETIF_F_HW_VLAN_CTAG_RX)
 			adapter->aq_required |=
 				I40EVF_FLAG_AQ_ENABLE_VLAN_STRIPPING;
 		else
 			adapter->aq_required |=
 				I40EVF_FLAG_AQ_DISABLE_VLAN_STRIPPING;
-	} else if ((netdev->features ^ features) & NETIF_F_HW_VLAN_CTAG_RX) {
-		return -EINVAL;
 	}
 
 	return 0;
-- 
2.9.5

