From: Alice Michael <alice.michael@intel.com>
Date: Tue, 23 Jul 2019 06:03:40 -0400
Subject: [Intel-wired-lan] [next PATCH S8 07/12] i40e: Fix crash caused by
 stress setting of VF MAC addresses
In-Reply-To: <20190723100345.57522-1-alice.michael@intel.com>
References: <20190723100345.57522-1-alice.michael@intel.com>
Message-ID: <20190723100345.57522-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Slawomir Laba <slawomirx.laba@intel.com>

Add update to the vsi pointer passed to the i40e_set_vf_mac function.
If VF is in reset state the driver waits in i40e_set_vf_mac function
for the reset to be complete, yet after reset the vsi pointer
that was passed into this function is no longer valid.

The patch updates local vsi pointer directly from pf->vsi array,
by using the id stored in vf pointer (lan_vsi_idx).

Without this commit the driver might occasionally invoke general
protection fault in kernel and disable the OS entirely.

Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 7bc4e397d56d..eeb37d83efc9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3970,10 +3970,15 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	/* When the VF is resetting wait until it is done.
 	 * It can take up to 200 milliseconds,
 	 * but wait for up to 300 milliseconds to be safe.
+	 * If the VF is indeed in reset, the vsi pointer has
+	 * to show on the newly loaded vsi under pf->vsi[id].
 	 */
 	for (i = 0; i < 15; i++) {
-		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
+		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
+			if (i > 0)
+				vsi = pf->vsi[vf->lan_vsi_idx];
 			break;
+		}
 		msleep(20);
 	}
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
-- 
2.21.0

