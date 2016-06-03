From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  3 Jun 2016 15:42:26 -0700
Subject: [Intel-wired-lan] [PATCH v1 16/18] fm10k: check if PCIe link is
	restored
In-Reply-To: <20160603224228.10192-1-jacob.e.keller@intel.com>
References: <20160603224228.10192-1-jacob.e.keller@intel.com>
Message-ID: <20160603224228.10192-17-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Sometimes, a VF driver will lose PCIe address access, such as due to
a PF FLR event. In fm10k_detach_subtask, poll and check whether the
PCIe register space is active again and restore the device when it has.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 8eaf6479b9dd..358fdb0d990b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -123,11 +123,24 @@ static void fm10k_service_timer(unsigned long data)
 static void fm10k_detach_subtask(struct fm10k_intfc *interface)
 {
 	struct net_device *netdev = interface->netdev;
+	u32 __iomem *hw_addr;
+	u32 value;
 
 	/* do nothing if device is still present or hw_addr is set */
 	if (netif_device_present(netdev) || interface->hw.hw_addr)
 		return;
 
+	/* check the real address space to see if we've recovered */
+	hw_addr = READ_ONCE(interface->uc_addr);
+	value = readl(hw_addr);
+	if ((~value)) {
+		interface->hw.hw_addr = interface->uc_addr;
+		netif_device_attach(netdev);
+		interface->flags |= FM10K_FLAG_RESET_REQUESTED;
+		netdev_warn(netdev, "PCIe link restored, device now attached\n");
+		return;
+	}
+
 	rtnl_lock();
 
 	if (netif_running(netdev))
-- 
2.8.2.820.gd1c5f70

