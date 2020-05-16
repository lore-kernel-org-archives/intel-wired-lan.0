From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 15 May 2020 17:42:13 -0700
Subject: [Intel-wired-lan] [PATCH S44 01/14] ice: Don't allow VLAN stripping
 change when pvid set
Message-ID: <20200516004226.4795-1-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Currently, if the PVID is set in the VLAN handling section of the VSI
context the driver still allows VLAN stripping to be enabled/disabled.
VLAN stripping should only be modifiable when the PVID is not set. Fix
this by preventing VLAN stripping modification when PVID is set.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 86a3a15c21c8..70b770083ee8 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1847,6 +1847,12 @@ int ice_vsi_manage_vlan_stripping(struct ice_vsi *vsi, bool ena)
 	enum ice_status status;
 	int ret = 0;
 
+	/* do not allow modifying VLAN stripping when a port VLAN is configured
+	 * on this VSI
+	 */
+	if (vsi->info.pvid)
+		return 0;
+
 	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
 	if (!ctxt)
 		return -ENOMEM;
-- 
2.20.1

