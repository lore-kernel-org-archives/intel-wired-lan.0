From: Alice Michael <alice.michael@intel.com>
Date: Wed,  1 Aug 2018 17:40:25 -0700
Subject: [Intel-wired-lan] [next PATCH S94 02/13] i40e: Add setting
 pf->lan_vsi in a recovery mode init path
In-Reply-To: <20180802004036.89363-1-alice.michael@intel.com>
References: <20180802004036.89363-1-alice.michael@intel.com>
Message-ID: <20180802004036.89363-2-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

This patch fixes the issue with shutdowning the system, after
entering the recovery mode. This is needed in the upgrade
scenario. Without this the driver tries to access an array out of
bounds.

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c4ba44c..c9b1d0c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -13640,6 +13640,7 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
 	v_idx = i40e_vsi_mem_alloc(pf, I40E_VSI_MAIN);
 	if (v_idx < 0)
 		goto err_switch_setup;
+	pf->lan_vsi = v_idx;
 	vsi = pf->vsi[v_idx];
 	if (!vsi)
 		goto err_switch_setup;
-- 
2.9.5

