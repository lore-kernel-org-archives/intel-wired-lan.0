From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon,  8 Jun 2020 18:49:39 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Refactor the
 igc_power_down_link()
Message-ID: <20200608154939.30699-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently inplementation of the igc_power_down_link()
method a bit tangled. This method just called
igc_power_down_phy_copper-base() method.
We can just call the igc_power_down_phy_copper_base()
method directly.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 5d70751e8ab3..af5e1686f7f2 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -61,16 +61,6 @@ enum latency_range {
 	latency_invalid = 255
 };
 
-/**
- * igc_power_down_link - Power down the phy link
- * @adapter: address of board private structure
- */
-static void igc_power_down_link(struct igc_adapter *adapter)
-{
-	if (adapter->hw.phy.media_type == igc_media_type_copper)
-		igc_power_down_phy_copper_base(&adapter->hw);
-}
-
 void igc_reset(struct igc_adapter *adapter)
 {
 	struct net_device *dev = adapter->netdev;
@@ -106,7 +96,7 @@ void igc_reset(struct igc_adapter *adapter)
 	igc_set_eee_i225(hw, true, true, true);
 
 	if (!netif_running(adapter->netdev))
-		igc_power_down_link(adapter);
+		igc_power_down_phy_copper_base(&adapter->hw);
 
 	/* Re-enable PTP, where applicable. */
 	igc_ptp_reset(adapter);
@@ -4617,7 +4607,7 @@ static int __igc_open(struct net_device *netdev, bool resuming)
 	igc_free_irq(adapter);
 err_req_irq:
 	igc_release_hw_control(adapter);
-	igc_power_down_link(adapter);
+	igc_power_down_phy_copper_base(&adapter->hw);
 	igc_free_all_rx_resources(adapter);
 err_setup_rx:
 	igc_free_all_tx_resources(adapter);
@@ -5316,7 +5306,7 @@ static int __igc_shutdown(struct pci_dev *pdev, bool *enable_wake,
 
 	wake = wufc || adapter->en_mng_pt;
 	if (!wake)
-		igc_power_down_link(adapter);
+		igc_power_down_phy_copper_base(&adapter->hw);
 	else
 		igc_power_up_link(adapter);
 
-- 
2.11.0

