From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Mar 2015 21:30:17 -0700
Subject: [Intel-wired-lan] [next-queue S2 07/15] i40e: warn at the right time
In-Reply-To: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1427257825-24519-1-git-send-email-jeffrey.t.kirsher@intel.com>
Message-ID: <1427257825-24519-7-git-send-email-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

The call to pci_disable_sriov got moved, but the message about not
disabling VFs didn't move. So move it. While we're at, reword the
message a bit to make it more consistent with other driver messages.

Change-ID: I17d3e15e4fcfd5c9431a96ecb0117d728d3da18b
Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index bb18412..184b003 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -734,6 +734,8 @@ void i40e_free_vfs(struct i40e_pf *pf)
 	 */
 	if (!pci_vfs_assigned(pf->pdev))
 		pci_disable_sriov(pf->pdev);
+	else
+		dev_warn(&pf->pdev->dev, "VFs are assigned - not disabling SR-IOV\n");
 
 	msleep(20); /* let any messages in transit get finished up */
 
@@ -763,9 +765,6 @@ void i40e_free_vfs(struct i40e_pf *pf)
 			bit_idx = (hw->func_caps.vf_base_id + vf_id) % 32;
 			wr32(hw, I40E_GLGEN_VFLRSTAT(reg_idx), (1 << bit_idx));
 		}
-	} else {
-		dev_warn(&pf->pdev->dev,
-			 "unable to disable SR-IOV because VFs are assigned.\n");
 	}
 	clear_bit(__I40E_VF_DISABLE, &pf->state);
 }
-- 
1.9.3

