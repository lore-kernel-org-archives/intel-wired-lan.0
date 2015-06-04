From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 4 Jun 2015 11:56:38 +0300
Subject: [Intel-wired-lan] [patch -next] i40e: fix some bit tests
Message-ID: <20150604085637.GB22838@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

These tests don't work as intended because __I40E_TESTING and
I40E_VF_STAT_ACTIVE are bit numbers and not masks.

Fixes: e17bc411aea8 ('i40e: Disable offline diagnostics if VFs are enabled')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 4653b6e..9fe6cd5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -980,7 +980,7 @@ static int i40e_pci_sriov_enable(struct pci_dev *pdev, int num_vfs)
 	int pre_existing_vfs = pci_num_vf(pdev);
 	int err = 0;
 
-	if (pf->state & __I40E_TESTING) {
+	if (test_bit(__I40E_TESTING, &pf->state)) {
 		dev_warn(&pdev->dev,
 			 "Cannot enable SR-IOV virtual functions while the device is undergoing diagnostic testing\n");
 		err = -EPERM;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 9a68c65..9ce4dc9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1555,7 +1555,7 @@ static inline bool i40e_active_vfs(struct i40e_pf *pf)
 	int i;
 
 	for (i = 0; i < pf->num_alloc_vfs; i++)
-		if (vfs[i].vf_states & I40E_VF_STAT_ACTIVE)
+		if (test_bit(I40E_VF_STAT_ACTIVE, &vfs[i].vf_states))
 			return true;
 	return false;
 }
