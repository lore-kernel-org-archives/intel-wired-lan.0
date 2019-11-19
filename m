From: Sasha Neftin <sasha.neftin@intel.com>
Date: Tue, 19 Nov 2019 13:43:41 +0200
Subject: [Intel-wired-lan] [PATCH v1 02/15] igc: Remove no need declaration
 of the igc_power_down_link
Message-ID: <20191119114341.41725-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We want to avoid forward-declarations of function if possible.
Rearrange the igc_power_down_link function implementation.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index ed71d8bdf47d..87823a04427e 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -54,7 +54,6 @@ MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
 /* forward declaration */
 static int igc_sw_init(struct igc_adapter *);
 static void igc_configure(struct igc_adapter *adapter);
-static void igc_power_down_link(struct igc_adapter *adapter);
 static void igc_set_default_mac_filter(struct igc_adapter *adapter);
 static void igc_set_rx_mode(struct net_device *netdev);
 static void igc_write_itr(struct igc_q_vector *q_vector);
@@ -76,6 +75,16 @@ enum latency_range {
 	latency_invalid = 255
 };
 
+/**
+ * igc_power_down_link - Power down the phy/serdes link
+ * @adapter: address of board private structure
+ */
+static void igc_power_down_link(struct igc_adapter *adapter)
+{
+	if (adapter->hw.phy.media_type == igc_media_type_copper)
+		igc_power_down_phy_copper_base(&adapter->hw);
+}
+
 void igc_reset(struct igc_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
@@ -128,16 +137,6 @@ static void igc_power_up_link(struct igc_adapter *adapter)
 }
 
 /**
- * igc_power_down_link - Power down the phy/serdes link
- * @adapter: address of board private structure
- */
-static void igc_power_down_link(struct igc_adapter *adapter)
-{
-	if (adapter->hw.phy.media_type == igc_media_type_copper)
-		igc_power_down_phy_copper_base(&adapter->hw);
-}
-
-/**
  * igc_release_hw_control - release control of the h/w to f/w
  * @adapter: address of board private structure
  *
-- 
2.11.0

