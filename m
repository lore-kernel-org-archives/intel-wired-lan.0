From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Tue, 10 Oct 2017 13:20:01 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: enable multicast on shutdown for
	WOL
Message-ID: <20171010202000.32625.17259.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previously we only enabled the reception of multicast packets when
wake on multicast is set, but we also need this to allow waking with
IPv6 magic packets.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7683c14..fe29689 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -6783,7 +6783,7 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 	struct ixgbe_adapter *adapter = pci_get_drvdata(pdev);
 	struct net_device *netdev = adapter->netdev;
 	struct ixgbe_hw *hw = &adapter->hw;
-	u32 ctrl, fctrl;
+	u32 ctrl;
 	u32 wufc = adapter->wol;
 #ifdef CONFIG_PM
 	int retval = 0;
@@ -6808,18 +6808,18 @@ static int __ixgbe_shutdown(struct pci_dev *pdev, bool *enable_wake)
 		hw->mac.ops.stop_link_on_d3(hw);
 
 	if (wufc) {
+		u32 fctrl;
+
 		ixgbe_set_rx_mode(netdev);
 
 		/* enable the optics for 82599 SFP+ fiber as we can WoL */
 		if (hw->mac.ops.enable_tx_laser)
 			hw->mac.ops.enable_tx_laser(hw);
 
-		/* turn on all-multi mode if wake on multicast is enabled */
-		if (wufc & IXGBE_WUFC_MC) {
-			fctrl = IXGBE_READ_REG(hw, IXGBE_FCTRL);
-			fctrl |= IXGBE_FCTRL_MPE;
-			IXGBE_WRITE_REG(hw, IXGBE_FCTRL, fctrl);
-		}
+		/* enable the reception of multicast packets */
+		fctrl = IXGBE_READ_REG(hw, IXGBE_FCTRL);
+		fctrl |= IXGBE_FCTRL_MPE;
+		IXGBE_WRITE_REG(hw, IXGBE_FCTRL, fctrl);
 
 		ctrl = IXGBE_READ_REG(hw, IXGBE_CTRL);
 		ctrl |= IXGBE_CTRL_GIO_DIS;

