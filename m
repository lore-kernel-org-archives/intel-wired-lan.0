From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri,  3 Apr 2015 13:26:57 -0700
Subject: [Intel-wired-lan] [net-next 07/25] fm10k: allow creation of VLAN on
	default vid
In-Reply-To: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1428092835-16834-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1428092835-16834-7-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Previously, the user was not allowed to create a VLAN interface on top
of the switch default vid.

Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Acked-by: Matthew Vick <matthew.vick@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2a61b83..c9f87bb 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -770,10 +770,6 @@ static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 	if (hw->mac.vlan_override)
 		return -EACCES;
 
-	/* if default VLAN is already present do nothing */
-	if (vid == hw->mac.default_vid)
-		return -EBUSY;
-
 	/* update active_vlans bitmask */
 	set_bit(vid, interface->active_vlans);
 	if (!set)
-- 
1.9.3

