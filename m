From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  1 Oct 2015 14:37:40 -0400
Subject: [Intel-wired-lan] [next PATCH S18 7/8] i40e: Disable VEB bridge
	mode with SR-IOV failure
In-Reply-To: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
References: <1443724661-92168-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1443724661-92168-8-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>

If a call to enable SR-IOV in the kernel failed, we need to disable
I40E_FLAG_VEB_MODE_ENABLED, so that bridge mode could fall back to
VEPA, which is a default.

Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
Change-ID: I12b6f776769506db85b29bea94b9c88d0b5ee65e

---
Testing-hints: 5645709
Configure driver with SR-IOV in a nested virtualization environment
(PCI-Passthrough) and confirmed that SR-IOV enablement failed. Bridge
mode should remain VEPA instead of VEB with the notion that SR-IOV has
been successfully configured.
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index b2d95ee..44462b4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -944,6 +944,7 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 	if (pci_num_vf(pf->pdev) != num_alloc_vfs) {
 		ret = pci_enable_sriov(pf->pdev, num_alloc_vfs);
 		if (ret) {
+			pf->flags &= ~I40E_FLAG_VEB_MODE_ENABLED;
 			pf->num_alloc_vfs = 0;
 			goto err_iov;
 		}
-- 
1.9.3

