From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 15 Jun 2015 15:00:53 -0700
Subject: [Intel-wired-lan] [PATCH 3/6] fm10k: only prevent removal of
	default VID rules
In-Reply-To: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
References: <1434405656-10465-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1434405656-10465-3-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This allows us to correctly add a VLAN even if it matches our default
VID. However, we don't want to remove the VID rules once that VLAN is
deleted. Correctly remove the stack layers information of the VLAN, but
then return to forwarding that VID as untagged frames. If we deleted the
VID rules here, we would begin dropping traffic due to VLAN membership
violations.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 99228bf46c12..818bc8b1fa58 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -775,8 +775,8 @@ static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 	if (!set)
 		clear_bit(vid, interface->active_vlans);
 
-	/* if default VLAN is already present do nothing */
-	if (vid == hw->mac.default_vid)
+	/* Do not remove default VID related entries from VLAN and MAC tables */
+	if (!set && vid == hw->mac.default_vid)
 		return 0;
 
 	fm10k_mbx_lock(interface);
-- 
2.4.2

