From: Alice Michael <alice.michael@intel.com>
Date: Wed,  7 Mar 2018 05:49:51 -0800
Subject: [Intel-wired-lan] [next PATCH S87-V3 2/8] i40e: Fix attach VF to VM
 issue
In-Reply-To: <20180307134957.61497-1-alice.michael@intel.com>
References: <20180307134957.61497-1-alice.michael@intel.com>
Message-ID: <20180307134957.61497-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

Fix for "Resource temporarily unavailable" problem when virsh is
trying to attach a device to VM. When the VF driver is loaded on
host and virsh is trying to attach it to the VM and set a MAC
address, it ends with a race condition between i40e_reset_vf and
i40e_ndo_set_vf_mac functions. The bug is fixed by adding polling
in i40e_ndo_set_vf_mac function For when the VF is in Reset mode.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 6049a56..8559c09 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -3742,6 +3742,7 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 	int ret = 0;
 	struct hlist_node *h;
 	int bkt;
+	u8 i;
 
 	/* validate the request */
 	if (vf_id >= pf->num_alloc_vfs) {
@@ -3753,6 +3754,16 @@ int i40e_ndo_set_vf_mac(struct net_device *netdev, int vf_id, u8 *mac)
 
 	vf = &(pf->vf[vf_id]);
 	vsi = pf->vsi[vf->lan_vsi_idx];
+
+	/* When the VF is resetting wait until it is done.
+	 * It can take up to 200 milliseconds,
+	 * but wait for up to 300 milliseconds to be safe.
+	 */
+	for (i = 0; i < 15; i++) {
+		if (test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
+			break;
+		msleep(20);
+	}
 	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
 		dev_err(&pf->pdev->dev, "VF %d still in reset. Try again.\n",
 			vf_id);
-- 
2.9.5

