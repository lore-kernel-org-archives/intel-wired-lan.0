From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu, 27 Aug 2015 11:42:35 -0400
Subject: [Intel-wired-lan] [next PATCH S12 07/15] i40e: add more verbose
	error messages
In-Reply-To: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
References: <1440690163-128213-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1440690163-128213-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Under certain circumstances, the device may not have enough resources to
enable all of the VFs that it advertises in config space. Although the
number of supported VFs is reported upon driver init, it is not obvious
when this is different from the number reported in config space. To
eliminate this confusion, add an error message explaining the problem.
Additionally, move the 'Allocating VFs' message down below the error
checks so as to prevent further confusion.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I45b7efca53a7aebf7777be33a8bc9d615ae48ea1
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 63fd6b7..aa4e44c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -998,17 +998,19 @@ static int i40e_pci_sriov_enable(struct pci_dev *pdev, int num_vfs)
 		goto err_out;
 	}
 
-	dev_info(&pdev->dev, "Allocating %d VFs.\n", num_vfs);
 	if (pre_existing_vfs && pre_existing_vfs != num_vfs)
 		i40e_free_vfs(pf);
 	else if (pre_existing_vfs && pre_existing_vfs == num_vfs)
 		goto out;
 
 	if (num_vfs > pf->num_req_vfs) {
+		dev_warn(&pdev->dev, "Unable to enable %d VFs. Limited to %d VFs due to device resource constraints.\n",
+			 num_vfs, pf->num_req_vfs);
 		err = -EPERM;
 		goto err_out;
 	}
 
+	dev_info(&pdev->dev, "Allocating %d VFs.\n", num_vfs);
 	err = i40e_alloc_vfs(pf, num_vfs);
 	if (err) {
 		dev_warn(&pdev->dev, "Failed to enable SR-IOV: %d\n", err);
-- 
1.9.3

