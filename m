From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 12 Apr 2018 11:15:59 -0700
Subject: [Intel-wired-lan] [PATCH 6/6] fm10k: don't protect
 fm10k_queue_mac_request by fm10k_host_mbx_ready
In-Reply-To: <20180412181559.4343-1-jacob.e.keller@intel.com>
References: <20180412181559.4343-1-jacob.e.keller@intel.com>
Message-ID: <20180412181559.4343-6-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We don't actually need to check if the host mbx is ready when queuing
MAC requests, because these are not handled by a special queue which
queues up requests until the mailbox is capable of handling them.

Pull these requests outside the fm10k_host_mbx_ready() check, as it is
not necessary.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 36200dec941d..11204fdbb484 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1555,12 +1555,12 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 
 	glort = l2_accel->dglort + 1 + i;
 
-	if (fm10k_host_mbx_ready(interface)) {
+	if (fm10k_host_mbx_ready(interface))
 		hw->mac.ops.update_xcast_mode(hw, glort,
 					      FM10K_XCAST_MODE_NONE);
-		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
-					hw->mac.default_vid, true);
-	}
+
+	fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
+				hw->mac.default_vid, true);
 
 	for (vid = fm10k_find_next_vlan(interface, 0);
 	     vid < VLAN_N_VID;
@@ -1601,12 +1601,12 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 
 	glort = l2_accel->dglort + 1 + i;
 
-	if (fm10k_host_mbx_ready(interface)) {
+	if (fm10k_host_mbx_ready(interface))
 		hw->mac.ops.update_xcast_mode(hw, glort,
 					      FM10K_XCAST_MODE_NONE);
-		fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
-					hw->mac.default_vid, false);
-	}
+
+	fm10k_queue_mac_request(interface, glort, sdev->dev_addr,
+				hw->mac.default_vid, false);
 
 	for (vid = fm10k_find_next_vlan(interface, 0);
 	     vid < VLAN_N_VID;
-- 
2.15.1.478.ga1e07cd25f8b

