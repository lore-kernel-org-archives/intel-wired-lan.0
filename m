From: Alice Michael <alice.michael@intel.com>
Date: Mon, 20 Aug 2018 08:12:33 -0700
Subject: [Intel-wired-lan] [next PATCH S95 12/12] i40e: static analysis
 report from community
In-Reply-To: <20180820151233.14629-1-alice.michael@intel.com>
References: <20180820151233.14629-1-alice.michael@intel.com>
Message-ID: <20180820151233.14629-12-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Martyna Szapar <martyna.szapar@intel.com>

Static analysis tools report a problem from original driver submission.
Removing unnecessary check in condition.

Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 969fb93..e40c023 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13129,7 +13129,7 @@ struct i40e_veb *i40e_veb_setup(struct i40e_pf *pf, u16 flags,
 	for (vsi_idx = 0; vsi_idx < pf->num_alloc_vsi; vsi_idx++)
 		if (pf->vsi[vsi_idx] && pf->vsi[vsi_idx]->seid == vsi_seid)
 			break;
-	if (vsi_idx >= pf->num_alloc_vsi && vsi_seid != 0) {
+	if (vsi_idx == pf->num_alloc_vsi && vsi_seid != 0) {
 		dev_info(&pf->pdev->dev, "vsi seid %d not found\n",
 			 vsi_seid);
 		return NULL;
-- 
2.9.5

