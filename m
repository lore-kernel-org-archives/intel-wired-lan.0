From: Alice Michael <alice.michael@intel.com>
Date: Fri, 23 Jun 2017 04:24:43 -0400
Subject: [Intel-wired-lan] [next PATCH S74-V2 02/10] i40e/i40evf: adjust
	packet size to account for double VLANs
In-Reply-To: <20170623082451.32671-1-alice.michael@intel.com>
References: <20170623082451.32671-1-alice.michael@intel.com>
Message-ID: <20170623082451.32671-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Now that the kernel supports double VLAN tags, we should at least play
nice. Adjust the max packet size to account for two VLAN tags, not just
one.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 4 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h     | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_txrx.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 21705d5..b429550 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2434,6 +2434,7 @@ static int i40e_max_xdp_frame_size(struct i40e_vsi *vsi)
 static int i40e_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	int max_frame = new_mtu + I40E_PACKET_HDR_PAD;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
 
@@ -9768,8 +9769,7 @@ static int i40e_config_netdev(struct i40e_vsi *vsi)
 
 	/* MTU range: 68 - 9706 */
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = I40E_MAX_RXBUFFER -
-			  (ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN);
+	netdev->max_mtu = I40E_MAX_RXBUFFER - I40E_PACKET_HDR_PAD;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index b288d58..a39892d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -130,6 +130,7 @@ enum i40e_dyn_idx_t {
  * i.e. RXBUFFER_512 --> 1216 byte skb (size-2048 slab)
  */
 #define I40E_RX_HDR_SIZE I40E_RXBUFFER_256
+#define I40E_PACKET_HDR_PAD (ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
 #define i40e_rx_desc i40e_32byte_rx_desc
 
 #define I40E_RX_DMA_ATTR \
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
index 901282c..472f606 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.h
@@ -117,6 +117,7 @@ enum i40e_dyn_idx_t {
  * i.e. RXBUFFER_512 --> 1216 byte skb (size-2048 slab)
  */
 #define I40E_RX_HDR_SIZE I40E_RXBUFFER_256
+#define I40E_PACKET_HDR_PAD (ETH_HLEN + ETH_FCS_LEN + (VLAN_HLEN * 2))
 #define i40e_rx_desc i40e_32byte_rx_desc
 
 #define I40E_RX_DMA_ATTR \
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 7c213a3..6422273 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -2269,6 +2269,7 @@ static int i40evf_close(struct net_device *netdev)
 static int i40evf_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct i40evf_adapter *adapter = netdev_priv(netdev);
+	int max_frame = new_mtu + I40E_PACKET_HDR_PAD;
 
 	netdev->mtu = new_mtu;
 	if (CLIENT_ENABLED(adapter)) {
@@ -2625,7 +2626,7 @@ static void i40evf_init_task(struct work_struct *work)
 
 	/* MTU range: 68 - 9710 */
 	netdev->min_mtu = ETH_MIN_MTU;
-	netdev->max_mtu = I40E_MAX_RXBUFFER - (ETH_HLEN + ETH_FCS_LEN);
+	netdev->max_mtu = I40E_MAX_RXBUFFER - I40E_PACKET_HDR_PAD;
 
 	if (!is_valid_ether_addr(adapter->hw.mac.addr)) {
 		dev_info(&pdev->dev, "Invalid MAC address %pM, using random\n",
-- 
2.9.3

