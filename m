From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 11:44:34 -0700
Subject: [Intel-wired-lan] [PATCH S9 02/15] ice: Call pci_disable_sriov
 before stopping queues for VF
In-Reply-To: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
References: <20181026184447.13547-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026184447.13547-3-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Brett Creeley <brett.creeley@intel.com>

Previous to this commit the driver was immediately stopping Tx/Rx
queues when doing the following "echo 0 > sriov_numvfs" and then it was
calling pci_disable_sriov if the VFs are not assigned. This was causing
the VIRTCHNL_OP_DISABLE_QUEUES to fail because it was trying to stop
the queues for a second time.

Fix this by calling pci_disable_sriov before stopping the Tx/Rx queues.
This allows the VIRTCHNL_OP_DISABLE_QUEUES to get processed before the
driver tries to stop the Rx/Tx queues in ice_free_vfs.

Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index e71065f9d391..20b94dee0036 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -215,6 +215,15 @@ void ice_free_vfs(struct ice_pf *pf)
 	while (test_and_set_bit(__ICE_VF_DIS, pf->state))
 		usleep_range(1000, 2000);
 
+	/* Disable IOV before freeing resources. This lets any VF drivers
+	 * running in the host get themselves cleaned up before we yank
+	 * the carpet out from underneath their feet.
+	 */
+	if (!pci_vfs_assigned(pf->pdev))
+		pci_disable_sriov(pf->pdev);
+	else
+		dev_warn(&pf->pdev->dev, "VFs are assigned - not disabling SR-IOV\n");
+
 	/* Avoid wait time by stopping all VFs at the same time */
 	for (i = 0; i < pf->num_alloc_vfs; i++) {
 		if (!test_bit(ICE_VF_STATE_ENA, pf->vf[i].vf_states))
@@ -228,15 +237,6 @@ void ice_free_vfs(struct ice_pf *pf)
 		clear_bit(ICE_VF_STATE_ENA, pf->vf[i].vf_states);
 	}
 
-	/* Disable IOV before freeing resources. This lets any VF drivers
-	 * running in the host get themselves cleaned up before we yank
-	 * the carpet out from underneath their feet.
-	 */
-	if (!pci_vfs_assigned(pf->pdev))
-		pci_disable_sriov(pf->pdev);
-	else
-		dev_warn(&pf->pdev->dev, "VFs are assigned - not disabling SR-IOV\n");
-
 	tmp = pf->num_alloc_vfs;
 	pf->num_vf_qps = 0;
 	pf->num_alloc_vfs = 0;
-- 
2.14.3

