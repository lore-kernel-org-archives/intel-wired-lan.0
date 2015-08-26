From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 26 Aug 2015 15:14:09 -0400
Subject: [Intel-wired-lan] [next PATCH S11 03/15] i40e: stop VF rings
In-Reply-To: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440616461-110869-4-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Explicitly stop the rings belonging to each VF when disabling SR-IOV.
Even though the VFs were gone, and the associated VSIs were removed, the
rings were not stopped, and in some circumstances the hardware would
continue to access the memory formerly used by the rings, causing memory
corruption or DMAR errors, both of which would lead to general malaise
of the kernel.

To relieve this condition, explicitly stop all the rings associated with
each VF before releasing its resources.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I78c05d562c66e7b594b7e48d67860f49b3e5b6ec
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index f60cd43..63fd6b7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -872,6 +872,11 @@ void i40e_free_vfs(struct i40e_pf *pf)
 			i40e_vsi_control_rings(pf->vsi[pf->vf[i].lan_vsi_idx],
 					       false);
 
+	for (i = 0; i < pf->num_alloc_vfs; i++)
+		if (test_bit(I40E_VF_STAT_INIT, &pf->vf[i].vf_states))
+			i40e_vsi_control_rings(pf->vsi[pf->vf[i].lan_vsi_idx],
+					       false);
+
 	/* Disable IOV before freeing resources. This lets any VF drivers
 	 * running in the host get themselves cleaned up before we yank
 	 * the carpet out from underneath their feet.
-- 
1.9.3

