From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 Aug 2018 10:16:04 -0700
Subject: [Intel-wired-lan] [next PATCH S96 4/9] i40e: use declared variables
 for pf and hw
In-Reply-To: <20180828171609.78242-1-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
Message-ID: <20180828171609.78242-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Patryk Ma?ek <patryk.malek@intel.com>

In order to slightly simplify the code use the variables for pf and hw
that are declared in i40e_set_mac function.

Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 79bffaf..6ce695f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1537,8 +1537,8 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 		return 0;
 	}
 
-	if (test_bit(__I40E_VSI_DOWN, vsi->back->state) ||
-	    test_bit(__I40E_RESET_RECOVERY_PENDING, vsi->back->state))
+	if (test_bit(__I40E_DOWN, pf->state) ||
+	    test_bit(__I40E_RESET_RECOVERY_PENDING, pf->state))
 		return -EADDRNOTAVAIL;
 
 	if (ether_addr_equal(hw->mac.addr, addr->sa_data))
@@ -1562,8 +1562,7 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 	if (vsi->type == I40E_VSI_MAIN) {
 		i40e_status ret;
 
-		ret = i40e_aq_mac_address_write(&vsi->back->hw,
-						I40E_AQC_WRITE_TYPE_LAA_WOL,
+		ret = i40e_aq_mac_address_write(hw, I40E_AQC_WRITE_TYPE_LAA_WOL,
 						addr->sa_data, NULL);
 		if (ret)
 			netdev_info(netdev, "Ignoring error from firmware on LAA update, status %s, AQ ret %s\n",
@@ -1574,7 +1573,7 @@ static int i40e_set_mac(struct net_device *netdev, void *p)
 	/* schedule our worker thread which will take care of
 	 * applying the new filter changes
 	 */
-	i40e_service_event_schedule(vsi->back);
+	i40e_service_event_schedule(pf);
 	return 0;
 }
 
-- 
2.9.5

