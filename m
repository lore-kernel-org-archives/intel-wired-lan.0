From: Jonathan Toppins <jtoppins@redhat.com>
Date: Thu,  3 Feb 2022 12:45:16 -0500
Subject: [Intel-wired-lan] [PATCH v2] ice: change "can't set link" message
 to dbg level
In-Reply-To: <b25f9e524c404820b310c73012507c8e65a2ef97.1643834329.git.jtoppins@redhat.com>
References: <b25f9e524c404820b310c73012507c8e65a2ef97.1643834329.git.jtoppins@redhat.com>
Message-ID: <cfb30f5c84364c8eff96c0a3ea0231e5dfda17e4.1643910316.git.jtoppins@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In the case where the link is owned by manageability, the firmware is
not allowed to set the link state, so an error code is returned.
This however is non-fatal and there is nothing the operator can do,
so instead of confusing the operator with messages they can do nothing
about hide this message behind the debug log level.

Signed-off-by: Jonathan Toppins <jtoppins@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 0c187cf04fcf..81b152133d11 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4117,9 +4117,9 @@ int ice_set_link(struct ice_vsi *vsi, bool ena)
 	 */
 	if (status == -EIO) {
 		if (hw->adminq.sq_last_status == ICE_AQ_RC_EMODE)
-			dev_warn(dev, "can't set link to %s, err %d aq_err %s. not fatal, continuing\n",
-				 (ena ? "ON" : "OFF"), status,
-				 ice_aq_str(hw->adminq.sq_last_status));
+			dev_dbg(dev, "can't set link to %s, err %d aq_err %s. not fatal, continuing\n",
+				(ena ? "ON" : "OFF"), status,
+				ice_aq_str(hw->adminq.sq_last_status));
 	} else if (status) {
 		dev_err(dev, "can't set link to %s, err %d aq_err %s\n",
 			(ena ? "ON" : "OFF"), status,
-- 
2.27.0

