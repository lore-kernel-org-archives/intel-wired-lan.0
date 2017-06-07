From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed,  7 Jun 2017 14:36:17 -0700
Subject: [Intel-wired-lan] [PATCH 1/5] ixgbe: Ensure MAC filter was added
	before setting MACVLAN
Message-ID: <20170607213621.18256-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch adds a check to ensure that adding the MAC filter was
successful before setting the MACVLAN.  If it was unsuccessful, propagate
the error.

Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index b77f992..df43c59 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -685,6 +685,7 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 {
 	struct list_head *pos;
 	struct vf_macvlans *entry;
+	s32 retval = 0;
 
 	if (index <= 1) {
 		list_for_each(pos, &adapter->vf_mvs.l) {
@@ -725,14 +726,15 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 	if (!entry || !entry->free)
 		return -ENOSPC;
 
-	entry->free = false;
-	entry->is_macvlan = true;
-	entry->vf = vf;
-	memcpy(entry->vf_macvlan, mac_addr, ETH_ALEN);
-
-	ixgbe_add_mac_filter(adapter, mac_addr, vf);
+	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
+	if (retval >= 0) {
+		entry->free = false;
+		entry->is_macvlan = true;
+		entry->vf = vf;
+		memcpy(entry->vf_macvlan, mac_addr, ETH_ALEN);
+	}
 
-	return 0;
+	return retval;
 }
 
 static inline void ixgbe_vf_reset_event(struct ixgbe_adapter *adapter, u32 vf)
-- 
2.9.3

