From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 24 Oct 2019 01:11:25 -0700
Subject: [Intel-wired-lan] [PATCH S30 v3 9/9] ice: allow 3k MTU for XDP
In-Reply-To: <20191024081125.6711-1-anthony.l.nguyen@intel.com>
References: <20191024081125.6711-1-anthony.l.nguyen@intel.com>
Message-ID: <20191024081125.6711-9-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

At this point ice driver is able to work on order 1 pages that are split
onto two 3k buffers. Let's reflect that when user is setting new mtu
size and XDP is present on interface.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index d5f292b17739..5fe0f94eb7f3 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4765,6 +4765,18 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	dev_err(dev, "Rebuild failed, unload and reload driver\n");
 }
 
+/**
+ * ice_max_xdp_frame_size - returns the maximum allowed frame size for XDP
+ * @vsi: Pointer to VSI structure
+ */
+static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
+{
+	if (PAGE_SIZE >= 8192 || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
+		return ICE_RXBUF_2048 - XDP_PACKET_HEADROOM;
+	else
+		return ICE_RXBUF_3072;
+}
+
 /**
  * ice_change_mtu - NDO callback to change the MTU
  * @netdev: network interface device structure
@@ -4786,11 +4798,11 @@ static int ice_change_mtu(struct net_device *netdev, int new_mtu)
 	}
 
 	if (ice_is_xdp_ena_vsi(vsi)) {
-		int frame_size = ICE_RXBUF_2048 - XDP_PACKET_HEADROOM;
+		int frame_size = ice_max_xdp_frame_size(vsi);
 
 		if (new_mtu + ICE_ETH_PKT_HDR_PAD > frame_size) {
 			netdev_err(netdev, "max MTU for XDP usage is %d\n",
-				   frame_size);
+				   frame_size - ICE_ETH_PKT_HDR_PAD);
 			return -EINVAL;
 		}
 	}
-- 
2.20.1

