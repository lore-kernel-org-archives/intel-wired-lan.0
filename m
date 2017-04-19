From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Apr 2017 09:25:52 -0400
Subject: [Intel-wired-lan] [next PATCH S71 03/10] i40e: amortize wait time
	when disabling lots of VFs
In-Reply-To: <20170419132559.20459-1-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
Message-ID: <20170419132559.20459-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Just as we do in i40e_reset_all_vfs, save some time when freeing VFs by
amortizing the wait time for stopping queues. We can use
i40e_vsi_stop_rings_no_wait() to begin the process of stopping all the
VF rings at once. Then, once we've started the process on each VF we can
begin waiting for the VFs to stop. This helps reduce the total wait time
by a large factor.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 74977a2..2a47a64 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1194,9 +1194,21 @@ void i40e_free_vfs(struct i40e_pf *pf)
 		usleep_range(1000, 2000);
 
 	i40e_notify_client_of_vf_enable(pf, 0);
-	for (i = 0; i < pf->num_alloc_vfs; i++)
+
+	/* Amortize wait time by stopping all VFs at the same time */
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
+		if (test_bit(I40E_VF_STATE_INIT, &pf->vf[i].vf_states))
+			continue;
+
+		i40e_vsi_stop_rings_no_wait(pf->vsi[pf->vf[i].lan_vsi_idx]);
+	}
+
+	for (i = 0; i < pf->num_alloc_vfs; i++) {
 		if (test_bit(I40E_VF_STATE_INIT, &pf->vf[i].vf_states))
-			i40e_vsi_stop_rings(pf->vsi[pf->vf[i].lan_vsi_idx]);
+			continue;
+
+		i40e_vsi_wait_queues_disabled(pf->vsi[pf->vf[i].lan_vsi_idx]);
+	}
 
 	/* Disable IOV before freeing resources. This lets any VF drivers
 	 * running in the host get themselves cleaned up before we yank
-- 
2.9.3

