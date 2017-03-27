From: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
Date: Mon, 27 Mar 2017 08:44:35 +0800
Subject: [Intel-wired-lan] [PATCH] igb: Enable reading of wake up packet
In-Reply-To: <1490575475-8215-1-git-send-email-kim.tatt.chuah@intel.com>
References: <1490575475-8215-1-git-send-email-kim.tatt.chuah@intel.com>
Message-ID: <1490575475-8215-2-git-send-email-kim.tatt.chuah@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently, in igb_resume(), igb driver ignores the Wake Up Status (WUS)
and Wake Up Packet Memory (WUPM) registers. This patch enables the igb
driver to read the WUPM if the controller was woken by a wake up packet
that is not more than 128 bytes long (maximum WUPM size), then pass it
up the kernel network stack.

Signed-off-by: Chuah, Kim Tatt <kim.tatt.chuah@intel.com>
---
 drivers/net/ethernet/intel/igb/e1000_defines.h | 21 +++++++++++++++
 drivers/net/ethernet/intel/igb/igb_main.c      | 36 +++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/e1000_defines.h b/drivers/net/ethernet/intel/igb/e1000_defines.h
index 8aee314..532bc7b 100644
--- a/drivers/net/ethernet/intel/igb/e1000_defines.h
+++ b/drivers/net/ethernet/intel/igb/e1000_defines.h
@@ -39,6 +39,27 @@
 #define E1000_WUFC_MC   0x00000008 /* Directed Multicast Wakeup Enable */
 #define E1000_WUFC_BC   0x00000010 /* Broadcast Wakeup Enable */
 
+/* Wake Up Status */
+#define E1000_WUS_EX    0x00000004 /* Directed Exact */
+#define E1000_WUS_ARPD  0x00000020 /* Directed ARP Request */
+#define E1000_WUS_IPV4  0x00000040 /* Directed IPv4 */
+#define E1000_WUS_IPV6  0x00000080 /* Directed IPv6 */
+#define E1000_WUS_NSD   0x00000400 /* Directed IPv6 Neighbor Solicitation */
+
+/* Packet types that are enabled for wake packet delivery */
+#define WAKE_PKT_WUS ( \
+	E1000_WUS_EX   | \
+	E1000_WUS_ARPD | \
+	E1000_WUS_IPV4 | \
+	E1000_WUS_IPV6 | \
+	E1000_WUS_NSD)
+
+/* Wake Up Packet Length */
+#define E1000_WUPL_MASK 0x00000FFF
+
+/* Wake Up Packet Memory stores the first 128 bytes of the wake up packet */
+#define E1000_WUPM_BYTES 128
+
 /* Extended Device Control */
 #define E1000_CTRL_EXT_SDP2_DATA 0x00000040 /* Value of SW Defineable Pin 2 */
 #define E1000_CTRL_EXT_SDP3_DATA 0x00000080 /* Value of SW Defineable Pin 3 */
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index be456ba..81e0982 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7630,6 +7630,36 @@ static int __igb_shutdown(struct pci_dev *pdev, bool *enable_wake,
 	return 0;
 }
 
+static void igb_deliver_wake_packet(struct net_device *netdev)
+{
+	struct igb_adapter *adapter = netdev_priv(netdev);
+	struct e1000_hw *hw = &adapter->hw;
+	struct sk_buff *skb;
+	u32 wupl;
+
+	wupl = rd32(E1000_WUPL) & E1000_WUPL_MASK;
+
+	/* WUPM stores only the first 128 bytes of the wake packet.
+	 * Read the packet only if we have the whole thing.
+	 */
+	if ((wupl == 0) || (wupl > E1000_WUPM_BYTES))
+		return;
+
+	skb = netdev_alloc_skb_ip_align(netdev, E1000_WUPM_BYTES);
+	if (!skb)
+		return;
+
+	skb_put(skb, wupl);
+
+	/* Ensure reads are 32-bit aligned */
+	wupl = roundup(wupl, 4);
+
+	memcpy_fromio(skb->data, hw->hw_addr + E1000_WUPM_REG(0), wupl);
+
+	skb->protocol = eth_type_trans(skb, netdev);
+	netif_rx(skb);
+}
+
 #ifdef CONFIG_PM
 #ifdef CONFIG_PM_SLEEP
 static int igb_suspend(struct device *dev)
@@ -7659,7 +7689,7 @@ static int igb_resume(struct device *dev)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
-	u32 err;
+	u32 err, val;
 
 	pci_set_power_state(pdev, PCI_D0);
 	pci_restore_state(pdev);
@@ -7690,6 +7720,10 @@ static int igb_resume(struct device *dev)
 	 */
 	igb_get_hw_control(adapter);
 
+	val = rd32(E1000_WUS);
+	if (val & WAKE_PKT_WUS)
+		igb_deliver_wake_packet(netdev);
+
 	wr32(E1000_WUS, ~0);
 
 	rtnl_lock();
-- 
1.9.1

