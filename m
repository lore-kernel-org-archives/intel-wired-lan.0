From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 19 Jul 2017 15:00:26 -0700
Subject: [Intel-wired-lan] [PATCH v2] ixgbe: Ensure MAC filter was added
	before setting MACVLAN
Message-ID: <20170719220026.47784-1-anthony.l.nguyen@intel.com>
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
v2: 
  Made changes as suggested by Joe Perches.
  - Declared retval as an int
  - Switched logic to return on error
  - Return 0 on success

 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
index 0760bd7..112d24c 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
@@ -679,8 +679,9 @@ static void ixgbe_clear_vf_vlans(struct ixgbe_adapter *adapter, u32 vf)
 static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 				int vf, int index, unsigned char *mac_addr)
 {
-	struct list_head *pos;
 	struct vf_macvlans *entry;
+	struct list_head *pos;
+	int retval = 0;
 
 	if (index <= 1) {
 		list_for_each(pos, &adapter->vf_mvs.l) {
@@ -721,13 +722,15 @@ static int ixgbe_set_vf_macvlan(struct ixgbe_adapter *adapter,
 	if (!entry || !entry->free)
 		return -ENOSPC;
 
+	retval = ixgbe_add_mac_filter(adapter, mac_addr, vf);
+	if (retval < 0)
+		return retval;
+
 	entry->free = false;
 	entry->is_macvlan = true;
 	entry->vf = vf;
 	memcpy(entry->vf_macvlan, mac_addr, ETH_ALEN);
 
-	ixgbe_add_mac_filter(adapter, mac_addr, vf);
-
 	return 0;
 }
 
-- 
2.9.3

