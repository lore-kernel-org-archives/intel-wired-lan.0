From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 10 Jul 2017 13:23:12 -0700
Subject: [Intel-wired-lan] [PATCH v3 09/16] fm10k: move
	fm10k_prepare_for_reset and fm10k_handle_reset
In-Reply-To: <20170710202319.22110-1-jacob.e.keller@intel.com>
References: <20170710202319.22110-1-jacob.e.keller@intel.com>
Message-ID: <20170710202319.22110-9-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

A future patch needs these functions defined earlier in the file. Move
them closer to above where they will be called.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 58 ++++++++++++++--------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 32b5ace82cad..6a7b4c5429ae 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -132,35 +132,6 @@ static void fm10k_service_timer(unsigned long data)
 	fm10k_service_event_schedule(interface);
 }
 
-static void fm10k_detach_subtask(struct fm10k_intfc *interface)
-{
-	struct net_device *netdev = interface->netdev;
-	u32 __iomem *hw_addr;
-	u32 value;
-
-	/* do nothing if device is still present or hw_addr is set */
-	if (netif_device_present(netdev) || interface->hw.hw_addr)
-		return;
-
-	/* check the real address space to see if we've recovered */
-	hw_addr = READ_ONCE(interface->uc_addr);
-	value = readl(hw_addr);
-	if (~value) {
-		interface->hw.hw_addr = interface->uc_addr;
-		netif_device_attach(netdev);
-		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
-		netdev_warn(netdev, "PCIe link restored, device now attached\n");
-		return;
-	}
-
-	rtnl_lock();
-
-	if (netif_running(netdev))
-		dev_close(netdev);
-
-	rtnl_unlock();
-}
-
 static void fm10k_prepare_for_reset(struct fm10k_intfc *interface)
 {
 	struct net_device *netdev = interface->netdev;
@@ -270,6 +241,35 @@ static int fm10k_handle_reset(struct fm10k_intfc *interface)
 	return err;
 }
 
+static void fm10k_detach_subtask(struct fm10k_intfc *interface)
+{
+	struct net_device *netdev = interface->netdev;
+	u32 __iomem *hw_addr;
+	u32 value;
+
+	/* do nothing if device is still present or hw_addr is set */
+	if (netif_device_present(netdev) || interface->hw.hw_addr)
+		return;
+
+	/* check the real address space to see if we've recovered */
+	hw_addr = READ_ONCE(interface->uc_addr);
+	value = readl(hw_addr);
+	if (~value) {
+		interface->hw.hw_addr = interface->uc_addr;
+		netif_device_attach(netdev);
+		set_bit(FM10K_FLAG_RESET_REQUESTED, interface->flags);
+		netdev_warn(netdev, "PCIe link restored, device now attached\n");
+		return;
+	}
+
+	rtnl_lock();
+
+	if (netif_running(netdev))
+		dev_close(netdev);
+
+	rtnl_unlock();
+}
+
 static void fm10k_reinit(struct fm10k_intfc *interface)
 {
 	int err;
-- 
2.13.0.615.gb09ed6e59a40

