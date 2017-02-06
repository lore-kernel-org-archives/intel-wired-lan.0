From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 05 Feb 2017 20:30:19 -0800
Subject: [Intel-wired-lan] [next PATCH v4 05/12] igb: Limit maximum frame Rx
	based on MTU
In-Reply-To: <20170206042508.14635.44702.stgit@localhost.localdomain>
References: <20170206042508.14635.44702.stgit@localhost.localdomain>
Message-ID: <20170206043014.14635.40476.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alexander Duyck <alexander.h.duyck@intel.com>

In order to support the use of build_skb going forward it will be necessary
to place a maximum limit on the amount of data we can receive when jumbo
frames is not enabled.  In order to do this I am adding a new upper limit
for receive based on the size of a 2K buffer minus padding.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 drivers/net/ethernet/intel/igb/igb.h      |   10 +++++++++-
 drivers/net/ethernet/intel/igb/igb_main.c |   16 ++++++++++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index a638254f4e06..a74928cc0e58 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -143,8 +143,17 @@ struct vf_data_storage {
 #define IGB_RXBUFFER_256	256
 #define IGB_RXBUFFER_2048	2048
 #define IGB_RX_HDR_LEN		IGB_RXBUFFER_256
+#define IGB_TS_HDR_LEN		16
 #define IGB_RX_BUFSZ		IGB_RXBUFFER_2048
 
+#define IGB_SKB_PAD		(NET_SKB_PAD + NET_IP_ALIGN)
+#if (PAGE_SIZE < 8192)
+#define IGB_MAX_FRAME_BUILD_SKB \
+	(SKB_WITH_OVERHEAD(IGB_RXBUFFER_2048) - IGB_SKB_PAD - IGB_TS_HDR_LEN)
+#else
+#define IGB_MAX_FRAME_BUILD_SKB (IGB_RXBUFFER_2048 - IGB_TS_HDR_LEN)
+#endif
+
 /* How many Rx Buffers do we bundle into one write to the hardware ? */
 #define IGB_RX_BUFFER_WRITE	16 /* Must be power of 2 */
 
@@ -561,7 +570,6 @@ struct igb_adapter {
 #define IGB_DMCTLX_DCFLUSH_DIS	0x80000000  /* Disable DMA Coal Flush */
 
 #define IGB_82576_TSYNC_SHIFT	19
-#define IGB_TS_HDR_LEN		16
 enum e1000_state_t {
 	__IGB_TESTING,
 	__IGB_RESETTING,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 3f3ae098e39a..d881c51ef162 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -4250,7 +4250,7 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned int vfn = adapter->vfs_allocated_count;
-	u32 rctl = 0, vmolr = 0;
+	u32 rctl = 0, vmolr = 0, rlpml = MAX_JUMBO_FRAME_SIZE;
 	int count;
 
 	/* Check for Promiscuous and All Multicast modes */
@@ -4322,12 +4322,20 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	vmolr |= rd32(E1000_VMOLR(vfn)) &
 		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
 
-	/* enable Rx jumbo frames, no need for restriction */
+	/* enable Rx jumbo frames, restrict as needed to support build_skb */
 	vmolr &= ~E1000_VMOLR_RLPML_MASK;
-	vmolr |= MAX_JUMBO_FRAME_SIZE | E1000_VMOLR_LPE;
+#if (PAGE_SIZE < 8192)
+	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB) {
+		if (!adapter->vfs_allocated_count)
+			rlpml = IGB_MAX_FRAME_BUILD_SKB;
+		vmolr |= IGB_MAX_FRAME_BUILD_SKB;
+	} else
+#endif
+		vmolr |= MAX_JUMBO_FRAME_SIZE;
+	vmolr |= E1000_VMOLR_LPE;
 
 	wr32(E1000_VMOLR(vfn), vmolr);
-	wr32(E1000_RLPML, MAX_JUMBO_FRAME_SIZE);
+	wr32(E1000_RLPML, rlpml);
 
 	igb_restore_vf_multicasts(adapter);
 }

