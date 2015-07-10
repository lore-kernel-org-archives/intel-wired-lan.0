From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:36:07 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 12/15] i40e:
	Remove redundant and unneeded messages
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-12-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

The kernel notifies all VXLAN capable registered drivers, i.e. any
driver that implements ndo_add_vxlan_port(), of the addition of a
port so that the driver can track which ports are in use.  There's
no need to log this - it just fills the system log with useless and
irksome noise.

Also, when failing to init SR-IOV interfaces the driver was printing the
same message twice. Just remove the inner printk and let the outer message
catch enable as well as the other failures.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Change-ID: Id5ecb1d425c2a357ee2bc1635dab24553831dade
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 --
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4951b03..ea3dbcd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7998,8 +7998,6 @@ static void i40e_add_vxlan_port(struct net_device *netdev,
 	pf->vxlan_ports[next_idx] = port;
 	pf->pending_vxlan_bitmap |= BIT_ULL(next_idx);
 	pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
-
-	dev_info(&pf->pdev->dev, "adding vxlan port %d\n", ntohs(port));
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 70a6fb1..ca7a568 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -921,8 +921,6 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 	if (pci_num_vf(pf->pdev) != num_alloc_vfs) {
 		ret = pci_enable_sriov(pf->pdev, num_alloc_vfs);
 		if (ret) {
-			dev_err(&pf->pdev->dev,
-				"Failed to enable SR-IOV, error %d.\n", ret);
 			pf->num_alloc_vfs = 0;
 			goto err_iov;
 		}
-- 
1.9.3

