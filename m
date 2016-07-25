From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 25 Jul 2016 16:15:51 -0700
Subject: [Intel-wired-lan] [next PATCH S40 09/13] i40e: Don't notify client
	of VF reset during VF creation
In-Reply-To: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469488555-28187-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Avinash Dayanand <avinash.dayanand@intel.com>

VF goes through reset path during VF creation which happens to also
have notification of VF reset to client. Adding conditional check to
avoid wrongly notifying VF reset during VF creation.

Also changing the call order of VF enable, calling it after VF creation
rather than before.

Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
Change-ID: I96eabd99deae746a2f0fc465194c886f196178ce
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 0fa050a..5ea659c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -991,7 +991,9 @@ complete_reset:
 		i40e_enable_vf_mappings(vf);
 		set_bit(I40E_VF_STAT_ACTIVE, &vf->vf_states);
 		clear_bit(I40E_VF_STAT_DISABLED, &vf->vf_states);
-		i40e_notify_client_of_vf_reset(pf, abs_vf_id);
+		/* Do not notify the client during VF init */
+		if (vf->pf->num_alloc_vfs)
+			i40e_notify_client_of_vf_reset(pf, abs_vf_id);
 		vf->num_vlan = 0;
 	}
 	/* tell the VF the reset is done */
@@ -1090,7 +1092,6 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 			goto err_iov;
 		}
 	}
-	i40e_notify_client_of_vf_enable(pf, num_alloc_vfs);
 	/* allocate memory */
 	vfs = kcalloc(num_alloc_vfs, sizeof(struct i40e_vf), GFP_KERNEL);
 	if (!vfs) {
@@ -1114,6 +1115,8 @@ int i40e_alloc_vfs(struct i40e_pf *pf, u16 num_alloc_vfs)
 	}
 	pf->num_alloc_vfs = num_alloc_vfs;
 
+	i40e_notify_client_of_vf_enable(pf, num_alloc_vfs);
+
 err_alloc:
 	if (ret)
 		i40e_free_vfs(pf);
-- 
2.4.11

