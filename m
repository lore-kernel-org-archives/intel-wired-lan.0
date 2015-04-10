From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 10 Apr 2015 16:48:19 -0700
Subject: [Intel-wired-lan] [net-next v2 07/25] fm10k: allow creation of VLAN
	on default vid
Message-ID: <20150410234616.23532.23537.stgit@gmw-smvitp108.amr.corp.intel.com>
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
v2: based on feedback from Alex, keep the code, but just move it down in
    the function and return 0
---
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2a61b83..e8f5c8c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -770,15 +770,15 @@ static int fm10k_update_vid(struct net_device *netdev, u16 vid, bool set)
 	if (hw->mac.vlan_override)
 		return -EACCES;
 
-	/* if default VLAN is already present do nothing */
-	if (vid == hw->mac.default_vid)
-		return -EBUSY;
-
 	/* update active_vlans bitmask */
 	set_bit(vid, interface->active_vlans);
 	if (!set)
 		clear_bit(vid, interface->active_vlans);
 
+	/* if default VLAN is already present do nothing */
+	if (vid == hw->mac.default_vid)
+		return 0;
+
 	fm10k_mbx_lock(interface);
 
 	/* only need to update the VLAN if not in promiscuous mode */

